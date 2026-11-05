import std/unittest

import ngis

suite "ngis":
  test "greets by name":
    check greet("Nim") == "hello, Nim"

