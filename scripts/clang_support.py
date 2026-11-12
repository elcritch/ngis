"""Locate a native libclang for the binding generators and independent audits."""
import ctypes.util
import json
import pathlib
import sys

from clang import cindex


def installed_headers(include):
    """Use package ownership when a conda prefix shares include/ with dependencies."""
    metadata = include.parent / "conda-meta"
    owned = set()
    if metadata.is_dir():
        packages = list(metadata.glob("libgdal*.json")) + list(metadata.glob("gdal-*.json"))
        for package in packages:
            for filename in json.loads(package.read_text()).get("files", []):
                path = pathlib.PurePosixPath(filename)
                if len(path.parts) == 2 and path.parts[0] == "include" and path.suffix in (".h", ".hpp"):
                    owned.add(path.name)
    if owned:
        return owned
    return {p.name for p in include.iterdir() if p.suffix in (".h", ".hpp")}


def configure_clang(library=None):
    if not library and sys.platform == "darwin":
        candidate = pathlib.Path("/Library/Developer/CommandLineTools/usr/lib/libclang.dylib")
        if candidate.exists():
            library = str(candidate)
    if not library:
        library = ctypes.util.find_library("clang")
        for version in range(30, 12, -1):
            if library:
                break
            library = ctypes.util.find_library(f"clang-{version}")
    if not library:
        raise RuntimeError("libclang was not found; install libclang-dev or pass --libclang")
    cindex.Config.set_library_file(library)
    cindex.Config.set_compatibility_check(False)
