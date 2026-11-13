## Generated from GDAL 3.13.3 public C headers. Do not edit.
## Regenerate with scripts/generate_bindings.py; see bindings.json for coverage.
import ./[library, systemtypes]
import ./private/imports
export library, systemtypes

when defined(windows) and defined(i386):
  {.pragma: gdalCall, stdcall.}
else:
  {.pragma: gdalCall, cdecl.}

when defined(windows):
  type
    CPL_FILE_HANDLE* = pointer
    CPL_PID* = cuint

  const
    CPL_FILE_INVALID_HANDLE* = nil
    CPL_FRMT_GB_WITHOUT_PREFIX* = "I64"
else:
  type
    CPL_FILE_HANDLE* = cint
    CPL_PID* = cint

  const
    CPL_FILE_INVALID_HANDLE* = -1
    CPL_FRMT_GB_WITHOUT_PREFIX* = "ll"
type
  GdalFile* {.importc: "FILE", header: "<stdio.h>", incompleteStruct.} = object
  GdalVaList* {.importc: "va_list", header: "<stdarg.h>".} = object
  GInt32* = cint
  GUInt32* = cuint
  GInt16* = cshort
  GUInt16* = cushort
  GByte* = uint8
  GInt8* = cschar
  GBool* = cint
  GIntBig* = clonglong
  GUIntBig* = culonglong
  GInt64* = GIntBig
  GUInt64* = GUIntBig
  GPtrDiff_t* = int
  CSLConstList* = cstringArray
  CPLCompressionFunc* = proc(
    a0: pointer,
    a1: csize_t,
    a2: ptr pointer,
    a3: ptr csize_t,
    a4: CSLConstList,
    a5: pointer,
  ): bool {.cdecl, raises: [].}
  CPLCompressorType* = distinct cuint
  GDALProgressFunc* =
    proc(a0: cdouble, a1: cstring, a2: pointer): cint {.gdalCall, raises: [].}
  VSIStatBuf* = GdalSystemstat
  vsi_l_offset* = GUIntBig
  VSILFILE* = VSIVirtualHandle
  VSIRangeStatus* = distinct cuint
  VSIWriteFunction* = proc(
    a0: pointer, a1: csize_t, a2: csize_t, a3: ptr GdalFile
  ): csize_t {.cdecl, raises: [].}
  VSIFilesystemPluginStatCallback* = proc(
    a0: pointer, a1: cstring, a2: ptr VSIStatBufL, a3: cint
  ): cint {.cdecl, raises: [].}
  VSIFilesystemPluginUnlinkCallback* =
    proc(a0: pointer, a1: cstring): cint {.cdecl, raises: [].}
  VSIFilesystemPluginRenameCallback* =
    proc(a0: pointer, a1: cstring, a2: cstring): cint {.cdecl, raises: [].}
  VSIFilesystemPluginMkdirCallback* =
    proc(a0: pointer, a1: cstring, a2: clong): cint {.cdecl, raises: [].}
  VSIFilesystemPluginRmdirCallback* =
    proc(a0: pointer, a1: cstring): cint {.cdecl, raises: [].}
  VSIFilesystemPluginReadDirCallback* =
    proc(a0: pointer, a1: cstring, a2: cint): cstringArray {.cdecl, raises: [].}
  VSIFilesystemPluginSiblingFilesCallback* =
    proc(a0: pointer, a1: cstring): cstringArray {.cdecl, raises: [].}
  VSIFilesystemPluginOpenCallback* =
    proc(a0: pointer, a1: cstring, a2: cstring): pointer {.cdecl, raises: [].}
  VSIFilesystemPluginTellCallback* =
    proc(a0: pointer): vsi_l_offset {.cdecl, raises: [].}
  VSIFilesystemPluginSeekCallback* =
    proc(a0: pointer, a1: vsi_l_offset, a2: cint): cint {.cdecl, raises: [].}
  VSIFilesystemPluginReadCallback* = proc(
    a0: pointer, a1: pointer, a2: csize_t, a3: csize_t
  ): csize_t {.cdecl, raises: [].}
  VSIFilesystemPluginReadMultiRangeCallback* = proc(
    a0: pointer, a1: cint, a2: ptr pointer, a3: ptr vsi_l_offset, a4: ptr csize_t
  ): cint {.cdecl, raises: [].}
  VSIFilesystemPluginGetRangeStatusCallback* = proc(
    a0: pointer, a1: vsi_l_offset, a2: vsi_l_offset
  ): VSIRangeStatus {.cdecl, raises: [].}
  VSIFilesystemPluginEofCallback* = proc(a0: pointer): cint {.cdecl, raises: [].}
  VSIFilesystemPluginWriteCallback* = proc(
    a0: pointer, a1: pointer, a2: csize_t, a3: csize_t
  ): csize_t {.cdecl, raises: [].}
  VSIFilesystemPluginFlushCallback* = proc(a0: pointer): cint {.cdecl, raises: [].}
  VSIFilesystemPluginTruncateCallback* =
    proc(a0: pointer, a1: vsi_l_offset): cint {.cdecl, raises: [].}
  VSIFilesystemPluginCloseCallback* = proc(a0: pointer): cint {.cdecl, raises: [].}
  VSIFilesystemPluginAdviseReadCallback* = proc(
    a0: pointer, a1: cint, a2: ptr vsi_l_offset, a3: ptr csize_t
  ) {.cdecl, raises: [].}
  VSIFilesystemPluginErrorCallback* = proc(a0: pointer): cint {.cdecl, raises: [].}
  VSIFilesystemPluginClearErrCallback* = proc(a0: pointer) {.cdecl, raises: [].}
  CPLErr* = distinct cuint
  CPLErrorNum* = cint
  CPLErrorHandler* =
    proc(a0: CPLErr, a1: CPLErrorNum, a2: cstring) {.gdalCall, raises: [].}
  CPLSetConfigOptionSubscriber* =
    proc(a0: cstring, a1: cstring, a2: bool, a3: pointer) {.cdecl, raises: [].}
  CPLFileFinder* = proc(a0: cstring, a1: cstring): cstring {.cdecl, raises: [].}
  CPLLockFileStatus* = distinct cuint
  CPLLockFileHandle* = ptr CPLLockFileStruct
  CPLValueType* = distinct cuint
  CSVCompareCriteria* = distinct cuint
  CPLHashSet* = C_CPLHashSet
  CPLHashSetHashFunc* = proc(a0: pointer): culong {.cdecl, raises: [].}
  CPLHashSetEqualFunc* = proc(a0: pointer, a1: pointer): cint {.cdecl, raises: [].}
  CPLHashSetFreeEltFunc* = proc(a0: pointer) {.cdecl, raises: [].}
  CPLHashSetIterEltFunc* = proc(a0: pointer, a1: pointer): cint {.cdecl, raises: [].}
  CPLHTTPFetchWriteFunc* = proc(
    a0: pointer, a1: csize_t, a2: csize_t, a3: pointer
  ): csize_t {.cdecl, raises: [].}
  CPLHTTPFetchCallbackFunc* = proc(
    a0: cstring,
    a1: CSLConstList,
    a2: GDALProgressFunc,
    a3: pointer,
    a4: CPLHTTPFetchWriteFunc,
    a5: pointer,
    a6: pointer,
  ): ptr CPLHTTPResult {.cdecl, raises: [].}
  CPLList* = C_CPLList
  CPLXMLNodeType* = distinct cuint
  CPLThreadFunc* = proc(a0: pointer) {.cdecl, raises: [].}
  CPLMutex* = C_CPLMutex
  CPLCond* = C_CPLCond
  CPLJoinableThread* = C_CPLJoinableThread
  CPLCondTimedWaitReason* = distinct cuint
  CPLLock* = C_CPLLock
  CPLLockType* = distinct cuint
  CPLTLSFreeFunc* = proc(a0: pointer) {.cdecl, raises: [].}
  CPLQuadTree* = C_CPLQuadTree
  CPLQuadTreeGetBoundsFunc* =
    proc(a0: pointer, a1: ptr CPLRectObj) {.cdecl, raises: [].}
  CPLQuadTreeGetBoundsExFunc* =
    proc(a0: pointer, a1: pointer, a2: ptr CPLRectObj) {.cdecl, raises: [].}
  CPLQuadTreeForeachFunc* = proc(a0: pointer, a1: pointer): cint {.cdecl, raises: [].}
  CPLQuadTreeDumpFeatureFunc* =
    proc(a0: pointer, a1: cint, a2: pointer) {.cdecl, raises: [].}
  CPLSpawnedProcess* = C_CPLSpawnedProcess
  CPLVirtualMemCachePageCbk* = proc(
    a0: ptr CPLVirtualMem, a1: csize_t, a2: pointer, a3: csize_t, a4: pointer
  ) {.cdecl, raises: [].}
  CPLVirtualMemUnCachePageCbk* = proc(
    a0: ptr CPLVirtualMem, a1: csize_t, a2: pointer, a3: csize_t, a4: pointer
  ) {.cdecl, raises: [].}
  CPLVirtualMemFreeUserData* = proc(a0: pointer) {.cdecl, raises: [].}
  CPLVirtualMemAccessMode* = distinct cuint
  VSIErrorNum* = cint
  GDALMajorObjectH* = pointer
  GDALDatasetH* = pointer
  GDALRasterBandH* = pointer
  GDALComputedRasterBandH* = pointer
  GDALDriverH* = pointer
  GDALColorTableH* = pointer
  GDALRasterAttributeTableH* = pointer
  GDALAsyncReaderH* = pointer
  GDALRelationshipH* = pointer
  GDALExtendedDataTypeH* = ptr GDALExtendedDataTypeHS
  GDALEDTComponentH* = ptr GDALEDTComponentHS
  GDALGroupH* = ptr GDALGroupHS
  GDALMDArrayH* = ptr GDALMDArrayHS
  GDALAttributeH* = ptr GDALAttributeHS
  GDALDimensionH* = ptr GDALDimensionHS
  GDALSubdatasetInfoH* = ptr GDALSubdatasetInfo
  OGRGeometryH* = pointer
  OGRGeomTransformerH* = ptr OGRGeomTransformer
  OGRGeomCoordinatePrecisionH* = ptr OGRGeomCoordinatePrecision
  OGRPreparedGeometryH* = ptr C_OGRPreparedGeometry
  OGRFieldDefnH* = pointer
  OGRFeatureDefnH* = pointer
  OGRGeomFieldDefnH* = ptr OGRGeomFieldDefnHS
  OGRFieldDomainH* = ptr OGRFieldDomainHS
  OGRFeatureH* = pointer
  OGRLayerH* = pointer
  OGRDataSourceH* = pointer
  OGRSFDriverH* = pointer
  OGRStyleMgrH* = pointer
  OGRStyleToolH* = pointer
  OGRStyleTableH* = pointer
  OGRSpatialReferenceH* = pointer
  OGRCoordinateTransformationH* = pointer
  OGRCoordinateTransformationOptionsH* = ptr OGRCoordinateTransformationOptions
  GNMNetworkH* = pointer
  GNMGenericNetworkH* = pointer
  OGRErr* = cint
  OGRBoolean* = cint
  OGRwkbGeometryType* = distinct cuint
  OGRwkbVariant* = distinct cuint
  OGRwkbByteOrder* = distinct cuint
  OGRFieldType* = distinct cuint
  OGRFieldSubType* = distinct cuint
  OGRJustification* = distinct cuint
  OGRSTClassId* = distinct cuint
  OGRSTUnitId* = distinct cuint
  OGRSTPenParam* = distinct cuint
  OGRSTBrushParam* = distinct cuint
  OGRSTSymbolParam* = distinct cuint
  OGRSTLabelParam* = distinct cuint
  OGRFieldDomainType* = distinct cuint
  OGRFieldDomainSplitPolicy* = distinct cuint
  OGRFieldDomainMergePolicy* = distinct cuint
  GDALDataType* = distinct cuint
  GDALAsyncStatusType* = distinct cuint
  GDALAccess* = distinct cuint
  GDALRWFlag* = distinct cuint
  GDALRIOResampleAlg* = distinct cuint
  GDALColorInterp* = distinct cuint
  GDALPaletteInterp* = distinct cuint
  GSpacing* = GIntBig
  GDALExtendedDataTypeClass* = distinct cuint
  GDALExtendedDataTypeSubType* = distinct cuint
  GDALQueryLoggerFunc* = proc(
    a0: cstring, a1: cstring, a2: int64, a3: int64, a4: pointer
  ) {.cdecl, raises: [].}
  GDALDerivedPixelFunc* = proc(
    a0: ptr pointer,
    a1: cint,
    a2: pointer,
    a3: cint,
    a4: cint,
    a5: GDALDataType,
    a6: GDALDataType,
    a7: cint,
    a8: cint,
  ): CPLErr {.cdecl, raises: [].}
  GDALDerivedPixelFuncWithArgs* = proc(
    a0: ptr pointer,
    a1: cint,
    a2: pointer,
    a3: cint,
    a4: cint,
    a5: GDALDataType,
    a6: GDALDataType,
    a7: cint,
    a8: cint,
    a9: CSLConstList,
  ): CPLErr {.cdecl, raises: [].}
  VRTPDWorkingDataPtr* = pointer
  GDALVRTProcessedDatasetFuncInit* = proc(
    a0: cstring,
    a1: pointer,
    a2: CSLConstList,
    a3: cint,
    a4: GDALDataType,
    a5: ptr cdouble,
    a6: ptr cint,
    a7: ptr GDALDataType,
    a8: ptr ptr cdouble,
    a9: cstring,
    a10: ptr VRTPDWorkingDataPtr,
  ): CPLErr {.cdecl, raises: [].}
  GDALVRTProcessedDatasetFuncFree* =
    proc(a0: cstring, a1: pointer, a2: VRTPDWorkingDataPtr) {.cdecl, raises: [].}
  GDALVRTProcessedDatasetFuncProcess* = proc(
    a0: cstring,
    a1: pointer,
    a2: VRTPDWorkingDataPtr,
    a3: CSLConstList,
    a4: cint,
    a5: cint,
    a6: pointer,
    a7: csize_t,
    a8: GDALDataType,
    a9: cint,
    a10: ptr cdouble,
    a11: pointer,
    a12: csize_t,
    a13: GDALDataType,
    a14: cint,
    a15: ptr cdouble,
    a16: cdouble,
    a17: cdouble,
    a18: cdouble,
    a19: cdouble,
    a20: ptr cdouble,
    a21: cstring,
    a22: CSLConstList,
  ): CPLErr {.cdecl, raises: [].}
  GDALRasterAlgebraUnaryOperation* = distinct cuint
  GDALRasterAlgebraBinaryOperation* = distinct cuint
  GDALRATFieldType* = distinct cuint
  GDALRATFieldUsage* = distinct cuint
  GDALRATTableType* = distinct cuint
  GDALRelationshipCardinality* = distinct cuint
  GDALRelationshipType* = distinct cuint
  GDALTileOrganization* = distinct cuint
  GDALAdbcLoadDriverFunc* = proc(
    a0: cstring, a1: cstring, a2: cint, a3: pointer, a4: pointer
  ): uint8 {.cdecl, raises: [].}
  GDALTransformerFunc* = proc(
    a0: pointer,
    a1: cint,
    a2: cint,
    a3: ptr cdouble,
    a4: ptr cdouble,
    a5: ptr cdouble,
    a6: ptr cint,
  ): cint {.cdecl, raises: [].}
  GDALContourWriter* = proc(
    a0: cdouble, a1: cint, a2: ptr cdouble, a3: ptr cdouble, a4: pointer
  ): CPLErr {.cdecl, raises: [].}
  GDALContourGeneratorH* = pointer
  GDALViewshedMode* = distinct cuint
  GDALViewshedOutputType* = distinct cuint
  GDALGridAlgorithm* = distinct cuint
  VRTImageReadFunc* = proc(
    a0: pointer, a1: cint, a2: cint, a3: cint, a4: cint, a5: pointer
  ): CPLErr {.cdecl, raises: [].}
  VRTAveragedSourceH* = pointer
  VRTAverageFilteredSourceH* = pointer
  VRTComplexSourceH* = pointer
  VRTDerivedRasterBandH* = pointer
  VRTDriverH* = pointer
  VRTFilteredSourceH* = pointer
  VRTFuncSourceH* = pointer
  VRTKernelFilteredSourceH* = pointer
  VRTRasterBandH* = pointer
  VRTRawRasterBandH* = pointer
  VRTSimpleSourceH* = pointer
  VRTSourceH* = pointer
  VRTWarpedDatasetH* = pointer
  VRTWarpedRasterBandH* = pointer
  VRTDatasetH* = pointer
  VRTSourcedRasterBandH* = pointer
  GDALAlgorithmArgType* = distinct cuint
  GDALArgDatasetValueH* = ptr GDALArgDatasetValueHS
  GDALAlgorithmArgH* = ptr GDALAlgorithmArgHS
  GDALAlgorithmH* = ptr GDALAlgorithmHS
  GDALAlgorithmRegistryH* = ptr GDALAlgorithmRegistryHS
  GDALArgDatasetType* = cint
  GDALGridFunction* = proc(
    a0: pointer,
    a1: GUInt32,
    a2: ptr cdouble,
    a3: ptr cdouble,
    a4: ptr cdouble,
    a5: cdouble,
    a6: cdouble,
    a7: ptr cdouble,
    a8: pointer,
  ): CPLErr {.cdecl, raises: [].}
  GDALPansharpenAlg* = distinct cuint
  GDALPansharpenOperationH* = pointer
  GDALResampleAlg* = distinct cuint
  GDALMaskFunc* = proc(
    a0: pointer,
    a1: cint,
    a2: GDALDataType,
    a3: cint,
    a4: cint,
    a5: cint,
    a6: cint,
    a7: ptr ptr GByte,
    a8: cint,
    a9: pointer,
  ): cint {.cdecl, raises: [].}
  GWKTieStrategy* = distinct cuint
  GDALWarpOperationH* = pointer
  FilterFuncType* = proc(a0: cdouble): cdouble {.cdecl, raises: [].}
  FilterFunc4ValuesType* = proc(a0: ptr cdouble): cdouble {.cdecl, raises: [].}
  GNMDirection* = cint
  GNMGraphAlgorithmType* = distinct cuint
  OGRGeocodingSessionH* = ptr C_OGRGeocodingSessionHS
  OGRAxisOrientation* = distinct cuint
  OSRAxisMappingStrategy* = distinct cuint
  OSRCRSType* = distinct cuint
  CPLCompressor* {.bycopy.} = object
    nStructVersion*: cint
    pszId*: cstring
    eType*: CPLCompressorType
    papszMetadata*: CSLConstList
    pfnFunc*: CPLCompressionFunc
    user_data*: pointer

  VSIVirtualHandle* {.incompleteStruct.} = object
  VSIDIR* {.incompleteStruct.} = object
  VSIDIREntry* {.bycopy.} = object
    pszName*: cstring
    nMode*: cint
    nSize*: vsi_l_offset
    nMTime*: GIntBig
    bModeKnown*: cchar
    bSizeKnown*: cchar
    bMTimeKnown*: cchar
    papszExtra*: cstringArray

  VSIFilesystemPluginCallbacksStruct* {.bycopy.} = object
    pUserData*: pointer
    stat*: VSIFilesystemPluginStatCallback
    unlink*: VSIFilesystemPluginUnlinkCallback
    rename*: VSIFilesystemPluginRenameCallback
    mkdir*: VSIFilesystemPluginMkdirCallback
    rmdir*: VSIFilesystemPluginRmdirCallback
    read_dir*: VSIFilesystemPluginReadDirCallback
    open*: VSIFilesystemPluginOpenCallback
    tell*: VSIFilesystemPluginTellCallback
    seek*: VSIFilesystemPluginSeekCallback
    read*: VSIFilesystemPluginReadCallback
    read_multi_range*: VSIFilesystemPluginReadMultiRangeCallback
    get_range_status*: VSIFilesystemPluginGetRangeStatusCallback
    eof*: VSIFilesystemPluginEofCallback
    write*: VSIFilesystemPluginWriteCallback
    flush*: VSIFilesystemPluginFlushCallback
    truncate*: VSIFilesystemPluginTruncateCallback
    close*: VSIFilesystemPluginCloseCallback
    nBufferSize*: csize_t
    nCacheSize*: csize_t
    sibling_files*: VSIFilesystemPluginSiblingFilesCallback
    advise_read*: VSIFilesystemPluginAdviseReadCallback
    error*: VSIFilesystemPluginErrorCallback
    clear_err*: VSIFilesystemPluginClearErrCallback

  CPLSharedFileInfo* {.bycopy.} = object
    fp*: ptr GdalFile
    nRefCount*: cint
    bLarge*: cint
    pszFilename*: cstring
    pszAccess*: cstring

  CPLLockFileStruct* {.incompleteStruct.} = object
  C_CPLHashSet* {.incompleteStruct.} = object
  CPLMimePart* {.bycopy.} = object
    papszHeaders*: cstringArray
    pabyData*: ptr GByte
    nDataLen*: cint

  CPLHTTPResult* {.bycopy.} = object
    nStatus*: cint
    pszContentType*: cstring
    pszErrBuf*: cstring
    nDataLen*: cint
    nDataAlloc*: cint
    pabyData*: ptr GByte
    papszHeaders*: cstringArray
    nMimePartCount*: cint
    pasMimePart*: ptr CPLMimePart

  C_CPLList* {.bycopy.} = object
    pData*: pointer
    psNext*: ptr C_CPLList

  CPLXMLNode* {.bycopy.} = object
    eType*: CPLXMLNodeType
    pszValue*: cstring
    psNext*: ptr CPLXMLNode
    psChild*: ptr CPLXMLNode

  C_CPLMutex* {.incompleteStruct.} = object
  C_CPLCond* {.incompleteStruct.} = object
  C_CPLJoinableThread* {.incompleteStruct.} = object
  C_CPLLock* {.incompleteStruct.} = object
  CPLRectObj* {.bycopy.} = object
    minx*: cdouble
    miny*: cdouble
    maxx*: cdouble
    maxy*: cdouble

  C_CPLQuadTree* {.incompleteStruct.} = object
  C_CPLSpawnedProcess* {.incompleteStruct.} = object
  CPLVirtualMem* {.incompleteStruct.} = object
  GDALExtendedDataTypeHS* {.incompleteStruct.} = object
  GDALEDTComponentHS* {.incompleteStruct.} = object
  GDALGroupHS* {.incompleteStruct.} = object
  GDALMDArrayHS* {.incompleteStruct.} = object
  GDALAttributeHS* {.incompleteStruct.} = object
  GDALDimensionHS* {.incompleteStruct.} = object
  GDALSubdatasetInfo* {.incompleteStruct.} = object
  OGRGeomTransformer* {.incompleteStruct.} = object
  OGRGeomCoordinatePrecision* {.incompleteStruct.} = object
  OGRwkbExportOptions* {.incompleteStruct.} = object
  C_OGRPreparedGeometry* {.incompleteStruct.} = object
  OGRGeomFieldDefnHS* {.incompleteStruct.} = object
  OGRFieldDomainHS* {.incompleteStruct.} = object
  OGRCoordinateTransformationOptions* {.incompleteStruct.} = object
  OGREnvelope* {.bycopy.} = object
    MinX*: cdouble
    MaxX*: cdouble
    MinY*: cdouble
    MaxY*: cdouble

  OGREnvelope3D* {.bycopy.} = object
    MinX*: cdouble
    MaxX*: cdouble
    MinY*: cdouble
    MaxY*: cdouble
    MinZ*: cdouble
    MaxZ*: cdouble

  OGRField* {.union, bycopy.} = object
    Integer*: cint
    Integer64*: GIntBig
    Real*: cdouble
    String*: cstring
    IntegerList*: OGRField_911
    Integer64List*: OGRField_917
    RealList*: OGRField_923
    StringList*: OGRField_929
    Binary*: OGRField_935
    Set*: OGRField_941
    Date*: OGRField_948

  OGRField_911* {.bycopy.} = object
    nCount*: cint
    paList*: ptr cint

  OGRField_917* {.bycopy.} = object
    nCount*: cint
    paList*: ptr GIntBig

  OGRField_923* {.bycopy.} = object
    nCount*: cint
    paList*: ptr cdouble

  OGRField_929* {.bycopy.} = object
    nCount*: cint
    paList*: cstringArray

  OGRField_935* {.bycopy.} = object
    nCount*: cint
    paData*: ptr GByte

  OGRField_941* {.bycopy.} = object
    nMarker1*: cint
    nMarker2*: cint
    nMarker3*: cint

  OGRField_948* {.bycopy.} = object
    Year*: GInt16
    Month*: GByte
    Day*: GByte
    Hour*: GByte
    Minute*: GByte
    TZFlag*: GByte
    Reserved*: GByte
    Second*: cfloat

  OGRCodedValue* {.bycopy.} = object
    pszCode*: cstring
    pszValue*: cstring

  C_CPLXMLNode* {.incompleteStruct.} = object
  OGRGeometryTypeCounter* {.bycopy.} = object
    eGeomType*: OGRwkbGeometryType
    nCount*: int64

  ArrowArrayStream* {.bycopy.} = object
    get_schema*:
      proc(a0: ptr ArrowArrayStream, a1: ptr ArrowSchema): cint {.cdecl, raises: [].}
    get_next*:
      proc(a0: ptr ArrowArrayStream, a1: ptr ArrowArray): cint {.cdecl, raises: [].}
    get_last_error*: proc(a0: ptr ArrowArrayStream): cstring {.cdecl, raises: [].}
    release*: proc(a0: ptr ArrowArrayStream) {.cdecl, raises: [].}
    private_data*: pointer

  ArrowSchema* {.bycopy.} = object
    format*: cstring
    name*: cstring
    metadata*: cstring
    flags*: int64
    n_children*: int64
    children*: ptr ptr ArrowSchema
    dictionary*: ptr ArrowSchema
    release*: proc(a0: ptr ArrowSchema) {.cdecl, raises: [].}
    private_data*: pointer

  ArrowArray* {.bycopy.} = object
    length*: int64
    null_count*: int64
    offset*: int64
    n_buffers*: int64
    n_children*: int64
    buffers*: ptr pointer
    children*: ptr ptr ArrowArray
    dictionary*: ptr ArrowArray
    release*: proc(a0: ptr ArrowArray) {.cdecl, raises: [].}
    private_data*: pointer

  GDALRasterIOExtraArg* {.bycopy.} = object
    nVersion*: cint
    eResampleAlg*: GDALRIOResampleAlg
    pfnProgress*: GDALProgressFunc
    pProgressData*: pointer
    bFloatingPointWindowValidity*: cint
    dfXOff*: cdouble
    dfYOff*: cdouble
    dfXSize*: cdouble
    dfYSize*: cdouble
    bUseOnlyThisScale*: cint
    bOperateInBufType*: cint

  GDAL_GCP* {.bycopy.} = object
    pszId*: cstring
    pszInfo*: cstring
    dfGCPPixel*: cdouble
    dfGCPLine*: cdouble
    dfGCPX*: cdouble
    dfGCPY*: cdouble
    dfGCPZ*: cdouble

  GDALRPCInfoV1* {.bycopy.} = object
    dfLINE_OFF*: cdouble
    dfSAMP_OFF*: cdouble
    dfLAT_OFF*: cdouble
    dfLONG_OFF*: cdouble
    dfHEIGHT_OFF*: cdouble
    dfLINE_SCALE*: cdouble
    dfSAMP_SCALE*: cdouble
    dfLAT_SCALE*: cdouble
    dfLONG_SCALE*: cdouble
    dfHEIGHT_SCALE*: cdouble
    adfLINE_NUM_COEFF*: array[20, cdouble]
    adfLINE_DEN_COEFF*: array[20, cdouble]
    adfSAMP_NUM_COEFF*: array[20, cdouble]
    adfSAMP_DEN_COEFF*: array[20, cdouble]
    dfMIN_LONG*: cdouble
    dfMIN_LAT*: cdouble
    dfMAX_LONG*: cdouble
    dfMAX_LAT*: cdouble

  GDALRPCInfoV2* {.bycopy.} = object
    dfLINE_OFF*: cdouble
    dfSAMP_OFF*: cdouble
    dfLAT_OFF*: cdouble
    dfLONG_OFF*: cdouble
    dfHEIGHT_OFF*: cdouble
    dfLINE_SCALE*: cdouble
    dfSAMP_SCALE*: cdouble
    dfLAT_SCALE*: cdouble
    dfLONG_SCALE*: cdouble
    dfHEIGHT_SCALE*: cdouble
    adfLINE_NUM_COEFF*: array[20, cdouble]
    adfLINE_DEN_COEFF*: array[20, cdouble]
    adfSAMP_NUM_COEFF*: array[20, cdouble]
    adfSAMP_DEN_COEFF*: array[20, cdouble]
    dfMIN_LONG*: cdouble
    dfMIN_LAT*: cdouble
    dfMAX_LONG*: cdouble
    dfMAX_LAT*: cdouble
    dfERR_BIAS*: cdouble
    dfERR_RAND*: cdouble

  GDALColorEntry* {.bycopy.} = object
    c1*: cshort
    c2*: cshort
    c3*: cshort
    c4*: cshort

  GDALRATDateTime* {.bycopy.} = object
    nYear*: cint
    nMonth*: cint
    nDay*: cint
    nHour*: cint
    nMinute*: cint
    fSecond*: cfloat
    nTimeZoneHour*: cint
    nTimeZoneMinute*: cint
    bPositiveTimeZone*: bool
    bIsValid*: bool

  GDALMDArrayRawBlockInfo* {.bycopy.} = object
    pszFilename*: cstring
    nOffset*: uint64
    nSize*: uint64
    papszInfo*: cstringArray
    pabyInlineData*: ptr GByte

  GDALTransformerInfo* {.bycopy.} = object
    abySignature*: array[4, GByte]
    pszClassName*: cstring
    pfnTransform*: GDALTransformerFunc
    pfnCleanup*: proc(a0: pointer) {.cdecl, raises: [].}
    pfnSerialize*: proc(a0: pointer): ptr CPLXMLNode {.cdecl, raises: [].}
    pfnCreateSimilar*:
      proc(a0: pointer, a1: cdouble, a2: cdouble): pointer {.cdecl, raises: [].}

  OGRContourWriterInfo* {.bycopy.} = object
    hLayer*: pointer
    adfGeoTransform*: array[6, cdouble]
    nElevField*: cint
    nElevFieldMin*: cint
    nElevFieldMax*: cint
    nIDField*: cint
    nNextID*: cint
    nWrittenFeatureCountSinceLastCommit*: GIntBig
    nTransactionCommitInterval*: GIntBig

  GDALGridInverseDistanceToAPowerOptions* {.bycopy.} = object
    nSizeOfStructure*: csize_t
    dfPower*: cdouble
    dfSmoothing*: cdouble
    dfAnisotropyRatio*: cdouble
    dfAnisotropyAngle*: cdouble
    dfRadius1*: cdouble
    dfRadius2*: cdouble
    dfAngle*: cdouble
    nMaxPoints*: GUInt32
    nMinPoints*: GUInt32
    dfNoDataValue*: cdouble

  GDALGridInverseDistanceToAPowerNearestNeighborOptions* {.bycopy.} = object
    nSizeOfStructure*: csize_t
    dfPower*: cdouble
    dfRadius*: cdouble
    dfSmoothing*: cdouble
    nMaxPoints*: GUInt32
    nMinPoints*: GUInt32
    dfNoDataValue*: cdouble
    nMaxPointsPerQuadrant*: GUInt32
    nMinPointsPerQuadrant*: GUInt32

  GDALGridMovingAverageOptions* {.bycopy.} = object
    nSizeOfStructure*: csize_t
    dfRadius1*: cdouble
    dfRadius2*: cdouble
    dfAngle*: cdouble
    nMaxPoints*: GUInt32
    nMinPoints*: GUInt32
    dfNoDataValue*: cdouble
    nMaxPointsPerQuadrant*: GUInt32
    nMinPointsPerQuadrant*: GUInt32

  GDALGridNearestNeighborOptions* {.bycopy.} = object
    nSizeOfStructure*: csize_t
    dfRadius1*: cdouble
    dfRadius2*: cdouble
    dfAngle*: cdouble
    dfNoDataValue*: cdouble

  GDALGridDataMetricsOptions* {.bycopy.} = object
    nSizeOfStructure*: csize_t
    dfRadius1*: cdouble
    dfRadius2*: cdouble
    dfAngle*: cdouble
    nMinPoints*: GUInt32
    dfNoDataValue*: cdouble
    nMaxPointsPerQuadrant*: GUInt32
    nMinPointsPerQuadrant*: GUInt32

  GDALGridLinearOptions* {.bycopy.} = object
    nSizeOfStructure*: csize_t
    dfRadius*: cdouble
    dfNoDataValue*: cdouble

  GDALGridContext* {.incompleteStruct.} = object
  GDALTriFacet* {.bycopy.} = object
    anVertexIdx*: array[3, cint]
    anNeighborIdx*: array[3, cint]

  GDALTriBarycentricCoefficients* {.bycopy.} = object
    dfMul1X*: cdouble
    dfMul1Y*: cdouble
    dfMul2X*: cdouble
    dfMul2Y*: cdouble
    dfCstX*: cdouble
    dfCstY*: cdouble

  GDALTriangulation* {.bycopy.} = object
    nFacets*: cint
    pasFacets*: ptr GDALTriFacet
    pasFacetCoefficients*: ptr GDALTriBarycentricCoefficients

  GDALInfoOptions* {.incompleteStruct.} = object
  GDALInfoOptionsForBinary* {.incompleteStruct.} = object
  GDALTranslateOptions* {.incompleteStruct.} = object
  GDALTranslateOptionsForBinary* {.incompleteStruct.} = object
  GDALWarpAppOptions* {.incompleteStruct.} = object
  GDALWarpAppOptionsForBinary* {.incompleteStruct.} = object
  GDALVectorTranslateOptions* {.incompleteStruct.} = object
  GDALVectorTranslateOptionsForBinary* {.incompleteStruct.} = object
  GDALDEMProcessingOptions* {.incompleteStruct.} = object
  GDALDEMProcessingOptionsForBinary* {.incompleteStruct.} = object
  GDALNearblackOptions* {.incompleteStruct.} = object
  GDALNearblackOptionsForBinary* {.incompleteStruct.} = object
  GDALGridOptions* {.incompleteStruct.} = object
  GDALGridOptionsForBinary* {.incompleteStruct.} = object
  GDALContourOptions* {.incompleteStruct.} = object
  GDALContourOptionsForBinary* {.incompleteStruct.} = object
  GDALRasterizeOptions* {.incompleteStruct.} = object
  GDALRasterizeOptionsForBinary* {.incompleteStruct.} = object
  GDALFootprintOptions* {.incompleteStruct.} = object
  GDALFootprintOptionsForBinary* {.incompleteStruct.} = object
  GDALBuildVRTOptions* {.incompleteStruct.} = object
  GDALBuildVRTOptionsForBinary* {.incompleteStruct.} = object
  GDALMultiDimInfoOptions* {.incompleteStruct.} = object
  GDALMultiDimInfoOptionsForBinary* {.incompleteStruct.} = object
  GDALMultiDimTranslateOptions* {.incompleteStruct.} = object
  GDALMultiDimTranslateOptionsForBinary* {.incompleteStruct.} = object
  GDALVectorInfoOptions* {.incompleteStruct.} = object
  GDALVectorInfoOptionsForBinary* {.incompleteStruct.} = object
  GDALTileIndexOptions* {.incompleteStruct.} = object
  GDALTileIndexOptionsForBinary* {.incompleteStruct.} = object
  GDALArgDatasetValueHS* {.incompleteStruct.} = object
  GDALAlgorithmArgHS* {.incompleteStruct.} = object
  GDALAlgorithmHS* {.incompleteStruct.} = object
  GDALAlgorithmRegistryHS* {.incompleteStruct.} = object
  GDALPansharpenOptions* {.bycopy.} = object
    ePansharpenAlg*: GDALPansharpenAlg
    eResampleAlg*: GDALRIOResampleAlg
    nBitDepth*: cint
    nWeightCount*: cint
    padfWeights*: ptr cdouble
    hPanchroBand*: GDALRasterBandH
    nInputSpectralBands*: cint
    pahInputSpectralBands*: ptr GDALRasterBandH
    nOutPansharpenedBands*: cint
    panOutPansharpenedBands*: ptr cint
    bHasNoData*: cint
    dfNoData*: cdouble
    nThreads*: cint

  GDALWarpOptions* {.bycopy.} = object
    papszWarpOptions*: cstringArray
    dfWarpMemoryLimit*: cdouble
    eResampleAlg*: GDALResampleAlg
    eWorkingDataType*: GDALDataType
    hSrcDS*: GDALDatasetH
    hDstDS*: GDALDatasetH
    nBandCount*: cint
    panSrcBands*: ptr cint
    panDstBands*: ptr cint
    nSrcAlphaBand*: cint
    nDstAlphaBand*: cint
    padfSrcNoDataReal*: ptr cdouble
    padfSrcNoDataImag*: ptr cdouble
    padfDstNoDataReal*: ptr cdouble
    padfDstNoDataImag*: ptr cdouble
    pfnProgress*: GDALProgressFunc
    pProgressArg*: pointer
    pfnTransformer*: GDALTransformerFunc
    pTransformerArg*: pointer
    papfnSrcPerBandValidityMaskFunc*: ptr GDALMaskFunc
    papSrcPerBandValidityMaskFuncArg*: ptr pointer
    pfnSrcValidityMaskFunc*: GDALMaskFunc
    pSrcValidityMaskFuncArg*: pointer
    pfnSrcDensityMaskFunc*: GDALMaskFunc
    pSrcDensityMaskFuncArg*: pointer
    pfnDstDensityMaskFunc*: GDALMaskFunc
    pDstDensityMaskFuncArg*: pointer
    pfnDstValidityMaskFunc*: GDALMaskFunc
    pDstValidityMaskFuncArg*: pointer
    pfnPreWarpChunkProcessor*:
      proc(a0: pointer, a1: pointer): CPLErr {.cdecl, raises: [].}
    pPreWarpProcessorArg*: pointer
    pfnPostWarpChunkProcessor*:
      proc(a0: pointer, a1: pointer): CPLErr {.cdecl, raises: [].}
    pPostWarpProcessorArg*: pointer
    hCutline*: pointer
    dfCutlineBlendDist*: cdouble
    eTieStrategy*: GWKTieStrategy

  C_OGRGeocodingSessionHS* {.incompleteStruct.} = object
  OSRCRSInfo* {.bycopy.} = object
    pszAuthName*: cstring
    pszCode*: cstring
    pszName*: cstring
    eType*: OSRCRSType
    bDeprecated*: cint
    bBboxValid*: cint
    dfWestLongitudeDeg*: cdouble
    dfSouthLatitudeDeg*: cdouble
    dfEastLongitudeDeg*: cdouble
    dfNorthLatitudeDeg*: cdouble
    pszAreaName*: cstring
    pszProjectionMethod*: cstring
    pszCelestialBodyName*: cstring

  OSRCRSListParameters* {.incompleteStruct.} = object

proc `==`*(a, b: CPLCompressorType): bool {.borrow.}
proc `$`*(value: CPLCompressorType): string {.borrow.}
proc `==`*(a, b: VSIRangeStatus): bool {.borrow.}
proc `$`*(value: VSIRangeStatus): string {.borrow.}
proc `==`*(a, b: CPLErr): bool {.borrow.}
proc `$`*(value: CPLErr): string {.borrow.}
proc `==`*(a, b: CPLLockFileStatus): bool {.borrow.}
proc `$`*(value: CPLLockFileStatus): string {.borrow.}
proc `==`*(a, b: CPLValueType): bool {.borrow.}
proc `$`*(value: CPLValueType): string {.borrow.}
proc `==`*(a, b: CSVCompareCriteria): bool {.borrow.}
proc `$`*(value: CSVCompareCriteria): string {.borrow.}
proc `==`*(a, b: CPLXMLNodeType): bool {.borrow.}
proc `$`*(value: CPLXMLNodeType): string {.borrow.}
proc `==`*(a, b: CPLCondTimedWaitReason): bool {.borrow.}
proc `$`*(value: CPLCondTimedWaitReason): string {.borrow.}
proc `==`*(a, b: CPLLockType): bool {.borrow.}
proc `$`*(value: CPLLockType): string {.borrow.}
proc `==`*(a, b: CPLVirtualMemAccessMode): bool {.borrow.}
proc `$`*(value: CPLVirtualMemAccessMode): string {.borrow.}
proc `==`*(a, b: OGRwkbGeometryType): bool {.borrow.}
proc `$`*(value: OGRwkbGeometryType): string {.borrow.}
proc `==`*(a, b: OGRwkbVariant): bool {.borrow.}
proc `$`*(value: OGRwkbVariant): string {.borrow.}
proc `==`*(a, b: OGRwkbByteOrder): bool {.borrow.}
proc `$`*(value: OGRwkbByteOrder): string {.borrow.}
proc `==`*(a, b: OGRFieldType): bool {.borrow.}
proc `$`*(value: OGRFieldType): string {.borrow.}
proc `==`*(a, b: OGRFieldSubType): bool {.borrow.}
proc `$`*(value: OGRFieldSubType): string {.borrow.}
proc `==`*(a, b: OGRJustification): bool {.borrow.}
proc `$`*(value: OGRJustification): string {.borrow.}
proc `==`*(a, b: OGRSTClassId): bool {.borrow.}
proc `$`*(value: OGRSTClassId): string {.borrow.}
proc `==`*(a, b: OGRSTUnitId): bool {.borrow.}
proc `$`*(value: OGRSTUnitId): string {.borrow.}
proc `==`*(a, b: OGRSTPenParam): bool {.borrow.}
proc `$`*(value: OGRSTPenParam): string {.borrow.}
proc `==`*(a, b: OGRSTBrushParam): bool {.borrow.}
proc `$`*(value: OGRSTBrushParam): string {.borrow.}
proc `==`*(a, b: OGRSTSymbolParam): bool {.borrow.}
proc `$`*(value: OGRSTSymbolParam): string {.borrow.}
proc `==`*(a, b: OGRSTLabelParam): bool {.borrow.}
proc `$`*(value: OGRSTLabelParam): string {.borrow.}
proc `==`*(a, b: OGRFieldDomainType): bool {.borrow.}
proc `$`*(value: OGRFieldDomainType): string {.borrow.}
proc `==`*(a, b: OGRFieldDomainSplitPolicy): bool {.borrow.}
proc `$`*(value: OGRFieldDomainSplitPolicy): string {.borrow.}
proc `==`*(a, b: OGRFieldDomainMergePolicy): bool {.borrow.}
proc `$`*(value: OGRFieldDomainMergePolicy): string {.borrow.}
proc `==`*(a, b: GDALDataType): bool {.borrow.}
proc `$`*(value: GDALDataType): string {.borrow.}
proc `==`*(a, b: GDALAsyncStatusType): bool {.borrow.}
proc `$`*(value: GDALAsyncStatusType): string {.borrow.}
proc `==`*(a, b: GDALAccess): bool {.borrow.}
proc `$`*(value: GDALAccess): string {.borrow.}
proc `==`*(a, b: GDALRWFlag): bool {.borrow.}
proc `$`*(value: GDALRWFlag): string {.borrow.}
proc `==`*(a, b: GDALRIOResampleAlg): bool {.borrow.}
proc `$`*(value: GDALRIOResampleAlg): string {.borrow.}
proc `==`*(a, b: GDALColorInterp): bool {.borrow.}
proc `$`*(value: GDALColorInterp): string {.borrow.}
proc `==`*(a, b: GDALPaletteInterp): bool {.borrow.}
proc `$`*(value: GDALPaletteInterp): string {.borrow.}
proc `==`*(a, b: GDALExtendedDataTypeClass): bool {.borrow.}
proc `$`*(value: GDALExtendedDataTypeClass): string {.borrow.}
proc `==`*(a, b: GDALExtendedDataTypeSubType): bool {.borrow.}
proc `$`*(value: GDALExtendedDataTypeSubType): string {.borrow.}
proc `==`*(a, b: GDALRasterAlgebraUnaryOperation): bool {.borrow.}
proc `$`*(value: GDALRasterAlgebraUnaryOperation): string {.borrow.}
proc `==`*(a, b: GDALRasterAlgebraBinaryOperation): bool {.borrow.}
proc `$`*(value: GDALRasterAlgebraBinaryOperation): string {.borrow.}
proc `==`*(a, b: GDALRATFieldType): bool {.borrow.}
proc `$`*(value: GDALRATFieldType): string {.borrow.}
proc `==`*(a, b: GDALRATFieldUsage): bool {.borrow.}
proc `$`*(value: GDALRATFieldUsage): string {.borrow.}
proc `==`*(a, b: GDALRATTableType): bool {.borrow.}
proc `$`*(value: GDALRATTableType): string {.borrow.}
proc `==`*(a, b: GDALRelationshipCardinality): bool {.borrow.}
proc `$`*(value: GDALRelationshipCardinality): string {.borrow.}
proc `==`*(a, b: GDALRelationshipType): bool {.borrow.}
proc `$`*(value: GDALRelationshipType): string {.borrow.}
proc `==`*(a, b: GDALTileOrganization): bool {.borrow.}
proc `$`*(value: GDALTileOrganization): string {.borrow.}
proc `==`*(a, b: GDALViewshedMode): bool {.borrow.}
proc `$`*(value: GDALViewshedMode): string {.borrow.}
proc `==`*(a, b: GDALViewshedOutputType): bool {.borrow.}
proc `$`*(value: GDALViewshedOutputType): string {.borrow.}
proc `==`*(a, b: GDALGridAlgorithm): bool {.borrow.}
proc `$`*(value: GDALGridAlgorithm): string {.borrow.}
proc `==`*(a, b: GDALAlgorithmArgType): bool {.borrow.}
proc `$`*(value: GDALAlgorithmArgType): string {.borrow.}
proc `==`*(a, b: GDALPansharpenAlg): bool {.borrow.}
proc `$`*(value: GDALPansharpenAlg): string {.borrow.}
proc `==`*(a, b: GDALResampleAlg): bool {.borrow.}
proc `$`*(value: GDALResampleAlg): string {.borrow.}
proc `==`*(a, b: GWKTieStrategy): bool {.borrow.}
proc `$`*(value: GWKTieStrategy): string {.borrow.}
proc `==`*(a, b: GNMGraphAlgorithmType): bool {.borrow.}
proc `$`*(value: GNMGraphAlgorithmType): string {.borrow.}
proc `==`*(a, b: OGRAxisOrientation): bool {.borrow.}
proc `$`*(value: OGRAxisOrientation): string {.borrow.}
proc `==`*(a, b: OSRAxisMappingStrategy): bool {.borrow.}
proc `$`*(value: OSRAxisMappingStrategy): string {.borrow.}
proc `==`*(a, b: OSRCRSType): bool {.borrow.}
proc `$`*(value: OSRCRSType): string {.borrow.}

const
  ALTER_ALL_FLAG* = 511
  ALTER_ALTERNATIVE_NAME_FLAG* = 128
  ALTER_COMMENT_FLAG* = 256
  ALTER_DEFAULT_FLAG* = 16
  ALTER_DOMAIN_FLAG* = 64
  ALTER_GEOM_FIELD_DEFN_ALL_FLAG* = 126976
  ALTER_GEOM_FIELD_DEFN_NAME_FLAG* = 4096
  ALTER_GEOM_FIELD_DEFN_NULLABLE_FLAG* = 16384
  ALTER_GEOM_FIELD_DEFN_SRS_COORD_EPOCH_FLAG* = 65536
  ALTER_GEOM_FIELD_DEFN_SRS_FLAG* = 32768
  ALTER_GEOM_FIELD_DEFN_TYPE_FLAG* = 8192
  ALTER_NAME_FLAG* = 1
  ALTER_NULLABLE_FLAG* = 8
  ALTER_TYPE_FLAG* = 2
  ALTER_UNIQUE_FLAG* = 32
  ALTER_WIDTH_PRECISION_FLAG* = 4
  ARROW_FLAG_DICTIONARY_ORDERED* = 1
  ARROW_FLAG_MAP_KEYS_SORTED* = 4
  ARROW_FLAG_NULLABLE* = 2
  CCT_COMPRESSOR* = CPLCompressorType(0)
  CCT_FILTER* = CPLCompressorType(1)
  CC_ApproxString* = CSVCompareCriteria(1)
  CC_ExactString* = CSVCompareCriteria(0)
  CC_Integer* = CSVCompareCriteria(2)
  CE_Debug* = CPLErr(1)
  CE_Failure* = CPLErr(3)
  CE_Fatal* = CPLErr(4)
  CE_None* = CPLErr(0)
  CE_Warning* = CPLErr(2)
  CLFS_API_MISUSE* = CPLLockFileStatus(3)
  CLFS_CANNOT_CREATE_LOCK* = CPLLockFileStatus(1)
  CLFS_LOCK_BUSY* = CPLLockFileStatus(2)
  CLFS_OK* = CPLLockFileStatus(0)
  CLFS_THREAD_CREATION_FAILED* = CPLLockFileStatus(4)
  COND_TIMED_WAIT_COND* = CPLCondTimedWaitReason(0)
  COND_TIMED_WAIT_OTHER* = CPLCondTimedWaitReason(2)
  COND_TIMED_WAIT_TIME_OUT* = CPLCondTimedWaitReason(1)
  CPLES_BackslashQuotable* = 0
  CPLES_CSV* = 4
  CPLES_CSV_FORCE_QUOTING* = 6
  CPLES_SQL* = 3
  CPLES_SQLI* = 7
  CPLES_URL* = 2
  CPLES_XML* = 1
  CPLES_XML_BUT_QUOTES* = 5
  CPLE_AWSAccessDenied* = 14
  CPLE_AWSBucketNotFound* = 12
  CPLE_AWSError* = 17
  CPLE_AWSInvalidCredentials* = 15
  CPLE_AWSObjectNotFound* = 13
  CPLE_AWSSignatureDoesNotMatch* = 16
  CPLE_AccessDenied* = 14
  CPLE_AppDefined* = 1
  CPLE_AssertionFailed* = 7
  CPLE_BucketNotFound* = 12
  CPLE_FileIO* = 3
  CPLE_HttpResponse* = 11
  CPLE_IllegalArg* = 5
  CPLE_InvalidCredentials* = 15
  CPLE_NoWriteAccess* = 8
  CPLE_None* = 0
  CPLE_NotSupported* = 6
  CPLE_ObjectNotFound* = 13
  CPLE_ObjectNull* = 10
  CPLE_ObjectStorageGenericError* = 17
  CPLE_OpenFailed* = 4
  CPLE_OutOfMemory* = 2
  CPLE_SignatureDoesNotMatch* = 16
  CPLE_UserInterrupt* = 9
  CPL_ENC_ASCII* = "ASCII"
  CPL_ENC_ISO8859_1* = "ISO-8859-1"
  CPL_ENC_LOCALE* = ""
  CPL_ENC_UCS2* = "UCS-2"
  CPL_ENC_UCS4* = "UCS-4"
  CPL_ENC_UTF16* = "UTF-16"
  CPL_ENC_UTF8* = "UTF-8"
  CPL_HAS_GINT64* = 1
  CPL_HTTP_MAX_RETRY* = 0
  CPL_HTTP_RETRY_DELAY* = 30.0
  CPL_IS_LSB* = 1
  CPL_MUTEX_ADAPTIVE* = 1
  CPL_MUTEX_RECURSIVE* = 0
  CPL_MUTEX_REGULAR* = 2
  CPL_NULLPTR* = 0
  CPL_NULL_VALUE* = "__CPL_NULL_VALUE__"
  CPL_VALUE_INTEGER* = CPLValueType(2)
  CPL_VALUE_REAL* = CPLValueType(1)
  CPL_VALUE_STRING* = CPLValueType(0)
  CSLT_ALLOWEMPTYTOKENS* = 2
  CSLT_HONOURSTRINGS* = 1
  CSLT_PRESERVEESCAPES* = 8
  CSLT_PRESERVEQUOTES* = 4
  CSLT_STRIPENDSPACES* = 32
  CSLT_STRIPLEADSPACES* = 16
  CTLS_ABSTRACTARCHIVE_SPLIT* = 8
  CTLS_CONFIGOPTIONS* = 14
  CTLS_CPLSPRINTF* = 10
  CTLS_CSVDEFAULTFILENAME* = 4
  CTLS_CSVTABLEPTR* = 3
  CTLS_ERRORCONTEXT* = 5
  CTLS_FINDFILE* = 15
  CTLS_GDALDEFAULTOVR_ANTIREC* = 19
  CTLS_GDALOPEN_ANTIRECURSION* = 9
  CTLS_HTTPFETCHCALLBACK* = 20
  CTLS_MAX* = 32
  CTLS_PATHBUF* = 7
  CTLS_PROJCONTEXTHOLDER* = 18
  CTLS_RESPONSIBLEPID* = 11
  CTLS_RLBUFFERINFO* = 1
  CTLS_VERSIONINFO* = 12
  CTLS_VERSIONINFO_LICENCE* = 13
  CTLS_VSICURL_CACHEDCONNECTION* = 6
  CTLS_VSIERRORCONTEXT* = 16
  CTLS_WIN32_COND* = 2
  CXT_Attribute* = CPLXMLNodeType(2)
  CXT_Comment* = CPLXMLNodeType(3)
  CXT_Element* = CPLXMLNodeType(0)
  CXT_Literal* = CPLXMLNodeType(4)
  CXT_Text* = CPLXMLNodeType(1)
  FALSE* = 0
  GAAT_BOOLEAN* = GDALAlgorithmArgType(0)
  GAAT_DATASET* = GDALAlgorithmArgType(4)
  GAAT_DATASET_LIST* = GDALAlgorithmArgType(8)
  GAAT_INTEGER* = GDALAlgorithmArgType(2)
  GAAT_INTEGER_LIST* = GDALAlgorithmArgType(6)
  GAAT_REAL* = GDALAlgorithmArgType(3)
  GAAT_REAL_LIST* = GDALAlgorithmArgType(7)
  GAAT_STRING* = GDALAlgorithmArgType(1)
  GAAT_STRING_LIST* = GDALAlgorithmArgType(5)
  GADV_NAME* = 1
  GADV_OBJECT* = 2
  GARIO_COMPLETE* = GDALAsyncStatusType(3)
  GARIO_ERROR* = GDALAsyncStatusType(2)
  GARIO_PENDING* = GDALAsyncStatusType(0)
  GARIO_TypeCount* = GDALAsyncStatusType(4)
  GARIO_UPDATE* = GDALAsyncStatusType(1)
  GATConnectedComponents* = GNMGraphAlgorithmType(3)
  GATDijkstraShortestPath* = GNMGraphAlgorithmType(1)
  GATKShortestPath* = GNMGraphAlgorithmType(2)
  GA_ReadOnly* = GDALAccess(0)
  GA_Update* = GDALAccess(1)
  GCI_AlphaBand* = GDALColorInterp(6)
  GCI_BlackBand* = GDALColorInterp(13)
  GCI_BlueBand* = GDALColorInterp(5)
  GCI_CoastalBand* = GDALColorInterp(18)
  GCI_CyanBand* = GDALColorInterp(10)
  GCI_GrayIndex* = GDALColorInterp(1)
  GCI_GreenBand* = GDALColorInterp(4)
  GCI_HueBand* = GDALColorInterp(7)
  GCI_IR_End* = 29
  GCI_IR_Reserved_1* = GDALColorInterp(26)
  GCI_IR_Reserved_2* = GDALColorInterp(27)
  GCI_IR_Reserved_3* = GDALColorInterp(28)
  GCI_IR_Reserved_4* = GDALColorInterp(29)
  GCI_IR_Start* = 20
  GCI_LWIRBand* = GDALColorInterp(23)
  GCI_LightnessBand* = GDALColorInterp(9)
  GCI_MWIRBand* = GDALColorInterp(22)
  GCI_MagentaBand* = GDALColorInterp(11)
  GCI_Max* = GDALColorInterp(39)
  GCI_NIRBand* = GDALColorInterp(20)
  GCI_OtherIRBand* = GDALColorInterp(25)
  GCI_PaletteIndex* = GDALColorInterp(2)
  GCI_PanBand* = GDALColorInterp(17)
  GCI_RedBand* = GDALColorInterp(3)
  GCI_RedEdgeBand* = GDALColorInterp(19)
  GCI_SAR_C_Band* = GDALColorInterp(34)
  GCI_SAR_End* = 39
  GCI_SAR_K_Band* = GDALColorInterp(31)
  GCI_SAR_Ka_Band* = GDALColorInterp(30)
  GCI_SAR_Ku_Band* = GDALColorInterp(32)
  GCI_SAR_L_Band* = GDALColorInterp(36)
  GCI_SAR_P_Band* = GDALColorInterp(37)
  GCI_SAR_Reserved_1* = GDALColorInterp(38)
  GCI_SAR_Reserved_2* = GDALColorInterp(39)
  GCI_SAR_S_Band* = GDALColorInterp(35)
  GCI_SAR_Start* = 30
  GCI_SAR_X_Band* = GDALColorInterp(33)
  GCI_SWIRBand* = GDALColorInterp(21)
  GCI_SaturationBand* = GDALColorInterp(8)
  GCI_TIRBand* = GDALColorInterp(24)
  GCI_Undefined* = GDALColorInterp(0)
  GCI_YCbCr_CbBand* = GDALColorInterp(15)
  GCI_YCbCr_CrBand* = GDALColorInterp(16)
  GCI_YCbCr_YBand* = GDALColorInterp(14)
  GCI_YellowBand* = GDALColorInterp(12)
  GCMVF_CHUNK_FULLY_WITHIN_CUTLINE* = 2
  GCMVF_NO_INTERSECTION* = 1
  GCMVF_PARTIAL_INTERSECTION* = 0
  GDALMD_AOP_AREA* = "Area"
  GDALMD_AOP_POINT* = "Point"
  GDALMD_AREA_OR_POINT* = "AREA_OR_POINT"
  GDAL_DATA_COVERAGE_STATUS_DATA* = 2
  GDAL_DATA_COVERAGE_STATUS_EMPTY* = 4
  GDAL_DATA_COVERAGE_STATUS_UNIMPLEMENTED* = 1
  GDAL_DCAP_APPEND* = "DCAP_APPEND"
  GDAL_DCAP_CAN_READ_AFTER_DELETE* = "DCAP_CAN_READ_AFTER_DELETE"
  GDAL_DCAP_COORDINATE_EPOCH* = "DCAP_COORDINATE_EPOCH"
  GDAL_DCAP_CREATE* = "DCAP_CREATE"
  GDAL_DCAP_CREATECOPY* = "DCAP_CREATECOPY"
  GDAL_DCAP_CREATECOPY_MULTIDIMENSIONAL* = "DCAP_CREATECOPY_MULTIDIMENSIONAL"
  GDAL_DCAP_CREATE_FIELD* = "DCAP_CREATE_FIELD"
  GDAL_DCAP_CREATE_LAYER* = "DCAP_CREATE_LAYER"
  GDAL_DCAP_CREATE_MULTIDIMENSIONAL* = "DCAP_CREATE_MULTIDIMENSIONAL"
  GDAL_DCAP_CREATE_ONLY_VISIBLE_AT_CLOSE_TIME* =
    "DCAP_CREATE_ONLY_VISIBLE_AT_CLOSE_TIME"
  GDAL_DCAP_CREATE_RELATIONSHIP* = "DCAP_CREATE_RELATIONSHIP"
  GDAL_DCAP_CREATE_SUBDATASETS* = "DCAP_CREATE_SUBDATASETS"
  GDAL_DCAP_CURVE_GEOMETRIES* = "DCAP_CURVE_GEOMETRIES"
  GDAL_DCAP_DEFAULT_FIELDS* = "DCAP_DEFAULT_FIELDS"
  GDAL_DCAP_DELETE_FIELD* = "DCAP_DELETE_FIELD"
  GDAL_DCAP_DELETE_LAYER* = "DCAP_DELETE_LAYER"
  GDAL_DCAP_DELETE_RELATIONSHIP* = "DCAP_DELETE_RELATIONSHIP"
  GDAL_DCAP_FEATURE_STYLES* = "DCAP_FEATURE_STYLES"
  GDAL_DCAP_FEATURE_STYLES_READ* = "DCAP_FEATURE_STYLES_READ"
  GDAL_DCAP_FEATURE_STYLES_WRITE* = "DCAP_FEATURE_STYLES_WRITE"
  GDAL_DCAP_FIELD_DOMAINS* = "DCAP_FIELD_DOMAINS"
  GDAL_DCAP_FLUSHCACHE_CONSISTENT_STATE* = "DCAP_FLUSHCACHE_CONSISTENT_STATE"
  GDAL_DCAP_GNM* = "DCAP_GNM"
  GDAL_DCAP_HONOR_GEOM_COORDINATE_PRECISION* = "DCAP_HONOR_GEOM_COORDINATE_PRECISION"
  GDAL_DCAP_MEASURED_GEOMETRIES* = "DCAP_MEASURED_GEOMETRIES"
  GDAL_DCAP_MULTIDIM_RASTER* = "DCAP_MULTIDIM_RASTER"
  GDAL_DCAP_MULTIPLE_VECTOR_LAYERS* = "DCAP_MULTIPLE_VECTOR_LAYERS"
  GDAL_DCAP_MULTIPLE_VECTOR_LAYERS_IN_DIRECTORY* =
    "GDAL_DCAP_MULTIPLE_VECTOR_LAYERS_IN_DIRECTORY"
  GDAL_DCAP_NONSPATIAL* = "DCAP_NONSPATIAL"
  GDAL_DCAP_NOTNULL_FIELDS* = "DCAP_NOTNULL_FIELDS"
  GDAL_DCAP_NOTNULL_GEOMFIELDS* = "DCAP_NOTNULL_GEOMFIELDS"
  GDAL_DCAP_OPEN* = "DCAP_OPEN"
  GDAL_DCAP_RASTER* = "DCAP_RASTER"
  GDAL_DCAP_RELATIONSHIPS* = "DCAP_RELATIONSHIPS"
  GDAL_DCAP_RENAME_LAYERS* = "DCAP_RENAME_LAYERS"
  GDAL_DCAP_REOPEN_AFTER_WRITE_REQUIRED* = "DCAP_REOPEN_AFTER_WRITE_REQUIRED"
  GDAL_DCAP_REORDER_FIELDS* = "DCAP_REORDER_FIELDS"
  GDAL_DCAP_SUBCREATECOPY* = "DCAP_SUBCREATECOPY"
  GDAL_DCAP_UNIQUE_FIELDS* = "DCAP_UNIQUE_FIELDS"
  GDAL_DCAP_UPDATE* = "DCAP_UPDATE"
  GDAL_DCAP_UPDATE_RELATIONSHIP* = "DCAP_UPDATE_RELATIONSHIP"
  GDAL_DCAP_UPSERT* = "DCAP_UPSERT"
  GDAL_DCAP_VECTOR* = "DCAP_VECTOR"
  GDAL_DCAP_VECTOR_TRANSLATE_FROM* = "DCAP_VECTOR_TRANSLATE_FROM"
  GDAL_DCAP_VIRTUALIO* = "DCAP_VIRTUALIO"
  GDAL_DCAP_Z_GEOMETRIES* = "DCAP_Z_GEOMETRIES"
  GDAL_DIM_TYPE_HORIZONTAL_X* = "HORIZONTAL_X"
  GDAL_DIM_TYPE_HORIZONTAL_Y* = "HORIZONTAL_Y"
  GDAL_DIM_TYPE_PARAMETRIC* = "PARAMETRIC"
  GDAL_DIM_TYPE_TEMPORAL* = "TEMPORAL"
  GDAL_DIM_TYPE_VERTICAL* = "VERTICAL"
  GDAL_DMD_ALTER_FIELD_DEFN_FLAGS* = "GDAL_DMD_ALTER_FIELD_DEFN_FLAGS"
  GDAL_DMD_ALTER_GEOM_FIELD_DEFN_FLAGS* = "DMD_ALTER_GEOM_FIELD_DEFN_FLAGS"
  GDAL_DMD_CONNECTION_PREFIX* = "DMD_CONNECTION_PREFIX"
  GDAL_DMD_CREATIONDATATYPES* = "DMD_CREATIONDATATYPES"
  GDAL_DMD_CREATIONFIELDDATASUBTYPES* = "DMD_CREATIONFIELDDATASUBTYPES"
  GDAL_DMD_CREATIONFIELDDATATYPES* = "DMD_CREATIONFIELDDATATYPES"
  GDAL_DMD_CREATIONOPTIONLIST* = "DMD_CREATIONOPTIONLIST"
  GDAL_DMD_CREATION_FIELD_DEFN_FLAGS* = "DMD_CREATION_FIELD_DEFN_FLAGS"
  GDAL_DMD_CREATION_FIELD_DOMAIN_TYPES* = "DMD_CREATION_FIELD_DOMAIN_TYPES"
  GDAL_DMD_EXTENSION* = "DMD_EXTENSION"
  GDAL_DMD_EXTENSIONS* = "DMD_EXTENSIONS"
  GDAL_DMD_GEOMETRY_FLAGS* = "GDAL_DMD_GEOMETRY_FLAGS"
  GDAL_DMD_HELPTOPIC* = "DMD_HELPTOPIC"
  GDAL_DMD_ILLEGAL_FIELD_NAMES* = "GDAL_DMD_ILLEGAL_FIELD_NAMES"
  GDAL_DMD_LONGNAME* = "DMD_LONGNAME"
  GDAL_DMD_MAX_STRING_LENGTH* = "DMD_MAX_STRING_LENGTH"
  GDAL_DMD_MIMETYPE* = "DMD_MIMETYPE"
  GDAL_DMD_MULTIDIM_ARRAY_CREATIONOPTIONLIST* = "DMD_MULTIDIM_ARRAY_CREATIONOPTIONLIST"
  GDAL_DMD_MULTIDIM_ARRAY_OPENOPTIONLIST* = "DMD_MULTIDIM_ARRAY_OPENOPTIONLIST"
  GDAL_DMD_MULTIDIM_ATTRIBUTE_CREATIONOPTIONLIST* =
    "DMD_MULTIDIM_ATTRIBUTE_CREATIONOPTIONLIST"
  GDAL_DMD_MULTIDIM_DATASET_CREATIONOPTIONLIST* =
    "DMD_MULTIDIM_DATASET_CREATIONOPTIONLIST"
  GDAL_DMD_MULTIDIM_DIMENSION_CREATIONOPTIONLIST* =
    "DMD_MULTIDIM_DIMENSION_CREATIONOPTIONLIST"
  GDAL_DMD_MULTIDIM_GROUP_CREATIONOPTIONLIST* = "DMD_MULTIDIM_GROUP_CREATIONOPTIONLIST"
  GDAL_DMD_NUMERIC_FIELD_WIDTH_INCLUDES_DECIMAL_SEPARATOR* =
    "DMD_NUMERIC_FIELD_WIDTH_INCLUDES_DECIMAL_SEPARATOR"
  GDAL_DMD_NUMERIC_FIELD_WIDTH_INCLUDES_SIGN* = "DMD_NUMERIC_FIELD_WIDTH_INCLUDES_SIGN"
  GDAL_DMD_OPENOPTIONLIST* = "DMD_OPENOPTIONLIST"
  GDAL_DMD_OVERVIEW_CREATIONOPTIONLIST* = "DMD_OVERVIEW_CREATIONOPTIONLIST"
  GDAL_DMD_PLUGIN_INSTALLATION_MESSAGE* = "DMD_PLUGIN_INSTALLATION_MESSAGE"
  GDAL_DMD_RELATIONSHIP_FLAGS* = "GDAL_DMD_RELATIONSHIP_FLAGS"
  GDAL_DMD_RELATIONSHIP_RELATED_TABLE_TYPES* =
    "GDAL_DMD_RELATIONSHIP_RELATED_TABLE_TYPES"
  GDAL_DMD_SUBDATASETS* = "DMD_SUBDATASETS"
  GDAL_DMD_SUPPORTED_SQL_DIALECTS* = "DMD_SUPPORTED_SQL_DIALECTS"
  GDAL_DMD_UPDATE_ITEMS* = "DMD_UPDATE_ITEMS"
  GDAL_DS_LAYER_CREATIONOPTIONLIST* = "DS_LAYER_CREATIONOPTIONLIST"
  GDAL_GTI2_SIGNATURE* = "GTI2"
  GDAL_OF_ALL* = 0
  GDAL_OF_ARRAY_BLOCK_ACCESS* = 256
  GDAL_OF_BLOCK_ACCESS_MASK* = 768
  GDAL_OF_DEFAULT_BLOCK_ACCESS* = 0
  GDAL_OF_FROM_GDALOPEN* = 1024
  GDAL_OF_GNM* = 8
  GDAL_OF_HASHSET_BLOCK_ACCESS* = 512
  GDAL_OF_INTERNAL* = 128
  GDAL_OF_KIND_MASK* = 30
  GDAL_OF_MULTIDIM_RASTER* = 16
  GDAL_OF_RASTER* = 2
  GDAL_OF_READONLY* = 0
  GDAL_OF_RESERVED_1* = 768
  GDAL_OF_SHARED* = 32
  GDAL_OF_THREAD_SAFE* = 2048
  GDAL_OF_UPDATE* = 1
  GDAL_OF_VECTOR* = 4
  GDAL_OF_VERBOSE_ERROR* = 64
  GDAL_PSH_WEIGHTED_BROVEY* = GDALPansharpenAlg(0)
  GDAL_RELEASE_DATE* = 20260813
  GDAL_RELEASE_NAME* = "3.13.3"
  GDAL_RELEASE_NICKNAME* = "Iowa City"
  GDAL_SWO_FORCE_SQUARE_PIXEL* = 2
  GDAL_SWO_ROUND_UP_SIZE* = 1
  GDAL_VERSION_BUILD* = 0
  GDAL_VERSION_MAJOR* = 3
  GDAL_VERSION_MINOR* = 13
  GDAL_VERSION_REV* = 3
  GDT_Byte* = GDALDataType(1)
  GDT_CFloat16* = GDALDataType(16)
  GDT_CFloat32* = GDALDataType(10)
  GDT_CFloat64* = GDALDataType(11)
  GDT_CInt16* = GDALDataType(8)
  GDT_CInt32* = GDALDataType(9)
  GDT_Float16* = GDALDataType(15)
  GDT_Float32* = GDALDataType(6)
  GDT_Float64* = GDALDataType(7)
  GDT_Int16* = GDALDataType(3)
  GDT_Int32* = GDALDataType(5)
  GDT_Int64* = GDALDataType(13)
  GDT_Int8* = GDALDataType(14)
  GDT_TypeCount* = GDALDataType(17)
  GDT_UInt16* = GDALDataType(2)
  GDT_UInt32* = GDALDataType(4)
  GDT_UInt64* = GDALDataType(12)
  GDT_UInt8* = GDALDataType(1)
  GDT_Unknown* = GDALDataType(0)
  GDsCAddRelationship* = "AddRelationship"
  GDsCDeleteRelationship* = "DeleteRelationship"
  GDsCFastGetExtent* = "FastGetExtent"
  GDsCFastGetExtentWGS84LongLat* = "FastGetExtentWGS84LongLat"
  GDsCUpdateRelationship* = "UpdateRelationship"
  GEDTC_COMPOUND* = GDALExtendedDataTypeClass(2)
  GEDTC_NUMERIC* = GDALExtendedDataTypeClass(0)
  GEDTC_STRING* = GDALExtendedDataTypeClass(1)
  GEDTST_JSON* = GDALExtendedDataTypeSubType(1)
  GEDTST_NONE* = GDALExtendedDataTypeSubType(0)
  GFT_Boolean* = GDALRATFieldType(3)
  GFT_DateTime* = GDALRATFieldType(4)
  GFT_Integer* = GDALRATFieldType(0)
  GFT_MaxCount* = 6
  GFT_Real* = GDALRATFieldType(1)
  GFT_String* = GDALRATFieldType(2)
  GFT_WKBGeometry* = GDALRATFieldType(5)
  GFU_Alpha* = GDALRATFieldUsage(9)
  GFU_AlphaMax* = GDALRATFieldUsage(17)
  GFU_AlphaMin* = GDALRATFieldUsage(13)
  GFU_Blue* = GDALRATFieldUsage(8)
  GFU_BlueMax* = GDALRATFieldUsage(16)
  GFU_BlueMin* = GDALRATFieldUsage(12)
  GFU_Generic* = GDALRATFieldUsage(0)
  GFU_Green* = GDALRATFieldUsage(7)
  GFU_GreenMax* = GDALRATFieldUsage(15)
  GFU_GreenMin* = GDALRATFieldUsage(11)
  GFU_Max* = GDALRATFieldUsage(4)
  GFU_MaxCount* = GDALRATFieldUsage(18)
  GFU_Min* = GDALRATFieldUsage(3)
  GFU_MinMax* = GDALRATFieldUsage(5)
  GFU_Name* = GDALRATFieldUsage(2)
  GFU_PixelCount* = GDALRATFieldUsage(1)
  GFU_Red* = GDALRATFieldUsage(6)
  GFU_RedMax* = GDALRATFieldUsage(14)
  GFU_RedMin* = GDALRATFieldUsage(10)
  GF_Read* = GDALRWFlag(0)
  GF_Write* = GDALRWFlag(1)
  GGA_InverseDistanceToAPower* = GDALGridAlgorithm(1)
  GGA_InverseDistanceToAPowerNearestNeighbor* = GDALGridAlgorithm(11)
  GGA_Linear* = GDALGridAlgorithm(10)
  GGA_MetricAverageDistance* = GDALGridAlgorithm(8)
  GGA_MetricAverageDistancePts* = GDALGridAlgorithm(9)
  GGA_MetricCount* = GDALGridAlgorithm(7)
  GGA_MetricMaximum* = GDALGridAlgorithm(5)
  GGA_MetricMinimum* = GDALGridAlgorithm(4)
  GGA_MetricRange* = GDALGridAlgorithm(6)
  GGA_MovingAverage* = GDALGridAlgorithm(2)
  GGA_NearestNeighbor* = GDALGridAlgorithm(3)
  GMF_ALL_VALID* = 1
  GMF_ALPHA* = 4
  GMF_NODATA* = 8
  GMF_PER_DATASET* = 2
  GNM_MD_DESCR* = "net_description"
  GNM_MD_EMITTER* = "emitter"
  GNM_MD_FETCHEDGES* = "fetch_edge"
  GNM_MD_FETCHVERTEX* = "fetch_vertex"
  GNM_MD_FORMAT* = "FORMAT"
  GNM_MD_NAME* = "net_name"
  GNM_MD_NUM_PATHS* = "num_paths"
  GNM_MD_RULE* = "net_rule"
  GNM_MD_SRS* = "net_srs"
  GNM_MD_VERSION* = "net_version"
  GPI_CMYK* = GDALPaletteInterp(2)
  GPI_Gray* = GDALPaletteInterp(0)
  GPI_HLS* = GDALPaletteInterp(3)
  GPI_RGB* = GDALPaletteInterp(1)
  GRABO_ADD* = GDALRasterAlgebraBinaryOperation(0)
  GRABO_DIV* = GDALRasterAlgebraBinaryOperation(3)
  GRABO_EQ* = GDALRasterAlgebraBinaryOperation(9)
  GRABO_GE* = GDALRasterAlgebraBinaryOperation(6)
  GRABO_GT* = GDALRasterAlgebraBinaryOperation(5)
  GRABO_LE* = GDALRasterAlgebraBinaryOperation(8)
  GRABO_LOGICAL_AND* = GDALRasterAlgebraBinaryOperation(11)
  GRABO_LOGICAL_OR* = GDALRasterAlgebraBinaryOperation(12)
  GRABO_LT* = GDALRasterAlgebraBinaryOperation(7)
  GRABO_MUL* = GDALRasterAlgebraBinaryOperation(2)
  GRABO_NE* = GDALRasterAlgebraBinaryOperation(10)
  GRABO_POW* = GDALRasterAlgebraBinaryOperation(4)
  GRABO_SUB* = GDALRasterAlgebraBinaryOperation(1)
  GRAUO_ABS* = GDALRasterAlgebraUnaryOperation(1)
  GRAUO_LOG* = GDALRasterAlgebraUnaryOperation(3)
  GRAUO_LOG10* = GDALRasterAlgebraUnaryOperation(4)
  GRAUO_LOGICAL_NOT* = GDALRasterAlgebraUnaryOperation(0)
  GRAUO_SQRT* = GDALRasterAlgebraUnaryOperation(2)
  GRA_Average* = GDALResampleAlg(5)
  GRA_Bilinear* = GDALResampleAlg(1)
  GRA_Cubic* = GDALResampleAlg(2)
  GRA_CubicSpline* = GDALResampleAlg(3)
  GRA_LAST_VALUE* = GDALResampleAlg(14)
  GRA_Lanczos* = GDALResampleAlg(4)
  GRA_Max* = GDALResampleAlg(8)
  GRA_Med* = GDALResampleAlg(10)
  GRA_Min* = GDALResampleAlg(9)
  GRA_Mode* = GDALResampleAlg(6)
  GRA_NearestNeighbour* = GDALResampleAlg(0)
  GRA_Q1* = GDALResampleAlg(11)
  GRA_Q3* = GDALResampleAlg(12)
  GRA_RMS* = GDALResampleAlg(14)
  GRA_Sum* = GDALResampleAlg(13)
  GRC_MANY_TO_MANY* = GDALRelationshipCardinality(3)
  GRC_MANY_TO_ONE* = GDALRelationshipCardinality(2)
  GRC_ONE_TO_MANY* = GDALRelationshipCardinality(1)
  GRC_ONE_TO_ONE* = GDALRelationshipCardinality(0)
  GRIORA_Average* = GDALRIOResampleAlg(5)
  GRIORA_Bilinear* = GDALRIOResampleAlg(1)
  GRIORA_Cubic* = GDALRIOResampleAlg(2)
  GRIORA_CubicSpline* = GDALRIOResampleAlg(3)
  GRIORA_Gauss* = GDALRIOResampleAlg(7)
  GRIORA_LAST* = GDALRIOResampleAlg(14)
  GRIORA_Lanczos* = GDALRIOResampleAlg(4)
  GRIORA_Mode* = GDALRIOResampleAlg(6)
  GRIORA_NearestNeighbour* = GDALRIOResampleAlg(0)
  GRIORA_RESERVED_END* = GDALRIOResampleAlg(13)
  GRIORA_RESERVED_START* = GDALRIOResampleAlg(8)
  GRIORA_RMS* = GDALRIOResampleAlg(14)
  GRTT_ATHEMATIC* = GDALRATTableType(1)
  GRTT_THEMATIC* = GDALRATTableType(0)
  GRT_AGGREGATION* = GDALRelationshipType(2)
  GRT_ASSOCIATION* = GDALRelationshipType(1)
  GRT_COMPOSITE* = GDALRelationshipType(0)
  GTO_BIT* = GDALTileOrganization(1)
  GTO_BSQ* = GDALTileOrganization(2)
  GTO_TIP* = GDALTileOrganization(0)
  GVM_Diagonal* = GDALViewshedMode(1)
  GVM_Edge* = GDALViewshedMode(2)
  GVM_Max* = GDALViewshedMode(3)
  GVM_Min* = GDALViewshedMode(4)
  GVOT_MIN_TARGET_HEIGHT_FROM_DEM* = GDALViewshedOutputType(2)
  GVOT_MIN_TARGET_HEIGHT_FROM_GROUND* = GDALViewshedOutputType(3)
  GVOT_NORMAL* = GDALViewshedOutputType(1)
  GWKTS_First* = GWKTieStrategy(1)
  GWKTS_Max* = GWKTieStrategy(3)
  GWKTS_Min* = GWKTieStrategy(2)
  LOCK_ADAPTIVE_MUTEX* = CPLLockType(1)
  LOCK_RECURSIVE_MUTEX* = CPLLockType(0)
  LOCK_SPIN* = CPLLockType(2)
  OAMS_AUTHORITY_COMPLIANT* = OSRAxisMappingStrategy(1)
  OAMS_CUSTOM* = OSRAxisMappingStrategy(2)
  OAMS_TRADITIONAL_GIS_ORDER* = OSRAxisMappingStrategy(0)
  OAO_Down* = OGRAxisOrientation(6)
  OAO_East* = OGRAxisOrientation(3)
  OAO_North* = OGRAxisOrientation(1)
  OAO_Other* = OGRAxisOrientation(0)
  OAO_South* = OGRAxisOrientation(2)
  OAO_Up* = OGRAxisOrientation(5)
  OAO_West* = OGRAxisOrientation(4)
  ODrCCreateDataSource* = "CreateDataSource"
  ODrCDeleteDataSource* = "DeleteDataSource"
  ODsCAddFieldDomain* = "AddFieldDomain"
  ODsCCreateGeomFieldAfterCreateLayer* = "CreateGeomFieldAfterCreateLayer"
  ODsCCreateLayer* = "CreateLayer"
  ODsCCurveGeometries* = "CurveGeometries"
  ODsCDeleteFieldDomain* = "DeleteFieldDomain"
  ODsCDeleteLayer* = "DeleteLayer"
  ODsCEmulatedTransactions* = "EmulatedTransactions"
  ODsCMeasuredGeometries* = "MeasuredGeometries"
  ODsCRandomLayerRead* = "RandomLayerRead"
  ODsCRandomLayerWrite* = "RandomLayerWrite "
  ODsCTransactions* = "Transactions"
  ODsCUpdateFieldDomain* = "UpdateFieldDomain"
  ODsCZGeometries* = "ZGeometries"
  OFDMP_DEFAULT_VALUE* = OGRFieldDomainMergePolicy(0)
  OFDMP_GEOMETRY_WEIGHTED* = OGRFieldDomainMergePolicy(2)
  OFDMP_SUM* = OGRFieldDomainMergePolicy(1)
  OFDSP_DEFAULT_VALUE* = OGRFieldDomainSplitPolicy(0)
  OFDSP_DUPLICATE* = OGRFieldDomainSplitPolicy(1)
  OFDSP_GEOMETRY_RATIO* = OGRFieldDomainSplitPolicy(2)
  OFDT_CODED* = OGRFieldDomainType(0)
  OFDT_GLOB* = OGRFieldDomainType(2)
  OFDT_RANGE* = OGRFieldDomainType(1)
  OFSTBoolean* = OGRFieldSubType(1)
  OFSTFloat32* = OGRFieldSubType(3)
  OFSTInt16* = OGRFieldSubType(2)
  OFSTJSON* = OGRFieldSubType(4)
  OFSTMaxSubType* = OGRFieldSubType(5)
  OFSTNone* = OGRFieldSubType(0)
  OFSTUUID* = OGRFieldSubType(5)
  OFTBinary* = OGRFieldType(8)
  OFTDate* = OGRFieldType(9)
  OFTDateTime* = OGRFieldType(11)
  OFTInteger* = OGRFieldType(0)
  OFTInteger64* = OGRFieldType(12)
  OFTInteger64List* = OGRFieldType(13)
  OFTIntegerList* = OGRFieldType(1)
  OFTMaxType* = OGRFieldType(13)
  OFTReal* = OGRFieldType(2)
  OFTRealList* = OGRFieldType(3)
  OFTString* = OGRFieldType(4)
  OFTStringList* = OGRFieldType(5)
  OFTTime* = OGRFieldType(10)
  OFTWideString* = OGRFieldType(6)
  OFTWideStringList* = OGRFieldType(7)
  OGRERR_CORRUPT_DATA* = 5
  OGRERR_FAILURE* = 6
  OGRERR_INVALID_HANDLE* = 8
  OGRERR_NONE* = 0
  OGRERR_NON_EXISTING_FEATURE* = 9
  OGRERR_NOT_ENOUGH_DATA* = 1
  OGRERR_NOT_ENOUGH_MEMORY* = 2
  OGRERR_UNSUPPORTED_GEOMETRY_TYPE* = 3
  OGRERR_UNSUPPORTED_OPERATION* = 4
  OGRERR_UNSUPPORTED_SRS* = 7
  OGRNullFID* = -1
  OGRNullMarker* = -21122
  OGRPARSEDATE_OPTION_LAX* = 1
  OGRSTBrushAngle* = OGRSTBrushParam(3)
  OGRSTBrushBColor* = OGRSTBrushParam(1)
  OGRSTBrushDx* = OGRSTBrushParam(5)
  OGRSTBrushDy* = OGRSTBrushParam(6)
  OGRSTBrushFColor* = OGRSTBrushParam(0)
  OGRSTBrushId* = OGRSTBrushParam(2)
  OGRSTBrushLast* = OGRSTBrushParam(8)
  OGRSTBrushPriority* = OGRSTBrushParam(7)
  OGRSTBrushSize* = OGRSTBrushParam(4)
  OGRSTCBrush* = OGRSTClassId(2)
  OGRSTCLabel* = OGRSTClassId(4)
  OGRSTCNone* = OGRSTClassId(0)
  OGRSTCPen* = OGRSTClassId(1)
  OGRSTCSymbol* = OGRSTClassId(3)
  OGRSTCVector* = OGRSTClassId(5)
  OGRSTLabelAdjHor* = OGRSTLabelParam(17)
  OGRSTLabelAdjVert* = OGRSTLabelParam(18)
  OGRSTLabelAnchor* = OGRSTLabelParam(7)
  OGRSTLabelAngle* = OGRSTLabelParam(3)
  OGRSTLabelBColor* = OGRSTLabelParam(5)
  OGRSTLabelBold* = OGRSTLabelParam(11)
  OGRSTLabelDx* = OGRSTLabelParam(8)
  OGRSTLabelDy* = OGRSTLabelParam(9)
  OGRSTLabelFColor* = OGRSTLabelParam(4)
  OGRSTLabelFontName* = OGRSTLabelParam(0)
  OGRSTLabelHColor* = OGRSTLabelParam(19)
  OGRSTLabelItalic* = OGRSTLabelParam(12)
  OGRSTLabelLast* = OGRSTLabelParam(21)
  OGRSTLabelOColor* = OGRSTLabelParam(20)
  OGRSTLabelPerp* = OGRSTLabelParam(10)
  OGRSTLabelPlacement* = OGRSTLabelParam(6)
  OGRSTLabelPriority* = OGRSTLabelParam(14)
  OGRSTLabelSize* = OGRSTLabelParam(1)
  OGRSTLabelStretch* = OGRSTLabelParam(16)
  OGRSTLabelStrikeout* = OGRSTLabelParam(15)
  OGRSTLabelTextString* = OGRSTLabelParam(2)
  OGRSTLabelUnderline* = OGRSTLabelParam(13)
  OGRSTPenCap* = OGRSTPenParam(5)
  OGRSTPenColor* = OGRSTPenParam(0)
  OGRSTPenId* = OGRSTPenParam(3)
  OGRSTPenJoin* = OGRSTPenParam(6)
  OGRSTPenLast* = OGRSTPenParam(8)
  OGRSTPenPattern* = OGRSTPenParam(2)
  OGRSTPenPerOffset* = OGRSTPenParam(4)
  OGRSTPenPriority* = OGRSTPenParam(7)
  OGRSTPenWidth* = OGRSTPenParam(1)
  OGRSTSymbolAngle* = OGRSTSymbolParam(1)
  OGRSTSymbolColor* = OGRSTSymbolParam(2)
  OGRSTSymbolDx* = OGRSTSymbolParam(4)
  OGRSTSymbolDy* = OGRSTSymbolParam(5)
  OGRSTSymbolFontName* = OGRSTSymbolParam(10)
  OGRSTSymbolId* = OGRSTSymbolParam(0)
  OGRSTSymbolLast* = OGRSTSymbolParam(12)
  OGRSTSymbolOColor* = OGRSTSymbolParam(11)
  OGRSTSymbolOffset* = OGRSTSymbolParam(8)
  OGRSTSymbolPerp* = OGRSTSymbolParam(7)
  OGRSTSymbolPriority* = OGRSTSymbolParam(9)
  OGRSTSymbolSize* = OGRSTSymbolParam(3)
  OGRSTSymbolStep* = OGRSTSymbolParam(6)
  OGRSTUCM* = OGRSTUnitId(4)
  OGRSTUGround* = OGRSTUnitId(0)
  OGRSTUInches* = OGRSTUnitId(5)
  OGRSTUMM* = OGRSTUnitId(3)
  OGRSTUPixel* = OGRSTUnitId(1)
  OGRSTUPoints* = OGRSTUnitId(2)
  OGRUnsetMarker* = -21121
  OGR_F_VAL_ALL* = 2147483631
  OGR_F_VAL_ALLOW_DIFFERENT_GEOM_DIM* = 16
  OGR_F_VAL_ALLOW_NULL_WHEN_DEFAULT* = 8
  OGR_F_VAL_GEOM_TYPE* = 2
  OGR_F_VAL_NULL* = 1
  OGR_F_VAL_WIDTH* = 4
  OGR_GEOM_COORD_PRECISION_UNKNOWN* = 0
  OGR_GEOS_PREC_KEEP_COLLAPSED* = 2
  OGR_GEOS_PREC_NO_TOPO* = 1
  OGR_GGT_COUNT_NOT_NEEDED* = 1
  OGR_GGT_GEOMCOLLECTIONZ_TINZ* = 4
  OGR_GGT_STOP_IF_MIXED* = 2
  OGR_TZFLAG_LOCALTIME* = 1
  OGR_TZFLAG_MIXED_TZ* = 2
  OGR_TZFLAG_UNKNOWN* = 0
  OGR_TZFLAG_UTC* = 100
  OJLeft* = OGRJustification(1)
  OJRight* = OGRJustification(2)
  OJUndefined* = OGRJustification(0)
  OLCAlterFieldDefn* = "AlterFieldDefn"
  OLCAlterGeomFieldDefn* = "AlterGeomFieldDefn"
  OLCCreateField* = "CreateField"
  OLCCreateGeomField* = "CreateGeomField"
  OLCCurveGeometries* = "CurveGeometries"
  OLCDeleteFeature* = "DeleteFeature"
  OLCDeleteField* = "DeleteField"
  OLCFastFeatureCount* = "FastFeatureCount"
  OLCFastGetArrowStream* = "FastGetArrowStream"
  OLCFastGetExtent* = "FastGetExtent"
  OLCFastGetExtent3D* = "FastGetExtent3D"
  OLCFastSetNextByIndex* = "FastSetNextByIndex"
  OLCFastSpatialFilter* = "FastSpatialFilter"
  OLCFastWriteArrowBatch* = "FastWriteArrowBatch"
  OLCIgnoreFields* = "IgnoreFields"
  OLCMeasuredGeometries* = "MeasuredGeometries"
  OLCRandomRead* = "RandomRead"
  OLCRandomWrite* = "RandomWrite"
  OLCRename* = "Rename"
  OLCReorderFields* = "ReorderFields"
  OLCSequentialWrite* = "SequentialWrite"
  OLCStringsAsUTF8* = "StringsAsUTF8"
  OLCTransactions* = "Transactions"
  OLCUpdateFeature* = "UpdateFeature"
  OLCUpsertFeature* = "UpsertFeature"
  OLCZGeometries* = "ZGeometries"
  OLMD_FID64* = "OLMD_FID64"
  OSR_CRS_TYPE_COMPOUND* = OSRCRSType(5)
  OSR_CRS_TYPE_GEOCENTRIC* = OSRCRSType(2)
  OSR_CRS_TYPE_GEOGRAPHIC_2D* = OSRCRSType(0)
  OSR_CRS_TYPE_GEOGRAPHIC_3D* = OSRCRSType(1)
  OSR_CRS_TYPE_OTHER* = OSRCRSType(6)
  OSR_CRS_TYPE_PROJECTED* = OSRCRSType(3)
  OSR_CRS_TYPE_VERTICAL* = OSRCRSType(4)
  SRS_DN_NAD27* = "North_American_Datum_1927"
  SRS_DN_NAD83* = "North_American_Datum_1983"
  SRS_DN_WGS72* = "WGS_1972"
  SRS_DN_WGS84* = "WGS_1984"
  SRS_PM_GREENWICH* = "Greenwich"
  SRS_PP_AZIMUTH* = "azimuth"
  SRS_PP_CENTRAL_MERIDIAN* = "central_meridian"
  SRS_PP_FALSE_EASTING* = "false_easting"
  SRS_PP_FALSE_NORTHING* = "false_northing"
  SRS_PP_FIPSZONE* = "fipszone"
  SRS_PP_LANDSAT_NUMBER* = "landsat_number"
  SRS_PP_LATITUDE_OF_1ST_POINT* = "Latitude_Of_1st_Point"
  SRS_PP_LATITUDE_OF_2ND_POINT* = "Latitude_Of_2nd_Point"
  SRS_PP_LATITUDE_OF_CENTER* = "latitude_of_center"
  SRS_PP_LATITUDE_OF_ORIGIN* = "latitude_of_origin"
  SRS_PP_LATITUDE_OF_POINT_1* = "latitude_of_point_1"
  SRS_PP_LATITUDE_OF_POINT_2* = "latitude_of_point_2"
  SRS_PP_LATITUDE_OF_POINT_3* = "latitude_of_point_3"
  SRS_PP_LONGITUDE_OF_1ST_POINT* = "Longitude_Of_1st_Point"
  SRS_PP_LONGITUDE_OF_2ND_POINT* = "Longitude_Of_2nd_Point"
  SRS_PP_LONGITUDE_OF_CENTER* = "longitude_of_center"
  SRS_PP_LONGITUDE_OF_ORIGIN* = "longitude_of_origin"
  SRS_PP_LONGITUDE_OF_POINT_1* = "longitude_of_point_1"
  SRS_PP_LONGITUDE_OF_POINT_2* = "longitude_of_point_2"
  SRS_PP_LONGITUDE_OF_POINT_3* = "longitude_of_point_3"
  SRS_PP_PATH_NUMBER* = "path_number"
  SRS_PP_PEG_POINT_HEADING* = "peg_point_heading"
  SRS_PP_PEG_POINT_HEIGHT* = "peg_point_height"
  SRS_PP_PEG_POINT_LATITUDE* = "peg_point_latitude"
  SRS_PP_PEG_POINT_LONGITUDE* = "peg_point_longitude"
  SRS_PP_PERSPECTIVE_POINT_HEIGHT* = "perspective_point_height"
  SRS_PP_PSEUDO_STD_PARALLEL_1* = "pseudo_standard_parallel_1"
  SRS_PP_RECTIFIED_GRID_ANGLE* = "rectified_grid_angle"
  SRS_PP_SATELLITE_HEIGHT* = "satellite_height"
  SRS_PP_SCALE_FACTOR* = "scale_factor"
  SRS_PP_STANDARD_PARALLEL_1* = "standard_parallel_1"
  SRS_PP_STANDARD_PARALLEL_2* = "standard_parallel_2"
  SRS_PP_ZONE* = "zone"
  SRS_PT_AITOFF* = "Aitoff"
  SRS_PT_ALBERS_CONIC_EQUAL_AREA* = "Albers_Conic_Equal_Area"
  SRS_PT_AZIMUTHAL_EQUIDISTANT* = "Azimuthal_Equidistant"
  SRS_PT_BONNE* = "Bonne"
  SRS_PT_CASSINI_SOLDNER* = "Cassini_Soldner"
  SRS_PT_CRASTER_PARABOLIC* = "Craster_Parabolic"
  SRS_PT_CYLINDRICAL_EQUAL_AREA* = "Cylindrical_Equal_Area"
  SRS_PT_ECKERT_I* = "Eckert_I"
  SRS_PT_ECKERT_II* = "Eckert_II"
  SRS_PT_ECKERT_III* = "Eckert_III"
  SRS_PT_ECKERT_IV* = "Eckert_IV"
  SRS_PT_ECKERT_V* = "Eckert_V"
  SRS_PT_ECKERT_VI* = "Eckert_VI"
  SRS_PT_EQUIDISTANT_CONIC* = "Equidistant_Conic"
  SRS_PT_EQUIRECTANGULAR* = "Equirectangular"
  SRS_PT_GALL_STEREOGRAPHIC* = "Gall_Stereographic"
  SRS_PT_GAUSSSCHREIBERTMERCATOR* = "Gauss_Schreiber_Transverse_Mercator"
  SRS_PT_GEOSTATIONARY_SATELLITE* = "Geostationary_Satellite"
  SRS_PT_GNOMONIC* = "Gnomonic"
  SRS_PT_GOODE_HOMOLOSINE* = "Goode_Homolosine"
  SRS_PT_HOTINE_OBLIQUE_MERCATOR* = "Hotine_Oblique_Mercator"
  SRS_PT_HOTINE_OBLIQUE_MERCATOR_AZIMUTH_CENTER* =
    "Hotine_Oblique_Mercator_Azimuth_Center"
  SRS_PT_HOTINE_OBLIQUE_MERCATOR_TWO_POINT_NATURAL_ORIGIN* =
    "Hotine_Oblique_Mercator_Two_Point_Natural_Origin"
  SRS_PT_IGH* = "Interrupted_Goode_Homolosine"
  SRS_PT_IMW_POLYCONIC* = "International_Map_of_the_World_Polyconic"
  SRS_PT_KROVAK* = "Krovak"
  SRS_PT_LABORDE_OBLIQUE_MERCATOR* = "Laborde_Oblique_Mercator"
  SRS_PT_LAMBERT_AZIMUTHAL_EQUAL_AREA* = "Lambert_Azimuthal_Equal_Area"
  SRS_PT_LAMBERT_CONFORMAL_CONIC_1SP* = "Lambert_Conformal_Conic_1SP"
  SRS_PT_LAMBERT_CONFORMAL_CONIC_2SP* = "Lambert_Conformal_Conic_2SP"
  SRS_PT_LAMBERT_CONFORMAL_CONIC_2SP_BELGIUM* = "Lambert_Conformal_Conic_2SP_Belgium"
  SRS_PT_LOXIMUTHAL* = "Loximuthal"
  SRS_PT_MERCATOR_1SP* = "Mercator_1SP"
  SRS_PT_MERCATOR_2SP* = "Mercator_2SP"
  SRS_PT_MERCATOR_AUXILIARY_SPHERE* = "Mercator_Auxiliary_Sphere"
  SRS_PT_MILLER_CYLINDRICAL* = "Miller_Cylindrical"
  SRS_PT_MOLLWEIDE* = "Mollweide"
  SRS_PT_NEW_ZEALAND_MAP_GRID* = "New_Zealand_Map_Grid"
  SRS_PT_OBLIQUE_STEREOGRAPHIC* = "Oblique_Stereographic"
  SRS_PT_ORTHOGRAPHIC* = "Orthographic"
  SRS_PT_POLAR_STEREOGRAPHIC* = "Polar_Stereographic"
  SRS_PT_POLYCONIC* = "Polyconic"
  SRS_PT_QSC* = "Quadrilateralized_Spherical_Cube"
  SRS_PT_QUARTIC_AUTHALIC* = "Quartic_Authalic"
  SRS_PT_ROBINSON* = "Robinson"
  SRS_PT_SCH* = "Spherical_Cross_Track_Height"
  SRS_PT_SINUSOIDAL* = "Sinusoidal"
  SRS_PT_STEREOGRAPHIC* = "Stereographic"
  SRS_PT_SWISS_OBLIQUE_CYLINDRICAL* = "Swiss_Oblique_Cylindrical"
  SRS_PT_TRANSVERSE_MERCATOR* = "Transverse_Mercator"
  SRS_PT_TRANSVERSE_MERCATOR_MI_21* = "Transverse_Mercator_MapInfo_21"
  SRS_PT_TRANSVERSE_MERCATOR_MI_22* = "Transverse_Mercator_MapInfo_22"
  SRS_PT_TRANSVERSE_MERCATOR_MI_23* = "Transverse_Mercator_MapInfo_23"
  SRS_PT_TRANSVERSE_MERCATOR_MI_24* = "Transverse_Mercator_MapInfo_24"
  SRS_PT_TRANSVERSE_MERCATOR_MI_25* = "Transverse_Mercator_MapInfo_25"
  SRS_PT_TRANSVERSE_MERCATOR_SOUTH_ORIENTED* = "Transverse_Mercator_South_Orientated"
  SRS_PT_TUNISIA_MINING_GRID* = "Tunisia_Mining_Grid"
  SRS_PT_TWO_POINT_EQUIDISTANT* = "Two_Point_Equidistant"
  SRS_PT_VANDERGRINTEN* = "VanDerGrinten"
  SRS_PT_WAGNER_I* = "Wagner_I"
  SRS_PT_WAGNER_II* = "Wagner_II"
  SRS_PT_WAGNER_III* = "Wagner_III"
  SRS_PT_WAGNER_IV* = "Wagner_IV"
  SRS_PT_WAGNER_V* = "Wagner_V"
  SRS_PT_WAGNER_VI* = "Wagner_VI"
  SRS_PT_WAGNER_VII* = "Wagner_VII"
  SRS_PT_WINKEL_I* = "Winkel_I"
  SRS_PT_WINKEL_II* = "Winkel_II"
  SRS_PT_WINKEL_TRIPEL* = "Winkel_Tripel"
  SRS_UA_DEGREE* = "degree"
  SRS_UA_DEGREE_CONV* = "0.0174532925199433"
  SRS_UA_RADIAN* = "radian"
  SRS_UL_CENTIMETER* = "Centimeter"
  SRS_UL_CENTIMETER_CONV* = "0.01"
  SRS_UL_CHAIN* = "Chain"
  SRS_UL_CHAIN_CONV* = "20.116684023368047"
  SRS_UL_DECIMETER* = "Decimeter"
  SRS_UL_DECIMETER_CONV* = "0.1"
  SRS_UL_FOOT* = "Foot (International)"
  SRS_UL_FOOT_CONV* = "0.3048"
  SRS_UL_INDIAN_CHAIN* = "Chain_Indian"
  SRS_UL_INDIAN_CHAIN_CONV* = "20.11669506"
  SRS_UL_INDIAN_FOOT* = "Foot_Indian"
  SRS_UL_INDIAN_FOOT_CONV* = "0.30479841"
  SRS_UL_INDIAN_YARD* = "Yard_Indian"
  SRS_UL_INDIAN_YARD_CONV* = "0.91439523"
  SRS_UL_INTL_CHAIN* = "Chain_International"
  SRS_UL_INTL_CHAIN_CONV* = "20.1168"
  SRS_UL_INTL_FATHOM* = "Fathom_International"
  SRS_UL_INTL_FATHOM_CONV* = "1.8288"
  SRS_UL_INTL_FOOT* = "Foot_International"
  SRS_UL_INTL_FOOT_CONV* = "0.3048"
  SRS_UL_INTL_INCH* = "Inch_International"
  SRS_UL_INTL_INCH_CONV* = "0.0254"
  SRS_UL_INTL_LINK* = "Link_International"
  SRS_UL_INTL_LINK_CONV* = "0.201168"
  SRS_UL_INTL_NAUT_MILE* = "Nautical_Mile_International"
  SRS_UL_INTL_NAUT_MILE_CONV* = "1852.0"
  SRS_UL_INTL_STAT_MILE* = "Statute_Mile_International"
  SRS_UL_INTL_STAT_MILE_CONV* = "1609.344"
  SRS_UL_INTL_YARD* = "Yard_International"
  SRS_UL_INTL_YARD_CONV* = "0.9144"
  SRS_UL_KILOMETER* = "Kilometer"
  SRS_UL_KILOMETER_CONV* = "1000."
  SRS_UL_LINK* = "Link"
  SRS_UL_LINK_CONV* = "0.20116684023368047"
  SRS_UL_LINK_Clarke* = "Link_Clarke"
  SRS_UL_LINK_Clarke_CONV* = "0.2011661949"
  SRS_UL_METER* = "Meter"
  SRS_UL_MILLIMETER* = "Millimeter"
  SRS_UL_MILLIMETER_CONV* = "0.001"
  SRS_UL_NAUTICAL_MILE* = "Nautical Mile"
  SRS_UL_NAUTICAL_MILE_CONV* = "1852.0"
  SRS_UL_ROD* = "Rod"
  SRS_UL_ROD_CONV* = "5.02921005842012"
  SRS_UL_US_CHAIN* = "Chain_US_Surveyor"
  SRS_UL_US_CHAIN_CONV* = "20.11684023368047"
  SRS_UL_US_FOOT* = "Foot_US"
  SRS_UL_US_FOOT_CONV* = "0.3048006096012192"
  SRS_UL_US_INCH* = "Inch_US_Surveyor"
  SRS_UL_US_INCH_CONV* = "0.025400050800101603"
  SRS_UL_US_STAT_MILE* = "Statute_Mile_US_Surveyor"
  SRS_UL_US_STAT_MILE_CONV* = "1609.347218694437"
  SRS_UL_US_YARD* = "Yard_US_Surveyor"
  SRS_UL_US_YARD_CONV* = "0.914401828803658"
  SRS_WGS84_INVFLATTENING* = 298.257223563
  SRS_WGS84_SEMIMAJOR* = 6378137.0
  SRS_WKT_WGS84_LAT_LONG* =
    "GEOGCS[\"WGS 84\",DATUM[\"WGS_1984\",SPHEROID[\"WGS 84\",6378137,298.257223563,AUTHORITY[\"EPSG\",\"7030\"]],AUTHORITY[\"EPSG\",\"6326\"]],PRIMEM[\"Greenwich\",0,AUTHORITY[\"EPSG\",\"8901\"]],UNIT[\"degree\",0.0174532925199433,AUTHORITY[\"EPSG\",\"9122\"]],AXIS[\"Latitude\",NORTH],AXIS[\"Longitude\",EAST],AUTHORITY[\"EPSG\",\"4326\"]]"
  TRUE* = 1
  VALIDATE_POINTER_ERR* = CPLErr(3)
  VIRTUALMEM_READONLY* = CPLVirtualMemAccessMode(0)
  VIRTUALMEM_READONLY_ENFORCED* = CPLVirtualMemAccessMode(1)
  VIRTUALMEM_READWRITE* = CPLVirtualMemAccessMode(2)
  VRT_NODATA_UNSET* = -1234.56
  VSIE_AWSAccessDenied* = 6
  VSIE_AWSBucketNotFound* = 7
  VSIE_AWSError* = 5
  VSIE_AWSInvalidCredentials* = 9
  VSIE_AWSObjectNotFound* = 8
  VSIE_AWSSignatureDoesNotMatch* = 10
  VSIE_AccessDenied* = 6
  VSIE_BucketNotFound* = 7
  VSIE_FileError* = 1
  VSIE_HttpError* = 2
  VSIE_InvalidCredentials* = 9
  VSIE_None* = 0
  VSIE_ObjectNotFound* = 8
  VSIE_ObjectStorageGenericError* = 5
  VSIE_SignatureDoesNotMatch* = 10
  VSI_RANGE_STATUS_DATA* = VSIRangeStatus(1)
  VSI_RANGE_STATUS_HOLE* = VSIRangeStatus(2)
  VSI_RANGE_STATUS_UNKNOWN* = VSIRangeStatus(0)
  VSI_STAT_CACHE_ONLY* = 16
  VSI_STAT_EXISTS_FLAG* = 1
  VSI_STAT_NATURE_FLAG* = 2
  VSI_STAT_SET_ERROR_FLAG* = 8
  VSI_STAT_SIZE_FLAG* = 4
  ogrZMarker* = 554850065
  szAlgNameAverage* = "average"
  szAlgNameAverageDistance* = "average_distance"
  szAlgNameAverageDistancePts* = "average_distance_pts"
  szAlgNameCount* = "count"
  szAlgNameInvDist* = "invdist"
  szAlgNameInvDistNearestNeighbor* = "invdistnn"
  szAlgNameLinear* = "linear"
  szAlgNameMaximum* = "maximum"
  szAlgNameMinimum* = "minimum"
  szAlgNameNearest* = "nearest"
  szAlgNameRange* = "range"
  wkb25DBit* = 2147483648'u32
  wkbCircularString* = OGRwkbGeometryType(8)
  wkbCircularStringM* = OGRwkbGeometryType(2008)
  wkbCircularStringZ* = OGRwkbGeometryType(1008)
  wkbCircularStringZM* = OGRwkbGeometryType(3008)
  wkbCompoundCurve* = OGRwkbGeometryType(9)
  wkbCompoundCurveM* = OGRwkbGeometryType(2009)
  wkbCompoundCurveZ* = OGRwkbGeometryType(1009)
  wkbCompoundCurveZM* = OGRwkbGeometryType(3009)
  wkbCurve* = OGRwkbGeometryType(13)
  wkbCurveM* = OGRwkbGeometryType(2013)
  wkbCurvePolygon* = OGRwkbGeometryType(10)
  wkbCurvePolygonM* = OGRwkbGeometryType(2010)
  wkbCurvePolygonZ* = OGRwkbGeometryType(1010)
  wkbCurvePolygonZM* = OGRwkbGeometryType(3010)
  wkbCurveZ* = OGRwkbGeometryType(1013)
  wkbCurveZM* = OGRwkbGeometryType(3013)
  wkbGeometryCollection* = OGRwkbGeometryType(7)
  wkbGeometryCollection25D* = OGRwkbGeometryType(2147483655'u32)
  wkbGeometryCollectionM* = OGRwkbGeometryType(2007)
  wkbGeometryCollectionZM* = OGRwkbGeometryType(3007)
  wkbLineString* = OGRwkbGeometryType(2)
  wkbLineString25D* = OGRwkbGeometryType(2147483650'u32)
  wkbLineStringM* = OGRwkbGeometryType(2002)
  wkbLineStringZM* = OGRwkbGeometryType(3002)
  wkbLinearRing* = OGRwkbGeometryType(101)
  wkbMultiCurve* = OGRwkbGeometryType(11)
  wkbMultiCurveM* = OGRwkbGeometryType(2011)
  wkbMultiCurveZ* = OGRwkbGeometryType(1011)
  wkbMultiCurveZM* = OGRwkbGeometryType(3011)
  wkbMultiLineString* = OGRwkbGeometryType(5)
  wkbMultiLineString25D* = OGRwkbGeometryType(2147483653'u32)
  wkbMultiLineStringM* = OGRwkbGeometryType(2005)
  wkbMultiLineStringZM* = OGRwkbGeometryType(3005)
  wkbMultiPoint* = OGRwkbGeometryType(4)
  wkbMultiPoint25D* = OGRwkbGeometryType(2147483652'u32)
  wkbMultiPointM* = OGRwkbGeometryType(2004)
  wkbMultiPointZM* = OGRwkbGeometryType(3004)
  wkbMultiPolygon* = OGRwkbGeometryType(6)
  wkbMultiPolygon25D* = OGRwkbGeometryType(2147483654'u32)
  wkbMultiPolygonM* = OGRwkbGeometryType(2006)
  wkbMultiPolygonZM* = OGRwkbGeometryType(3006)
  wkbMultiSurface* = OGRwkbGeometryType(12)
  wkbMultiSurfaceM* = OGRwkbGeometryType(2012)
  wkbMultiSurfaceZ* = OGRwkbGeometryType(1012)
  wkbMultiSurfaceZM* = OGRwkbGeometryType(3012)
  wkbNDR* = OGRwkbByteOrder(1)
  wkbNone* = OGRwkbGeometryType(100)
  wkbPoint* = OGRwkbGeometryType(1)
  wkbPoint25D* = OGRwkbGeometryType(2147483649'u32)
  wkbPointM* = OGRwkbGeometryType(2001)
  wkbPointZM* = OGRwkbGeometryType(3001)
  wkbPolygon* = OGRwkbGeometryType(3)
  wkbPolygon25D* = OGRwkbGeometryType(2147483651'u32)
  wkbPolygonM* = OGRwkbGeometryType(2003)
  wkbPolygonZM* = OGRwkbGeometryType(3003)
  wkbPolyhedralSurface* = OGRwkbGeometryType(15)
  wkbPolyhedralSurfaceM* = OGRwkbGeometryType(2015)
  wkbPolyhedralSurfaceZ* = OGRwkbGeometryType(1015)
  wkbPolyhedralSurfaceZM* = OGRwkbGeometryType(3015)
  wkbSurface* = OGRwkbGeometryType(14)
  wkbSurfaceM* = OGRwkbGeometryType(2014)
  wkbSurfaceZ* = OGRwkbGeometryType(1014)
  wkbSurfaceZM* = OGRwkbGeometryType(3014)
  wkbTIN* = OGRwkbGeometryType(16)
  wkbTINM* = OGRwkbGeometryType(2016)
  wkbTINZ* = OGRwkbGeometryType(1016)
  wkbTINZM* = OGRwkbGeometryType(3016)
  wkbTriangle* = OGRwkbGeometryType(17)
  wkbTriangleM* = OGRwkbGeometryType(2017)
  wkbTriangleZ* = OGRwkbGeometryType(1017)
  wkbTriangleZM* = OGRwkbGeometryType(3017)
  wkbUnknown* = OGRwkbGeometryType(0)
  wkbVariantIso* = OGRwkbVariant(1)
  wkbVariantOldOgc* = OGRwkbVariant(0)
  wkbVariantPostGIS1* = OGRwkbVariant(2)
  wkbXDR* = OGRwkbByteOrder(0)

gdalImports:
  proc CPLAtomicAdd*(
    `ptr`: ptr cint, increment: cint
  ): cint {.cdecl, importc: "CPLAtomicAdd", raises: [].}

  proc CPLAtomicCompareAndExchange*(
    `ptr`: ptr cint, oldval: cint, newval: cint
  ): cint {.cdecl, importc: "CPLAtomicCompareAndExchange", raises: [].}

  proc CPLRegisterCompressor*(
    compressor: ptr CPLCompressor
  ): bool {.cdecl, importc: "CPLRegisterCompressor", raises: [].}

  proc CPLRegisterDecompressor*(
    decompressor: ptr CPLCompressor
  ): bool {.cdecl, importc: "CPLRegisterDecompressor", raises: [].}

  proc CPLGetCompressors*(): cstringArray {.
    cdecl, importc: "CPLGetCompressors", raises: []
  .}

  proc CPLGetDecompressors*(): cstringArray {.
    cdecl, importc: "CPLGetDecompressors", raises: []
  .}

  proc CPLGetCompressor*(
    pszId: cstring
  ): ptr CPLCompressor {.cdecl, importc: "CPLGetCompressor", raises: [].}

  proc CPLGetDecompressor*(
    pszId: cstring
  ): ptr CPLCompressor {.cdecl, importc: "CPLGetDecompressor", raises: [].}

  proc CPLDestroyCompressorRegistry*() {.
    cdecl, importc: "CPLDestroyCompressorRegistry", raises: []
  .}

  proc GDALDummyProgress*(
    a0: cdouble, a1: cstring, a2: pointer
  ): cint {.gdalCall, importc: "GDALDummyProgress", raises: [].}

  proc GDALTermProgress*(
    a0: cdouble, a1: cstring, a2: pointer
  ): cint {.gdalCall, importc: "GDALTermProgress", raises: [].}

  proc GDALScaledProgress*(
    a0: cdouble, a1: cstring, a2: pointer
  ): cint {.gdalCall, importc: "GDALScaledProgress", raises: [].}

  proc GDALCreateScaledProgress*(
    a0: cdouble, a1: cdouble, a2: GDALProgressFunc, a3: pointer
  ): pointer {.gdalCall, importc: "GDALCreateScaledProgress", raises: [].}

  proc GDALDestroyScaledProgress*(
    a0: pointer
  ) {.gdalCall, importc: "GDALDestroyScaledProgress", raises: [].}

  proc VSIFOpen*(
    a0: cstring, a1: cstring
  ): ptr GdalFile {.cdecl, importc: "VSIFOpen", raises: [].}

  proc VSIFClose*(a0: ptr GdalFile): cint {.cdecl, importc: "VSIFClose", raises: [].}
  proc VSIFSeek*(
    a0: ptr GdalFile, a1: clong, a2: cint
  ): cint {.cdecl, importc: "VSIFSeek", raises: [].}

  proc VSIFTell*(a0: ptr GdalFile): clong {.cdecl, importc: "VSIFTell", raises: [].}
  proc VSIRewind*(a0: ptr GdalFile) {.cdecl, importc: "VSIRewind", raises: [].}
  proc VSIFFlush*(a0: ptr GdalFile) {.cdecl, importc: "VSIFFlush", raises: [].}
  proc VSIFRead*(
    a0: pointer, a1: csize_t, a2: csize_t, a3: ptr GdalFile
  ): csize_t {.cdecl, importc: "VSIFRead", raises: [].}

  proc VSIFWrite*(
    a0: pointer, a1: csize_t, a2: csize_t, a3: ptr GdalFile
  ): csize_t {.cdecl, importc: "VSIFWrite", raises: [].}

  proc VSIFGets*(
    a0: cstring, a1: cint, a2: ptr GdalFile
  ): cstring {.cdecl, importc: "VSIFGets", raises: [].}

  proc VSIFPuts*(
    a0: cstring, a1: ptr GdalFile
  ): cint {.cdecl, importc: "VSIFPuts", raises: [].}

  proc VSIFPrintf*(
    a0: ptr GdalFile, a1: cstring
  ): cint {.cdecl, importc: "VSIFPrintf", raises: [], varargs.}

  proc VSIFGetc*(a0: ptr GdalFile): cint {.cdecl, importc: "VSIFGetc", raises: [].}
  proc VSIFPutc*(
    a0: cint, a1: ptr GdalFile
  ): cint {.cdecl, importc: "VSIFPutc", raises: [].}

  proc VSIUngetc*(
    a0: cint, a1: ptr GdalFile
  ): cint {.cdecl, importc: "VSIUngetc", raises: [].}

  proc VSIFEof*(a0: ptr GdalFile): cint {.cdecl, importc: "VSIFEof", raises: [].}
  proc VSIStat*(
    a0: cstring, a1: ptr VSIStatBuf
  ): cint {.cdecl, importc: "VSIStat", raises: [].}

  proc VSIFOpenL*(
    a0: cstring, a1: cstring
  ): ptr VSILFILE {.cdecl, importc: "VSIFOpenL", raises: [].}

  proc VSIFOpenExL*(
    a0: cstring, a1: cstring, a2: cint
  ): ptr VSILFILE {.cdecl, importc: "VSIFOpenExL", raises: [].}

  proc VSIFOpenEx2L*(
    a0: cstring, a1: cstring, a2: cint, a3: CSLConstList
  ): ptr VSILFILE {.cdecl, importc: "VSIFOpenEx2L", raises: [].}

  proc VSIFCloseL*(a0: ptr VSILFILE): cint {.cdecl, importc: "VSIFCloseL", raises: [].}
  proc VSIFSeekL*(
    a0: ptr VSILFILE, a1: vsi_l_offset, a2: cint
  ): cint {.cdecl, importc: "VSIFSeekL", raises: [].}

  proc VSIFTellL*(
    a0: ptr VSILFILE
  ): vsi_l_offset {.cdecl, importc: "VSIFTellL", raises: [].}

  proc VSIRewindL*(a0: ptr VSILFILE) {.cdecl, importc: "VSIRewindL", raises: [].}
  proc VSIFReadL*(
    a0: pointer, a1: csize_t, a2: csize_t, a3: ptr VSILFILE
  ): csize_t {.cdecl, importc: "VSIFReadL", raises: [].}

  proc VSIFReadMultiRangeL*(
    nRanges: cint,
    ppData: ptr pointer,
    panOffsets: ptr vsi_l_offset,
    panSizes: ptr csize_t,
    a4: ptr VSILFILE,
  ): cint {.cdecl, importc: "VSIFReadMultiRangeL", raises: [].}

  proc VSIFWriteL*(
    a0: pointer, a1: csize_t, a2: csize_t, a3: ptr VSILFILE
  ): csize_t {.cdecl, importc: "VSIFWriteL", raises: [].}

  proc VSIFClearErrL*(a0: ptr VSILFILE) {.cdecl, importc: "VSIFClearErrL", raises: [].}
  proc VSIFErrorL*(a0: ptr VSILFILE): cint {.cdecl, importc: "VSIFErrorL", raises: [].}
  proc VSIFEofL*(a0: ptr VSILFILE): cint {.cdecl, importc: "VSIFEofL", raises: [].}
  proc VSIFTruncateL*(
    a0: ptr VSILFILE, a1: vsi_l_offset
  ): cint {.cdecl, importc: "VSIFTruncateL", raises: [].}

  proc VSIFFlushL*(a0: ptr VSILFILE): cint {.cdecl, importc: "VSIFFlushL", raises: [].}
  proc VSIFPrintfL*(
    a0: ptr VSILFILE, a1: cstring
  ): cint {.cdecl, importc: "VSIFPrintfL", raises: [], varargs.}

  proc VSIFPutcL*(
    a0: cint, a1: ptr VSILFILE
  ): cint {.cdecl, importc: "VSIFPutcL", raises: [].}

  proc VSIFGetRangeStatusL*(
    fp: ptr VSILFILE, nStart: vsi_l_offset, nLength: vsi_l_offset
  ): VSIRangeStatus {.cdecl, importc: "VSIFGetRangeStatusL", raises: [].}

  proc VSIIngestFile*(
    fp: ptr VSILFILE,
    pszFilename: cstring,
    ppabyRet: ptr ptr GByte,
    pnSize: ptr vsi_l_offset,
    nMaxSize: GIntBig,
  ): cint {.cdecl, importc: "VSIIngestFile", raises: [].}

  proc VSIOverwriteFile*(
    fpTarget: ptr VSILFILE, pszSourceFilename: cstring
  ): cint {.cdecl, importc: "VSIOverwriteFile", raises: [].}

  proc VSIStatL*(
    a0: cstring, a1: ptr VSIStatBufL
  ): cint {.cdecl, importc: "VSIStatL", raises: [].}

  proc VSIStatExL*(
    pszFilename: cstring, psStatBuf: ptr VSIStatBufL, nFlags: cint
  ): cint {.cdecl, importc: "VSIStatExL", raises: [].}

  proc VSIIsCaseSensitiveFS*(
    pszFilename: cstring
  ): cint {.cdecl, importc: "VSIIsCaseSensitiveFS", raises: [].}

  proc VSISupportsSparseFiles*(
    pszPath: cstring
  ): cint {.cdecl, importc: "VSISupportsSparseFiles", raises: [].}

  proc VSIIsLocal*(pszPath: cstring): bool {.cdecl, importc: "VSIIsLocal", raises: [].}
  proc VSIGetCanonicalFilename*(
    pszPath: cstring
  ): cstring {.cdecl, importc: "VSIGetCanonicalFilename", raises: [].}

  proc VSISupportsSequentialWrite*(
    pszPath: cstring, bAllowLocalTempFile: bool
  ): bool {.cdecl, importc: "VSISupportsSequentialWrite", raises: [].}

  proc VSISupportsRandomWrite*(
    pszPath: cstring, bAllowLocalTempFile: bool
  ): bool {.cdecl, importc: "VSISupportsRandomWrite", raises: [].}

  proc VSIHasOptimizedReadMultiRange*(
    pszPath: cstring
  ): cint {.cdecl, importc: "VSIHasOptimizedReadMultiRange", raises: [].}

  proc VSIGetActualURL*(
    pszFilename: cstring
  ): cstring {.cdecl, importc: "VSIGetActualURL", raises: [].}

  proc VSIGetSignedURL*(
    pszFilename: cstring, papszOptions: CSLConstList
  ): cstring {.cdecl, importc: "VSIGetSignedURL", raises: [].}

  proc VSIGetFileSystemOptions*(
    pszFilename: cstring
  ): cstring {.cdecl, importc: "VSIGetFileSystemOptions", raises: [].}

  proc VSIGetFileSystemsPrefixes*(): cstringArray {.
    cdecl, importc: "VSIGetFileSystemsPrefixes", raises: []
  .}

  proc VSIFGetNativeFileDescriptorL*(
    a0: ptr VSILFILE
  ): pointer {.cdecl, importc: "VSIFGetNativeFileDescriptorL", raises: [].}

  proc VSIGetFileMetadata*(
    pszFilename: cstring, pszDomain: cstring, papszOptions: CSLConstList
  ): cstringArray {.cdecl, importc: "VSIGetFileMetadata", raises: [].}

  proc VSISetFileMetadata*(
    pszFilename: cstring,
    papszMetadata: CSLConstList,
    pszDomain: cstring,
    papszOptions: CSLConstList,
  ): cint {.cdecl, importc: "VSISetFileMetadata", raises: [].}

  proc VSISetPathSpecificOption*(
    pszPathPrefix: cstring, pszKey: cstring, pszValue: cstring
  ) {.cdecl, importc: "VSISetPathSpecificOption", raises: [].}

  proc VSIClearPathSpecificOptions*(
    pszPathPrefix: cstring
  ) {.cdecl, importc: "VSIClearPathSpecificOptions", raises: [].}

  proc VSIGetPathSpecificOption*(
    pszPath: cstring, pszKey: cstring, pszDefault: cstring
  ): cstring {.cdecl, importc: "VSIGetPathSpecificOption", raises: [].}

  proc VSISetCredential*(
    pszPathPrefix: cstring, pszKey: cstring, pszValue: cstring
  ) {.cdecl, importc: "VSISetCredential", raises: [].}

  proc VSIClearCredentials*(
    pszPathPrefix: cstring
  ) {.cdecl, importc: "VSIClearCredentials", raises: [].}

  proc VSIGetCredential*(
    pszPath: cstring, pszKey: cstring, pszDefault: cstring
  ): cstring {.cdecl, importc: "VSIGetCredential", raises: [].}

  proc VSICalloc*(
    a0: csize_t, a1: csize_t
  ): pointer {.cdecl, importc: "VSICalloc", raises: [].}

  proc VSIMalloc*(a0: csize_t): pointer {.cdecl, importc: "VSIMalloc", raises: [].}
  proc VSIFree*(a0: pointer) {.cdecl, importc: "VSIFree", raises: [].}
  proc VSIRealloc*(
    a0: pointer, a1: csize_t
  ): pointer {.cdecl, importc: "VSIRealloc", raises: [].}

  proc VSIStrdup*(a0: cstring): cstring {.cdecl, importc: "VSIStrdup", raises: [].}
  proc VSIMallocAligned*(
    nAlignment: csize_t, nSize: csize_t
  ): pointer {.cdecl, importc: "VSIMallocAligned", raises: [].}

  proc VSIMallocAlignedAuto*(
    nSize: csize_t
  ): pointer {.cdecl, importc: "VSIMallocAlignedAuto", raises: [].}

  proc VSIFreeAligned*(`ptr`: pointer) {.cdecl, importc: "VSIFreeAligned", raises: [].}
  proc VSIMallocAlignedAutoVerboseRaw*(
    nSize: csize_t, pszFile: cstring, nLine: cint
  ): pointer {.cdecl, importc: "VSIMallocAlignedAutoVerbose", raises: [].}

  proc VSIMalloc2*(
    nSize1: csize_t, nSize2: csize_t
  ): pointer {.cdecl, importc: "VSIMalloc2", raises: [].}

  proc VSIMalloc3*(
    nSize1: csize_t, nSize2: csize_t, nSize3: csize_t
  ): pointer {.cdecl, importc: "VSIMalloc3", raises: [].}

  proc VSIMallocVerboseRaw*(
    nSize: csize_t, pszFile: cstring, nLine: cint
  ): pointer {.cdecl, importc: "VSIMallocVerbose", raises: [].}

  proc VSIMalloc2VerboseRaw*(
    nSize1: csize_t, nSize2: csize_t, pszFile: cstring, nLine: cint
  ): pointer {.cdecl, importc: "VSIMalloc2Verbose", raises: [].}

  proc VSIMalloc3VerboseRaw*(
    nSize1: csize_t, nSize2: csize_t, nSize3: csize_t, pszFile: cstring, nLine: cint
  ): pointer {.cdecl, importc: "VSIMalloc3Verbose", raises: [].}

  proc VSICallocVerboseRaw*(
    nCount: csize_t, nSize: csize_t, pszFile: cstring, nLine: cint
  ): pointer {.cdecl, importc: "VSICallocVerbose", raises: [].}

  proc VSIReallocVerboseRaw*(
    pOldPtr: pointer, nNewSize: csize_t, pszFile: cstring, nLine: cint
  ): pointer {.cdecl, importc: "VSIReallocVerbose", raises: [].}

  proc VSIStrdupVerboseRaw*(
    pszStr: cstring, pszFile: cstring, nLine: cint
  ): cstring {.cdecl, importc: "VSIStrdupVerbose", raises: [].}

  proc CPLGetPhysicalRAM*(): GIntBig {.cdecl, importc: "CPLGetPhysicalRAM", raises: [].}
  proc CPLGetUsablePhysicalRAM*(): GIntBig {.
    cdecl, importc: "CPLGetUsablePhysicalRAM", raises: []
  .}

  proc VSIReadDir*(
    a0: cstring
  ): cstringArray {.cdecl, importc: "VSIReadDir", raises: [].}

  proc VSIReadDirRecursive*(
    pszPath: cstring
  ): cstringArray {.cdecl, importc: "VSIReadDirRecursive", raises: [].}

  proc VSIReadDirEx*(
    pszPath: cstring, nMaxFiles: cint
  ): cstringArray {.cdecl, importc: "VSIReadDirEx", raises: [].}

  proc VSISiblingFiles*(
    pszPath: cstring
  ): cstringArray {.cdecl, importc: "VSISiblingFiles", raises: [].}

  proc VSIGlob*(
    pszPattern: cstring,
    papszOptions: cstringArray,
    pProgressFunc: GDALProgressFunc,
    pProgressData: pointer,
  ): cstringArray {.cdecl, importc: "VSIGlob", raises: [].}

  proc VSIGetDirectorySeparator*(
    pszPath: cstring
  ): cstring {.cdecl, importc: "VSIGetDirectorySeparator", raises: [].}

  proc VSIOpenDir*(
    pszPath: cstring, nRecurseDepth: cint, papszOptions: cstringArray
  ): ptr VSIDIR {.cdecl, importc: "VSIOpenDir", raises: [].}

  proc VSIGetNextDirEntry*(
    dir: ptr VSIDIR
  ): ptr VSIDIREntry {.cdecl, importc: "VSIGetNextDirEntry", raises: [].}

  proc VSICloseDir*(dir: ptr VSIDIR) {.cdecl, importc: "VSICloseDir", raises: [].}
  proc VSIMkdir*(
    pszPathname: cstring, mode: clong
  ): cint {.cdecl, importc: "VSIMkdir", raises: [].}

  proc VSIMkdirRecursive*(
    pszPathname: cstring, mode: clong
  ): cint {.cdecl, importc: "VSIMkdirRecursive", raises: [].}

  proc VSIRmdir*(pszDirname: cstring): cint {.cdecl, importc: "VSIRmdir", raises: [].}
  proc VSIRmdirRecursive*(
    pszDirname: cstring
  ): cint {.cdecl, importc: "VSIRmdirRecursive", raises: [].}

  proc VSIUnlink*(
    pszFilename: cstring
  ): cint {.cdecl, importc: "VSIUnlink", raises: [].}

  proc VSIUnlinkBatch*(
    papszFiles: CSLConstList
  ): ptr cint {.cdecl, importc: "VSIUnlinkBatch", raises: [].}

  proc VSIRename*(
    oldpath: cstring, newpath: cstring
  ): cint {.cdecl, importc: "VSIRename", raises: [].}

  proc VSIMove*(
    oldpath: cstring,
    newpath: cstring,
    papszOptions: cstringArray,
    pProgressFunc: GDALProgressFunc,
    pProgressData: pointer,
  ): cint {.cdecl, importc: "VSIMove", raises: [].}

  proc VSICopyFile*(
    pszSource: cstring,
    pszTarget: cstring,
    fpSource: ptr VSILFILE,
    nSourceSize: vsi_l_offset,
    papszOptions: cstringArray,
    pProgressFunc: GDALProgressFunc,
    pProgressData: pointer,
  ): cint {.cdecl, importc: "VSICopyFile", raises: [].}

  proc VSICopyFileRestartable*(
    pszSource: cstring,
    pszTarget: cstring,
    pszInputPayload: cstring,
    ppszOutputPayload: cstringArray,
    papszOptions: cstringArray,
    pProgressFunc: GDALProgressFunc,
    pProgressData: pointer,
  ): cint {.cdecl, importc: "VSICopyFileRestartable", raises: [].}

  proc VSISync*(
    pszSource: cstring,
    pszTarget: cstring,
    papszOptions: cstringArray,
    pProgressFunc: GDALProgressFunc,
    pProgressData: pointer,
    ppapszOutputs: ptr cstringArray,
  ): cint {.cdecl, importc: "VSISync", raises: [].}

  proc VSIMultipartUploadGetCapabilities*(
    pszFilename: cstring,
    pbNonSequentialUploadSupported: ptr cint,
    pbParallelUploadSupported: ptr cint,
    pbAbortSupported: ptr cint,
    pnMinPartSize: ptr csize_t,
    pnMaxPartSize: ptr csize_t,
    pnMaxPartCount: ptr cint,
  ): cint {.cdecl, importc: "VSIMultipartUploadGetCapabilities", raises: [].}

  proc VSIMultipartUploadStart*(
    pszFilename: cstring, papszOptions: CSLConstList
  ): cstring {.cdecl, importc: "VSIMultipartUploadStart", raises: [].}

  proc VSIMultipartUploadAddPart*(
    pszFilename: cstring,
    pszUploadId: cstring,
    nPartNumber: cint,
    nFileOffset: vsi_l_offset,
    pData: pointer,
    nDataLength: csize_t,
    papszOptions: CSLConstList,
  ): cstring {.cdecl, importc: "VSIMultipartUploadAddPart", raises: [].}

  proc VSIMultipartUploadEnd*(
    pszFilename: cstring,
    pszUploadId: cstring,
    nPartIdsCount: csize_t,
    apszPartIds: cstringArray,
    nTotalSize: vsi_l_offset,
    papszOptions: CSLConstList,
  ): cint {.cdecl, importc: "VSIMultipartUploadEnd", raises: [].}

  proc VSIMultipartUploadAbort*(
    pszFilename: cstring, pszUploadId: cstring, papszOptions: CSLConstList
  ): cint {.cdecl, importc: "VSIMultipartUploadAbort", raises: [].}

  proc VSIAbortPendingUploads*(
    pszFilename: cstring
  ): cint {.cdecl, importc: "VSIAbortPendingUploads", raises: [].}

  proc VSIStrerror*(a0: cint): cstring {.cdecl, importc: "VSIStrerror", raises: [].}
  proc VSIGetDiskFreeSpace*(
    pszDirname: cstring
  ): GIntBig {.cdecl, importc: "VSIGetDiskFreeSpace", raises: [].}

  proc VSINetworkStatsReset*() {.cdecl, importc: "VSINetworkStatsReset", raises: [].}
  proc VSINetworkStatsGetAsSerializedJSON*(
    papszOptions: cstringArray
  ): cstring {.cdecl, importc: "VSINetworkStatsGetAsSerializedJSON", raises: [].}

  proc VSIInstallMemFileHandler*() {.
    cdecl, importc: "VSIInstallMemFileHandler", raises: []
  .}

  proc VSIInstallLargeFileHandler*() {.
    cdecl, importc: "VSIInstallLargeFileHandler", raises: []
  .}

  proc VSIInstallSubFileHandler*() {.
    cdecl, importc: "VSIInstallSubFileHandler", raises: []
  .}

  proc VSIInstallCurlFileHandler*() {.
    cdecl, importc: "VSIInstallCurlFileHandler", raises: []
  .}

  proc VSICurlClearCache*() {.cdecl, importc: "VSICurlClearCache", raises: [].}
  proc VSICurlPartialClearCache*(
    pszFilenamePrefix: cstring
  ) {.cdecl, importc: "VSICurlPartialClearCache", raises: [].}

  proc VSIInstallCurlStreamingFileHandler*() {.
    cdecl, importc: "VSIInstallCurlStreamingFileHandler", raises: []
  .}

  proc VSIInstallS3FileHandler*() {.
    cdecl, importc: "VSIInstallS3FileHandler", raises: []
  .}

  proc VSIInstallS3StreamingFileHandler*() {.
    cdecl, importc: "VSIInstallS3StreamingFileHandler", raises: []
  .}

  proc VSIInstallGSFileHandler*() {.
    cdecl, importc: "VSIInstallGSFileHandler", raises: []
  .}

  proc VSIInstallGSStreamingFileHandler*() {.
    cdecl, importc: "VSIInstallGSStreamingFileHandler", raises: []
  .}

  proc VSIInstallAzureFileHandler*() {.
    cdecl, importc: "VSIInstallAzureFileHandler", raises: []
  .}

  proc VSIInstallAzureStreamingFileHandler*() {.
    cdecl, importc: "VSIInstallAzureStreamingFileHandler", raises: []
  .}

  proc VSIInstallADLSFileHandler*() {.
    cdecl, importc: "VSIInstallADLSFileHandler", raises: []
  .}

  proc VSIInstallOSSFileHandler*() {.
    cdecl, importc: "VSIInstallOSSFileHandler", raises: []
  .}

  proc VSIInstallOSSStreamingFileHandler*() {.
    cdecl, importc: "VSIInstallOSSStreamingFileHandler", raises: []
  .}

  proc VSIInstallSwiftFileHandler*() {.
    cdecl, importc: "VSIInstallSwiftFileHandler", raises: []
  .}

  proc VSIInstallSwiftStreamingFileHandler*() {.
    cdecl, importc: "VSIInstallSwiftStreamingFileHandler", raises: []
  .}

  proc VSIInstall7zFileHandler*() {.
    cdecl, importc: "VSIInstall7zFileHandler", raises: []
  .}

  proc VSIInstallRarFileHandler*() {.
    cdecl, importc: "VSIInstallRarFileHandler", raises: []
  .}

  proc VSIInstallGZipFileHandler*() {.
    cdecl, importc: "VSIInstallGZipFileHandler", raises: []
  .}

  proc VSIInstallZipFileHandler*() {.
    cdecl, importc: "VSIInstallZipFileHandler", raises: []
  .}

  proc VSIInstallStdinHandler*() {.
    cdecl, importc: "VSIInstallStdinHandler", raises: []
  .}

  proc VSIInstallHdfsHandler*() {.cdecl, importc: "VSIInstallHdfsHandler", raises: [].}
  proc VSIInstallWebHdfsHandler*() {.
    cdecl, importc: "VSIInstallWebHdfsHandler", raises: []
  .}

  proc VSIInstallStdoutHandler*() {.
    cdecl, importc: "VSIInstallStdoutHandler", raises: []
  .}

  proc VSIInstallSparseFileHandler*() {.
    cdecl, importc: "VSIInstallSparseFileHandler", raises: []
  .}

  proc VSIInstallTarFileHandler*() {.
    cdecl, importc: "VSIInstallTarFileHandler", raises: []
  .}

  proc VSIInstallCachedFileHandler*() {.
    cdecl, importc: "VSIInstallCachedFileHandler", raises: []
  .}

  proc VSIInstallCryptFileHandler*() {.
    cdecl, importc: "VSIInstallCryptFileHandler", raises: []
  .}

  proc VSISetCryptKey*(
    pabyKey: ptr GByte, nKeySize: cint
  ) {.cdecl, importc: "VSISetCryptKey", raises: [].}

  proc VSICleanupFileManager*() {.cdecl, importc: "VSICleanupFileManager", raises: [].}
  proc VSIDuplicateFileSystemHandler*(
    pszSourceFSName: cstring, pszNewFSName: cstring
  ): bool {.cdecl, importc: "VSIDuplicateFileSystemHandler", raises: [].}

  proc VSIFileFromMemBuffer*(
    pszFilename: cstring,
    pabyData: ptr GByte,
    nDataLength: vsi_l_offset,
    bTakeOwnership: cint,
  ): ptr VSILFILE {.cdecl, importc: "VSIFileFromMemBuffer", raises: [].}

  proc VSIGetMemFileBuffer*(
    pszFilename: cstring, pnDataLength: ptr vsi_l_offset, bUnlinkAndSeize: cint
  ): ptr GByte {.cdecl, importc: "VSIGetMemFileBuffer", raises: [].}

  proc VSIMemGenerateHiddenFilename*(
    pszFilename: cstring
  ): cstring {.cdecl, importc: "VSIMemGenerateHiddenFilename", raises: [].}

  proc VSIStdoutSetRedirection*(
    pFct: VSIWriteFunction, stream: ptr GdalFile
  ) {.cdecl, importc: "VSIStdoutSetRedirection", raises: [].}

  proc VSIAllocFilesystemPluginCallbacksStruct*(): ptr VSIFilesystemPluginCallbacksStruct {.
    cdecl, importc: "VSIAllocFilesystemPluginCallbacksStruct", raises: []
  .}

  proc VSIFreeFilesystemPluginCallbacksStruct*(
    poCb: ptr VSIFilesystemPluginCallbacksStruct
  ) {.cdecl, importc: "VSIFreeFilesystemPluginCallbacksStruct", raises: [].}

  proc VSIInstallPluginHandler*(
    pszPrefix: cstring, poCb: ptr VSIFilesystemPluginCallbacksStruct
  ): cint {.cdecl, importc: "VSIInstallPluginHandler", raises: [].}

  proc VSIRemovePluginHandler*(
    pszPrefix: cstring
  ): cint {.cdecl, importc: "VSIRemovePluginHandler", raises: [].}

  proc VSITime*(a0: ptr culong): culong {.cdecl, importc: "VSITime", raises: [].}
  proc VSICTime*(a0: culong): cstring {.cdecl, importc: "VSICTime", raises: [].}
  proc VSIGMTime*(
    pnTime: ptr clong, poBrokenTime: ptr GdalSystemtm
  ): ptr GdalSystemtm {.cdecl, importc: "VSIGMTime", raises: [].}

  proc VSILocalTime*(
    pnTime: ptr clong, poBrokenTime: ptr GdalSystemtm
  ): ptr GdalSystemtm {.cdecl, importc: "VSILocalTime", raises: [].}

  proc CPLError*(
    eErrClass: CPLErr, err_no: CPLErrorNum, fmt: cstring
  ) {.cdecl, importc: "CPLError", raises: [], varargs.}

  proc CPLErrorV*(
    a0: CPLErr, a1: CPLErrorNum, a2: cstring, a3: GdalVaList
  ) {.cdecl, importc: "CPLErrorV", raises: [].}

  proc CPLEmergencyError*(
    a0: cstring
  ) {.cdecl, importc: "CPLEmergencyError", raises: [].}

  proc CPLErrorReset*() {.gdalCall, importc: "CPLErrorReset", raises: [].}
  proc CPLGetLastErrorNo*(): CPLErrorNum {.
    gdalCall, importc: "CPLGetLastErrorNo", raises: []
  .}

  proc CPLGetLastErrorType*(): CPLErr {.
    gdalCall, importc: "CPLGetLastErrorType", raises: []
  .}

  proc CPLGetLastErrorMsg*(): cstring {.
    gdalCall, importc: "CPLGetLastErrorMsg", raises: []
  .}

  proc CPLGetErrorCounter*(): GUInt32 {.
    gdalCall, importc: "CPLGetErrorCounter", raises: []
  .}

  proc CPLGetErrorHandlerUserData*(): pointer {.
    gdalCall, importc: "CPLGetErrorHandlerUserData", raises: []
  .}

  proc CPLErrorSetState*(
    eErrClass: CPLErr, err_no: CPLErrorNum, pszMsg: cstring
  ) {.cdecl, importc: "CPLErrorSetState", raises: [].}

  proc CPLCallPreviousHandler*(
    eErrClass: CPLErr, err_no: CPLErrorNum, pszMsg: cstring
  ) {.cdecl, importc: "CPLCallPreviousHandler", raises: [].}

  proc CPLCleanupErrorMutex*() {.cdecl, importc: "CPLCleanupErrorMutex", raises: [].}
  proc CPLLoggingErrorHandler*(
    a0: CPLErr, a1: CPLErrorNum, a2: cstring
  ) {.gdalCall, importc: "CPLLoggingErrorHandler", raises: [].}

  proc CPLDefaultErrorHandler*(
    a0: CPLErr, a1: CPLErrorNum, a2: cstring
  ) {.gdalCall, importc: "CPLDefaultErrorHandler", raises: [].}

  proc CPLQuietErrorHandler*(
    a0: CPLErr, a1: CPLErrorNum, a2: cstring
  ) {.gdalCall, importc: "CPLQuietErrorHandler", raises: [].}

  proc CPLQuietWarningsErrorHandler*(
    a0: CPLErr, a1: CPLErrorNum, a2: cstring
  ) {.gdalCall, importc: "CPLQuietWarningsErrorHandler", raises: [].}

  proc CPLTurnFailureIntoWarning*(
    bOn: cint
  ) {.cdecl, importc: "CPLTurnFailureIntoWarning", raises: [].}

  proc CPLGetErrorHandler*(
    ppUserData: ptr pointer
  ): CPLErrorHandler {.cdecl, importc: "CPLGetErrorHandler", raises: [].}

  proc CPLSetErrorHandler*(
    a0: CPLErrorHandler
  ): CPLErrorHandler {.gdalCall, importc: "CPLSetErrorHandler", raises: [].}

  proc CPLSetErrorHandlerEx*(
    a0: CPLErrorHandler, a1: pointer
  ): CPLErrorHandler {.gdalCall, importc: "CPLSetErrorHandlerEx", raises: [].}

  proc CPLPushErrorHandler*(
    a0: CPLErrorHandler
  ) {.gdalCall, importc: "CPLPushErrorHandler", raises: [].}

  proc CPLPushErrorHandlerEx*(
    a0: CPLErrorHandler, a1: pointer
  ) {.gdalCall, importc: "CPLPushErrorHandlerEx", raises: [].}

  proc CPLSetCurrentErrorHandlerCatchDebug*(
    bCatchDebug: cint
  ) {.gdalCall, importc: "CPLSetCurrentErrorHandlerCatchDebug", raises: [].}

  proc CPLPopErrorHandler*() {.gdalCall, importc: "CPLPopErrorHandler", raises: [].}
  proc CPLDebug*(
    a0: cstring, a1: cstring
  ) {.cdecl, importc: "CPLDebug", raises: [], varargs.}

  proc CPLDebugProgress*(
    a0: cstring, a1: cstring
  ) {.cdecl, importc: "CPLDebugProgress", raises: [], varargs.}

  proc c_CPLAssert*(
    a0: cstring, a1: cstring, a2: cint
  ) {.gdalCall, importc: "_CPLAssert", raises: [].}

  proc CPLVerifyConfiguration*() {.
    cdecl, importc: "CPLVerifyConfiguration", raises: []
  .}

  proc CPLIsDebugEnabled*(): bool {.cdecl, importc: "CPLIsDebugEnabled", raises: [].}
  proc CPLGetConfigOption*(
    a0: cstring, a1: cstring
  ): cstring {.gdalCall, importc: "CPLGetConfigOption", raises: [].}

  proc CPLGetThreadLocalConfigOption*(
    a0: cstring, a1: cstring
  ): cstring {.gdalCall, importc: "CPLGetThreadLocalConfigOption", raises: [].}

  proc CPLGetGlobalConfigOption*(
    a0: cstring, a1: cstring
  ): cstring {.gdalCall, importc: "CPLGetGlobalConfigOption", raises: [].}

  proc CPLSetConfigOption*(
    a0: cstring, a1: cstring
  ) {.gdalCall, importc: "CPLSetConfigOption", raises: [].}

  proc CPLSetThreadLocalConfigOption*(
    pszKey: cstring, pszValue: cstring
  ) {.gdalCall, importc: "CPLSetThreadLocalConfigOption", raises: [].}

  proc CPLDeclareKnownConfigOption*(
    pszKey: cstring, pszDefinition: cstring
  ) {.cdecl, importc: "CPLDeclareKnownConfigOption", raises: [].}

  proc CPLGetKnownConfigOptions*(): cstringArray {.
    cdecl, importc: "CPLGetKnownConfigOptions", raises: []
  .}

  proc CPLSubscribeToSetConfigOption*(
    pfnCallback: CPLSetConfigOptionSubscriber, pUserData: pointer
  ): cint {.cdecl, importc: "CPLSubscribeToSetConfigOption", raises: [].}

  proc CPLUnsubscribeToSetConfigOption*(
    nSubscriberId: cint
  ) {.cdecl, importc: "CPLUnsubscribeToSetConfigOption", raises: [].}

  proc CPLFreeConfig*() {.gdalCall, importc: "CPLFreeConfig", raises: [].}
  proc CPLGetConfigOptions*(): cstringArray {.
    cdecl, importc: "CPLGetConfigOptions", raises: []
  .}

  proc CPLSetConfigOptions*(
    papszConfigOptions: cstringArray
  ) {.cdecl, importc: "CPLSetConfigOptions", raises: [].}

  proc CPLGetThreadLocalConfigOptions*(): cstringArray {.
    cdecl, importc: "CPLGetThreadLocalConfigOptions", raises: []
  .}

  proc CPLSetThreadLocalConfigOptions*(
    papszConfigOptions: cstringArray
  ) {.cdecl, importc: "CPLSetThreadLocalConfigOptions", raises: [].}

  proc CPLLoadConfigOptionsFromFile*(
    pszFilename: cstring, bOverrideEnvVars: cint
  ) {.cdecl, importc: "CPLLoadConfigOptionsFromFile", raises: [].}

  proc CPLLoadConfigOptionsFromPredefinedFiles*() {.
    cdecl, importc: "CPLLoadConfigOptionsFromPredefinedFiles", raises: []
  .}

  proc CPLMalloc*(a0: csize_t): pointer {.cdecl, importc: "CPLMalloc", raises: [].}
  proc CPLCalloc*(
    a0: csize_t, a1: csize_t
  ): pointer {.cdecl, importc: "CPLCalloc", raises: [].}

  proc CPLRealloc*(
    a0: pointer, a1: csize_t
  ): pointer {.cdecl, importc: "CPLRealloc", raises: [].}

  proc CPLStrdup*(a0: cstring): cstring {.cdecl, importc: "CPLStrdup", raises: [].}
  proc CPLStrlwr*(a0: cstring): cstring {.cdecl, importc: "CPLStrlwr", raises: [].}
  proc CPLFGets*(
    a0: cstring, a1: cint, a2: ptr GdalFile
  ): cstring {.cdecl, importc: "CPLFGets", raises: [].}

  proc CPLReadLine*(
    a0: ptr GdalFile
  ): cstring {.cdecl, importc: "CPLReadLine", raises: [].}

  proc CPLReadLineL*(
    a0: ptr VSILFILE
  ): cstring {.cdecl, importc: "CPLReadLineL", raises: [].}

  proc CPLReadLine2L*(
    a0: ptr VSILFILE, a1: cint, a2: CSLConstList
  ): cstring {.cdecl, importc: "CPLReadLine2L", raises: [].}

  proc CPLReadLine3L*(
    a0: ptr VSILFILE, a1: cint, a2: ptr cint, a3: CSLConstList
  ): cstring {.cdecl, importc: "CPLReadLine3L", raises: [].}

  proc CPLAtof*(a0: cstring): cdouble {.cdecl, importc: "CPLAtof", raises: [].}
  proc CPLAtofDelim*(
    a0: cstring, a1: cchar
  ): cdouble {.cdecl, importc: "CPLAtofDelim", raises: [].}

  proc CPLStrtod*(
    a0: cstring, a1: cstringArray
  ): cdouble {.cdecl, importc: "CPLStrtod", raises: [].}

  proc CPLStrtodM*(
    a0: cstring, a1: cstringArray
  ): cdouble {.cdecl, importc: "CPLStrtodM", raises: [].}

  proc CPLStrtodDelim*(
    a0: cstring, a1: cstringArray, a2: cchar
  ): cdouble {.cdecl, importc: "CPLStrtodDelim", raises: [].}

  proc CPLStrtof*(
    a0: cstring, a1: cstringArray
  ): cfloat {.cdecl, importc: "CPLStrtof", raises: [].}

  proc CPLStrtofDelim*(
    a0: cstring, a1: cstringArray, a2: cchar
  ): cfloat {.cdecl, importc: "CPLStrtofDelim", raises: [].}

  proc CPLAtofM*(a0: cstring): cdouble {.cdecl, importc: "CPLAtofM", raises: [].}
  proc CPLScanString*(
    a0: cstring, a1: cint, a2: cint, a3: cint
  ): cstring {.cdecl, importc: "CPLScanString", raises: [].}

  proc CPLScanDouble*(
    a0: cstring, a1: cint
  ): cdouble {.cdecl, importc: "CPLScanDouble", raises: [].}

  proc CPLScanLong*(
    a0: cstring, a1: cint
  ): clong {.cdecl, importc: "CPLScanLong", raises: [].}

  proc CPLScanULong*(
    a0: cstring, a1: cint
  ): culong {.cdecl, importc: "CPLScanULong", raises: [].}

  proc CPLScanUIntBig*(
    a0: cstring, a1: cint
  ): GUIntBig {.cdecl, importc: "CPLScanUIntBig", raises: [].}

  proc CPLAtoGIntBig*(
    pszString: cstring
  ): GIntBig {.cdecl, importc: "CPLAtoGIntBig", raises: [].}

  proc CPLAtoGIntBigEx*(
    pszString: cstring, bWarn: cint, pbOverflow: ptr cint
  ): GIntBig {.cdecl, importc: "CPLAtoGIntBigEx", raises: [].}

  proc CPLScanPointer*(
    a0: cstring, a1: cint
  ): pointer {.cdecl, importc: "CPLScanPointer", raises: [].}

  proc CPLPrintString*(
    a0: cstring, a1: cstring, a2: cint
  ): cint {.cdecl, importc: "CPLPrintString", raises: [].}

  proc CPLPrintStringFill*(
    a0: cstring, a1: cstring, a2: cint
  ): cint {.cdecl, importc: "CPLPrintStringFill", raises: [].}

  proc CPLPrintInt32*(
    a0: cstring, a1: GInt32, a2: cint
  ): cint {.cdecl, importc: "CPLPrintInt32", raises: [].}

  proc CPLPrintUIntBig*(
    a0: cstring, a1: GUIntBig, a2: cint
  ): cint {.cdecl, importc: "CPLPrintUIntBig", raises: [].}

  proc CPLPrintDouble*(
    a0: cstring, a1: cstring, a2: cdouble, a3: cstring
  ): cint {.cdecl, importc: "CPLPrintDouble", raises: [].}

  proc CPLPrintTime*(
    a0: cstring, a1: cint, a2: cstring, a3: ptr GdalSystemtm, a4: cstring
  ): cint {.cdecl, importc: "CPLPrintTime", raises: [].}

  proc CPLPrintPointer*(
    a0: cstring, a1: pointer, a2: cint
  ): cint {.cdecl, importc: "CPLPrintPointer", raises: [].}

  proc CPLGetSymbol*(
    a0: cstring, a1: cstring
  ): pointer {.cdecl, importc: "CPLGetSymbol", raises: [].}

  proc CPLGetExecPath*(
    pszPathBuf: cstring, nMaxLength: cint
  ): cint {.cdecl, importc: "CPLGetExecPath", raises: [].}

  proc CPLGetPath*(a0: cstring): cstring {.cdecl, importc: "CPLGetPath", raises: [].}
  proc CPLGetDirname*(
    a0: cstring
  ): cstring {.cdecl, importc: "CPLGetDirname", raises: [].}

  proc CPLGetBasename*(
    a0: cstring
  ): cstring {.cdecl, importc: "CPLGetBasename", raises: [].}

  proc CPLGetExtension*(
    a0: cstring
  ): cstring {.cdecl, importc: "CPLGetExtension", raises: [].}

  proc CPLFormFilename*(
    pszPath: cstring, pszBasename: cstring, pszExtension: cstring
  ): cstring {.cdecl, importc: "CPLFormFilename", raises: [].}

  proc CPLFormCIFilename*(
    pszPath: cstring, pszBasename: cstring, pszExtension: cstring
  ): cstring {.cdecl, importc: "CPLFormCIFilename", raises: [].}

  proc CPLResetExtension*(
    a0: cstring, a1: cstring
  ): cstring {.cdecl, importc: "CPLResetExtension", raises: [].}

  proc CPLProjectRelativeFilename*(
    pszProjectDir: cstring, pszSecondaryFilename: cstring
  ): cstring {.cdecl, importc: "CPLProjectRelativeFilename", raises: [].}

  proc CPLCleanTrailingSlash*(
    a0: cstring
  ): cstring {.cdecl, importc: "CPLCleanTrailingSlash", raises: [].}

  proc CPLGenerateTempFilename*(
    pszStem: cstring
  ): cstring {.cdecl, importc: "CPLGenerateTempFilename", raises: [].}

  proc CPLExpandTilde*(
    pszFilename: cstring
  ): cstring {.cdecl, importc: "CPLExpandTilde", raises: [].}

  proc CPLLaunderForFilename*(
    pszName: cstring, pszOutputPath: cstring
  ): cstring {.cdecl, importc: "CPLLaunderForFilename", raises: [].}

  proc CPLGetCurrentDir*(): cstring {.cdecl, importc: "CPLGetCurrentDir", raises: [].}
  proc CPLGetFilename*(
    a0: cstring
  ): cstring {.cdecl, importc: "CPLGetFilename", raises: [].}

  proc CPLIsFilenameRelative*(
    pszFilename: cstring
  ): cint {.cdecl, importc: "CPLIsFilenameRelative", raises: [].}

  proc CPLExtractRelativePath*(
    a0: cstring, a1: cstring, a2: ptr cint
  ): cstring {.cdecl, importc: "CPLExtractRelativePath", raises: [].}

  proc CPLCorrespondingPaths*(
    pszOldFilename: cstring, pszNewFilename: cstring, papszFileList: CSLConstList
  ): cstringArray {.cdecl, importc: "CPLCorrespondingPaths", raises: [].}

  proc CPLCheckForFile*(
    pszFilename: cstring, papszSiblingList: CSLConstList
  ): cint {.cdecl, importc: "CPLCheckForFile", raises: [].}

  proc CPLGetHomeDir*(): cstring {.cdecl, importc: "CPLGetHomeDir", raises: [].}
  proc CPLHasPathTraversal*(
    pszFilename: cstring
  ): bool {.cdecl, importc: "CPLHasPathTraversal", raises: [].}

  proc CPLHasUnbalancedPathTraversal*(
    pszFilename: cstring
  ): bool {.cdecl, importc: "CPLHasUnbalancedPathTraversal", raises: [].}

  proc CPLFindFile*(
    pszClass: cstring, pszBasename: cstring
  ): cstring {.cdecl, importc: "CPLFindFile", raises: [].}

  proc CPLDefaultFindFile*(
    pszClass: cstring, pszBasename: cstring
  ): cstring {.cdecl, importc: "CPLDefaultFindFile", raises: [].}

  proc CPLPushFileFinder*(
    pfnFinder: CPLFileFinder
  ) {.cdecl, importc: "CPLPushFileFinder", raises: [].}

  proc CPLPopFileFinder*(): CPLFileFinder {.
    cdecl, importc: "CPLPopFileFinder", raises: []
  .}

  proc CPLPushFinderLocation*(
    a0: cstring
  ) {.cdecl, importc: "CPLPushFinderLocation", raises: [].}

  proc CPLPopFinderLocation*() {.cdecl, importc: "CPLPopFinderLocation", raises: [].}
  proc CPLFinderClean*() {.cdecl, importc: "CPLFinderClean", raises: [].}
  proc CPLStat*(
    a0: cstring, a1: ptr VSIStatBuf
  ): cint {.cdecl, importc: "CPLStat", raises: [].}

  proc CPLOpenShared*(
    a0: cstring, a1: cstring, a2: cint
  ): ptr GdalFile {.cdecl, importc: "CPLOpenShared", raises: [].}

  proc CPLCloseShared*(
    a0: ptr GdalFile
  ) {.cdecl, importc: "CPLCloseShared", raises: [].}

  proc CPLGetSharedList*(
    a0: ptr cint
  ): ptr CPLSharedFileInfo {.cdecl, importc: "CPLGetSharedList", raises: [].}

  proc CPLDumpSharedList*(
    a0: ptr GdalFile
  ) {.cdecl, importc: "CPLDumpSharedList", raises: [].}

  proc CPLCleanupSharedFileMutex*() {.
    cdecl, importc: "CPLCleanupSharedFileMutex", raises: []
  .}

  proc CPLDMSToDec*(
    `is`: cstring
  ): cdouble {.cdecl, importc: "CPLDMSToDec", raises: [].}

  proc CPLDecToDMS*(
    dfAngle: cdouble, pszAxis: cstring, nPrecision: cint
  ): cstring {.cdecl, importc: "CPLDecToDMS", raises: [].}

  proc CPLPackedDMSToDec*(
    a0: cdouble
  ): cdouble {.cdecl, importc: "CPLPackedDMSToDec", raises: [].}

  proc CPLDecToPackedDMS*(
    dfDec: cdouble
  ): cdouble {.cdecl, importc: "CPLDecToPackedDMS", raises: [].}

  proc CPLStringToComplex*(
    pszString: cstring, pdfReal: ptr cdouble, pdfImag: ptr cdouble
  ): CPLErr {.cdecl, importc: "CPLStringToComplex", raises: [].}

  proc CPLUnlinkTree*(a0: cstring): cint {.cdecl, importc: "CPLUnlinkTree", raises: [].}
  proc CPLCopyFile*(
    pszNewPath: cstring, pszOldPath: cstring
  ): cint {.cdecl, importc: "CPLCopyFile", raises: [].}

  proc CPLCopyTree*(
    pszNewPath: cstring, pszOldPath: cstring
  ): cint {.cdecl, importc: "CPLCopyTree", raises: [].}

  proc CPLMoveFile*(
    pszNewPath: cstring, pszOldPath: cstring
  ): cint {.cdecl, importc: "CPLMoveFile", raises: [].}

  proc CPLSymlink*(
    pszOldPath: cstring, pszNewPath: cstring, papszOptions: CSLConstList
  ): cint {.cdecl, importc: "CPLSymlink", raises: [].}

  proc CPLGetRemainingFileDescriptorCount*(): cint {.
    cdecl, importc: "CPLGetRemainingFileDescriptorCount", raises: []
  .}

  proc CPLLockFileEx*(
    pszLockFileName: cstring,
    phLockFileHandle: ptr CPLLockFileHandle,
    papszOptions: CSLConstList,
  ): CPLLockFileStatus {.cdecl, importc: "CPLLockFileEx", raises: [].}

  proc CPLUnlockFileEx*(
    hLockFileHandle: CPLLockFileHandle
  ) {.cdecl, importc: "CPLUnlockFileEx", raises: [].}

  proc CPLCreateZip*(
    pszZipFilename: cstring, papszOptions: cstringArray
  ): pointer {.cdecl, importc: "CPLCreateZip", raises: [].}

  proc CPLCreateFileInZip*(
    hZip: pointer, pszFilename: cstring, papszOptions: cstringArray
  ): CPLErr {.cdecl, importc: "CPLCreateFileInZip", raises: [].}

  proc CPLWriteFileInZip*(
    hZip: pointer, pBuffer: pointer, nBufferSize: cint
  ): CPLErr {.cdecl, importc: "CPLWriteFileInZip", raises: [].}

  proc CPLCloseFileInZip*(
    hZip: pointer
  ): CPLErr {.cdecl, importc: "CPLCloseFileInZip", raises: [].}

  proc CPLAddFileInZip*(
    hZip: pointer,
    pszArchiveFilename: cstring,
    pszInputFilename: cstring,
    fpInput: ptr VSILFILE,
    papszOptions: CSLConstList,
    pProgressFunc: GDALProgressFunc,
    pProgressData: pointer,
  ): CPLErr {.cdecl, importc: "CPLAddFileInZip", raises: [].}

  proc CPLCloseZip*(hZip: pointer): CPLErr {.cdecl, importc: "CPLCloseZip", raises: [].}
  proc CPLZLibDeflate*(
    `ptr`: pointer,
    nBytes: csize_t,
    nLevel: cint,
    outptr: pointer,
    nOutAvailableBytes: csize_t,
    pnOutBytes: ptr csize_t,
  ): pointer {.cdecl, importc: "CPLZLibDeflate", raises: [].}

  proc CPLZLibInflate*(
    `ptr`: pointer,
    nBytes: csize_t,
    outptr: pointer,
    nOutAvailableBytes: csize_t,
    pnOutBytes: ptr csize_t,
  ): pointer {.cdecl, importc: "CPLZLibInflate", raises: [].}

  proc CPLZLibInflateEx*(
    `ptr`: pointer,
    nBytes: csize_t,
    outptr: pointer,
    nOutAvailableBytes: csize_t,
    bAllowResizeOutptr: bool,
    pnOutBytes: ptr csize_t,
  ): pointer {.cdecl, importc: "CPLZLibInflateEx", raises: [].}

  proc CPLValidateXML*(
    pszXMLFilename: cstring, pszXSDFilename: cstring, papszOptions: CSLConstList
  ): cint {.cdecl, importc: "CPLValidateXML", raises: [].}

  proc CPLsetlocale*(
    category: cint, locale: cstring
  ): cstring {.cdecl, importc: "CPLsetlocale", raises: [].}

  proc CPLCleanupSetlocaleMutex*() {.
    cdecl, importc: "CPLCleanupSetlocaleMutex", raises: []
  .}

  proc CPLIsPowerOfTwo*(
    i: cuint
  ): cint {.cdecl, importc: "CPLIsPowerOfTwo", raises: [].}

  proc CPLIsInteractive*(
    f: ptr GdalFile
  ): bool {.cdecl, importc: "CPLIsInteractive", raises: [].}

  proc CSLAddString*(
    papszStrList: cstringArray, pszNewString: cstring
  ): cstringArray {.cdecl, importc: "CSLAddString", raises: [].}

  proc CSLAddStringMayFail*(
    papszStrList: cstringArray, pszNewString: cstring
  ): cstringArray {.cdecl, importc: "CSLAddStringMayFail", raises: [].}

  proc CSLCount*(
    papszStrList: CSLConstList
  ): cint {.cdecl, importc: "CSLCount", raises: [].}

  proc CSLGetField*(
    a0: CSLConstList, a1: cint
  ): cstring {.cdecl, importc: "CSLGetField", raises: [].}

  proc CSLDestroy*(
    papszStrList: cstringArray
  ) {.gdalCall, importc: "CSLDestroy", raises: [].}

  proc CSLDuplicate*(
    papszStrList: CSLConstList
  ): cstringArray {.cdecl, importc: "CSLDuplicate", raises: [].}

  proc CSLMerge*(
    papszOrig: cstringArray, papszOverride: CSLConstList
  ): cstringArray {.cdecl, importc: "CSLMerge", raises: [].}

  proc CSLTokenizeString*(
    pszString: cstring
  ): cstringArray {.cdecl, importc: "CSLTokenizeString", raises: [].}

  proc CSLTokenizeStringComplex*(
    pszString: cstring,
    pszDelimiter: cstring,
    bHonourStrings: cint,
    bAllowEmptyTokens: cint,
  ): cstringArray {.cdecl, importc: "CSLTokenizeStringComplex", raises: [].}

  proc CSLTokenizeString2*(
    pszString: cstring, pszDelimiter: cstring, nCSLTFlags: cint
  ): cstringArray {.cdecl, importc: "CSLTokenizeString2", raises: [].}

  proc CSLPrint*(
    papszStrList: CSLConstList, fpOut: ptr GdalFile
  ): cint {.cdecl, importc: "CSLPrint", raises: [].}

  proc CSLLoad*(
    pszFname: cstring
  ): cstringArray {.cdecl, importc: "CSLLoad", raises: [].}

  proc CSLLoad2*(
    pszFname: cstring, nMaxLines: cint, nMaxCols: cint, papszOptions: CSLConstList
  ): cstringArray {.cdecl, importc: "CSLLoad2", raises: [].}

  proc CSLSave*(
    papszStrList: CSLConstList, pszFname: cstring
  ): cint {.cdecl, importc: "CSLSave", raises: [].}

  proc CSLInsertStrings*(
    papszStrList: cstringArray, nInsertAtLineNo: cint, papszNewLines: CSLConstList
  ): cstringArray {.cdecl, importc: "CSLInsertStrings", raises: [].}

  proc CSLInsertString*(
    papszStrList: cstringArray, nInsertAtLineNo: cint, pszNewLine: cstring
  ): cstringArray {.cdecl, importc: "CSLInsertString", raises: [].}

  proc CSLRemoveStrings*(
    papszStrList: cstringArray,
    nFirstLineToDelete: cint,
    nNumToRemove: cint,
    ppapszRetStrings: ptr cstringArray,
  ): cstringArray {.cdecl, importc: "CSLRemoveStrings", raises: [].}

  proc CSLFindString*(
    papszList: CSLConstList, pszTarget: cstring
  ): cint {.cdecl, importc: "CSLFindString", raises: [].}

  proc CSLFindStringCaseSensitive*(
    papszList: CSLConstList, pszTarget: cstring
  ): cint {.cdecl, importc: "CSLFindStringCaseSensitive", raises: [].}

  proc CSLPartialFindString*(
    papszHaystack: CSLConstList, pszNeedle: cstring
  ): cint {.cdecl, importc: "CSLPartialFindString", raises: [].}

  proc CSLFindName*(
    papszStrList: CSLConstList, pszName: cstring
  ): cint {.cdecl, importc: "CSLFindName", raises: [].}

  proc CSLFetchBoolean*(
    papszStrList: CSLConstList, pszKey: cstring, bDefault: cint
  ): cint {.cdecl, importc: "CSLFetchBoolean", raises: [].}

  proc CSLTestBoolean*(
    pszValue: cstring
  ): cint {.cdecl, importc: "CSLTestBoolean", raises: [].}

  proc CPLTestBoolean*(
    pszValue: cstring
  ): cint {.cdecl, importc: "CPLTestBoolean", raises: [].}

  proc CPLTestBool*(
    pszValue: cstring
  ): bool {.cdecl, importc: "CPLTestBool", raises: [].}

  proc CPLFetchBool*(
    papszStrList: CSLConstList, pszKey: cstring, bDefault: bool
  ): bool {.cdecl, importc: "CPLFetchBool", raises: [].}

  proc CPLParseMemorySize*(
    pszValue: cstring, pnValue: ptr GIntBig, pbUnitSpecified: ptr bool
  ): CPLErr {.cdecl, importc: "CPLParseMemorySize", raises: [].}

  proc CPLParseNameValue*(
    pszNameValue: cstring, ppszKey: cstringArray
  ): cstring {.cdecl, importc: "CPLParseNameValue", raises: [].}

  proc CPLParseNameValueSep*(
    pszNameValue: cstring, ppszKey: cstringArray, chSep: cchar
  ): cstring {.cdecl, importc: "CPLParseNameValueSep", raises: [].}

  proc CSLFetchNameValue*(
    papszStrList: CSLConstList, pszName: cstring
  ): cstring {.cdecl, importc: "CSLFetchNameValue", raises: [].}

  proc CSLFetchNameValueDef*(
    papszStrList: CSLConstList, pszName: cstring, pszDefault: cstring
  ): cstring {.cdecl, importc: "CSLFetchNameValueDef", raises: [].}

  proc CSLFetchNameValueMultiple*(
    papszStrList: CSLConstList, pszName: cstring
  ): cstringArray {.cdecl, importc: "CSLFetchNameValueMultiple", raises: [].}

  proc CSLAddNameValue*(
    papszStrList: cstringArray, pszName: cstring, pszValue: cstring
  ): cstringArray {.cdecl, importc: "CSLAddNameValue", raises: [].}

  proc CSLSetNameValue*(
    papszStrList: cstringArray, pszName: cstring, pszValue: cstring
  ): cstringArray {.cdecl, importc: "CSLSetNameValue", raises: [].}

  proc CSLSetNameValueSeparator*(
    papszStrList: cstringArray, pszSeparator: cstring
  ) {.cdecl, importc: "CSLSetNameValueSeparator", raises: [].}

  proc CSLParseCommandLine*(
    pszCommandLine: cstring
  ): cstringArray {.cdecl, importc: "CSLParseCommandLine", raises: [].}

  proc CPLEscapeString*(
    pszString: cstring, nLength: cint, nScheme: cint
  ): cstring {.cdecl, importc: "CPLEscapeString", raises: [].}

  proc CPLUnescapeString*(
    pszString: cstring, pnLength: ptr cint, nScheme: cint
  ): cstring {.cdecl, importc: "CPLUnescapeString", raises: [].}

  proc CPLBinaryToHex*(
    nBytes: cint, pabyData: ptr GByte
  ): cstring {.cdecl, importc: "CPLBinaryToHex", raises: [].}

  proc CPLHexToBinary*(
    pszHex: cstring, pnBytes: ptr cint
  ): ptr GByte {.cdecl, importc: "CPLHexToBinary", raises: [].}

  proc CPLBase64Encode*(
    nBytes: cint, pabyData: ptr GByte
  ): cstring {.cdecl, importc: "CPLBase64Encode", raises: [].}

  proc CPLBase64DecodeInPlace*(
    pszBase64: ptr GByte
  ): cint {.cdecl, importc: "CPLBase64DecodeInPlace", raises: [].}

  proc CPLGetValueType*(
    pszValue: cstring
  ): CPLValueType {.cdecl, importc: "CPLGetValueType", raises: [].}

  proc CPLToupper*(c: cint): cint {.cdecl, importc: "CPLToupper", raises: [].}
  proc CPLTolower*(c: cint): cint {.cdecl, importc: "CPLTolower", raises: [].}
  proc CPLStrlcpy*(
    pszDest: cstring, pszSrc: cstring, nDestSize: csize_t
  ): csize_t {.cdecl, importc: "CPLStrlcpy", raises: [].}

  proc CPLStrlcat*(
    pszDest: cstring, pszSrc: cstring, nDestSize: csize_t
  ): csize_t {.cdecl, importc: "CPLStrlcat", raises: [].}

  proc CPLStrnlen*(
    pszStr: cstring, nMaxLen: csize_t
  ): csize_t {.cdecl, importc: "CPLStrnlen", raises: [].}

  proc CPLvsnprintf*(
    str: cstring, size: csize_t, fmt: cstring, args: GdalVaList
  ): cint {.cdecl, importc: "CPLvsnprintf", raises: [].}

  proc CPLsnprintf*(
    str: cstring, size: csize_t, fmt: cstring
  ): cint {.cdecl, importc: "CPLsnprintf", raises: [], varargs.}

  proc CPLsprintfBuffer*(
    str: cstring, fmt: cstring
  ): cint {.cdecl, importc: "CPLsprintf", raises: [], varargs.}

  proc CPLprintf*(
    fmt: cstring
  ): cint {.cdecl, importc: "CPLprintf", raises: [], varargs.}

  proc CPLsscanf*(
    str: cstring, fmt: cstring
  ): cint {.cdecl, importc: "CPLsscanf", raises: [], varargs.}

  proc CPLSPrintfText*(
    fmt: cstring
  ): cstring {.cdecl, importc: "CPLSPrintf", raises: [], varargs.}

  proc CSLAppendPrintf*(
    papszStrList: cstringArray, fmt: cstring
  ): cstringArray {.cdecl, importc: "CSLAppendPrintf", raises: [], varargs.}

  proc CPLVASPrintf*(
    buf: cstringArray, fmt: cstring, args: GdalVaList
  ): cint {.cdecl, importc: "CPLVASPrintf", raises: [].}

  proc CPLEncodingCharSize*(
    pszEncoding: cstring
  ): cint {.cdecl, importc: "CPLEncodingCharSize", raises: [].}

  proc CPLClearRecodeWarningFlags*() {.
    cdecl, importc: "CPLClearRecodeWarningFlags", raises: []
  .}

  proc CPLRecode*(
    pszSource: cstring, pszSrcEncoding: cstring, pszDstEncoding: cstring
  ): cstring {.cdecl, importc: "CPLRecode", raises: [].}

  proc CPLRecodeFromWChar*(
    pwszSource: ptr cint, pszSrcEncoding: cstring, pszDstEncoding: cstring
  ): cstring {.cdecl, importc: "CPLRecodeFromWChar", raises: [].}

  proc CPLRecodeToWChar*(
    pszSource: cstring, pszSrcEncoding: cstring, pszDstEncoding: cstring
  ): ptr cint {.cdecl, importc: "CPLRecodeToWChar", raises: [].}

  proc CPLIsUTF8*(
    pabyData: cstring, nLen: cint
  ): cint {.cdecl, importc: "CPLIsUTF8", raises: [].}

  proc CPLIsASCII*(
    pabyData: cstring, nLen: csize_t
  ): bool {.cdecl, importc: "CPLIsASCII", raises: [].}

  proc CPLForceToASCII*(
    pabyData: cstring, nLen: cint, chReplacementChar: cchar
  ): cstring {.cdecl, importc: "CPLForceToASCII", raises: [].}

  proc CPLUTF8ForceToASCII*(
    pszStr: cstring, chReplacementChar: cchar
  ): cstring {.cdecl, importc: "CPLUTF8ForceToASCII", raises: [].}

  proc CPLStrlenUTF8*(
    pszUTF8Str: cstring
  ): cint {.cdecl, importc: "CPLStrlenUTF8", raises: [].}

  proc CPLStrlenUTF8Ex*(
    pszUTF8Str: cstring
  ): csize_t {.cdecl, importc: "CPLStrlenUTF8Ex", raises: [].}

  proc CPLCanRecode*(
    pszTestStr: cstring, pszSrcEncoding: cstring, pszDstEncoding: cstring
  ): cint {.cdecl, importc: "CPLCanRecode", raises: [].}

  proc CSVFilename*(a0: cstring): cstring {.cdecl, importc: "CSVFilename", raises: [].}
  proc CSVDetectSeperator*(
    pszLine: cstring
  ): cchar {.cdecl, importc: "CSVDetectSeperator", raises: [].}

  proc CSVReadParseLine*(
    fp: ptr GdalFile
  ): cstringArray {.cdecl, importc: "CSVReadParseLine", raises: [].}

  proc CSVReadParseLine2*(
    fp: ptr GdalFile, chDelimiter: cchar
  ): cstringArray {.cdecl, importc: "CSVReadParseLine2", raises: [].}

  proc CSVReadParseLineL*(
    fp: ptr VSILFILE
  ): cstringArray {.cdecl, importc: "CSVReadParseLineL", raises: [].}

  proc CSVReadParseLine2L*(
    fp: ptr VSILFILE, chDelimiter: cchar
  ): cstringArray {.cdecl, importc: "CSVReadParseLine2L", raises: [].}

  proc CSVReadParseLine3L*(
    fp: ptr VSILFILE,
    nMaxLineSize: csize_t,
    pszDelimiter: cstring,
    bHonourStrings: bool,
    bKeepLeadingAndClosingQuotes: bool,
    bMergeDelimiter: bool,
    bSkipBOM: bool,
  ): cstringArray {.cdecl, importc: "CSVReadParseLine3L", raises: [].}

  proc CSVScanLines*(
    a0: ptr GdalFile, a1: cint, a2: cstring, a3: CSVCompareCriteria
  ): cstringArray {.cdecl, importc: "CSVScanLines", raises: [].}

  proc CSVScanLinesL*(
    a0: ptr VSILFILE, a1: cint, a2: cstring, a3: CSVCompareCriteria
  ): cstringArray {.cdecl, importc: "CSVScanLinesL", raises: [].}

  proc CSVScanFile*(
    a0: cstring, a1: cint, a2: cstring, a3: CSVCompareCriteria
  ): cstringArray {.cdecl, importc: "CSVScanFile", raises: [].}

  proc CSVScanFileByName*(
    a0: cstring, a1: cstring, a2: cstring, a3: CSVCompareCriteria
  ): cstringArray {.cdecl, importc: "CSVScanFileByName", raises: [].}

  proc CSVRewind*(a0: cstring) {.cdecl, importc: "CSVRewind", raises: [].}
  proc CSVGetNextLine*(
    a0: cstring
  ): cstringArray {.cdecl, importc: "CSVGetNextLine", raises: [].}

  proc CSVGetFieldId*(
    a0: ptr GdalFile, a1: cstring
  ): cint {.cdecl, importc: "CSVGetFieldId", raises: [].}

  proc CSVGetFieldIdL*(
    a0: ptr VSILFILE, a1: cstring
  ): cint {.cdecl, importc: "CSVGetFieldIdL", raises: [].}

  proc CSVGetFileFieldId*(
    a0: cstring, a1: cstring
  ): cint {.cdecl, importc: "CSVGetFileFieldId", raises: [].}

  proc CSVDeaccess*(a0: cstring) {.cdecl, importc: "CSVDeaccess", raises: [].}
  proc CSVGetField*(
    a0: cstring, a1: cstring, a2: cstring, a3: CSVCompareCriteria, a4: cstring
  ): cstring {.cdecl, importc: "CSVGetField", raises: [].}

  proc SetCSVFilenameHook*(
    a0: proc(a0: cstring): cstring {.cdecl, raises: [].}
  ) {.cdecl, importc: "SetCSVFilenameHook", raises: [].}

  proc CPLHalfToFloat*(
    iHalf: GUInt16
  ): GUInt32 {.cdecl, importc: "CPLHalfToFloat", raises: [].}

  proc CPLTripleToFloat*(
    iTriple: GUInt32
  ): GUInt32 {.cdecl, importc: "CPLTripleToFloat", raises: [].}

  proc CPLHashSetNew*(
    fnHashFunc: CPLHashSetHashFunc,
    fnEqualFunc: CPLHashSetEqualFunc,
    fnFreeEltFunc: CPLHashSetFreeEltFunc,
  ): ptr CPLHashSet {.cdecl, importc: "CPLHashSetNew", raises: [].}

  proc CPLHashSetDestroy*(
    set: ptr CPLHashSet
  ) {.cdecl, importc: "CPLHashSetDestroy", raises: [].}

  proc CPLHashSetClear*(
    set: ptr CPLHashSet
  ) {.cdecl, importc: "CPLHashSetClear", raises: [].}

  proc CPLHashSetSize*(
    set: ptr CPLHashSet
  ): cint {.cdecl, importc: "CPLHashSetSize", raises: [].}

  proc CPLHashSetForeach*(
    set: ptr CPLHashSet, fnIterFunc: CPLHashSetIterEltFunc, user_data: pointer
  ) {.cdecl, importc: "CPLHashSetForeach", raises: [].}

  proc CPLHashSetInsert*(
    set: ptr CPLHashSet, elt: pointer
  ): cint {.cdecl, importc: "CPLHashSetInsert", raises: [].}

  proc CPLHashSetLookup*(
    set: ptr CPLHashSet, elt: pointer
  ): pointer {.cdecl, importc: "CPLHashSetLookup", raises: [].}

  proc CPLHashSetRemove*(
    set: ptr CPLHashSet, elt: pointer
  ): cint {.cdecl, importc: "CPLHashSetRemove", raises: [].}

  proc CPLHashSetRemoveDeferRehash*(
    set: ptr CPLHashSet, elt: pointer
  ): cint {.cdecl, importc: "CPLHashSetRemoveDeferRehash", raises: [].}

  proc CPLHashSetHashPointer*(
    elt: pointer
  ): culong {.cdecl, importc: "CPLHashSetHashPointer", raises: [].}

  proc CPLHashSetEqualPointer*(
    elt1: pointer, elt2: pointer
  ): cint {.cdecl, importc: "CPLHashSetEqualPointer", raises: [].}

  proc CPLHashSetHashStr*(
    pszStr: pointer
  ): culong {.cdecl, importc: "CPLHashSetHashStr", raises: [].}

  proc CPLHashSetEqualStr*(
    pszStr1: pointer, pszStr2: pointer
  ): cint {.cdecl, importc: "CPLHashSetEqualStr", raises: [].}

  proc CPLHTTPEnabled*(): cint {.cdecl, importc: "CPLHTTPEnabled", raises: [].}
  proc CPLHTTPFetch*(
    pszURL: cstring, papszOptions: CSLConstList
  ): ptr CPLHTTPResult {.cdecl, importc: "CPLHTTPFetch", raises: [].}

  proc CPLHTTPFetchEx*(
    pszURL: cstring,
    papszOptions: CSLConstList,
    pfnProgress: GDALProgressFunc,
    pProgressArg: pointer,
    pfnWrite: CPLHTTPFetchWriteFunc,
    pWriteArg: pointer,
  ): ptr CPLHTTPResult {.cdecl, importc: "CPLHTTPFetchEx", raises: [].}

  proc CPLHTTPMultiFetch*(
    papszURL: cstringArray,
    nURLCount: cint,
    nMaxSimultaneous: cint,
    papszOptions: CSLConstList,
  ): ptr ptr CPLHTTPResult {.cdecl, importc: "CPLHTTPMultiFetch", raises: [].}

  proc CPLHTTPCleanup*() {.cdecl, importc: "CPLHTTPCleanup", raises: [].}
  proc CPLHTTPDestroyResult*(
    psResult: ptr CPLHTTPResult
  ) {.cdecl, importc: "CPLHTTPDestroyResult", raises: [].}

  proc CPLHTTPDestroyMultiResult*(
    papsResults: ptr ptr CPLHTTPResult, nCount: cint
  ) {.cdecl, importc: "CPLHTTPDestroyMultiResult", raises: [].}

  proc CPLHTTPParseMultipartMime*(
    psResult: ptr CPLHTTPResult
  ): cint {.cdecl, importc: "CPLHTTPParseMultipartMime", raises: [].}

  proc CPLHTTPSetDefaultUserAgent*(
    pszUserAgent: cstring
  ) {.cdecl, importc: "CPLHTTPSetDefaultUserAgent", raises: [].}

  proc CPLHTTPSetFetchCallback*(
    pFunc: CPLHTTPFetchCallbackFunc, pUserData: pointer
  ) {.cdecl, importc: "CPLHTTPSetFetchCallback", raises: [].}

  proc CPLHTTPPushFetchCallback*(
    pFunc: CPLHTTPFetchCallbackFunc, pUserData: pointer
  ): cint {.cdecl, importc: "CPLHTTPPushFetchCallback", raises: [].}

  proc CPLHTTPPopFetchCallback*(): cint {.
    cdecl, importc: "CPLHTTPPopFetchCallback", raises: []
  .}

  proc GOA2GetAuthorizationURL*(
    pszScope: cstring
  ): cstring {.cdecl, importc: "GOA2GetAuthorizationURL", raises: [].}

  proc GOA2GetRefreshToken*(
    pszAuthToken: cstring, pszScope: cstring
  ): cstring {.cdecl, importc: "GOA2GetRefreshToken", raises: [].}

  proc GOA2GetAccessToken*(
    pszRefreshToken: cstring, pszScope: cstring
  ): cstring {.cdecl, importc: "GOA2GetAccessToken", raises: [].}

  proc GOA2GetAccessTokenFromServiceAccount*(
    pszPrivateKey: cstring,
    pszClientEmail: cstring,
    pszScope: cstring,
    papszAdditionalClaims: CSLConstList,
    papszOptions: CSLConstList,
  ): cstringArray {.cdecl, importc: "GOA2GetAccessTokenFromServiceAccount", raises: [].}

  proc GOA2GetAccessTokenFromCloudEngineVM*(
    papszOptions: CSLConstList
  ): cstringArray {.cdecl, importc: "GOA2GetAccessTokenFromCloudEngineVM", raises: [].}

  proc CPLListAppend*(
    psList: ptr CPLList, pData: pointer
  ): ptr CPLList {.cdecl, importc: "CPLListAppend", raises: [].}

  proc CPLListInsert*(
    psList: ptr CPLList, pData: pointer, nPosition: cint
  ): ptr CPLList {.cdecl, importc: "CPLListInsert", raises: [].}

  proc CPLListGetLast*(
    psList: ptr CPLList
  ): ptr CPLList {.cdecl, importc: "CPLListGetLast", raises: [].}

  proc CPLListGet*(
    psList: ptr CPLList, nPosition: cint
  ): ptr CPLList {.cdecl, importc: "CPLListGet", raises: [].}

  proc CPLListCount*(
    psList: ptr CPLList
  ): cint {.cdecl, importc: "CPLListCount", raises: [].}

  proc CPLListRemove*(
    psList: ptr CPLList, nPosition: cint
  ): ptr CPLList {.cdecl, importc: "CPLListRemove", raises: [].}

  proc CPLListDestroy*(
    psList: ptr CPLList
  ) {.cdecl, importc: "CPLListDestroy", raises: [].}

  proc CPLListGetNext*(
    psElement: ptr CPLList
  ): ptr CPLList {.cdecl, importc: "CPLListGetNext", raises: [].}

  proc CPLListGetData*(
    psElement: ptr CPLList
  ): pointer {.cdecl, importc: "CPLListGetData", raises: [].}

  proc CPLParseXMLString*(
    a0: cstring
  ): ptr CPLXMLNode {.cdecl, importc: "CPLParseXMLString", raises: [].}

  proc CPLDestroyXMLNode*(
    a0: ptr CPLXMLNode
  ) {.cdecl, importc: "CPLDestroyXMLNode", raises: [].}

  proc CPLGetXMLNode*(
    poRoot: ptr CPLXMLNode, pszPath: cstring
  ): ptr CPLXMLNode {.cdecl, importc: "CPLGetXMLNode", raises: [].}

  proc CPLSearchXMLNode*(
    poRoot: ptr CPLXMLNode, pszTarget: cstring
  ): ptr CPLXMLNode {.cdecl, importc: "CPLSearchXMLNode", raises: [].}

  proc CPLGetXMLValue*(
    poRoot: ptr CPLXMLNode, pszPath: cstring, pszDefault: cstring
  ): cstring {.cdecl, importc: "CPLGetXMLValue", raises: [].}

  proc CPLCreateXMLNode*(
    poParent: ptr CPLXMLNode, eType: CPLXMLNodeType, pszText: cstring
  ): ptr CPLXMLNode {.cdecl, importc: "CPLCreateXMLNode", raises: [].}

  proc CPLSerializeXMLTree*(
    psNode: ptr CPLXMLNode
  ): cstring {.cdecl, importc: "CPLSerializeXMLTree", raises: [].}

  proc CPLAddXMLChild*(
    psParent: ptr CPLXMLNode, psChild: ptr CPLXMLNode
  ) {.cdecl, importc: "CPLAddXMLChild", raises: [].}

  proc CPLRemoveXMLChild*(
    psParent: ptr CPLXMLNode, psChild: ptr CPLXMLNode
  ): cint {.cdecl, importc: "CPLRemoveXMLChild", raises: [].}

  proc CPLAddXMLSibling*(
    psOlderSibling: ptr CPLXMLNode, psNewSibling: ptr CPLXMLNode
  ) {.cdecl, importc: "CPLAddXMLSibling", raises: [].}

  proc CPLCreateXMLElementAndValue*(
    psParent: ptr CPLXMLNode, pszName: cstring, pszValue: cstring
  ): ptr CPLXMLNode {.cdecl, importc: "CPLCreateXMLElementAndValue", raises: [].}

  proc CPLAddXMLAttributeAndValue*(
    psParent: ptr CPLXMLNode, pszName: cstring, pszValue: cstring
  ) {.cdecl, importc: "CPLAddXMLAttributeAndValue", raises: [].}

  proc CPLCloneXMLTree*(
    psTree: ptr CPLXMLNode
  ): ptr CPLXMLNode {.cdecl, importc: "CPLCloneXMLTree", raises: [].}

  proc CPLSetXMLValue*(
    psRoot: ptr CPLXMLNode, pszPath: cstring, pszValue: cstring
  ): cint {.cdecl, importc: "CPLSetXMLValue", raises: [].}

  proc CPLStripXMLNamespace*(
    psRoot: ptr CPLXMLNode, pszNameSpace: cstring, bRecurse: cint
  ) {.cdecl, importc: "CPLStripXMLNamespace", raises: [].}

  proc CPLCleanXMLElementName*(
    a0: cstring
  ) {.cdecl, importc: "CPLCleanXMLElementName", raises: [].}

  proc CPLParseXMLFile*(
    pszFilename: cstring
  ): ptr CPLXMLNode {.cdecl, importc: "CPLParseXMLFile", raises: [].}

  proc CPLSerializeXMLTreeToFile*(
    psTree: ptr CPLXMLNode, pszFilename: cstring
  ): cint {.cdecl, importc: "CPLSerializeXMLTreeToFile", raises: [].}

  proc CPLXMLNodeGetRAMUsageEstimate*(
    psNode: ptr CPLXMLNode
  ): csize_t {.cdecl, importc: "CPLXMLNodeGetRAMUsageEstimate", raises: [].}

  proc CPLLockFile*(
    pszPath: cstring, dfWaitInSeconds: cdouble
  ): pointer {.cdecl, importc: "CPLLockFile", raises: [].}

  proc CPLUnlockFile*(hLock: pointer) {.cdecl, importc: "CPLUnlockFile", raises: [].}
  proc CPLCreateMutex*(): ptr CPLMutex {.cdecl, importc: "CPLCreateMutex", raises: [].}
  proc CPLCreateMutexEx*(
    nOptions: cint
  ): ptr CPLMutex {.cdecl, importc: "CPLCreateMutexEx", raises: [].}

  proc CPLCreateOrAcquireMutex*(
    a0: ptr ptr CPLMutex, dfWaitInSeconds: cdouble
  ): cint {.cdecl, importc: "CPLCreateOrAcquireMutex", raises: [].}

  proc CPLCreateOrAcquireMutexEx*(
    a0: ptr ptr CPLMutex, dfWaitInSeconds: cdouble, nOptions: cint
  ): cint {.cdecl, importc: "CPLCreateOrAcquireMutexEx", raises: [].}

  proc CPLAcquireMutex*(
    hMutex: ptr CPLMutex, dfWaitInSeconds: cdouble
  ): cint {.cdecl, importc: "CPLAcquireMutex", raises: [].}

  proc CPLReleaseMutex*(
    hMutex: ptr CPLMutex
  ) {.cdecl, importc: "CPLReleaseMutex", raises: [].}

  proc CPLDestroyMutex*(
    hMutex: ptr CPLMutex
  ) {.cdecl, importc: "CPLDestroyMutex", raises: [].}

  proc CPLCleanupMasterMutex*() {.cdecl, importc: "CPLCleanupMasterMutex", raises: [].}
  proc CPLCreateCond*(): ptr CPLCond {.cdecl, importc: "CPLCreateCond", raises: [].}
  proc CPLCondWait*(
    hCond: ptr CPLCond, hMutex: ptr CPLMutex
  ) {.cdecl, importc: "CPLCondWait", raises: [].}

  proc CPLCondTimedWait*(
    hCond: ptr CPLCond, hMutex: ptr CPLMutex, dfWaitInSeconds: cdouble
  ): CPLCondTimedWaitReason {.cdecl, importc: "CPLCondTimedWait", raises: [].}

  proc CPLCondSignal*(
    hCond: ptr CPLCond
  ) {.cdecl, importc: "CPLCondSignal", raises: [].}

  proc CPLCondBroadcast*(
    hCond: ptr CPLCond
  ) {.cdecl, importc: "CPLCondBroadcast", raises: [].}

  proc CPLDestroyCond*(
    hCond: ptr CPLCond
  ) {.cdecl, importc: "CPLDestroyCond", raises: [].}

  proc CPLGetPID*(): GIntBig {.cdecl, importc: "CPLGetPID", raises: [].}
  proc CPLGetCurrentProcessID*(): cint {.
    cdecl, importc: "CPLGetCurrentProcessID", raises: []
  .}

  proc CPLCreateThread*(
    pfnMain: CPLThreadFunc, pArg: pointer
  ): cint {.cdecl, importc: "CPLCreateThread", raises: [].}

  proc CPLCreateJoinableThread*(
    pfnMain: CPLThreadFunc, pArg: pointer
  ): ptr CPLJoinableThread {.cdecl, importc: "CPLCreateJoinableThread", raises: [].}

  proc CPLJoinThread*(
    hJoinableThread: ptr CPLJoinableThread
  ) {.cdecl, importc: "CPLJoinThread", raises: [].}

  proc CPLSleep*(dfWaitInSeconds: cdouble) {.cdecl, importc: "CPLSleep", raises: [].}
  proc CPLGetThreadingModel*(): cstring {.
    cdecl, importc: "CPLGetThreadingModel", raises: []
  .}

  proc CPLGetNumCPUs*(): cint {.cdecl, importc: "CPLGetNumCPUs", raises: [].}
  proc CPLGetCurrentThreadCount*(): cint {.
    cdecl, importc: "CPLGetCurrentThreadCount", raises: []
  .}

  proc CPLCreateLock*(
    eType: CPLLockType
  ): ptr CPLLock {.cdecl, importc: "CPLCreateLock", raises: [].}

  proc CPLCreateOrAcquireLock*(
    a0: ptr ptr CPLLock, eType: CPLLockType
  ): cint {.cdecl, importc: "CPLCreateOrAcquireLock", raises: [].}

  proc CPLAcquireLock*(
    a0: ptr CPLLock
  ): cint {.cdecl, importc: "CPLAcquireLock", raises: [].}

  proc CPLReleaseLock*(a0: ptr CPLLock) {.cdecl, importc: "CPLReleaseLock", raises: [].}
  proc CPLDestroyLock*(a0: ptr CPLLock) {.cdecl, importc: "CPLDestroyLock", raises: [].}
  proc CPLLockSetDebugPerf*(
    a0: ptr CPLLock, bEnableIn: cint
  ) {.cdecl, importc: "CPLLockSetDebugPerf", raises: [].}

  proc CPLGetTLS*(nIndex: cint): pointer {.cdecl, importc: "CPLGetTLS", raises: [].}
  proc CPLGetTLSEx*(
    nIndex: cint, pbMemoryErrorOccurred: ptr cint
  ): pointer {.cdecl, importc: "CPLGetTLSEx", raises: [].}

  proc CPLSetTLS*(
    nIndex: cint, pData: pointer, bFreeOnExit: cint
  ) {.cdecl, importc: "CPLSetTLS", raises: [].}

  proc CPLSetTLSWithFreeFunc*(
    nIndex: cint, pData: pointer, pfnFree: CPLTLSFreeFunc
  ) {.cdecl, importc: "CPLSetTLSWithFreeFunc", raises: [].}

  proc CPLSetTLSWithFreeFuncEx*(
    nIndex: cint,
    pData: pointer,
    pfnFree: CPLTLSFreeFunc,
    pbMemoryErrorOccurred: ptr cint,
  ) {.cdecl, importc: "CPLSetTLSWithFreeFuncEx", raises: [].}

  proc CPLCleanupTLS*() {.cdecl, importc: "CPLCleanupTLS", raises: [].}
  proc CPLQuadTreeCreate*(
    pGlobalBounds: ptr CPLRectObj, pfnGetBounds: CPLQuadTreeGetBoundsFunc
  ): ptr CPLQuadTree {.cdecl, importc: "CPLQuadTreeCreate", raises: [].}

  proc CPLQuadTreeCreateEx*(
    pGlobalBounds: ptr CPLRectObj,
    pfnGetBounds: CPLQuadTreeGetBoundsExFunc,
    pUserData: pointer,
  ): ptr CPLQuadTree {.cdecl, importc: "CPLQuadTreeCreateEx", raises: [].}

  proc CPLQuadTreeDestroy*(
    hQuadtree: ptr CPLQuadTree
  ) {.cdecl, importc: "CPLQuadTreeDestroy", raises: [].}

  proc CPLQuadTreeSetBucketCapacity*(
    hQuadtree: ptr CPLQuadTree, nBucketCapacity: cint
  ) {.cdecl, importc: "CPLQuadTreeSetBucketCapacity", raises: [].}

  proc CPLQuadTreeForceUseOfSubNodes*(
    hQuadTree: ptr CPLQuadTree
  ) {.cdecl, importc: "CPLQuadTreeForceUseOfSubNodes", raises: [].}

  proc CPLQuadTreeGetAdvisedMaxDepth*(
    nExpectedFeatures: cint
  ): cint {.cdecl, importc: "CPLQuadTreeGetAdvisedMaxDepth", raises: [].}

  proc CPLQuadTreeSetMaxDepth*(
    hQuadtree: ptr CPLQuadTree, nMaxDepth: cint
  ) {.cdecl, importc: "CPLQuadTreeSetMaxDepth", raises: [].}

  proc CPLQuadTreeInsert*(
    hQuadtree: ptr CPLQuadTree, hFeature: pointer
  ) {.cdecl, importc: "CPLQuadTreeInsert", raises: [].}

  proc CPLQuadTreeInsertWithBounds*(
    hQuadtree: ptr CPLQuadTree, hFeature: pointer, psBounds: ptr CPLRectObj
  ) {.cdecl, importc: "CPLQuadTreeInsertWithBounds", raises: [].}

  proc CPLQuadTreeRemove*(
    hQuadtree: ptr CPLQuadTree, hFeature: pointer, psBounds: ptr CPLRectObj
  ) {.cdecl, importc: "CPLQuadTreeRemove", raises: [].}

  proc CPLQuadTreeSearch*(
    hQuadtree: ptr CPLQuadTree, pAoi: ptr CPLRectObj, pnFeatureCount: ptr cint
  ): ptr pointer {.cdecl, importc: "CPLQuadTreeSearch", raises: [].}

  proc CPLQuadTreeHasMatch*(
    hQuadtree: ptr CPLQuadTree, pAoi: ptr CPLRectObj
  ): bool {.cdecl, importc: "CPLQuadTreeHasMatch", raises: [].}

  proc CPLQuadTreeForeach*(
    hQuadtree: ptr CPLQuadTree, pfnForeach: CPLQuadTreeForeachFunc, pUserData: pointer
  ) {.cdecl, importc: "CPLQuadTreeForeach", raises: [].}

  proc CPLQuadTreeDump*(
    hQuadtree: ptr CPLQuadTree,
    pfnDumpFeatureFunc: CPLQuadTreeDumpFeatureFunc,
    pUserData: pointer,
  ) {.cdecl, importc: "CPLQuadTreeDump", raises: [].}

  proc CPLQuadTreeGetStats*(
    hQuadtree: ptr CPLQuadTree,
    pnFeatureCount: ptr cint,
    pnNodeCount: ptr cint,
    pnMaxDepth: ptr cint,
    pnMaxBucketCapacity: ptr cint,
  ) {.cdecl, importc: "CPLQuadTreeGetStats", raises: [].}

  proc CPLSpawn*(
    papszArgv: cstringArray, fin: ptr VSILFILE, fout: ptr VSILFILE, bDisplayErr: cint
  ): cint {.cdecl, importc: "CPLSpawn", raises: [].}

  proc CPLSpawnAsync*(
    pfnMain: proc(a0: CPL_FILE_HANDLE, a1: CPL_FILE_HANDLE): cint {.cdecl, raises: [].},
    papszArgv: cstringArray,
    bCreateInputPipe: cint,
    bCreateOutputPipe: cint,
    bCreateErrorPipe: cint,
    papszOptions: cstringArray,
  ): ptr CPLSpawnedProcess {.cdecl, importc: "CPLSpawnAsync", raises: [].}

  proc CPLSpawnAsyncGetChildProcessId*(
    p: ptr CPLSpawnedProcess
  ): CPL_PID {.cdecl, importc: "CPLSpawnAsyncGetChildProcessId", raises: [].}

  proc CPLSpawnAsyncFinish*(
    p: ptr CPLSpawnedProcess, bWait: cint, bKill: cint
  ): cint {.cdecl, importc: "CPLSpawnAsyncFinish", raises: [].}

  proc CPLSpawnAsyncGetInputFileHandle*(
    p: ptr CPLSpawnedProcess
  ): CPL_FILE_HANDLE {.cdecl, importc: "CPLSpawnAsyncGetInputFileHandle", raises: [].}

  proc CPLSpawnAsyncGetOutputFileHandle*(
    p: ptr CPLSpawnedProcess
  ): CPL_FILE_HANDLE {.cdecl, importc: "CPLSpawnAsyncGetOutputFileHandle", raises: [].}

  proc CPLSpawnAsyncGetErrorFileHandle*(
    p: ptr CPLSpawnedProcess
  ): CPL_FILE_HANDLE {.cdecl, importc: "CPLSpawnAsyncGetErrorFileHandle", raises: [].}

  proc CPLSpawnAsyncCloseInputFileHandle*(
    p: ptr CPLSpawnedProcess
  ) {.cdecl, importc: "CPLSpawnAsyncCloseInputFileHandle", raises: [].}

  proc CPLSpawnAsyncCloseOutputFileHandle*(
    p: ptr CPLSpawnedProcess
  ) {.cdecl, importc: "CPLSpawnAsyncCloseOutputFileHandle", raises: [].}

  proc CPLSpawnAsyncCloseErrorFileHandle*(
    p: ptr CPLSpawnedProcess
  ) {.cdecl, importc: "CPLSpawnAsyncCloseErrorFileHandle", raises: [].}

  proc CPLPipeRead*(
    fin: CPL_FILE_HANDLE, data: pointer, length: cint
  ): cint {.cdecl, importc: "CPLPipeRead", raises: [].}

  proc CPLPipeWrite*(
    fout: CPL_FILE_HANDLE, data: pointer, length: cint
  ): cint {.cdecl, importc: "CPLPipeWrite", raises: [].}

  proc CPLGetPageSize*(): csize_t {.cdecl, importc: "CPLGetPageSize", raises: [].}
  proc CPLVirtualMemNew*(
    nSize: csize_t,
    nCacheSize: csize_t,
    nPageSizeHint: csize_t,
    bSingleThreadUsage: cint,
    eAccessMode: CPLVirtualMemAccessMode,
    pfnCachePage: CPLVirtualMemCachePageCbk,
    pfnUnCachePage: CPLVirtualMemUnCachePageCbk,
    pfnFreeUserData: CPLVirtualMemFreeUserData,
    pCbkUserData: pointer,
  ): ptr CPLVirtualMem {.cdecl, importc: "CPLVirtualMemNew", raises: [].}

  proc CPLIsVirtualMemFileMapAvailable*(): cint {.
    cdecl, importc: "CPLIsVirtualMemFileMapAvailable", raises: []
  .}

  proc CPLVirtualMemFileMapNew*(
    fp: ptr VSILFILE,
    nOffset: vsi_l_offset,
    nLength: vsi_l_offset,
    eAccessMode: CPLVirtualMemAccessMode,
    pfnFreeUserData: CPLVirtualMemFreeUserData,
    pCbkUserData: pointer,
  ): ptr CPLVirtualMem {.cdecl, importc: "CPLVirtualMemFileMapNew", raises: [].}

  proc CPLVirtualMemDerivedNew*(
    pVMemBase: ptr CPLVirtualMem,
    nOffset: vsi_l_offset,
    nSize: vsi_l_offset,
    pfnFreeUserData: CPLVirtualMemFreeUserData,
    pCbkUserData: pointer,
  ): ptr CPLVirtualMem {.cdecl, importc: "CPLVirtualMemDerivedNew", raises: [].}

  proc CPLVirtualMemFree*(
    ctxt: ptr CPLVirtualMem
  ) {.cdecl, importc: "CPLVirtualMemFree", raises: [].}

  proc CPLVirtualMemGetAddr*(
    ctxt: ptr CPLVirtualMem
  ): pointer {.cdecl, importc: "CPLVirtualMemGetAddr", raises: [].}

  proc CPLVirtualMemGetSize*(
    ctxt: ptr CPLVirtualMem
  ): csize_t {.cdecl, importc: "CPLVirtualMemGetSize", raises: [].}

  proc CPLVirtualMemIsFileMapping*(
    ctxt: ptr CPLVirtualMem
  ): cint {.cdecl, importc: "CPLVirtualMemIsFileMapping", raises: [].}

  proc CPLVirtualMemGetAccessMode*(
    ctxt: ptr CPLVirtualMem
  ): CPLVirtualMemAccessMode {.
    cdecl, importc: "CPLVirtualMemGetAccessMode", raises: []
  .}

  proc CPLVirtualMemGetPageSize*(
    ctxt: ptr CPLVirtualMem
  ): csize_t {.cdecl, importc: "CPLVirtualMemGetPageSize", raises: [].}

  proc CPLVirtualMemIsAccessThreadSafe*(
    ctxt: ptr CPLVirtualMem
  ): cint {.cdecl, importc: "CPLVirtualMemIsAccessThreadSafe", raises: [].}

  proc CPLVirtualMemDeclareThread*(
    ctxt: ptr CPLVirtualMem
  ) {.cdecl, importc: "CPLVirtualMemDeclareThread", raises: [].}

  proc CPLVirtualMemUnDeclareThread*(
    ctxt: ptr CPLVirtualMem
  ) {.cdecl, importc: "CPLVirtualMemUnDeclareThread", raises: [].}

  proc CPLVirtualMemPin*(
    ctxt: ptr CPLVirtualMem, pAddr: pointer, nSize: csize_t, bWriteOp: cint
  ) {.cdecl, importc: "CPLVirtualMemPin", raises: [].}

  proc CPLVirtualMemManagerTerminate*() {.
    cdecl, importc: "CPLVirtualMemManagerTerminate", raises: []
  .}

  proc VSIError*(
    err_no: VSIErrorNum, fmt: cstring
  ) {.cdecl, importc: "VSIError", raises: [], varargs.}

  proc VSIErrorReset*() {.gdalCall, importc: "VSIErrorReset", raises: [].}
  proc VSIGetLastErrorNo*(): VSIErrorNum {.
    gdalCall, importc: "VSIGetLastErrorNo", raises: []
  .}

  proc VSIGetLastErrorMsg*(): cstring {.
    gdalCall, importc: "VSIGetLastErrorMsg", raises: []
  .}

  proc VSIErrorNumToString*(
    eErr: cint
  ): cstring {.cdecl, importc: "VSIErrorNumToString", raises: [].}

  proc VSIToCPLError*(
    eErrClass: CPLErr, eDefaultErrorNo: CPLErrorNum
  ): cint {.gdalCall, importc: "VSIToCPLError", raises: [].}

  proc VSIToCPLErrorWithMsg*(
    eErrClass: CPLErr, eDefaultErrorNo: CPLErrorNum, pszMsg: cstring
  ) {.cdecl, importc: "VSIToCPLErrorWithMsg", raises: [].}

  proc OGRMalloc*(a0: csize_t): pointer {.cdecl, importc: "OGRMalloc", raises: [].}
  proc OGRCalloc*(
    a0: csize_t, a1: csize_t
  ): pointer {.cdecl, importc: "OGRCalloc", raises: [].}

  proc OGRRealloc*(
    a0: pointer, a1: csize_t
  ): pointer {.cdecl, importc: "OGRRealloc", raises: [].}

  proc OGRStrdup*(a0: cstring): cstring {.cdecl, importc: "OGRStrdup", raises: [].}
  proc OGRFree*(a0: pointer) {.cdecl, importc: "OGRFree", raises: [].}
  proc OGRGeometryTypeToName*(
    eType: OGRwkbGeometryType
  ): cstring {.cdecl, importc: "OGRGeometryTypeToName", raises: [].}

  proc OGRMergeGeometryTypes*(
    eMain: OGRwkbGeometryType, eExtra: OGRwkbGeometryType
  ): OGRwkbGeometryType {.cdecl, importc: "OGRMergeGeometryTypes", raises: [].}

  proc OGRMergeGeometryTypesEx*(
    eMain: OGRwkbGeometryType, eExtra: OGRwkbGeometryType, bAllowPromotingToCurves: cint
  ): OGRwkbGeometryType {.cdecl, importc: "OGRMergeGeometryTypesEx", raises: [].}

  proc OGR_GT_Flatten*(
    eType: OGRwkbGeometryType
  ): OGRwkbGeometryType {.cdecl, importc: "OGR_GT_Flatten", raises: [].}

  proc OGR_GT_SetZ*(
    eType: OGRwkbGeometryType
  ): OGRwkbGeometryType {.cdecl, importc: "OGR_GT_SetZ", raises: [].}

  proc OGR_GT_SetM*(
    eType: OGRwkbGeometryType
  ): OGRwkbGeometryType {.cdecl, importc: "OGR_GT_SetM", raises: [].}

  proc OGR_GT_SetModifier*(
    eType: OGRwkbGeometryType, bSetZ: cint, bSetM: cint
  ): OGRwkbGeometryType {.cdecl, importc: "OGR_GT_SetModifier", raises: [].}

  proc OGR_GT_HasZ*(
    eType: OGRwkbGeometryType
  ): cint {.cdecl, importc: "OGR_GT_HasZ", raises: [].}

  proc OGR_GT_HasM*(
    eType: OGRwkbGeometryType
  ): cint {.cdecl, importc: "OGR_GT_HasM", raises: [].}

  proc OGR_GT_IsSubClassOf*(
    eType: OGRwkbGeometryType, eSuperType: OGRwkbGeometryType
  ): cint {.cdecl, importc: "OGR_GT_IsSubClassOf", raises: [].}

  proc OGR_GT_IsCurve*(
    a0: OGRwkbGeometryType
  ): cint {.cdecl, importc: "OGR_GT_IsCurve", raises: [].}

  proc OGR_GT_IsSurface*(
    a0: OGRwkbGeometryType
  ): cint {.cdecl, importc: "OGR_GT_IsSurface", raises: [].}

  proc OGR_GT_IsNonLinear*(
    a0: OGRwkbGeometryType
  ): cint {.cdecl, importc: "OGR_GT_IsNonLinear", raises: [].}

  proc OGR_GT_GetCollection*(
    eType: OGRwkbGeometryType
  ): OGRwkbGeometryType {.cdecl, importc: "OGR_GT_GetCollection", raises: [].}

  proc OGR_GT_GetSingle*(
    eType: OGRwkbGeometryType
  ): OGRwkbGeometryType {.cdecl, importc: "OGR_GT_GetSingle", raises: [].}

  proc OGR_GT_GetCurve*(
    eType: OGRwkbGeometryType
  ): OGRwkbGeometryType {.cdecl, importc: "OGR_GT_GetCurve", raises: [].}

  proc OGR_GT_GetLinear*(
    eType: OGRwkbGeometryType
  ): OGRwkbGeometryType {.cdecl, importc: "OGR_GT_GetLinear", raises: [].}

  proc OGR_GET_MS*(fSec: cfloat): cint {.cdecl, importc: "OGR_GET_MS", raises: [].}
  proc OGRParseDate*(
    pszInput: cstring, psOutput: ptr OGRField, nOptions: cint
  ): cint {.cdecl, importc: "OGRParseDate", raises: [].}

  proc GDALVersionInfo*(
    a0: cstring
  ): cstring {.gdalCall, importc: "GDALVersionInfo", raises: [].}

  proc GDALCheckVersionRaw*(
    nVersionMajor: cint, nVersionMinor: cint, pszCallingComponentName: cstring
  ): cint {.gdalCall, importc: "GDALCheckVersion", raises: [].}

  proc OGRGetGEOSVersion*(
    pnMajor: ptr cint, pnMinor: ptr cint, pnPatch: ptr cint
  ): bool {.cdecl, importc: "OGRGetGEOSVersion", raises: [].}

  proc OGRGeomCoordinatePrecisionCreate*(): OGRGeomCoordinatePrecisionH {.
    cdecl, importc: "OGRGeomCoordinatePrecisionCreate", raises: []
  .}

  proc OGRGeomCoordinatePrecisionDestroy*(
    a0: OGRGeomCoordinatePrecisionH
  ) {.cdecl, importc: "OGRGeomCoordinatePrecisionDestroy", raises: [].}

  proc OGRGeomCoordinatePrecisionGetXYResolution*(
    a0: OGRGeomCoordinatePrecisionH
  ): cdouble {.cdecl, importc: "OGRGeomCoordinatePrecisionGetXYResolution", raises: [].}

  proc OGRGeomCoordinatePrecisionGetZResolution*(
    a0: OGRGeomCoordinatePrecisionH
  ): cdouble {.cdecl, importc: "OGRGeomCoordinatePrecisionGetZResolution", raises: [].}

  proc OGRGeomCoordinatePrecisionGetMResolution*(
    a0: OGRGeomCoordinatePrecisionH
  ): cdouble {.cdecl, importc: "OGRGeomCoordinatePrecisionGetMResolution", raises: [].}

  proc OGRGeomCoordinatePrecisionGetFormats*(
    a0: OGRGeomCoordinatePrecisionH
  ): cstringArray {.cdecl, importc: "OGRGeomCoordinatePrecisionGetFormats", raises: [].}

  proc OGRGeomCoordinatePrecisionGetFormatSpecificOptions*(
    a0: OGRGeomCoordinatePrecisionH, pszFormatName: cstring
  ): CSLConstList {.
    cdecl, importc: "OGRGeomCoordinatePrecisionGetFormatSpecificOptions", raises: []
  .}

  proc OGRGeomCoordinatePrecisionSet*(
    a0: OGRGeomCoordinatePrecisionH,
    dfXYResolution: cdouble,
    dfZResolution: cdouble,
    dfMResolution: cdouble,
  ) {.cdecl, importc: "OGRGeomCoordinatePrecisionSet", raises: [].}

  proc OGRGeomCoordinatePrecisionSetFromMeter*(
    a0: OGRGeomCoordinatePrecisionH,
    hSRS: OGRSpatialReferenceH,
    dfXYMeterResolution: cdouble,
    dfZMeterResolution: cdouble,
    dfMResolution: cdouble,
  ) {.cdecl, importc: "OGRGeomCoordinatePrecisionSetFromMeter", raises: [].}

  proc OGRGeomCoordinatePrecisionSetFormatSpecificOptions*(
    a0: OGRGeomCoordinatePrecisionH, pszFormatName: cstring, papszOptions: CSLConstList
  ) {.cdecl, importc: "OGRGeomCoordinatePrecisionSetFormatSpecificOptions", raises: [].}

  proc OGR_G_CreateFromWkb*(
    a0: pointer, a1: OGRSpatialReferenceH, a2: ptr OGRGeometryH, a3: cint
  ): OGRErr {.cdecl, importc: "OGR_G_CreateFromWkb", raises: [].}

  proc OGR_G_CreateFromWkbEx*(
    a0: pointer, a1: OGRSpatialReferenceH, a2: ptr OGRGeometryH, a3: csize_t
  ): OGRErr {.cdecl, importc: "OGR_G_CreateFromWkbEx", raises: [].}

  proc OGR_G_CreateFromWkt*(
    a0: cstringArray, a1: OGRSpatialReferenceH, a2: ptr OGRGeometryH
  ): OGRErr {.cdecl, importc: "OGR_G_CreateFromWkt", raises: [].}

  proc OGR_G_CreateFromFgf*(
    a0: pointer, a1: OGRSpatialReferenceH, a2: ptr OGRGeometryH, a3: cint, a4: ptr cint
  ): OGRErr {.cdecl, importc: "OGR_G_CreateFromFgf", raises: [].}

  proc OGR_G_CreateFromEnvelope*(
    a0: cdouble, a1: cdouble, a2: cdouble, a3: cdouble, a4: OGRSpatialReferenceH
  ): OGRGeometryH {.cdecl, importc: "OGR_G_CreateFromEnvelope", raises: [].}

  proc OGR_G_DestroyGeometry*(
    a0: OGRGeometryH
  ) {.cdecl, importc: "OGR_G_DestroyGeometry", raises: [].}

  proc OGR_G_CreateGeometry*(
    a0: OGRwkbGeometryType
  ): OGRGeometryH {.cdecl, importc: "OGR_G_CreateGeometry", raises: [].}

  proc OGR_G_ApproximateArcAngles*(
    dfCenterX: cdouble,
    dfCenterY: cdouble,
    dfZ: cdouble,
    dfPrimaryRadius: cdouble,
    dfSecondaryAxis: cdouble,
    dfRotation: cdouble,
    dfStartAngle: cdouble,
    dfEndAngle: cdouble,
    dfMaxAngleStepSizeDegrees: cdouble,
  ): OGRGeometryH {.cdecl, importc: "OGR_G_ApproximateArcAngles", raises: [].}

  proc OGR_G_ForceToPolygon*(
    a0: OGRGeometryH
  ): OGRGeometryH {.cdecl, importc: "OGR_G_ForceToPolygon", raises: [].}

  proc OGR_G_ForceToLineString*(
    a0: OGRGeometryH
  ): OGRGeometryH {.cdecl, importc: "OGR_G_ForceToLineString", raises: [].}

  proc OGR_G_ForceToMultiPolygon*(
    a0: OGRGeometryH
  ): OGRGeometryH {.cdecl, importc: "OGR_G_ForceToMultiPolygon", raises: [].}

  proc OGR_G_ForceToMultiPoint*(
    a0: OGRGeometryH
  ): OGRGeometryH {.cdecl, importc: "OGR_G_ForceToMultiPoint", raises: [].}

  proc OGR_G_ForceToMultiLineString*(
    a0: OGRGeometryH
  ): OGRGeometryH {.cdecl, importc: "OGR_G_ForceToMultiLineString", raises: [].}

  proc OGR_G_ForceTo*(
    hGeom: OGRGeometryH, eTargetType: OGRwkbGeometryType, papszOptions: CSLConstList
  ): OGRGeometryH {.cdecl, importc: "OGR_G_ForceTo", raises: [].}

  proc OGR_G_RemoveLowerDimensionSubGeoms*(
    hGeom: OGRGeometryH
  ): OGRGeometryH {.cdecl, importc: "OGR_G_RemoveLowerDimensionSubGeoms", raises: [].}

  proc OGR_G_GetDimension*(
    a0: OGRGeometryH
  ): cint {.cdecl, importc: "OGR_G_GetDimension", raises: [].}

  proc OGR_G_GetCoordinateDimension*(
    a0: OGRGeometryH
  ): cint {.cdecl, importc: "OGR_G_GetCoordinateDimension", raises: [].}

  proc OGR_G_CoordinateDimension*(
    a0: OGRGeometryH
  ): cint {.cdecl, importc: "OGR_G_CoordinateDimension", raises: [].}

  proc OGR_G_SetCoordinateDimension*(
    a0: OGRGeometryH, a1: cint
  ) {.cdecl, importc: "OGR_G_SetCoordinateDimension", raises: [].}

  proc OGR_G_Is3D*(a0: OGRGeometryH): cint {.cdecl, importc: "OGR_G_Is3D", raises: [].}
  proc OGR_G_IsMeasured*(
    a0: OGRGeometryH
  ): cint {.cdecl, importc: "OGR_G_IsMeasured", raises: [].}

  proc OGR_G_Set3D*(
    a0: OGRGeometryH, a1: cint
  ) {.cdecl, importc: "OGR_G_Set3D", raises: [].}

  proc OGR_G_SetMeasured*(
    a0: OGRGeometryH, a1: cint
  ) {.cdecl, importc: "OGR_G_SetMeasured", raises: [].}

  proc OGR_G_Clone*(
    a0: OGRGeometryH
  ): OGRGeometryH {.cdecl, importc: "OGR_G_Clone", raises: [].}

  proc OGR_G_GetEnvelope*(
    a0: OGRGeometryH, a1: ptr OGREnvelope
  ) {.cdecl, importc: "OGR_G_GetEnvelope", raises: [].}

  proc OGR_G_GetEnvelope3D*(
    a0: OGRGeometryH, a1: ptr OGREnvelope3D
  ) {.cdecl, importc: "OGR_G_GetEnvelope3D", raises: [].}

  proc OGR_G_ImportFromWkb*(
    a0: OGRGeometryH, a1: pointer, a2: cint
  ): OGRErr {.cdecl, importc: "OGR_G_ImportFromWkb", raises: [].}

  proc OGR_G_ExportToWkb*(
    a0: OGRGeometryH, a1: OGRwkbByteOrder, a2: ptr uint8
  ): OGRErr {.cdecl, importc: "OGR_G_ExportToWkb", raises: [].}

  proc OGR_G_ExportToIsoWkb*(
    a0: OGRGeometryH, a1: OGRwkbByteOrder, a2: ptr uint8
  ): OGRErr {.cdecl, importc: "OGR_G_ExportToIsoWkb", raises: [].}

  proc OGRwkbExportOptionsCreate*(): ptr OGRwkbExportOptions {.
    cdecl, importc: "OGRwkbExportOptionsCreate", raises: []
  .}

  proc OGRwkbExportOptionsDestroy*(
    a0: ptr OGRwkbExportOptions
  ) {.cdecl, importc: "OGRwkbExportOptionsDestroy", raises: [].}

  proc OGRwkbExportOptionsSetByteOrder*(
    a0: ptr OGRwkbExportOptions, a1: OGRwkbByteOrder
  ) {.cdecl, importc: "OGRwkbExportOptionsSetByteOrder", raises: [].}

  proc OGRwkbExportOptionsSetVariant*(
    a0: ptr OGRwkbExportOptions, a1: OGRwkbVariant
  ) {.cdecl, importc: "OGRwkbExportOptionsSetVariant", raises: [].}

  proc OGRwkbExportOptionsSetPrecision*(
    a0: ptr OGRwkbExportOptions, a1: OGRGeomCoordinatePrecisionH
  ) {.cdecl, importc: "OGRwkbExportOptionsSetPrecision", raises: [].}

  proc OGR_G_ExportToWkbEx*(
    a0: OGRGeometryH, a1: ptr uint8, a2: ptr OGRwkbExportOptions
  ): OGRErr {.cdecl, importc: "OGR_G_ExportToWkbEx", raises: [].}

  proc OGR_G_WkbSize*(
    hGeom: OGRGeometryH
  ): cint {.cdecl, importc: "OGR_G_WkbSize", raises: [].}

  proc OGR_G_WkbSizeEx*(
    hGeom: OGRGeometryH
  ): csize_t {.cdecl, importc: "OGR_G_WkbSizeEx", raises: [].}

  proc OGR_G_ImportFromWkt*(
    a0: OGRGeometryH, a1: cstringArray
  ): OGRErr {.cdecl, importc: "OGR_G_ImportFromWkt", raises: [].}

  proc OGR_G_ExportToWkt*(
    a0: OGRGeometryH, a1: cstringArray
  ): OGRErr {.cdecl, importc: "OGR_G_ExportToWkt", raises: [].}

  proc OGR_G_ExportToIsoWkt*(
    a0: OGRGeometryH, a1: cstringArray
  ): OGRErr {.cdecl, importc: "OGR_G_ExportToIsoWkt", raises: [].}

  proc OGR_G_GetGeometryType*(
    a0: OGRGeometryH
  ): OGRwkbGeometryType {.cdecl, importc: "OGR_G_GetGeometryType", raises: [].}

  proc OGR_G_GetGeometryName*(
    a0: OGRGeometryH
  ): cstring {.cdecl, importc: "OGR_G_GetGeometryName", raises: [].}

  proc OGR_G_DumpReadable*(
    a0: OGRGeometryH, a1: ptr GdalFile, a2: cstring
  ) {.cdecl, importc: "OGR_G_DumpReadable", raises: [].}

  proc OGR_G_FlattenTo2D*(
    a0: OGRGeometryH
  ) {.cdecl, importc: "OGR_G_FlattenTo2D", raises: [].}

  proc OGR_G_CloseRings*(
    a0: OGRGeometryH
  ) {.cdecl, importc: "OGR_G_CloseRings", raises: [].}

  proc OGR_G_CreateFromGML*(
    a0: cstring
  ): OGRGeometryH {.cdecl, importc: "OGR_G_CreateFromGML", raises: [].}

  proc OGR_G_ExportToGML*(
    a0: OGRGeometryH
  ): cstring {.cdecl, importc: "OGR_G_ExportToGML", raises: [].}

  proc OGR_G_ExportToGMLEx*(
    a0: OGRGeometryH, papszOptions: CSLConstList
  ): cstring {.cdecl, importc: "OGR_G_ExportToGMLEx", raises: [].}

  proc OGR_G_CreateFromGMLTree*(
    a0: ptr CPLXMLNode
  ): OGRGeometryH {.cdecl, importc: "OGR_G_CreateFromGMLTree", raises: [].}

  proc OGR_G_ExportToGMLTree*(
    a0: OGRGeometryH
  ): ptr CPLXMLNode {.cdecl, importc: "OGR_G_ExportToGMLTree", raises: [].}

  proc OGR_G_ExportEnvelopeToGMLTree*(
    a0: OGRGeometryH
  ): ptr CPLXMLNode {.cdecl, importc: "OGR_G_ExportEnvelopeToGMLTree", raises: [].}

  proc OGR_G_ExportToKML*(
    a0: OGRGeometryH, pszAltitudeMode: cstring
  ): cstring {.cdecl, importc: "OGR_G_ExportToKML", raises: [].}

  proc OGR_G_ExportToJson*(
    a0: OGRGeometryH
  ): cstring {.cdecl, importc: "OGR_G_ExportToJson", raises: [].}

  proc OGR_G_ExportToJsonEx*(
    a0: OGRGeometryH, papszOptions: CSLConstList
  ): cstring {.cdecl, importc: "OGR_G_ExportToJsonEx", raises: [].}

  proc OGR_G_CreateGeometryFromJson*(
    a0: cstring
  ): OGRGeometryH {.cdecl, importc: "OGR_G_CreateGeometryFromJson", raises: [].}

  proc OGR_G_CreateGeometryFromEsriJson*(
    a0: cstring
  ): OGRGeometryH {.cdecl, importc: "OGR_G_CreateGeometryFromEsriJson", raises: [].}

  proc OGR_G_AssignSpatialReference*(
    a0: OGRGeometryH, a1: OGRSpatialReferenceH
  ) {.cdecl, importc: "OGR_G_AssignSpatialReference", raises: [].}

  proc OGR_G_GetSpatialReference*(
    a0: OGRGeometryH
  ): OGRSpatialReferenceH {.cdecl, importc: "OGR_G_GetSpatialReference", raises: [].}

  proc OGR_G_Transform*(
    a0: OGRGeometryH, a1: OGRCoordinateTransformationH
  ): OGRErr {.cdecl, importc: "OGR_G_Transform", raises: [].}

  proc OGR_G_TransformTo*(
    a0: OGRGeometryH, a1: OGRSpatialReferenceH
  ): OGRErr {.cdecl, importc: "OGR_G_TransformTo", raises: [].}

  proc OGR_GeomTransformer_Create*(
    a0: OGRCoordinateTransformationH, papszOptions: CSLConstList
  ): OGRGeomTransformerH {.cdecl, importc: "OGR_GeomTransformer_Create", raises: [].}

  proc OGR_GeomTransformer_Transform*(
    hTransformer: OGRGeomTransformerH, hGeom: OGRGeometryH
  ): OGRGeometryH {.cdecl, importc: "OGR_GeomTransformer_Transform", raises: [].}

  proc OGR_GeomTransformer_Destroy*(
    hTransformer: OGRGeomTransformerH
  ) {.cdecl, importc: "OGR_GeomTransformer_Destroy", raises: [].}

  proc OGR_G_Simplify*(
    hThis: OGRGeometryH, tolerance: cdouble
  ): OGRGeometryH {.cdecl, importc: "OGR_G_Simplify", raises: [].}

  proc OGR_G_SimplifyPreserveTopology*(
    hThis: OGRGeometryH, tolerance: cdouble
  ): OGRGeometryH {.cdecl, importc: "OGR_G_SimplifyPreserveTopology", raises: [].}

  proc OGR_G_DelaunayTriangulation*(
    hThis: OGRGeometryH, dfTolerance: cdouble, bOnlyEdges: cint
  ): OGRGeometryH {.cdecl, importc: "OGR_G_DelaunayTriangulation", raises: [].}

  proc OGR_G_ConstrainedDelaunayTriangulation*(
    hThis: OGRGeometryH
  ): OGRGeometryH {.
    cdecl, importc: "OGR_G_ConstrainedDelaunayTriangulation", raises: []
  .}

  proc OGR_G_Segmentize*(
    hGeom: OGRGeometryH, dfMaxLength: cdouble
  ) {.cdecl, importc: "OGR_G_Segmentize", raises: [].}

  proc OGR_G_Intersects*(
    a0: OGRGeometryH, a1: OGRGeometryH
  ): cint {.cdecl, importc: "OGR_G_Intersects", raises: [].}

  proc OGR_G_Equals*(
    a0: OGRGeometryH, a1: OGRGeometryH
  ): cint {.cdecl, importc: "OGR_G_Equals", raises: [].}

  proc OGR_G_Disjoint*(
    a0: OGRGeometryH, a1: OGRGeometryH
  ): cint {.cdecl, importc: "OGR_G_Disjoint", raises: [].}

  proc OGR_G_Touches*(
    a0: OGRGeometryH, a1: OGRGeometryH
  ): cint {.cdecl, importc: "OGR_G_Touches", raises: [].}

  proc OGR_G_Crosses*(
    a0: OGRGeometryH, a1: OGRGeometryH
  ): cint {.cdecl, importc: "OGR_G_Crosses", raises: [].}

  proc OGR_G_Within*(
    a0: OGRGeometryH, a1: OGRGeometryH
  ): cint {.cdecl, importc: "OGR_G_Within", raises: [].}

  proc OGR_G_Contains*(
    a0: OGRGeometryH, a1: OGRGeometryH
  ): cint {.cdecl, importc: "OGR_G_Contains", raises: [].}

  proc OGR_G_Overlaps*(
    a0: OGRGeometryH, a1: OGRGeometryH
  ): cint {.cdecl, importc: "OGR_G_Overlaps", raises: [].}

  proc OGR_G_Boundary*(
    a0: OGRGeometryH
  ): OGRGeometryH {.cdecl, importc: "OGR_G_Boundary", raises: [].}

  proc OGR_G_ConvexHull*(
    a0: OGRGeometryH
  ): OGRGeometryH {.cdecl, importc: "OGR_G_ConvexHull", raises: [].}

  proc OGR_G_ConcaveHull*(
    a0: OGRGeometryH, dfRatio: cdouble, bAllowHoles: bool
  ): OGRGeometryH {.cdecl, importc: "OGR_G_ConcaveHull", raises: [].}

  proc OGR_G_ConcaveHullOfPolygons*(
    a0: OGRGeometryH, dfLengthRatio: cdouble, bIsTight: bool, bAllowHoles: bool
  ): OGRGeometryH {.cdecl, importc: "OGR_G_ConcaveHullOfPolygons", raises: [].}

  proc OGR_G_Buffer*(
    a0: OGRGeometryH, dfDist: cdouble, nQuadSegs: cint
  ): OGRGeometryH {.cdecl, importc: "OGR_G_Buffer", raises: [].}

  proc OGR_G_BufferEx*(
    a0: OGRGeometryH, dfDist: cdouble, papszOptions: CSLConstList
  ): OGRGeometryH {.cdecl, importc: "OGR_G_BufferEx", raises: [].}

  proc OGR_G_Intersection*(
    a0: OGRGeometryH, a1: OGRGeometryH
  ): OGRGeometryH {.cdecl, importc: "OGR_G_Intersection", raises: [].}

  proc OGR_G_Union*(
    a0: OGRGeometryH, a1: OGRGeometryH
  ): OGRGeometryH {.cdecl, importc: "OGR_G_Union", raises: [].}

  proc OGR_G_UnionCascaded*(
    a0: OGRGeometryH
  ): OGRGeometryH {.cdecl, importc: "OGR_G_UnionCascaded", raises: [].}

  proc OGR_G_UnaryUnion*(
    a0: OGRGeometryH
  ): OGRGeometryH {.cdecl, importc: "OGR_G_UnaryUnion", raises: [].}

  proc OGR_G_PointOnSurface*(
    a0: OGRGeometryH
  ): OGRGeometryH {.cdecl, importc: "OGR_G_PointOnSurface", raises: [].}

  proc OGR_G_Difference*(
    a0: OGRGeometryH, a1: OGRGeometryH
  ): OGRGeometryH {.cdecl, importc: "OGR_G_Difference", raises: [].}

  proc OGR_G_SymDifference*(
    a0: OGRGeometryH, a1: OGRGeometryH
  ): OGRGeometryH {.cdecl, importc: "OGR_G_SymDifference", raises: [].}

  proc OGR_G_Distance*(
    a0: OGRGeometryH, a1: OGRGeometryH
  ): cdouble {.cdecl, importc: "OGR_G_Distance", raises: [].}

  proc OGR_G_Distance3D*(
    a0: OGRGeometryH, a1: OGRGeometryH
  ): cdouble {.cdecl, importc: "OGR_G_Distance3D", raises: [].}

  proc OGR_G_Length*(
    a0: OGRGeometryH
  ): cdouble {.cdecl, importc: "OGR_G_Length", raises: [].}

  proc OGR_G_GeodesicLength*(
    a0: OGRGeometryH
  ): cdouble {.cdecl, importc: "OGR_G_GeodesicLength", raises: [].}

  proc OGR_G_Area*(
    a0: OGRGeometryH
  ): cdouble {.cdecl, importc: "OGR_G_Area", raises: [].}

  proc OGR_G_GeodesicArea*(
    a0: OGRGeometryH
  ): cdouble {.cdecl, importc: "OGR_G_GeodesicArea", raises: [].}

  proc OGR_G_IsClockwise*(
    hGeom: OGRGeometryH
  ): bool {.cdecl, importc: "OGR_G_IsClockwise", raises: [].}

  proc OGR_G_Centroid*(
    a0: OGRGeometryH, a1: OGRGeometryH
  ): cint {.cdecl, importc: "OGR_G_Centroid", raises: [].}

  proc OGR_G_Value*(
    a0: OGRGeometryH, dfDistance: cdouble
  ): OGRGeometryH {.cdecl, importc: "OGR_G_Value", raises: [].}

  proc OGR_G_Empty*(a0: OGRGeometryH) {.cdecl, importc: "OGR_G_Empty", raises: [].}
  proc OGR_G_IsEmpty*(
    a0: OGRGeometryH
  ): cint {.cdecl, importc: "OGR_G_IsEmpty", raises: [].}

  proc OGR_G_IsValid*(
    a0: OGRGeometryH
  ): cint {.cdecl, importc: "OGR_G_IsValid", raises: [].}

  proc OGR_G_GetInvalidityReason*(
    a0: OGRGeometryH
  ): cstring {.cdecl, importc: "OGR_G_GetInvalidityReason", raises: [].}

  proc OGR_G_MakeValid*(
    a0: OGRGeometryH
  ): OGRGeometryH {.cdecl, importc: "OGR_G_MakeValid", raises: [].}

  proc OGR_G_MakeValidEx*(
    a0: OGRGeometryH, a1: CSLConstList
  ): OGRGeometryH {.cdecl, importc: "OGR_G_MakeValidEx", raises: [].}

  proc OGR_G_Normalize*(
    a0: OGRGeometryH
  ): OGRGeometryH {.cdecl, importc: "OGR_G_Normalize", raises: [].}

  proc OGR_G_IsSimple*(
    a0: OGRGeometryH
  ): cint {.cdecl, importc: "OGR_G_IsSimple", raises: [].}

  proc OGR_G_IsRing*(
    a0: OGRGeometryH
  ): cint {.cdecl, importc: "OGR_G_IsRing", raises: [].}

  proc OGR_G_SetPrecision*(
    a0: OGRGeometryH, dfGridSize: cdouble, nFlags: cint
  ): OGRGeometryH {.cdecl, importc: "OGR_G_SetPrecision", raises: [].}

  proc OGR_G_Polygonize*(
    a0: OGRGeometryH
  ): OGRGeometryH {.cdecl, importc: "OGR_G_Polygonize", raises: [].}

  proc OGR_G_BuildArea*(
    a0: OGRGeometryH
  ): OGRGeometryH {.cdecl, importc: "OGR_G_BuildArea", raises: [].}

  proc OGR_G_Intersect*(
    a0: OGRGeometryH, a1: OGRGeometryH
  ): cint {.cdecl, importc: "OGR_G_Intersect", raises: [].}

  proc OGR_G_Equal*(
    a0: OGRGeometryH, a1: OGRGeometryH
  ): cint {.cdecl, importc: "OGR_G_Equal", raises: [].}

  proc OGR_G_SymmetricDifference*(
    a0: OGRGeometryH, a1: OGRGeometryH
  ): OGRGeometryH {.cdecl, importc: "OGR_G_SymmetricDifference", raises: [].}

  proc OGR_G_GetArea*(
    a0: OGRGeometryH
  ): cdouble {.cdecl, importc: "OGR_G_GetArea", raises: [].}

  proc OGR_G_GetBoundary*(
    a0: OGRGeometryH
  ): OGRGeometryH {.cdecl, importc: "OGR_G_GetBoundary", raises: [].}

  proc OGR_G_GetPointCount*(
    a0: OGRGeometryH
  ): cint {.cdecl, importc: "OGR_G_GetPointCount", raises: [].}

  proc OGR_G_GetPoints*(
    hGeom: OGRGeometryH,
    pabyX: pointer,
    nXStride: cint,
    pabyY: pointer,
    nYStride: cint,
    pabyZ: pointer,
    nZStride: cint,
  ): cint {.cdecl, importc: "OGR_G_GetPoints", raises: [].}

  proc OGR_G_GetPointsZM*(
    hGeom: OGRGeometryH,
    pabyX: pointer,
    nXStride: cint,
    pabyY: pointer,
    nYStride: cint,
    pabyZ: pointer,
    nZStride: cint,
    pabyM: pointer,
    nMStride: cint,
  ): cint {.cdecl, importc: "OGR_G_GetPointsZM", raises: [].}

  proc OGR_G_GetX*(
    a0: OGRGeometryH, a1: cint
  ): cdouble {.cdecl, importc: "OGR_G_GetX", raises: [].}

  proc OGR_G_GetY*(
    a0: OGRGeometryH, a1: cint
  ): cdouble {.cdecl, importc: "OGR_G_GetY", raises: [].}

  proc OGR_G_GetZ*(
    a0: OGRGeometryH, a1: cint
  ): cdouble {.cdecl, importc: "OGR_G_GetZ", raises: [].}

  proc OGR_G_GetM*(
    a0: OGRGeometryH, a1: cint
  ): cdouble {.cdecl, importc: "OGR_G_GetM", raises: [].}

  proc OGR_G_GetPoint*(
    a0: OGRGeometryH, iPoint: cint, a2: ptr cdouble, a3: ptr cdouble, a4: ptr cdouble
  ) {.cdecl, importc: "OGR_G_GetPoint", raises: [].}

  proc OGR_G_GetPointZM*(
    a0: OGRGeometryH,
    iPoint: cint,
    a2: ptr cdouble,
    a3: ptr cdouble,
    a4: ptr cdouble,
    a5: ptr cdouble,
  ) {.cdecl, importc: "OGR_G_GetPointZM", raises: [].}

  proc OGR_G_SetPointCount*(
    hGeom: OGRGeometryH, nNewPointCount: cint
  ): OGRErr {.cdecl, importc: "OGR_G_SetPointCount", raises: [].}

  proc OGR_G_SetPoint*(
    a0: OGRGeometryH, iPoint: cint, a2: cdouble, a3: cdouble, a4: cdouble
  ): OGRErr {.cdecl, importc: "OGR_G_SetPoint", raises: [].}

  proc OGR_G_SetPoint_2D*(
    a0: OGRGeometryH, iPoint: cint, a2: cdouble, a3: cdouble
  ): OGRErr {.cdecl, importc: "OGR_G_SetPoint_2D", raises: [].}

  proc OGR_G_SetPointM*(
    a0: OGRGeometryH, iPoint: cint, a2: cdouble, a3: cdouble, a4: cdouble
  ): OGRErr {.cdecl, importc: "OGR_G_SetPointM", raises: [].}

  proc OGR_G_SetPointZM*(
    a0: OGRGeometryH, iPoint: cint, a2: cdouble, a3: cdouble, a4: cdouble, a5: cdouble
  ): OGRErr {.cdecl, importc: "OGR_G_SetPointZM", raises: [].}

  proc OGR_G_AddPoint*(
    a0: OGRGeometryH, a1: cdouble, a2: cdouble, a3: cdouble
  ): OGRErr {.cdecl, importc: "OGR_G_AddPoint", raises: [].}

  proc OGR_G_AddPoint_2D*(
    a0: OGRGeometryH, a1: cdouble, a2: cdouble
  ): OGRErr {.cdecl, importc: "OGR_G_AddPoint_2D", raises: [].}

  proc OGR_G_AddPointM*(
    a0: OGRGeometryH, a1: cdouble, a2: cdouble, a3: cdouble
  ): OGRErr {.cdecl, importc: "OGR_G_AddPointM", raises: [].}

  proc OGR_G_AddPointZM*(
    a0: OGRGeometryH, a1: cdouble, a2: cdouble, a3: cdouble, a4: cdouble
  ): OGRErr {.cdecl, importc: "OGR_G_AddPointZM", raises: [].}

  proc OGR_G_SetPoints*(
    hGeom: OGRGeometryH,
    nPointsIn: cint,
    pabyX: pointer,
    nXStride: cint,
    pabyY: pointer,
    nYStride: cint,
    pabyZ: pointer,
    nZStride: cint,
  ): OGRErr {.cdecl, importc: "OGR_G_SetPoints", raises: [].}

  proc OGR_G_SetPointsZM*(
    hGeom: OGRGeometryH,
    nPointsIn: cint,
    pabyX: pointer,
    nXStride: cint,
    pabyY: pointer,
    nYStride: cint,
    pabyZ: pointer,
    nZStride: cint,
    pabyM: pointer,
    nMStride: cint,
  ): OGRErr {.cdecl, importc: "OGR_G_SetPointsZM", raises: [].}

  proc OGR_G_SwapXY*(hGeom: OGRGeometryH) {.cdecl, importc: "OGR_G_SwapXY", raises: [].}
  proc OGR_G_GetGeometryCount*(
    a0: OGRGeometryH
  ): cint {.cdecl, importc: "OGR_G_GetGeometryCount", raises: [].}

  proc OGR_G_GetGeometryRef*(
    a0: OGRGeometryH, a1: cint
  ): OGRGeometryH {.cdecl, importc: "OGR_G_GetGeometryRef", raises: [].}

  proc OGR_G_AddGeometry*(
    a0: OGRGeometryH, a1: OGRGeometryH
  ): OGRErr {.cdecl, importc: "OGR_G_AddGeometry", raises: [].}

  proc OGR_G_AddGeometryDirectly*(
    a0: OGRGeometryH, a1: OGRGeometryH
  ): OGRErr {.cdecl, importc: "OGR_G_AddGeometryDirectly", raises: [].}

  proc OGR_G_RemoveGeometry*(
    a0: OGRGeometryH, a1: cint, a2: cint
  ): OGRErr {.cdecl, importc: "OGR_G_RemoveGeometry", raises: [].}

  proc OGR_G_HasCurveGeometry*(
    a0: OGRGeometryH, bLookForNonLinear: cint
  ): cint {.cdecl, importc: "OGR_G_HasCurveGeometry", raises: [].}

  proc OGR_G_GetLinearGeometry*(
    hGeom: OGRGeometryH, dfMaxAngleStepSizeDegrees: cdouble, papszOptions: CSLConstList
  ): OGRGeometryH {.cdecl, importc: "OGR_G_GetLinearGeometry", raises: [].}

  proc OGR_G_GetCurveGeometry*(
    hGeom: OGRGeometryH, papszOptions: CSLConstList
  ): OGRGeometryH {.cdecl, importc: "OGR_G_GetCurveGeometry", raises: [].}

  proc OGRBuildPolygonFromEdges*(
    hLinesAsCollection: OGRGeometryH,
    bBestEffort: cint,
    bAutoClose: cint,
    dfTolerance: cdouble,
    peErr: ptr OGRErr,
  ): OGRGeometryH {.cdecl, importc: "OGRBuildPolygonFromEdges", raises: [].}

  proc OGRSetGenerate_DB2_V72_BYTE_ORDER*(
    bGenerate_DB2_V72_BYTE_ORDER: cint
  ): OGRErr {.cdecl, importc: "OGRSetGenerate_DB2_V72_BYTE_ORDER", raises: [].}

  proc OGRGetGenerate_DB2_V72_BYTE_ORDER*(): cint {.
    cdecl, importc: "OGRGetGenerate_DB2_V72_BYTE_ORDER", raises: []
  .}

  proc OGRSetNonLinearGeometriesEnabledFlag*(
    bFlag: cint
  ) {.cdecl, importc: "OGRSetNonLinearGeometriesEnabledFlag", raises: [].}

  proc OGRGetNonLinearGeometriesEnabledFlag*(): cint {.
    cdecl, importc: "OGRGetNonLinearGeometriesEnabledFlag", raises: []
  .}

  proc OGRHasPreparedGeometrySupport*(): cint {.
    cdecl, importc: "OGRHasPreparedGeometrySupport", raises: []
  .}

  proc OGRCreatePreparedGeometry*(
    hGeom: OGRGeometryH
  ): OGRPreparedGeometryH {.cdecl, importc: "OGRCreatePreparedGeometry", raises: [].}

  proc OGRDestroyPreparedGeometry*(
    hPreparedGeom: OGRPreparedGeometryH
  ) {.cdecl, importc: "OGRDestroyPreparedGeometry", raises: [].}

  proc OGRPreparedGeometryIntersects*(
    hPreparedGeom: OGRPreparedGeometryH, hOtherGeom: OGRGeometryH
  ): cint {.cdecl, importc: "OGRPreparedGeometryIntersects", raises: [].}

  proc OGRPreparedGeometryContains*(
    hPreparedGeom: OGRPreparedGeometryH, hOtherGeom: OGRGeometryH
  ): cint {.cdecl, importc: "OGRPreparedGeometryContains", raises: [].}

  proc OGR_Fld_Create*(
    a0: cstring, a1: OGRFieldType
  ): OGRFieldDefnH {.cdecl, importc: "OGR_Fld_Create", raises: [].}

  proc OGR_Fld_Destroy*(
    a0: OGRFieldDefnH
  ) {.cdecl, importc: "OGR_Fld_Destroy", raises: [].}

  proc OGR_Fld_SetName*(
    a0: OGRFieldDefnH, a1: cstring
  ) {.cdecl, importc: "OGR_Fld_SetName", raises: [].}

  proc OGR_Fld_GetNameRef*(
    a0: OGRFieldDefnH
  ): cstring {.cdecl, importc: "OGR_Fld_GetNameRef", raises: [].}

  proc OGR_Fld_SetAlternativeName*(
    a0: OGRFieldDefnH, a1: cstring
  ) {.cdecl, importc: "OGR_Fld_SetAlternativeName", raises: [].}

  proc OGR_Fld_GetAlternativeNameRef*(
    a0: OGRFieldDefnH
  ): cstring {.cdecl, importc: "OGR_Fld_GetAlternativeNameRef", raises: [].}

  proc OGR_Fld_GetType*(
    a0: OGRFieldDefnH
  ): OGRFieldType {.cdecl, importc: "OGR_Fld_GetType", raises: [].}

  proc OGR_Fld_SetType*(
    a0: OGRFieldDefnH, a1: OGRFieldType
  ) {.cdecl, importc: "OGR_Fld_SetType", raises: [].}

  proc OGR_Fld_GetSubType*(
    a0: OGRFieldDefnH
  ): OGRFieldSubType {.cdecl, importc: "OGR_Fld_GetSubType", raises: [].}

  proc OGR_Fld_SetSubType*(
    a0: OGRFieldDefnH, a1: OGRFieldSubType
  ) {.cdecl, importc: "OGR_Fld_SetSubType", raises: [].}

  proc OGR_Fld_GetJustify*(
    a0: OGRFieldDefnH
  ): OGRJustification {.cdecl, importc: "OGR_Fld_GetJustify", raises: [].}

  proc OGR_Fld_SetJustify*(
    a0: OGRFieldDefnH, a1: OGRJustification
  ) {.cdecl, importc: "OGR_Fld_SetJustify", raises: [].}

  proc OGR_Fld_GetWidth*(
    a0: OGRFieldDefnH
  ): cint {.cdecl, importc: "OGR_Fld_GetWidth", raises: [].}

  proc OGR_Fld_SetWidth*(
    a0: OGRFieldDefnH, a1: cint
  ) {.cdecl, importc: "OGR_Fld_SetWidth", raises: [].}

  proc OGR_Fld_GetPrecision*(
    a0: OGRFieldDefnH
  ): cint {.cdecl, importc: "OGR_Fld_GetPrecision", raises: [].}

  proc OGR_Fld_SetPrecision*(
    a0: OGRFieldDefnH, a1: cint
  ) {.cdecl, importc: "OGR_Fld_SetPrecision", raises: [].}

  proc OGR_Fld_GetTZFlag*(
    a0: OGRFieldDefnH
  ): cint {.cdecl, importc: "OGR_Fld_GetTZFlag", raises: [].}

  proc OGR_Fld_SetTZFlag*(
    a0: OGRFieldDefnH, a1: cint
  ) {.cdecl, importc: "OGR_Fld_SetTZFlag", raises: [].}

  proc OGR_Fld_Set*(
    a0: OGRFieldDefnH,
    a1: cstring,
    a2: OGRFieldType,
    a3: cint,
    a4: cint,
    a5: OGRJustification,
  ) {.cdecl, importc: "OGR_Fld_Set", raises: [].}

  proc OGR_Fld_IsIgnored*(
    hDefn: OGRFieldDefnH
  ): cint {.cdecl, importc: "OGR_Fld_IsIgnored", raises: [].}

  proc OGR_Fld_SetIgnored*(
    hDefn: OGRFieldDefnH, a1: cint
  ) {.cdecl, importc: "OGR_Fld_SetIgnored", raises: [].}

  proc OGR_Fld_IsNullable*(
    hDefn: OGRFieldDefnH
  ): cint {.cdecl, importc: "OGR_Fld_IsNullable", raises: [].}

  proc OGR_Fld_SetNullable*(
    hDefn: OGRFieldDefnH, a1: cint
  ) {.cdecl, importc: "OGR_Fld_SetNullable", raises: [].}

  proc OGR_Fld_SetGenerated*(
    hDefn: OGRFieldDefnH, a1: cint
  ) {.cdecl, importc: "OGR_Fld_SetGenerated", raises: [].}

  proc OGR_Fld_IsGenerated*(
    hDefn: OGRFieldDefnH
  ): cint {.cdecl, importc: "OGR_Fld_IsGenerated", raises: [].}

  proc OGR_Fld_IsUnique*(
    hDefn: OGRFieldDefnH
  ): cint {.cdecl, importc: "OGR_Fld_IsUnique", raises: [].}

  proc OGR_Fld_SetUnique*(
    hDefn: OGRFieldDefnH, a1: cint
  ) {.cdecl, importc: "OGR_Fld_SetUnique", raises: [].}

  proc OGR_Fld_GetDefault*(
    hDefn: OGRFieldDefnH
  ): cstring {.cdecl, importc: "OGR_Fld_GetDefault", raises: [].}

  proc OGR_Fld_SetDefault*(
    hDefn: OGRFieldDefnH, a1: cstring
  ) {.cdecl, importc: "OGR_Fld_SetDefault", raises: [].}

  proc OGR_Fld_IsDefaultDriverSpecific*(
    hDefn: OGRFieldDefnH
  ): cint {.cdecl, importc: "OGR_Fld_IsDefaultDriverSpecific", raises: [].}

  proc OGR_Fld_GetDomainName*(
    hDefn: OGRFieldDefnH
  ): cstring {.cdecl, importc: "OGR_Fld_GetDomainName", raises: [].}

  proc OGR_Fld_SetDomainName*(
    hDefn: OGRFieldDefnH, a1: cstring
  ) {.cdecl, importc: "OGR_Fld_SetDomainName", raises: [].}

  proc OGR_Fld_GetComment*(
    hDefn: OGRFieldDefnH
  ): cstring {.cdecl, importc: "OGR_Fld_GetComment", raises: [].}

  proc OGR_Fld_SetComment*(
    hDefn: OGRFieldDefnH, a1: cstring
  ) {.cdecl, importc: "OGR_Fld_SetComment", raises: [].}

  proc OGR_GetFieldTypeName*(
    a0: OGRFieldType
  ): cstring {.cdecl, importc: "OGR_GetFieldTypeName", raises: [].}

  proc OGR_GetFieldTypeByName*(
    a0: cstring
  ): OGRFieldType {.cdecl, importc: "OGR_GetFieldTypeByName", raises: [].}

  proc OGR_GetFieldSubTypeName*(
    a0: OGRFieldSubType
  ): cstring {.cdecl, importc: "OGR_GetFieldSubTypeName", raises: [].}

  proc OGR_GetFieldSubTypeByName*(
    a0: cstring
  ): OGRFieldSubType {.cdecl, importc: "OGR_GetFieldSubTypeByName", raises: [].}

  proc OGR_AreTypeSubTypeCompatible*(
    eType: OGRFieldType, eSubType: OGRFieldSubType
  ): cint {.cdecl, importc: "OGR_AreTypeSubTypeCompatible", raises: [].}

  proc OGR_GFld_Create*(
    a0: cstring, a1: OGRwkbGeometryType
  ): OGRGeomFieldDefnH {.cdecl, importc: "OGR_GFld_Create", raises: [].}

  proc OGR_GFld_Destroy*(
    a0: OGRGeomFieldDefnH
  ) {.cdecl, importc: "OGR_GFld_Destroy", raises: [].}

  proc OGR_GFld_SetName*(
    a0: OGRGeomFieldDefnH, a1: cstring
  ) {.cdecl, importc: "OGR_GFld_SetName", raises: [].}

  proc OGR_GFld_GetNameRef*(
    a0: OGRGeomFieldDefnH
  ): cstring {.cdecl, importc: "OGR_GFld_GetNameRef", raises: [].}

  proc OGR_GFld_GetType*(
    a0: OGRGeomFieldDefnH
  ): OGRwkbGeometryType {.cdecl, importc: "OGR_GFld_GetType", raises: [].}

  proc OGR_GFld_SetType*(
    a0: OGRGeomFieldDefnH, a1: OGRwkbGeometryType
  ) {.cdecl, importc: "OGR_GFld_SetType", raises: [].}

  proc OGR_GFld_GetSpatialRef*(
    a0: OGRGeomFieldDefnH
  ): OGRSpatialReferenceH {.cdecl, importc: "OGR_GFld_GetSpatialRef", raises: [].}

  proc OGR_GFld_SetSpatialRef*(
    a0: OGRGeomFieldDefnH, hSRS: OGRSpatialReferenceH
  ) {.cdecl, importc: "OGR_GFld_SetSpatialRef", raises: [].}

  proc OGR_GFld_IsNullable*(
    hDefn: OGRGeomFieldDefnH
  ): cint {.cdecl, importc: "OGR_GFld_IsNullable", raises: [].}

  proc OGR_GFld_SetNullable*(
    hDefn: OGRGeomFieldDefnH, a1: cint
  ) {.cdecl, importc: "OGR_GFld_SetNullable", raises: [].}

  proc OGR_GFld_IsIgnored*(
    hDefn: OGRGeomFieldDefnH
  ): cint {.cdecl, importc: "OGR_GFld_IsIgnored", raises: [].}

  proc OGR_GFld_SetIgnored*(
    hDefn: OGRGeomFieldDefnH, a1: cint
  ) {.cdecl, importc: "OGR_GFld_SetIgnored", raises: [].}

  proc OGR_GFld_GetCoordinatePrecision*(
    a0: OGRGeomFieldDefnH
  ): OGRGeomCoordinatePrecisionH {.
    cdecl, importc: "OGR_GFld_GetCoordinatePrecision", raises: []
  .}

  proc OGR_GFld_SetCoordinatePrecision*(
    a0: OGRGeomFieldDefnH, a1: OGRGeomCoordinatePrecisionH
  ) {.cdecl, importc: "OGR_GFld_SetCoordinatePrecision", raises: [].}

  proc OGR_FD_Create*(
    a0: cstring
  ): OGRFeatureDefnH {.cdecl, importc: "OGR_FD_Create", raises: [].}

  proc OGR_FD_Destroy*(
    a0: OGRFeatureDefnH
  ) {.cdecl, importc: "OGR_FD_Destroy", raises: [].}

  proc OGR_FD_Release*(
    a0: OGRFeatureDefnH
  ) {.cdecl, importc: "OGR_FD_Release", raises: [].}

  proc OGR_FD_GetName*(
    a0: OGRFeatureDefnH
  ): cstring {.cdecl, importc: "OGR_FD_GetName", raises: [].}

  proc OGR_FD_GetFieldCount*(
    a0: OGRFeatureDefnH
  ): cint {.cdecl, importc: "OGR_FD_GetFieldCount", raises: [].}

  proc OGR_FD_GetFieldDefn*(
    a0: OGRFeatureDefnH, a1: cint
  ): OGRFieldDefnH {.cdecl, importc: "OGR_FD_GetFieldDefn", raises: [].}

  proc OGR_FD_GetFieldIndex*(
    a0: OGRFeatureDefnH, a1: cstring
  ): cint {.cdecl, importc: "OGR_FD_GetFieldIndex", raises: [].}

  proc OGR_FD_AddFieldDefn*(
    a0: OGRFeatureDefnH, a1: OGRFieldDefnH
  ) {.cdecl, importc: "OGR_FD_AddFieldDefn", raises: [].}

  proc OGR_FD_DeleteFieldDefn*(
    hDefn: OGRFeatureDefnH, iField: cint
  ): OGRErr {.cdecl, importc: "OGR_FD_DeleteFieldDefn", raises: [].}

  proc OGR_FD_ReorderFieldDefns*(
    hDefn: OGRFeatureDefnH, panMap: ptr cint
  ): OGRErr {.cdecl, importc: "OGR_FD_ReorderFieldDefns", raises: [].}

  proc OGR_FD_GetGeomType*(
    a0: OGRFeatureDefnH
  ): OGRwkbGeometryType {.cdecl, importc: "OGR_FD_GetGeomType", raises: [].}

  proc OGR_FD_SetGeomType*(
    a0: OGRFeatureDefnH, a1: OGRwkbGeometryType
  ) {.cdecl, importc: "OGR_FD_SetGeomType", raises: [].}

  proc OGR_FD_IsGeometryIgnored*(
    a0: OGRFeatureDefnH
  ): cint {.cdecl, importc: "OGR_FD_IsGeometryIgnored", raises: [].}

  proc OGR_FD_SetGeometryIgnored*(
    a0: OGRFeatureDefnH, a1: cint
  ) {.cdecl, importc: "OGR_FD_SetGeometryIgnored", raises: [].}

  proc OGR_FD_IsStyleIgnored*(
    a0: OGRFeatureDefnH
  ): cint {.cdecl, importc: "OGR_FD_IsStyleIgnored", raises: [].}

  proc OGR_FD_SetStyleIgnored*(
    a0: OGRFeatureDefnH, a1: cint
  ) {.cdecl, importc: "OGR_FD_SetStyleIgnored", raises: [].}

  proc OGR_FD_Reference*(
    a0: OGRFeatureDefnH
  ): cint {.cdecl, importc: "OGR_FD_Reference", raises: [].}

  proc OGR_FD_Dereference*(
    a0: OGRFeatureDefnH
  ): cint {.cdecl, importc: "OGR_FD_Dereference", raises: [].}

  proc OGR_FD_GetReferenceCount*(
    a0: OGRFeatureDefnH
  ): cint {.cdecl, importc: "OGR_FD_GetReferenceCount", raises: [].}

  proc OGR_FD_GetGeomFieldCount*(
    hFDefn: OGRFeatureDefnH
  ): cint {.cdecl, importc: "OGR_FD_GetGeomFieldCount", raises: [].}

  proc OGR_FD_GetGeomFieldDefn*(
    hFDefn: OGRFeatureDefnH, i: cint
  ): OGRGeomFieldDefnH {.cdecl, importc: "OGR_FD_GetGeomFieldDefn", raises: [].}

  proc OGR_FD_GetGeomFieldIndex*(
    hFDefn: OGRFeatureDefnH, pszName: cstring
  ): cint {.cdecl, importc: "OGR_FD_GetGeomFieldIndex", raises: [].}

  proc OGR_FD_AddGeomFieldDefn*(
    hFDefn: OGRFeatureDefnH, hGFldDefn: OGRGeomFieldDefnH
  ) {.cdecl, importc: "OGR_FD_AddGeomFieldDefn", raises: [].}

  proc OGR_FD_DeleteGeomFieldDefn*(
    hFDefn: OGRFeatureDefnH, iGeomField: cint
  ): OGRErr {.cdecl, importc: "OGR_FD_DeleteGeomFieldDefn", raises: [].}

  proc OGR_FD_IsSame*(
    hFDefn: OGRFeatureDefnH, hOtherFDefn: OGRFeatureDefnH
  ): cint {.cdecl, importc: "OGR_FD_IsSame", raises: [].}

  proc OGR_F_Create*(
    a0: OGRFeatureDefnH
  ): OGRFeatureH {.cdecl, importc: "OGR_F_Create", raises: [].}

  proc OGR_F_Destroy*(a0: OGRFeatureH) {.cdecl, importc: "OGR_F_Destroy", raises: [].}
  proc OGR_F_GetDefnRef*(
    a0: OGRFeatureH
  ): OGRFeatureDefnH {.cdecl, importc: "OGR_F_GetDefnRef", raises: [].}

  proc OGR_F_SetGeometryDirectly*(
    a0: OGRFeatureH, a1: OGRGeometryH
  ): OGRErr {.cdecl, importc: "OGR_F_SetGeometryDirectly", raises: [].}

  proc OGR_F_SetGeometry*(
    a0: OGRFeatureH, a1: OGRGeometryH
  ): OGRErr {.cdecl, importc: "OGR_F_SetGeometry", raises: [].}

  proc OGR_F_GetGeometryRef*(
    a0: OGRFeatureH
  ): OGRGeometryH {.cdecl, importc: "OGR_F_GetGeometryRef", raises: [].}

  proc OGR_F_StealGeometry*(
    a0: OGRFeatureH
  ): OGRGeometryH {.cdecl, importc: "OGR_F_StealGeometry", raises: [].}

  proc OGR_F_StealGeometryEx*(
    a0: OGRFeatureH, iGeomField: cint
  ): OGRGeometryH {.cdecl, importc: "OGR_F_StealGeometryEx", raises: [].}

  proc OGR_F_Clone*(
    a0: OGRFeatureH
  ): OGRFeatureH {.cdecl, importc: "OGR_F_Clone", raises: [].}

  proc OGR_F_Equal*(
    a0: OGRFeatureH, a1: OGRFeatureH
  ): cint {.cdecl, importc: "OGR_F_Equal", raises: [].}

  proc OGR_F_GetFieldCount*(
    a0: OGRFeatureH
  ): cint {.cdecl, importc: "OGR_F_GetFieldCount", raises: [].}

  proc OGR_F_GetFieldDefnRef*(
    a0: OGRFeatureH, a1: cint
  ): OGRFieldDefnH {.cdecl, importc: "OGR_F_GetFieldDefnRef", raises: [].}

  proc OGR_F_GetFieldIndex*(
    a0: OGRFeatureH, a1: cstring
  ): cint {.cdecl, importc: "OGR_F_GetFieldIndex", raises: [].}

  proc OGR_F_IsFieldSet*(
    a0: OGRFeatureH, a1: cint
  ): cint {.cdecl, importc: "OGR_F_IsFieldSet", raises: [].}

  proc OGR_F_UnsetField*(
    a0: OGRFeatureH, a1: cint
  ) {.cdecl, importc: "OGR_F_UnsetField", raises: [].}

  proc OGR_F_IsFieldNull*(
    a0: OGRFeatureH, a1: cint
  ): cint {.cdecl, importc: "OGR_F_IsFieldNull", raises: [].}

  proc OGR_F_IsFieldSetAndNotNull*(
    a0: OGRFeatureH, a1: cint
  ): cint {.cdecl, importc: "OGR_F_IsFieldSetAndNotNull", raises: [].}

  proc OGR_F_SetFieldNull*(
    a0: OGRFeatureH, a1: cint
  ) {.cdecl, importc: "OGR_F_SetFieldNull", raises: [].}

  proc OGR_F_GetRawFieldRef*(
    a0: OGRFeatureH, a1: cint
  ): ptr OGRField {.cdecl, importc: "OGR_F_GetRawFieldRef", raises: [].}

  proc OGR_RawField_IsUnset*(
    a0: ptr OGRField
  ): cint {.cdecl, importc: "OGR_RawField_IsUnset", raises: [].}

  proc OGR_RawField_IsNull*(
    a0: ptr OGRField
  ): cint {.cdecl, importc: "OGR_RawField_IsNull", raises: [].}

  proc OGR_RawField_SetUnset*(
    a0: ptr OGRField
  ) {.cdecl, importc: "OGR_RawField_SetUnset", raises: [].}

  proc OGR_RawField_SetNull*(
    a0: ptr OGRField
  ) {.cdecl, importc: "OGR_RawField_SetNull", raises: [].}

  proc OGR_F_GetFieldAsInteger*(
    a0: OGRFeatureH, a1: cint
  ): cint {.cdecl, importc: "OGR_F_GetFieldAsInteger", raises: [].}

  proc OGR_F_GetFieldAsInteger64*(
    a0: OGRFeatureH, a1: cint
  ): GIntBig {.cdecl, importc: "OGR_F_GetFieldAsInteger64", raises: [].}

  proc OGR_F_GetFieldAsDouble*(
    a0: OGRFeatureH, a1: cint
  ): cdouble {.cdecl, importc: "OGR_F_GetFieldAsDouble", raises: [].}

  proc OGR_F_GetFieldAsString*(
    a0: OGRFeatureH, a1: cint
  ): cstring {.cdecl, importc: "OGR_F_GetFieldAsString", raises: [].}

  proc OGR_F_GetFieldAsISO8601DateTime*(
    a0: OGRFeatureH, a1: cint, a2: CSLConstList
  ): cstring {.cdecl, importc: "OGR_F_GetFieldAsISO8601DateTime", raises: [].}

  proc OGR_F_GetFieldAsIntegerList*(
    a0: OGRFeatureH, a1: cint, a2: ptr cint
  ): ptr cint {.cdecl, importc: "OGR_F_GetFieldAsIntegerList", raises: [].}

  proc OGR_F_GetFieldAsInteger64List*(
    a0: OGRFeatureH, a1: cint, a2: ptr cint
  ): ptr GIntBig {.cdecl, importc: "OGR_F_GetFieldAsInteger64List", raises: [].}

  proc OGR_F_GetFieldAsDoubleList*(
    a0: OGRFeatureH, a1: cint, a2: ptr cint
  ): ptr cdouble {.cdecl, importc: "OGR_F_GetFieldAsDoubleList", raises: [].}

  proc OGR_F_GetFieldAsStringList*(
    a0: OGRFeatureH, a1: cint
  ): cstringArray {.cdecl, importc: "OGR_F_GetFieldAsStringList", raises: [].}

  proc OGR_F_GetFieldAsBinary*(
    a0: OGRFeatureH, a1: cint, a2: ptr cint
  ): ptr GByte {.cdecl, importc: "OGR_F_GetFieldAsBinary", raises: [].}

  proc OGR_F_GetFieldAsDateTime*(
    a0: OGRFeatureH,
    a1: cint,
    a2: ptr cint,
    a3: ptr cint,
    a4: ptr cint,
    a5: ptr cint,
    a6: ptr cint,
    a7: ptr cint,
    a8: ptr cint,
  ): cint {.cdecl, importc: "OGR_F_GetFieldAsDateTime", raises: [].}

  proc OGR_F_GetFieldAsDateTimeEx*(
    hFeat: OGRFeatureH,
    iField: cint,
    pnYear: ptr cint,
    pnMonth: ptr cint,
    pnDay: ptr cint,
    pnHour: ptr cint,
    pnMinute: ptr cint,
    pfSecond: ptr cfloat,
    pnTZFlag: ptr cint,
  ): cint {.cdecl, importc: "OGR_F_GetFieldAsDateTimeEx", raises: [].}

  proc OGR_F_SetFieldInteger*(
    a0: OGRFeatureH, a1: cint, a2: cint
  ) {.cdecl, importc: "OGR_F_SetFieldInteger", raises: [].}

  proc OGR_F_SetFieldInteger64*(
    a0: OGRFeatureH, a1: cint, a2: GIntBig
  ) {.cdecl, importc: "OGR_F_SetFieldInteger64", raises: [].}

  proc OGR_F_SetFieldDouble*(
    a0: OGRFeatureH, a1: cint, a2: cdouble
  ) {.cdecl, importc: "OGR_F_SetFieldDouble", raises: [].}

  proc OGR_F_SetFieldString*(
    a0: OGRFeatureH, a1: cint, a2: cstring
  ) {.cdecl, importc: "OGR_F_SetFieldString", raises: [].}

  proc OGR_F_SetFieldIntegerList*(
    a0: OGRFeatureH, a1: cint, a2: cint, a3: ptr cint
  ) {.cdecl, importc: "OGR_F_SetFieldIntegerList", raises: [].}

  proc OGR_F_SetFieldInteger64List*(
    a0: OGRFeatureH, a1: cint, a2: cint, a3: ptr GIntBig
  ) {.cdecl, importc: "OGR_F_SetFieldInteger64List", raises: [].}

  proc OGR_F_SetFieldDoubleList*(
    a0: OGRFeatureH, a1: cint, a2: cint, a3: ptr cdouble
  ) {.cdecl, importc: "OGR_F_SetFieldDoubleList", raises: [].}

  proc OGR_F_SetFieldStringList*(
    a0: OGRFeatureH, a1: cint, a2: CSLConstList
  ) {.cdecl, importc: "OGR_F_SetFieldStringList", raises: [].}

  proc OGR_F_SetFieldRaw*(
    a0: OGRFeatureH, a1: cint, a2: ptr OGRField
  ) {.cdecl, importc: "OGR_F_SetFieldRaw", raises: [].}

  proc OGR_F_SetFieldBinary*(
    a0: OGRFeatureH, a1: cint, a2: cint, a3: pointer
  ) {.cdecl, importc: "OGR_F_SetFieldBinary", raises: [].}

  proc OGR_F_SetFieldDateTime*(
    a0: OGRFeatureH,
    a1: cint,
    a2: cint,
    a3: cint,
    a4: cint,
    a5: cint,
    a6: cint,
    a7: cint,
    a8: cint,
  ) {.cdecl, importc: "OGR_F_SetFieldDateTime", raises: [].}

  proc OGR_F_SetFieldDateTimeEx*(
    a0: OGRFeatureH,
    a1: cint,
    a2: cint,
    a3: cint,
    a4: cint,
    a5: cint,
    a6: cint,
    a7: cfloat,
    a8: cint,
  ) {.cdecl, importc: "OGR_F_SetFieldDateTimeEx", raises: [].}

  proc OGR_F_GetGeomFieldCount*(
    hFeat: OGRFeatureH
  ): cint {.cdecl, importc: "OGR_F_GetGeomFieldCount", raises: [].}

  proc OGR_F_GetGeomFieldDefnRef*(
    hFeat: OGRFeatureH, iField: cint
  ): OGRGeomFieldDefnH {.cdecl, importc: "OGR_F_GetGeomFieldDefnRef", raises: [].}

  proc OGR_F_GetGeomFieldIndex*(
    hFeat: OGRFeatureH, pszName: cstring
  ): cint {.cdecl, importc: "OGR_F_GetGeomFieldIndex", raises: [].}

  proc OGR_F_GetGeomFieldRef*(
    hFeat: OGRFeatureH, iField: cint
  ): OGRGeometryH {.cdecl, importc: "OGR_F_GetGeomFieldRef", raises: [].}

  proc OGR_F_SetGeomFieldDirectly*(
    hFeat: OGRFeatureH, iField: cint, hGeom: OGRGeometryH
  ): OGRErr {.cdecl, importc: "OGR_F_SetGeomFieldDirectly", raises: [].}

  proc OGR_F_SetGeomField*(
    hFeat: OGRFeatureH, iField: cint, hGeom: OGRGeometryH
  ): OGRErr {.cdecl, importc: "OGR_F_SetGeomField", raises: [].}

  proc OGR_F_GetFID*(
    a0: OGRFeatureH
  ): GIntBig {.cdecl, importc: "OGR_F_GetFID", raises: [].}

  proc OGR_F_SetFID*(
    a0: OGRFeatureH, a1: GIntBig
  ): OGRErr {.cdecl, importc: "OGR_F_SetFID", raises: [].}

  proc OGR_F_DumpReadable*(
    a0: OGRFeatureH, a1: ptr GdalFile
  ) {.cdecl, importc: "OGR_F_DumpReadable", raises: [].}

  proc OGR_F_DumpReadableAsString*(
    a0: OGRFeatureH, a1: CSLConstList
  ): cstring {.cdecl, importc: "OGR_F_DumpReadableAsString", raises: [].}

  proc OGR_F_SetFrom*(
    a0: OGRFeatureH, a1: OGRFeatureH, a2: cint
  ): OGRErr {.cdecl, importc: "OGR_F_SetFrom", raises: [].}

  proc OGR_F_SetFromWithMap*(
    a0: OGRFeatureH, a1: OGRFeatureH, a2: cint, a3: ptr cint
  ): OGRErr {.cdecl, importc: "OGR_F_SetFromWithMap", raises: [].}

  proc OGR_F_GetStyleString*(
    a0: OGRFeatureH
  ): cstring {.cdecl, importc: "OGR_F_GetStyleString", raises: [].}

  proc OGR_F_SetStyleString*(
    a0: OGRFeatureH, a1: cstring
  ) {.cdecl, importc: "OGR_F_SetStyleString", raises: [].}

  proc OGR_F_SetStyleStringDirectly*(
    a0: OGRFeatureH, a1: cstring
  ) {.cdecl, importc: "OGR_F_SetStyleStringDirectly", raises: [].}

  proc OGR_F_GetStyleTable*(
    a0: OGRFeatureH
  ): OGRStyleTableH {.cdecl, importc: "OGR_F_GetStyleTable", raises: [].}

  proc OGR_F_SetStyleTableDirectly*(
    a0: OGRFeatureH, a1: OGRStyleTableH
  ) {.cdecl, importc: "OGR_F_SetStyleTableDirectly", raises: [].}

  proc OGR_F_SetStyleTable*(
    a0: OGRFeatureH, a1: OGRStyleTableH
  ) {.cdecl, importc: "OGR_F_SetStyleTable", raises: [].}

  proc OGR_F_GetNativeData*(
    a0: OGRFeatureH
  ): cstring {.cdecl, importc: "OGR_F_GetNativeData", raises: [].}

  proc OGR_F_SetNativeData*(
    a0: OGRFeatureH, a1: cstring
  ) {.cdecl, importc: "OGR_F_SetNativeData", raises: [].}

  proc OGR_F_GetNativeMediaType*(
    a0: OGRFeatureH
  ): cstring {.cdecl, importc: "OGR_F_GetNativeMediaType", raises: [].}

  proc OGR_F_SetNativeMediaType*(
    a0: OGRFeatureH, a1: cstring
  ) {.cdecl, importc: "OGR_F_SetNativeMediaType", raises: [].}

  proc OGR_F_FillUnsetWithDefault*(
    hFeat: OGRFeatureH, bNotNullableOnly: cint, papszOptions: CSLConstList
  ) {.cdecl, importc: "OGR_F_FillUnsetWithDefault", raises: [].}

  proc OGR_F_Validate*(
    a0: OGRFeatureH, nValidateFlags: cint, bEmitError: cint
  ): cint {.cdecl, importc: "OGR_F_Validate", raises: [].}

  proc OGR_FldDomain_Destroy*(
    a0: OGRFieldDomainH
  ) {.cdecl, importc: "OGR_FldDomain_Destroy", raises: [].}

  proc OGR_FldDomain_GetName*(
    a0: OGRFieldDomainH
  ): cstring {.cdecl, importc: "OGR_FldDomain_GetName", raises: [].}

  proc OGR_FldDomain_GetDescription*(
    a0: OGRFieldDomainH
  ): cstring {.cdecl, importc: "OGR_FldDomain_GetDescription", raises: [].}

  proc OGR_FldDomain_GetDomainType*(
    a0: OGRFieldDomainH
  ): OGRFieldDomainType {.cdecl, importc: "OGR_FldDomain_GetDomainType", raises: [].}

  proc OGR_FldDomain_GetFieldType*(
    a0: OGRFieldDomainH
  ): OGRFieldType {.cdecl, importc: "OGR_FldDomain_GetFieldType", raises: [].}

  proc OGR_FldDomain_GetFieldSubType*(
    a0: OGRFieldDomainH
  ): OGRFieldSubType {.cdecl, importc: "OGR_FldDomain_GetFieldSubType", raises: [].}

  proc OGR_FldDomain_GetSplitPolicy*(
    a0: OGRFieldDomainH
  ): OGRFieldDomainSplitPolicy {.
    cdecl, importc: "OGR_FldDomain_GetSplitPolicy", raises: []
  .}

  proc OGR_FldDomain_SetSplitPolicy*(
    a0: OGRFieldDomainH, a1: OGRFieldDomainSplitPolicy
  ) {.cdecl, importc: "OGR_FldDomain_SetSplitPolicy", raises: [].}

  proc OGR_FldDomain_GetMergePolicy*(
    a0: OGRFieldDomainH
  ): OGRFieldDomainMergePolicy {.
    cdecl, importc: "OGR_FldDomain_GetMergePolicy", raises: []
  .}

  proc OGR_FldDomain_SetMergePolicy*(
    a0: OGRFieldDomainH, a1: OGRFieldDomainMergePolicy
  ) {.cdecl, importc: "OGR_FldDomain_SetMergePolicy", raises: [].}

  proc OGR_CodedFldDomain_Create*(
    pszName: cstring,
    pszDescription: cstring,
    eFieldType: OGRFieldType,
    eFieldSubType: OGRFieldSubType,
    enumeration: ptr OGRCodedValue,
  ): OGRFieldDomainH {.cdecl, importc: "OGR_CodedFldDomain_Create", raises: [].}

  proc OGR_CodedFldDomain_GetEnumeration*(
    a0: OGRFieldDomainH
  ): ptr OGRCodedValue {.
    cdecl, importc: "OGR_CodedFldDomain_GetEnumeration", raises: []
  .}

  proc OGR_RangeFldDomain_Create*(
    pszName: cstring,
    pszDescription: cstring,
    eFieldType: OGRFieldType,
    eFieldSubType: OGRFieldSubType,
    psMin: ptr OGRField,
    bMinIsInclusive: bool,
    psMax: ptr OGRField,
    bMaxIsInclusive: bool,
  ): OGRFieldDomainH {.cdecl, importc: "OGR_RangeFldDomain_Create", raises: [].}

  proc OGR_RangeFldDomain_GetMin*(
    a0: OGRFieldDomainH, pbIsInclusiveOut: ptr bool
  ): ptr OGRField {.cdecl, importc: "OGR_RangeFldDomain_GetMin", raises: [].}

  proc OGR_RangeFldDomain_GetMax*(
    a0: OGRFieldDomainH, pbIsInclusiveOut: ptr bool
  ): ptr OGRField {.cdecl, importc: "OGR_RangeFldDomain_GetMax", raises: [].}

  proc OGR_GlobFldDomain_Create*(
    pszName: cstring,
    pszDescription: cstring,
    eFieldType: OGRFieldType,
    eFieldSubType: OGRFieldSubType,
    pszGlob: cstring,
  ): OGRFieldDomainH {.cdecl, importc: "OGR_GlobFldDomain_Create", raises: [].}

  proc OGR_GlobFldDomain_GetGlob*(
    a0: OGRFieldDomainH
  ): cstring {.cdecl, importc: "OGR_GlobFldDomain_GetGlob", raises: [].}

  proc OGR_L_GetName*(
    a0: OGRLayerH
  ): cstring {.cdecl, importc: "OGR_L_GetName", raises: [].}

  proc OGR_L_GetGeomType*(
    a0: OGRLayerH
  ): OGRwkbGeometryType {.cdecl, importc: "OGR_L_GetGeomType", raises: [].}

  proc OGR_L_GetGeometryTypes*(
    hLayer: OGRLayerH,
    iGeomField: cint,
    nFlags: cint,
    pnEntryCount: ptr cint,
    pfnProgress: GDALProgressFunc,
    pProgressData: pointer,
  ): ptr OGRGeometryTypeCounter {.cdecl, importc: "OGR_L_GetGeometryTypes", raises: [].}

  proc OGR_L_GetSpatialFilter*(
    a0: OGRLayerH
  ): OGRGeometryH {.cdecl, importc: "OGR_L_GetSpatialFilter", raises: [].}

  proc OGR_L_SetSpatialFilter*(
    a0: OGRLayerH, a1: OGRGeometryH
  ) {.cdecl, importc: "OGR_L_SetSpatialFilter", raises: [].}

  proc OGR_L_SetSpatialFilterRect*(
    a0: OGRLayerH, a1: cdouble, a2: cdouble, a3: cdouble, a4: cdouble
  ) {.cdecl, importc: "OGR_L_SetSpatialFilterRect", raises: [].}

  proc OGR_L_SetSpatialFilterEx*(
    a0: OGRLayerH, iGeomField: cint, hGeom: OGRGeometryH
  ) {.cdecl, importc: "OGR_L_SetSpatialFilterEx", raises: [].}

  proc OGR_L_SetSpatialFilterRectEx*(
    a0: OGRLayerH,
    iGeomField: cint,
    dfMinX: cdouble,
    dfMinY: cdouble,
    dfMaxX: cdouble,
    dfMaxY: cdouble,
  ) {.cdecl, importc: "OGR_L_SetSpatialFilterRectEx", raises: [].}

  proc OGR_L_SetAttributeFilter*(
    a0: OGRLayerH, a1: cstring
  ): OGRErr {.cdecl, importc: "OGR_L_SetAttributeFilter", raises: [].}

  proc OGR_L_GetAttributeFilter*(
    a0: OGRLayerH
  ): cstring {.cdecl, importc: "OGR_L_GetAttributeFilter", raises: [].}

  proc OGR_L_ResetReading*(
    a0: OGRLayerH
  ) {.cdecl, importc: "OGR_L_ResetReading", raises: [].}

  proc OGR_L_GetNextFeature*(
    a0: OGRLayerH
  ): OGRFeatureH {.cdecl, importc: "OGR_L_GetNextFeature", raises: [].}

  proc OGR_L_GetArrowStream*(
    hLayer: OGRLayerH, out_stream: ptr ArrowArrayStream, papszOptions: CSLConstList
  ): bool {.cdecl, importc: "OGR_L_GetArrowStream", raises: [].}

  proc OGR_L_IsArrowSchemaSupported*(
    hLayer: OGRLayerH,
    schema: ptr ArrowSchema,
    papszOptions: CSLConstList,
    ppszErrorMsg: cstringArray,
  ): bool {.cdecl, importc: "OGR_L_IsArrowSchemaSupported", raises: [].}

  proc OGR_L_CreateFieldFromArrowSchema*(
    hLayer: OGRLayerH, schema: ptr ArrowSchema, papszOptions: CSLConstList
  ): bool {.cdecl, importc: "OGR_L_CreateFieldFromArrowSchema", raises: [].}

  proc OGR_L_WriteArrowBatch*(
    hLayer: OGRLayerH,
    schema: ptr ArrowSchema,
    array: ptr ArrowArray,
    papszOptions: CSLConstList,
  ): bool {.cdecl, importc: "OGR_L_WriteArrowBatch", raises: [].}

  proc OGR_L_SetNextByIndex*(
    a0: OGRLayerH, a1: GIntBig
  ): OGRErr {.cdecl, importc: "OGR_L_SetNextByIndex", raises: [].}

  proc OGR_L_GetFeature*(
    a0: OGRLayerH, a1: GIntBig
  ): OGRFeatureH {.cdecl, importc: "OGR_L_GetFeature", raises: [].}

  proc OGR_L_SetFeature*(
    a0: OGRLayerH, a1: OGRFeatureH
  ): OGRErr {.cdecl, importc: "OGR_L_SetFeature", raises: [].}

  proc OGR_L_CreateFeature*(
    a0: OGRLayerH, a1: OGRFeatureH
  ): OGRErr {.cdecl, importc: "OGR_L_CreateFeature", raises: [].}

  proc OGR_L_DeleteFeature*(
    a0: OGRLayerH, a1: GIntBig
  ): OGRErr {.cdecl, importc: "OGR_L_DeleteFeature", raises: [].}

  proc OGR_L_UpsertFeature*(
    a0: OGRLayerH, a1: OGRFeatureH
  ): OGRErr {.cdecl, importc: "OGR_L_UpsertFeature", raises: [].}

  proc OGR_L_UpdateFeature*(
    a0: OGRLayerH,
    a1: OGRFeatureH,
    nUpdatedFieldsCount: cint,
    panUpdatedFieldsIdx: ptr cint,
    nUpdatedGeomFieldsCount: cint,
    panUpdatedGeomFieldsIdx: ptr cint,
    bUpdateStyleString: bool,
  ): OGRErr {.cdecl, importc: "OGR_L_UpdateFeature", raises: [].}

  proc OGR_L_GetLayerDefn*(
    a0: OGRLayerH
  ): OGRFeatureDefnH {.cdecl, importc: "OGR_L_GetLayerDefn", raises: [].}

  proc OGR_L_GetSpatialRef*(
    a0: OGRLayerH
  ): OGRSpatialReferenceH {.cdecl, importc: "OGR_L_GetSpatialRef", raises: [].}

  proc OGR_L_GetSupportedSRSList*(
    hLayer: OGRLayerH, iGeomField: cint, pnCount: ptr cint
  ): ptr OGRSpatialReferenceH {.
    cdecl, importc: "OGR_L_GetSupportedSRSList", raises: []
  .}

  proc OGR_L_SetActiveSRS*(
    hLayer: OGRLayerH, iGeomField: cint, hSRS: OGRSpatialReferenceH
  ): OGRErr {.cdecl, importc: "OGR_L_SetActiveSRS", raises: [].}

  proc OGR_L_FindFieldIndex*(
    a0: OGRLayerH, a1: cstring, bExactMatch: cint
  ): cint {.cdecl, importc: "OGR_L_FindFieldIndex", raises: [].}

  proc OGR_L_GetFeatureCount*(
    a0: OGRLayerH, a1: cint
  ): GIntBig {.cdecl, importc: "OGR_L_GetFeatureCount", raises: [].}

  proc OGR_L_GetExtent*(
    a0: OGRLayerH, a1: ptr OGREnvelope, a2: cint
  ): OGRErr {.cdecl, importc: "OGR_L_GetExtent", raises: [].}

  proc OGR_L_GetExtentEx*(
    a0: OGRLayerH, iGeomField: cint, psExtent: ptr OGREnvelope, bForce: cint
  ): OGRErr {.cdecl, importc: "OGR_L_GetExtentEx", raises: [].}

  proc OGR_L_GetExtent3D*(
    hLayer: OGRLayerH, iGeomField: cint, psExtent3D: ptr OGREnvelope3D, bForce: cint
  ): OGRErr {.cdecl, importc: "OGR_L_GetExtent3D", raises: [].}

  proc OGR_L_TestCapability*(
    a0: OGRLayerH, a1: cstring
  ): cint {.cdecl, importc: "OGR_L_TestCapability", raises: [].}

  proc OGR_L_CreateField*(
    a0: OGRLayerH, a1: OGRFieldDefnH, a2: cint
  ): OGRErr {.cdecl, importc: "OGR_L_CreateField", raises: [].}

  proc OGR_L_CreateGeomField*(
    hLayer: OGRLayerH, hFieldDefn: OGRGeomFieldDefnH, bForce: cint
  ): OGRErr {.cdecl, importc: "OGR_L_CreateGeomField", raises: [].}

  proc OGR_L_DeleteField*(
    a0: OGRLayerH, iField: cint
  ): OGRErr {.cdecl, importc: "OGR_L_DeleteField", raises: [].}

  proc OGR_L_ReorderFields*(
    a0: OGRLayerH, panMap: ptr cint
  ): OGRErr {.cdecl, importc: "OGR_L_ReorderFields", raises: [].}

  proc OGR_L_ReorderField*(
    a0: OGRLayerH, iOldFieldPos: cint, iNewFieldPos: cint
  ): OGRErr {.cdecl, importc: "OGR_L_ReorderField", raises: [].}

  proc OGR_L_AlterFieldDefn*(
    a0: OGRLayerH, iField: cint, hNewFieldDefn: OGRFieldDefnH, nFlags: cint
  ): OGRErr {.cdecl, importc: "OGR_L_AlterFieldDefn", raises: [].}

  proc OGR_L_AlterGeomFieldDefn*(
    a0: OGRLayerH, iField: cint, hNewGeomFieldDefn: OGRGeomFieldDefnH, nFlags: cint
  ): OGRErr {.cdecl, importc: "OGR_L_AlterGeomFieldDefn", raises: [].}

  proc OGR_L_StartTransaction*(
    a0: OGRLayerH
  ): OGRErr {.cdecl, importc: "OGR_L_StartTransaction", raises: [].}

  proc OGR_L_CommitTransaction*(
    a0: OGRLayerH
  ): OGRErr {.cdecl, importc: "OGR_L_CommitTransaction", raises: [].}

  proc OGR_L_RollbackTransaction*(
    a0: OGRLayerH
  ): OGRErr {.cdecl, importc: "OGR_L_RollbackTransaction", raises: [].}

  proc OGR_L_Rename*(
    hLayer: OGRLayerH, pszNewName: cstring
  ): OGRErr {.cdecl, importc: "OGR_L_Rename", raises: [].}

  proc OGR_L_Reference*(
    a0: OGRLayerH
  ): cint {.cdecl, importc: "OGR_L_Reference", raises: [].}

  proc OGR_L_Dereference*(
    a0: OGRLayerH
  ): cint {.cdecl, importc: "OGR_L_Dereference", raises: [].}

  proc OGR_L_GetRefCount*(
    a0: OGRLayerH
  ): cint {.cdecl, importc: "OGR_L_GetRefCount", raises: [].}

  proc OGR_L_SyncToDisk*(
    a0: OGRLayerH
  ): OGRErr {.cdecl, importc: "OGR_L_SyncToDisk", raises: [].}

  proc OGR_L_GetFeaturesRead*(
    a0: OGRLayerH
  ): GIntBig {.cdecl, importc: "OGR_L_GetFeaturesRead", raises: [].}

  proc OGR_L_GetFIDColumn*(
    a0: OGRLayerH
  ): cstring {.cdecl, importc: "OGR_L_GetFIDColumn", raises: [].}

  proc OGR_L_GetGeometryColumn*(
    a0: OGRLayerH
  ): cstring {.cdecl, importc: "OGR_L_GetGeometryColumn", raises: [].}

  proc OGR_L_GetStyleTable*(
    a0: OGRLayerH
  ): OGRStyleTableH {.cdecl, importc: "OGR_L_GetStyleTable", raises: [].}

  proc OGR_L_SetStyleTableDirectly*(
    a0: OGRLayerH, a1: OGRStyleTableH
  ) {.cdecl, importc: "OGR_L_SetStyleTableDirectly", raises: [].}

  proc OGR_L_SetStyleTable*(
    a0: OGRLayerH, a1: OGRStyleTableH
  ) {.cdecl, importc: "OGR_L_SetStyleTable", raises: [].}

  proc OGR_L_SetIgnoredFields*(
    a0: OGRLayerH, a1: cstringArray
  ): OGRErr {.cdecl, importc: "OGR_L_SetIgnoredFields", raises: [].}

  proc OGR_L_Intersection*(
    a0: OGRLayerH,
    a1: OGRLayerH,
    a2: OGRLayerH,
    a3: CSLConstList,
    a4: GDALProgressFunc,
    a5: pointer,
  ): OGRErr {.cdecl, importc: "OGR_L_Intersection", raises: [].}

  proc OGR_L_Union*(
    a0: OGRLayerH,
    a1: OGRLayerH,
    a2: OGRLayerH,
    a3: CSLConstList,
    a4: GDALProgressFunc,
    a5: pointer,
  ): OGRErr {.cdecl, importc: "OGR_L_Union", raises: [].}

  proc OGR_L_SymDifference*(
    a0: OGRLayerH,
    a1: OGRLayerH,
    a2: OGRLayerH,
    a3: CSLConstList,
    a4: GDALProgressFunc,
    a5: pointer,
  ): OGRErr {.cdecl, importc: "OGR_L_SymDifference", raises: [].}

  proc OGR_L_Identity*(
    a0: OGRLayerH,
    a1: OGRLayerH,
    a2: OGRLayerH,
    a3: CSLConstList,
    a4: GDALProgressFunc,
    a5: pointer,
  ): OGRErr {.cdecl, importc: "OGR_L_Identity", raises: [].}

  proc OGR_L_Update*(
    a0: OGRLayerH,
    a1: OGRLayerH,
    a2: OGRLayerH,
    a3: CSLConstList,
    a4: GDALProgressFunc,
    a5: pointer,
  ): OGRErr {.cdecl, importc: "OGR_L_Update", raises: [].}

  proc OGR_L_Clip*(
    a0: OGRLayerH,
    a1: OGRLayerH,
    a2: OGRLayerH,
    a3: CSLConstList,
    a4: GDALProgressFunc,
    a5: pointer,
  ): OGRErr {.cdecl, importc: "OGR_L_Clip", raises: [].}

  proc OGR_L_Erase*(
    a0: OGRLayerH,
    a1: OGRLayerH,
    a2: OGRLayerH,
    a3: CSLConstList,
    a4: GDALProgressFunc,
    a5: pointer,
  ): OGRErr {.cdecl, importc: "OGR_L_Erase", raises: [].}

  proc OGR_DS_Destroy*(
    a0: OGRDataSourceH
  ) {.cdecl, importc: "OGR_DS_Destroy", raises: [].}

  proc OGR_DS_GetName*(
    a0: OGRDataSourceH
  ): cstring {.cdecl, importc: "OGR_DS_GetName", raises: [].}

  proc OGR_DS_GetLayerCount*(
    a0: OGRDataSourceH
  ): cint {.cdecl, importc: "OGR_DS_GetLayerCount", raises: [].}

  proc OGR_DS_GetLayer*(
    a0: OGRDataSourceH, a1: cint
  ): OGRLayerH {.cdecl, importc: "OGR_DS_GetLayer", raises: [].}

  proc OGR_DS_GetLayerByName*(
    a0: OGRDataSourceH, a1: cstring
  ): OGRLayerH {.cdecl, importc: "OGR_DS_GetLayerByName", raises: [].}

  proc OGR_DS_DeleteLayer*(
    a0: OGRDataSourceH, a1: cint
  ): OGRErr {.cdecl, importc: "OGR_DS_DeleteLayer", raises: [].}

  proc OGR_DS_GetDriver*(
    a0: OGRDataSourceH
  ): OGRSFDriverH {.cdecl, importc: "OGR_DS_GetDriver", raises: [].}

  proc OGR_DS_CreateLayer*(
    a0: OGRDataSourceH,
    a1: cstring,
    a2: OGRSpatialReferenceH,
    a3: OGRwkbGeometryType,
    a4: cstringArray,
  ): OGRLayerH {.cdecl, importc: "OGR_DS_CreateLayer", raises: [].}

  proc OGR_DS_CopyLayer*(
    a0: OGRDataSourceH, a1: OGRLayerH, a2: cstring, a3: cstringArray
  ): OGRLayerH {.cdecl, importc: "OGR_DS_CopyLayer", raises: [].}

  proc OGR_DS_TestCapability*(
    a0: OGRDataSourceH, a1: cstring
  ): cint {.cdecl, importc: "OGR_DS_TestCapability", raises: [].}

  proc OGR_DS_ExecuteSQL*(
    a0: OGRDataSourceH, a1: cstring, a2: OGRGeometryH, a3: cstring
  ): OGRLayerH {.cdecl, importc: "OGR_DS_ExecuteSQL", raises: [].}

  proc OGR_DS_ReleaseResultSet*(
    a0: OGRDataSourceH, a1: OGRLayerH
  ) {.cdecl, importc: "OGR_DS_ReleaseResultSet", raises: [].}

  proc OGR_DS_Reference*(
    a0: OGRDataSourceH
  ): cint {.cdecl, importc: "OGR_DS_Reference", raises: [].}

  proc OGR_DS_Dereference*(
    a0: OGRDataSourceH
  ): cint {.cdecl, importc: "OGR_DS_Dereference", raises: [].}

  proc OGR_DS_GetRefCount*(
    a0: OGRDataSourceH
  ): cint {.cdecl, importc: "OGR_DS_GetRefCount", raises: [].}

  proc OGR_DS_GetSummaryRefCount*(
    a0: OGRDataSourceH
  ): cint {.cdecl, importc: "OGR_DS_GetSummaryRefCount", raises: [].}

  proc OGR_DS_SyncToDisk*(
    a0: OGRDataSourceH
  ): OGRErr {.cdecl, importc: "OGR_DS_SyncToDisk", raises: [].}

  proc OGR_DS_GetStyleTable*(
    a0: OGRDataSourceH
  ): OGRStyleTableH {.cdecl, importc: "OGR_DS_GetStyleTable", raises: [].}

  proc OGR_DS_SetStyleTableDirectly*(
    a0: OGRDataSourceH, a1: OGRStyleTableH
  ) {.cdecl, importc: "OGR_DS_SetStyleTableDirectly", raises: [].}

  proc OGR_DS_SetStyleTable*(
    a0: OGRDataSourceH, a1: OGRStyleTableH
  ) {.cdecl, importc: "OGR_DS_SetStyleTable", raises: [].}

  proc OGR_Dr_GetName*(
    a0: OGRSFDriverH
  ): cstring {.cdecl, importc: "OGR_Dr_GetName", raises: [].}

  proc OGR_Dr_Open*(
    a0: OGRSFDriverH, a1: cstring, a2: cint
  ): OGRDataSourceH {.cdecl, importc: "OGR_Dr_Open", raises: [].}

  proc OGR_Dr_TestCapability*(
    a0: OGRSFDriverH, a1: cstring
  ): cint {.cdecl, importc: "OGR_Dr_TestCapability", raises: [].}

  proc OGR_Dr_CreateDataSource*(
    a0: OGRSFDriverH, a1: cstring, a2: cstringArray
  ): OGRDataSourceH {.cdecl, importc: "OGR_Dr_CreateDataSource", raises: [].}

  proc OGR_Dr_CopyDataSource*(
    a0: OGRSFDriverH, a1: OGRDataSourceH, a2: cstring, a3: cstringArray
  ): OGRDataSourceH {.cdecl, importc: "OGR_Dr_CopyDataSource", raises: [].}

  proc OGR_Dr_DeleteDataSource*(
    a0: OGRSFDriverH, a1: cstring
  ): OGRErr {.cdecl, importc: "OGR_Dr_DeleteDataSource", raises: [].}

  proc OGROpen*(
    a0: cstring, a1: cint, a2: ptr OGRSFDriverH
  ): OGRDataSourceH {.cdecl, importc: "OGROpen", raises: [].}

  proc OGROpenShared*(
    a0: cstring, a1: cint, a2: ptr OGRSFDriverH
  ): OGRDataSourceH {.cdecl, importc: "OGROpenShared", raises: [].}

  proc OGRReleaseDataSource*(
    a0: OGRDataSourceH
  ): OGRErr {.cdecl, importc: "OGRReleaseDataSource", raises: [].}

  proc OGRRegisterDriver*(
    a0: OGRSFDriverH
  ) {.cdecl, importc: "OGRRegisterDriver", raises: [].}

  proc OGRDeregisterDriver*(
    a0: OGRSFDriverH
  ) {.cdecl, importc: "OGRDeregisterDriver", raises: [].}

  proc OGRGetDriverCount*(): cint {.cdecl, importc: "OGRGetDriverCount", raises: [].}
  proc OGRGetDriver*(
    a0: cint
  ): OGRSFDriverH {.cdecl, importc: "OGRGetDriver", raises: [].}

  proc OGRGetDriverByName*(
    a0: cstring
  ): OGRSFDriverH {.cdecl, importc: "OGRGetDriverByName", raises: [].}

  proc OGRGetOpenDSCount*(): cint {.cdecl, importc: "OGRGetOpenDSCount", raises: [].}
  proc OGRGetOpenDS*(
    iDS: cint
  ): OGRDataSourceH {.cdecl, importc: "OGRGetOpenDS", raises: [].}

  proc OGRRegisterAll*() {.cdecl, importc: "OGRRegisterAll", raises: [].}
  proc OGRCleanupAll*() {.cdecl, importc: "OGRCleanupAll", raises: [].}
  proc OGR_SM_Create*(
    hStyleTable: OGRStyleTableH
  ): OGRStyleMgrH {.cdecl, importc: "OGR_SM_Create", raises: [].}

  proc OGR_SM_Destroy*(
    hSM: OGRStyleMgrH
  ) {.cdecl, importc: "OGR_SM_Destroy", raises: [].}

  proc OGR_SM_InitFromFeature*(
    hSM: OGRStyleMgrH, hFeat: OGRFeatureH
  ): cstring {.cdecl, importc: "OGR_SM_InitFromFeature", raises: [].}

  proc OGR_SM_InitStyleString*(
    hSM: OGRStyleMgrH, pszStyleString: cstring
  ): cint {.cdecl, importc: "OGR_SM_InitStyleString", raises: [].}

  proc OGR_SM_GetPartCount*(
    hSM: OGRStyleMgrH, pszStyleString: cstring
  ): cint {.cdecl, importc: "OGR_SM_GetPartCount", raises: [].}

  proc OGR_SM_GetPart*(
    hSM: OGRStyleMgrH, nPartId: cint, pszStyleString: cstring
  ): OGRStyleToolH {.cdecl, importc: "OGR_SM_GetPart", raises: [].}

  proc OGR_SM_AddPart*(
    hSM: OGRStyleMgrH, hST: OGRStyleToolH
  ): cint {.cdecl, importc: "OGR_SM_AddPart", raises: [].}

  proc OGR_SM_AddStyle*(
    hSM: OGRStyleMgrH, pszStyleName: cstring, pszStyleString: cstring
  ): cint {.cdecl, importc: "OGR_SM_AddStyle", raises: [].}

  proc OGR_ST_Create*(
    eClassId: OGRSTClassId
  ): OGRStyleToolH {.cdecl, importc: "OGR_ST_Create", raises: [].}

  proc OGR_ST_Destroy*(
    hST: OGRStyleToolH
  ) {.cdecl, importc: "OGR_ST_Destroy", raises: [].}

  proc OGR_ST_GetType*(
    hST: OGRStyleToolH
  ): OGRSTClassId {.cdecl, importc: "OGR_ST_GetType", raises: [].}

  proc OGR_ST_GetUnit*(
    hST: OGRStyleToolH
  ): OGRSTUnitId {.cdecl, importc: "OGR_ST_GetUnit", raises: [].}

  proc OGR_ST_SetUnit*(
    hST: OGRStyleToolH, eUnit: OGRSTUnitId, dfGroundPaperScale: cdouble
  ) {.cdecl, importc: "OGR_ST_SetUnit", raises: [].}

  proc OGR_ST_GetParamStr*(
    hST: OGRStyleToolH, eParam: cint, bValueIsNull: ptr cint
  ): cstring {.cdecl, importc: "OGR_ST_GetParamStr", raises: [].}

  proc OGR_ST_GetParamNum*(
    hST: OGRStyleToolH, eParam: cint, bValueIsNull: ptr cint
  ): cint {.cdecl, importc: "OGR_ST_GetParamNum", raises: [].}

  proc OGR_ST_GetParamDbl*(
    hST: OGRStyleToolH, eParam: cint, bValueIsNull: ptr cint
  ): cdouble {.cdecl, importc: "OGR_ST_GetParamDbl", raises: [].}

  proc OGR_ST_SetParamStr*(
    hST: OGRStyleToolH, eParam: cint, pszValue: cstring
  ) {.cdecl, importc: "OGR_ST_SetParamStr", raises: [].}

  proc OGR_ST_SetParamNum*(
    hST: OGRStyleToolH, eParam: cint, nValue: cint
  ) {.cdecl, importc: "OGR_ST_SetParamNum", raises: [].}

  proc OGR_ST_SetParamDbl*(
    hST: OGRStyleToolH, eParam: cint, dfValue: cdouble
  ) {.cdecl, importc: "OGR_ST_SetParamDbl", raises: [].}

  proc OGR_ST_GetStyleString*(
    hST: OGRStyleToolH
  ): cstring {.cdecl, importc: "OGR_ST_GetStyleString", raises: [].}

  proc OGR_ST_GetRGBFromString*(
    hST: OGRStyleToolH,
    pszColor: cstring,
    pnRed: ptr cint,
    pnGreen: ptr cint,
    pnBlue: ptr cint,
    pnAlpha: ptr cint,
  ): cint {.cdecl, importc: "OGR_ST_GetRGBFromString", raises: [].}

  proc OGR_STBL_Create*(): OGRStyleTableH {.
    cdecl, importc: "OGR_STBL_Create", raises: []
  .}

  proc OGR_STBL_Destroy*(
    hSTBL: OGRStyleTableH
  ) {.cdecl, importc: "OGR_STBL_Destroy", raises: [].}

  proc OGR_STBL_AddStyle*(
    hStyleTable: OGRStyleTableH, pszName: cstring, pszStyleString: cstring
  ): cint {.cdecl, importc: "OGR_STBL_AddStyle", raises: [].}

  proc OGR_STBL_SaveStyleTable*(
    hStyleTable: OGRStyleTableH, pszFilename: cstring
  ): cint {.cdecl, importc: "OGR_STBL_SaveStyleTable", raises: [].}

  proc OGR_STBL_LoadStyleTable*(
    hStyleTable: OGRStyleTableH, pszFilename: cstring
  ): cint {.cdecl, importc: "OGR_STBL_LoadStyleTable", raises: [].}

  proc OGR_STBL_Find*(
    hStyleTable: OGRStyleTableH, pszName: cstring
  ): cstring {.cdecl, importc: "OGR_STBL_Find", raises: [].}

  proc OGR_STBL_ResetStyleStringReading*(
    hStyleTable: OGRStyleTableH
  ) {.cdecl, importc: "OGR_STBL_ResetStyleStringReading", raises: [].}

  proc OGR_STBL_GetNextStyle*(
    hStyleTable: OGRStyleTableH
  ): cstring {.cdecl, importc: "OGR_STBL_GetNextStyle", raises: [].}

  proc OGR_STBL_GetLastStyleName*(
    hStyleTable: OGRStyleTableH
  ): cstring {.cdecl, importc: "OGR_STBL_GetLastStyleName", raises: [].}

  proc GDALGetDataTypeSize*(
    a0: GDALDataType
  ): cint {.gdalCall, importc: "GDALGetDataTypeSize", raises: [].}

  proc GDALGetDataTypeSizeBits*(
    eDataType: GDALDataType
  ): cint {.gdalCall, importc: "GDALGetDataTypeSizeBits", raises: [].}

  proc GDALGetDataTypeSizeBytes*(
    a0: GDALDataType
  ): cint {.gdalCall, importc: "GDALGetDataTypeSizeBytes", raises: [].}

  proc GDALDataTypeIsComplex*(
    a0: GDALDataType
  ): cint {.gdalCall, importc: "GDALDataTypeIsComplex", raises: [].}

  proc GDALDataTypeIsInteger*(
    a0: GDALDataType
  ): cint {.gdalCall, importc: "GDALDataTypeIsInteger", raises: [].}

  proc GDALDataTypeIsFloating*(
    a0: GDALDataType
  ): cint {.gdalCall, importc: "GDALDataTypeIsFloating", raises: [].}

  proc GDALDataTypeIsSigned*(
    a0: GDALDataType
  ): cint {.gdalCall, importc: "GDALDataTypeIsSigned", raises: [].}

  proc GDALGetDataTypeName*(
    a0: GDALDataType
  ): cstring {.gdalCall, importc: "GDALGetDataTypeName", raises: [].}

  proc GDALGetDataTypeByName*(
    a0: cstring
  ): GDALDataType {.gdalCall, importc: "GDALGetDataTypeByName", raises: [].}

  proc GDALDataTypeUnion*(
    a0: GDALDataType, a1: GDALDataType
  ): GDALDataType {.gdalCall, importc: "GDALDataTypeUnion", raises: [].}

  proc GDALDataTypeUnionWithValue*(
    eDT: GDALDataType, dValue: cdouble, bComplex: cint
  ): GDALDataType {.gdalCall, importc: "GDALDataTypeUnionWithValue", raises: [].}

  proc GDALFindDataType*(
    nBits: cint, bSigned: cint, bFloating: cint, bComplex: cint
  ): GDALDataType {.gdalCall, importc: "GDALFindDataType", raises: [].}

  proc GDALFindDataTypeForValue*(
    dValue: cdouble, bComplex: cint
  ): GDALDataType {.gdalCall, importc: "GDALFindDataTypeForValue", raises: [].}

  proc GDALAdjustValueToDataType*(
    eDT: GDALDataType, dfValue: cdouble, pbClamped: ptr cint, pbRounded: ptr cint
  ): cdouble {.cdecl, importc: "GDALAdjustValueToDataType", raises: [].}

  proc GDALIsValueExactAs*(
    dfValue: cdouble, eDT: GDALDataType
  ): bool {.cdecl, importc: "GDALIsValueExactAs", raises: [].}

  proc GDALIsValueInRangeOf*(
    dfValue: cdouble, eDT: GDALDataType
  ): bool {.cdecl, importc: "GDALIsValueInRangeOf", raises: [].}

  proc GDALGetNonComplexDataType*(
    a0: GDALDataType
  ): GDALDataType {.gdalCall, importc: "GDALGetNonComplexDataType", raises: [].}

  proc GDALDataTypeIsConversionLossy*(
    eTypeFrom: GDALDataType, eTypeTo: GDALDataType
  ): cint {.gdalCall, importc: "GDALDataTypeIsConversionLossy", raises: [].}

  proc GDALGetAsyncStatusTypeName*(
    a0: GDALAsyncStatusType
  ): cstring {.gdalCall, importc: "GDALGetAsyncStatusTypeName", raises: [].}

  proc GDALGetAsyncStatusTypeByName*(
    a0: cstring
  ): GDALAsyncStatusType {.
    gdalCall, importc: "GDALGetAsyncStatusTypeByName", raises: []
  .}

  proc GDALGetColorInterpretationName*(
    a0: GDALColorInterp
  ): cstring {.cdecl, importc: "GDALGetColorInterpretationName", raises: [].}

  proc GDALGetColorInterpretationByName*(
    pszName: cstring
  ): GDALColorInterp {.cdecl, importc: "GDALGetColorInterpretationByName", raises: [].}

  proc GDALGetColorInterpretationList*(
    pnCount: ptr cint
  ): ptr GDALColorInterp {.
    cdecl, importc: "GDALGetColorInterpretationList", raises: []
  .}

  proc GDALGetPaletteInterpretationName*(
    a0: GDALPaletteInterp
  ): cstring {.cdecl, importc: "GDALGetPaletteInterpretationName", raises: [].}

  proc GDALAllRegister*() {.gdalCall, importc: "GDALAllRegister", raises: [].}
  proc GDALRegisterPlugins*() {.cdecl, importc: "GDALRegisterPlugins", raises: [].}
  proc GDALRegisterPlugin*(
    name: cstring
  ): CPLErr {.cdecl, importc: "GDALRegisterPlugin", raises: [].}

  proc GDALCreate*(
    hDriver: GDALDriverH,
    a1: cstring,
    a2: cint,
    a3: cint,
    a4: cint,
    a5: GDALDataType,
    a6: CSLConstList,
  ): GDALDatasetH {.gdalCall, importc: "GDALCreate", raises: [].}

  proc GDALCreateCopy*(
    a0: GDALDriverH,
    a1: cstring,
    a2: GDALDatasetH,
    a3: cint,
    a4: CSLConstList,
    a5: GDALProgressFunc,
    a6: pointer,
  ): GDALDatasetH {.gdalCall, importc: "GDALCreateCopy", raises: [].}

  proc GDALIdentifyDriver*(
    pszFilename: cstring, papszFileList: CSLConstList
  ): GDALDriverH {.gdalCall, importc: "GDALIdentifyDriver", raises: [].}

  proc GDALIdentifyDriverEx*(
    pszFilename: cstring,
    nIdentifyFlags: cuint,
    papszAllowedDrivers: cstringArray,
    papszFileList: cstringArray,
  ): GDALDriverH {.gdalCall, importc: "GDALIdentifyDriverEx", raises: [].}

  proc GDALOpen*(
    pszFilename: cstring, eAccess: GDALAccess
  ): GDALDatasetH {.gdalCall, importc: "GDALOpen", raises: [].}

  proc GDALOpenShared*(
    a0: cstring, a1: GDALAccess
  ): GDALDatasetH {.gdalCall, importc: "GDALOpenShared", raises: [].}

  proc GDALOpenEx*(
    pszFilename: cstring,
    nOpenFlags: cuint,
    papszAllowedDrivers: cstringArray,
    papszOpenOptions: cstringArray,
    papszSiblingFiles: cstringArray,
  ): GDALDatasetH {.gdalCall, importc: "GDALOpenEx", raises: [].}

  proc GDALDumpOpenDatasets*(
    a0: ptr GdalFile
  ): cint {.gdalCall, importc: "GDALDumpOpenDatasets", raises: [].}

  proc GDALGetDriverByName*(
    a0: cstring
  ): GDALDriverH {.gdalCall, importc: "GDALGetDriverByName", raises: [].}

  proc GDALGetDriverCount*(): cint {.
    gdalCall, importc: "GDALGetDriverCount", raises: []
  .}

  proc GDALGetDriver*(
    a0: cint
  ): GDALDriverH {.gdalCall, importc: "GDALGetDriver", raises: [].}

  proc GDALCreateDriver*(): GDALDriverH {.
    gdalCall, importc: "GDALCreateDriver", raises: []
  .}

  proc GDALDestroyDriver*(
    a0: GDALDriverH
  ) {.gdalCall, importc: "GDALDestroyDriver", raises: [].}

  proc GDALRegisterDriver*(
    a0: GDALDriverH
  ): cint {.gdalCall, importc: "GDALRegisterDriver", raises: [].}

  proc GDALDeregisterDriver*(
    a0: GDALDriverH
  ) {.gdalCall, importc: "GDALDeregisterDriver", raises: [].}

  proc GDALDestroyDriverManager*() {.
    gdalCall, importc: "GDALDestroyDriverManager", raises: []
  .}

  proc GDALClearMemoryCaches*() {.cdecl, importc: "GDALClearMemoryCaches", raises: [].}
  proc GDALDestroy*() {.cdecl, importc: "GDALDestroy", raises: [].}
  proc GDALDeleteDataset*(
    a0: GDALDriverH, a1: cstring
  ): CPLErr {.gdalCall, importc: "GDALDeleteDataset", raises: [].}

  proc GDALRenameDataset*(
    a0: GDALDriverH, pszNewName: cstring, pszOldName: cstring
  ): CPLErr {.gdalCall, importc: "GDALRenameDataset", raises: [].}

  proc GDALCopyDatasetFiles*(
    a0: GDALDriverH, pszNewName: cstring, pszOldName: cstring
  ): CPLErr {.gdalCall, importc: "GDALCopyDatasetFiles", raises: [].}

  proc GDALValidateCreationOptions*(
    a0: GDALDriverH, papszCreationOptions: CSLConstList
  ): cint {.gdalCall, importc: "GDALValidateCreationOptions", raises: [].}

  proc GDALGetOutputDriversForDatasetName*(
    pszDestFilename: cstring,
    nFlagRasterVector: cint,
    bSingleMatch: bool,
    bEmitWarning: bool,
  ): cstringArray {.cdecl, importc: "GDALGetOutputDriversForDatasetName", raises: [].}

  proc GDALDriverHasOpenOption*(
    a0: GDALDriverH, pszOpenOptionName: cstring
  ): bool {.cdecl, importc: "GDALDriverHasOpenOption", raises: [].}

  proc GDALGetDriverShortName*(
    a0: GDALDriverH
  ): cstring {.gdalCall, importc: "GDALGetDriverShortName", raises: [].}

  proc GDALGetDriverLongName*(
    a0: GDALDriverH
  ): cstring {.gdalCall, importc: "GDALGetDriverLongName", raises: [].}

  proc GDALGetDriverHelpTopic*(
    a0: GDALDriverH
  ): cstring {.gdalCall, importc: "GDALGetDriverHelpTopic", raises: [].}

  proc GDALGetDriverCreationOptionList*(
    a0: GDALDriverH
  ): cstring {.gdalCall, importc: "GDALGetDriverCreationOptionList", raises: [].}

  proc GDALInitGCPs*(
    a0: cint, a1: ptr GDAL_GCP
  ) {.gdalCall, importc: "GDALInitGCPs", raises: [].}

  proc GDALDeinitGCPs*(
    a0: cint, a1: ptr GDAL_GCP
  ) {.gdalCall, importc: "GDALDeinitGCPs", raises: [].}

  proc GDALDuplicateGCPs*(
    a0: cint, a1: ptr GDAL_GCP
  ): ptr GDAL_GCP {.gdalCall, importc: "GDALDuplicateGCPs", raises: [].}

  proc GDALGCPsToGeoTransform*(
    nGCPCount: cint,
    pasGCPs: ptr GDAL_GCP,
    padfGeoTransform: ptr cdouble,
    bApproxOK: cint,
  ): cint {.gdalCall, importc: "GDALGCPsToGeoTransform", raises: [].}

  proc GDALInvGeoTransform*(
    padfGeoTransformIn: ptr cdouble, padfInvGeoTransformOut: ptr cdouble
  ): cint {.gdalCall, importc: "GDALInvGeoTransform", raises: [].}

  proc GDALApplyGeoTransform*(
    a0: ptr cdouble, a1: cdouble, a2: cdouble, a3: ptr cdouble, a4: ptr cdouble
  ) {.gdalCall, importc: "GDALApplyGeoTransform", raises: [].}

  proc GDALComposeGeoTransforms*(
    padfGeoTransform1: ptr cdouble,
    padfGeoTransform2: ptr cdouble,
    padfGeoTransformOut: ptr cdouble,
  ) {.cdecl, importc: "GDALComposeGeoTransforms", raises: [].}

  proc GDALGCPsToHomography*(
    nGCPCount: cint, pasGCPs: ptr GDAL_GCP, padfHomography: ptr cdouble
  ): cint {.cdecl, importc: "GDALGCPsToHomography", raises: [].}

  proc GDALInvHomography*(
    padfHomographyIn: ptr cdouble, padfInvHomographyOut: ptr cdouble
  ): cint {.cdecl, importc: "GDALInvHomography", raises: [].}

  proc GDALApplyHomography*(
    a0: ptr cdouble, a1: cdouble, a2: cdouble, a3: ptr cdouble, a4: ptr cdouble
  ): cint {.cdecl, importc: "GDALApplyHomography", raises: [].}

  proc GDALComposeHomographies*(
    padfHomography1: ptr cdouble,
    padfHomography2: ptr cdouble,
    padfHomographyOut: ptr cdouble,
  ) {.cdecl, importc: "GDALComposeHomographies", raises: [].}

  proc GDALGetMetadataDomainList*(
    hObject: GDALMajorObjectH
  ): cstringArray {.gdalCall, importc: "GDALGetMetadataDomainList", raises: [].}

  proc GDALGetMetadata*(
    a0: GDALMajorObjectH, a1: cstring
  ): CSLConstList {.gdalCall, importc: "GDALGetMetadata", raises: [].}

  proc GDALSetMetadata*(
    a0: GDALMajorObjectH, a1: CSLConstList, a2: cstring
  ): CPLErr {.gdalCall, importc: "GDALSetMetadata", raises: [].}

  proc GDALGetMetadataItem*(
    a0: GDALMajorObjectH, a1: cstring, a2: cstring
  ): cstring {.gdalCall, importc: "GDALGetMetadataItem", raises: [].}

  proc GDALSetMetadataItem*(
    a0: GDALMajorObjectH, a1: cstring, a2: cstring, a3: cstring
  ): CPLErr {.gdalCall, importc: "GDALSetMetadataItem", raises: [].}

  proc GDALGetDescription*(
    a0: GDALMajorObjectH
  ): cstring {.gdalCall, importc: "GDALGetDescription", raises: [].}

  proc GDALSetDescription*(
    a0: GDALMajorObjectH, a1: cstring
  ) {.gdalCall, importc: "GDALSetDescription", raises: [].}

  proc GDALGetDatasetDriver*(
    a0: GDALDatasetH
  ): GDALDriverH {.gdalCall, importc: "GDALGetDatasetDriver", raises: [].}

  proc GDALGetFileList*(
    a0: GDALDatasetH
  ): cstringArray {.gdalCall, importc: "GDALGetFileList", raises: [].}

  proc GDALDatasetMarkSuppressOnClose*(
    a0: GDALDatasetH
  ) {.cdecl, importc: "GDALDatasetMarkSuppressOnClose", raises: [].}

  proc GDALClose*(
    a0: GDALDatasetH
  ): CPLErr {.gdalCall, importc: "GDALClose", raises: [].}

  proc GDALCloseEx*(
    hDS: GDALDatasetH, pfnProgress: GDALProgressFunc, pProgressData: pointer
  ): CPLErr {.cdecl, importc: "GDALCloseEx", raises: [].}

  proc GDALDatasetGetCloseReportsProgress*(
    hDS: GDALDatasetH
  ): bool {.cdecl, importc: "GDALDatasetGetCloseReportsProgress", raises: [].}

  proc GDALDatasetRunCloseWithoutDestroying*(
    hDS: GDALDatasetH
  ): CPLErr {.cdecl, importc: "GDALDatasetRunCloseWithoutDestroying", raises: [].}

  proc GDALDatasetRunCloseWithoutDestroyingEx*(
    hDS: GDALDatasetH, pfnProgress: GDALProgressFunc, pProgressData: pointer
  ): CPLErr {.cdecl, importc: "GDALDatasetRunCloseWithoutDestroyingEx", raises: [].}

  proc GDALGetRasterXSize*(
    a0: GDALDatasetH
  ): cint {.gdalCall, importc: "GDALGetRasterXSize", raises: [].}

  proc GDALGetRasterYSize*(
    a0: GDALDatasetH
  ): cint {.gdalCall, importc: "GDALGetRasterYSize", raises: [].}

  proc GDALGetRasterCount*(
    a0: GDALDatasetH
  ): cint {.gdalCall, importc: "GDALGetRasterCount", raises: [].}

  proc GDALGetRasterBand*(
    a0: GDALDatasetH, a1: cint
  ): GDALRasterBandH {.gdalCall, importc: "GDALGetRasterBand", raises: [].}

  proc GDALDatasetIsThreadSafe*(
    a0: GDALDatasetH, nScopeFlags: cint, papszOptions: CSLConstList
  ): bool {.cdecl, importc: "GDALDatasetIsThreadSafe", raises: [].}

  proc GDALGetThreadSafeDataset*(
    a0: GDALDatasetH, nScopeFlags: cint, papszOptions: CSLConstList
  ): GDALDatasetH {.cdecl, importc: "GDALGetThreadSafeDataset", raises: [].}

  proc GDALAddBand*(
    hDS: GDALDatasetH, eType: GDALDataType, papszOptions: CSLConstList
  ): CPLErr {.gdalCall, importc: "GDALAddBand", raises: [].}

  proc GDALBeginAsyncReader*(
    hDS: GDALDatasetH,
    nXOff: cint,
    nYOff: cint,
    nXSize: cint,
    nYSize: cint,
    pBuf: pointer,
    nBufXSize: cint,
    nBufYSize: cint,
    eBufType: GDALDataType,
    nBandCount: cint,
    panBandMap: ptr cint,
    nPixelSpace: cint,
    nLineSpace: cint,
    nBandSpace: cint,
    papszOptions: CSLConstList,
  ): GDALAsyncReaderH {.gdalCall, importc: "GDALBeginAsyncReader", raises: [].}

  proc GDALEndAsyncReader*(
    hDS: GDALDatasetH, hAsynchReaderH: GDALAsyncReaderH
  ) {.gdalCall, importc: "GDALEndAsyncReader", raises: [].}

  proc GDALDatasetRasterIO*(
    hDS: GDALDatasetH,
    eRWFlag: GDALRWFlag,
    nDSXOff: cint,
    nDSYOff: cint,
    nDSXSize: cint,
    nDSYSize: cint,
    pBuffer: pointer,
    nBXSize: cint,
    nBYSize: cint,
    eBDataType: GDALDataType,
    nBandCount: cint,
    panBandCount: ptr cint,
    nPixelSpace: cint,
    nLineSpace: cint,
    nBandSpace: cint,
  ): CPLErr {.gdalCall, importc: "GDALDatasetRasterIO", raises: [].}

  proc GDALDatasetRasterIOEx*(
    hDS: GDALDatasetH,
    eRWFlag: GDALRWFlag,
    nDSXOff: cint,
    nDSYOff: cint,
    nDSXSize: cint,
    nDSYSize: cint,
    pBuffer: pointer,
    nBXSize: cint,
    nBYSize: cint,
    eBDataType: GDALDataType,
    nBandCount: cint,
    panBandCount: ptr cint,
    nPixelSpace: GSpacing,
    nLineSpace: GSpacing,
    nBandSpace: GSpacing,
    psExtraArg: ptr GDALRasterIOExtraArg,
  ): CPLErr {.gdalCall, importc: "GDALDatasetRasterIOEx", raises: [].}

  proc GDALDatasetAdviseRead*(
    hDS: GDALDatasetH,
    nDSXOff: cint,
    nDSYOff: cint,
    nDSXSize: cint,
    nDSYSize: cint,
    nBXSize: cint,
    nBYSize: cint,
    eBDataType: GDALDataType,
    nBandCount: cint,
    panBandCount: ptr cint,
    papszOptions: CSLConstList,
  ): CPLErr {.gdalCall, importc: "GDALDatasetAdviseRead", raises: [].}

  proc GDALDatasetGetCompressionFormats*(
    hDS: GDALDatasetH,
    nXOff: cint,
    nYOff: cint,
    nXSize: cint,
    nYSize: cint,
    nBandCount: cint,
    panBandList: ptr cint,
  ): cstringArray {.cdecl, importc: "GDALDatasetGetCompressionFormats", raises: [].}

  proc GDALDatasetReadCompressedData*(
    hDS: GDALDatasetH,
    pszFormat: cstring,
    nXOff: cint,
    nYOff: cint,
    nXSize: cint,
    nYSize: cint,
    nBandCount: cint,
    panBandList: ptr cint,
    ppBuffer: ptr pointer,
    pnBufferSize: ptr csize_t,
    ppszDetailedFormat: cstringArray,
  ): CPLErr {.cdecl, importc: "GDALDatasetReadCompressedData", raises: [].}

  proc GDALGetProjectionRef*(
    a0: GDALDatasetH
  ): cstring {.gdalCall, importc: "GDALGetProjectionRef", raises: [].}

  proc GDALGetSpatialRef*(
    a0: GDALDatasetH
  ): OGRSpatialReferenceH {.cdecl, importc: "GDALGetSpatialRef", raises: [].}

  proc GDALSetProjection*(
    a0: GDALDatasetH, a1: cstring
  ): CPLErr {.gdalCall, importc: "GDALSetProjection", raises: [].}

  proc GDALSetSpatialRef*(
    a0: GDALDatasetH, a1: OGRSpatialReferenceH
  ): CPLErr {.cdecl, importc: "GDALSetSpatialRef", raises: [].}

  proc GDALGetGeoTransform*(
    a0: GDALDatasetH, a1: ptr cdouble
  ): CPLErr {.gdalCall, importc: "GDALGetGeoTransform", raises: [].}

  proc GDALSetGeoTransform*(
    a0: GDALDatasetH, a1: ptr cdouble
  ): CPLErr {.gdalCall, importc: "GDALSetGeoTransform", raises: [].}

  proc GDALGetExtent*(
    a0: GDALDatasetH, a1: ptr OGREnvelope, hCRS: OGRSpatialReferenceH
  ): CPLErr {.cdecl, importc: "GDALGetExtent", raises: [].}

  proc GDALGetExtentWGS84LongLat*(
    a0: GDALDatasetH, a1: ptr OGREnvelope
  ): CPLErr {.cdecl, importc: "GDALGetExtentWGS84LongLat", raises: [].}

  proc GDALDatasetGeolocationToPixelLine*(
    a0: GDALDatasetH,
    dfGeolocX: cdouble,
    dfGeolocY: cdouble,
    hSRS: OGRSpatialReferenceH,
    pdfPixel: ptr cdouble,
    pdfLine: ptr cdouble,
    papszTransformerOptions: CSLConstList,
  ): CPLErr {.cdecl, importc: "GDALDatasetGeolocationToPixelLine", raises: [].}

  proc GDALDatasetGetInterBandCovarianceMatrix*(
    hDS: GDALDatasetH,
    padfCovMatrix: ptr cdouble,
    nSize: csize_t,
    nBandCount: cint,
    panBandList: ptr cint,
    bApproxOK: bool,
    bForce: bool,
    bWriteIntoMetadata: bool,
    nDeltaDegreeOfFreedom: cint,
    pfnProgress: GDALProgressFunc,
    pProgressData: pointer,
  ): CPLErr {.cdecl, importc: "GDALDatasetGetInterBandCovarianceMatrix", raises: [].}

  proc GDALDatasetComputeInterBandCovarianceMatrix*(
    hDS: GDALDatasetH,
    padfCovMatrix: ptr cdouble,
    nSize: csize_t,
    nBandCount: cint,
    panBandList: ptr cint,
    bApproxOK: bool,
    bWriteIntoMetadata: bool,
    nDeltaDegreeOfFreedom: cint,
    pfnProgress: GDALProgressFunc,
    pProgressData: pointer,
  ): CPLErr {.
    cdecl, importc: "GDALDatasetComputeInterBandCovarianceMatrix", raises: []
  .}

  proc GDALGetGCPCount*(
    a0: GDALDatasetH
  ): cint {.gdalCall, importc: "GDALGetGCPCount", raises: [].}

  proc GDALGetGCPProjection*(
    a0: GDALDatasetH
  ): cstring {.gdalCall, importc: "GDALGetGCPProjection", raises: [].}

  proc GDALGetGCPSpatialRef*(
    a0: GDALDatasetH
  ): OGRSpatialReferenceH {.cdecl, importc: "GDALGetGCPSpatialRef", raises: [].}

  proc GDALGetGCPs*(
    a0: GDALDatasetH
  ): ptr GDAL_GCP {.gdalCall, importc: "GDALGetGCPs", raises: [].}

  proc GDALSetGCPs*(
    a0: GDALDatasetH, a1: cint, a2: ptr GDAL_GCP, a3: cstring
  ): CPLErr {.gdalCall, importc: "GDALSetGCPs", raises: [].}

  proc GDALSetGCPs2*(
    a0: GDALDatasetH, a1: cint, a2: ptr GDAL_GCP, a3: OGRSpatialReferenceH
  ): CPLErr {.cdecl, importc: "GDALSetGCPs2", raises: [].}

  proc GDALGetInternalHandle*(
    a0: GDALDatasetH, a1: cstring
  ): pointer {.gdalCall, importc: "GDALGetInternalHandle", raises: [].}

  proc GDALReferenceDataset*(
    a0: GDALDatasetH
  ): cint {.gdalCall, importc: "GDALReferenceDataset", raises: [].}

  proc GDALDereferenceDataset*(
    a0: GDALDatasetH
  ): cint {.gdalCall, importc: "GDALDereferenceDataset", raises: [].}

  proc GDALReleaseDataset*(
    a0: GDALDatasetH
  ): cint {.gdalCall, importc: "GDALReleaseDataset", raises: [].}

  proc GDALBuildOverviews*(
    a0: GDALDatasetH,
    a1: cstring,
    a2: cint,
    a3: ptr cint,
    a4: cint,
    a5: ptr cint,
    a6: GDALProgressFunc,
    a7: pointer,
  ): CPLErr {.gdalCall, importc: "GDALBuildOverviews", raises: [].}

  proc GDALBuildOverviewsEx*(
    a0: GDALDatasetH,
    a1: cstring,
    a2: cint,
    a3: ptr cint,
    a4: cint,
    a5: ptr cint,
    a6: GDALProgressFunc,
    a7: pointer,
    papszOptions: CSLConstList,
  ): CPLErr {.gdalCall, importc: "GDALBuildOverviewsEx", raises: [].}

  proc GDALGetOpenDatasets*(
    hDS: ptr ptr GDALDatasetH, pnCount: ptr cint
  ) {.gdalCall, importc: "GDALGetOpenDatasets", raises: [].}

  proc GDALGetAccess*(
    hDS: GDALDatasetH
  ): cint {.gdalCall, importc: "GDALGetAccess", raises: [].}

  proc GDALFlushCache*(
    hDS: GDALDatasetH
  ): CPLErr {.gdalCall, importc: "GDALFlushCache", raises: [].}

  proc GDALDropCache*(
    hDS: GDALDatasetH
  ): CPLErr {.gdalCall, importc: "GDALDropCache", raises: [].}

  proc GDALCreateDatasetMaskBand*(
    hDS: GDALDatasetH, nFlags: cint
  ): CPLErr {.gdalCall, importc: "GDALCreateDatasetMaskBand", raises: [].}

  proc GDALDatasetCopyWholeRaster*(
    hSrcDS: GDALDatasetH,
    hDstDS: GDALDatasetH,
    papszOptions: CSLConstList,
    pfnProgress: GDALProgressFunc,
    pProgressData: pointer,
  ): CPLErr {.gdalCall, importc: "GDALDatasetCopyWholeRaster", raises: [].}

  proc GDALRasterBandCopyWholeRaster*(
    hSrcBand: GDALRasterBandH,
    hDstBand: GDALRasterBandH,
    constpapszOptions: cstringArray,
    pfnProgress: GDALProgressFunc,
    pProgressData: pointer,
  ): CPLErr {.gdalCall, importc: "GDALRasterBandCopyWholeRaster", raises: [].}

  proc GDALRegenerateOverviews*(
    hSrcBand: GDALRasterBandH,
    nOverviewCount: cint,
    pahOverviewBands: ptr GDALRasterBandH,
    pszResampling: cstring,
    pfnProgress: GDALProgressFunc,
    pProgressData: pointer,
  ): CPLErr {.cdecl, importc: "GDALRegenerateOverviews", raises: [].}

  proc GDALRegenerateOverviewsEx*(
    hSrcBand: GDALRasterBandH,
    nOverviewCount: cint,
    pahOverviewBands: ptr GDALRasterBandH,
    pszResampling: cstring,
    pfnProgress: GDALProgressFunc,
    pProgressData: pointer,
    papszOptions: CSLConstList,
  ): CPLErr {.cdecl, importc: "GDALRegenerateOverviewsEx", raises: [].}

  proc GDALDatasetGetLayerCount*(
    a0: GDALDatasetH
  ): cint {.cdecl, importc: "GDALDatasetGetLayerCount", raises: [].}

  proc GDALDatasetGetLayer*(
    a0: GDALDatasetH, a1: cint
  ): OGRLayerH {.cdecl, importc: "GDALDatasetGetLayer", raises: [].}

  proc OGR_L_GetDataset*(
    hLayer: OGRLayerH
  ): GDALDatasetH {.cdecl, importc: "OGR_L_GetDataset", raises: [].}

  proc GDALDatasetGetLayerByName*(
    a0: GDALDatasetH, a1: cstring
  ): OGRLayerH {.cdecl, importc: "GDALDatasetGetLayerByName", raises: [].}

  proc GDALDatasetIsLayerPrivate*(
    a0: GDALDatasetH, a1: cint
  ): cint {.cdecl, importc: "GDALDatasetIsLayerPrivate", raises: [].}

  proc GDALDatasetDeleteLayer*(
    a0: GDALDatasetH, a1: cint
  ): OGRErr {.cdecl, importc: "GDALDatasetDeleteLayer", raises: [].}

  proc GDALDatasetCreateLayer*(
    a0: GDALDatasetH,
    a1: cstring,
    a2: OGRSpatialReferenceH,
    a3: OGRwkbGeometryType,
    a4: CSLConstList,
  ): OGRLayerH {.cdecl, importc: "GDALDatasetCreateLayer", raises: [].}

  proc GDALDatasetCreateLayerFromGeomFieldDefn*(
    a0: GDALDatasetH, a1: cstring, a2: OGRGeomFieldDefnH, a3: CSLConstList
  ): OGRLayerH {.cdecl, importc: "GDALDatasetCreateLayerFromGeomFieldDefn", raises: [].}

  proc GDALDatasetCopyLayer*(
    a0: GDALDatasetH, a1: OGRLayerH, a2: cstring, a3: CSLConstList
  ): OGRLayerH {.cdecl, importc: "GDALDatasetCopyLayer", raises: [].}

  proc GDALDatasetResetReading*(
    a0: GDALDatasetH
  ) {.cdecl, importc: "GDALDatasetResetReading", raises: [].}

  proc GDALDatasetGetNextFeature*(
    hDS: GDALDatasetH,
    phBelongingLayer: ptr OGRLayerH,
    pdfProgressPct: ptr cdouble,
    pfnProgress: GDALProgressFunc,
    pProgressData: pointer,
  ): OGRFeatureH {.cdecl, importc: "GDALDatasetGetNextFeature", raises: [].}

  proc GDALDatasetTestCapability*(
    a0: GDALDatasetH, a1: cstring
  ): cint {.cdecl, importc: "GDALDatasetTestCapability", raises: [].}

  proc GDALDatasetExecuteSQL*(
    a0: GDALDatasetH, a1: cstring, a2: OGRGeometryH, a3: cstring
  ): OGRLayerH {.cdecl, importc: "GDALDatasetExecuteSQL", raises: [].}

  proc GDALDatasetAbortSQL*(
    a0: GDALDatasetH
  ): OGRErr {.cdecl, importc: "GDALDatasetAbortSQL", raises: [].}

  proc GDALDatasetReleaseResultSet*(
    a0: GDALDatasetH, a1: OGRLayerH
  ) {.cdecl, importc: "GDALDatasetReleaseResultSet", raises: [].}

  proc GDALDatasetGetStyleTable*(
    a0: GDALDatasetH
  ): OGRStyleTableH {.cdecl, importc: "GDALDatasetGetStyleTable", raises: [].}

  proc GDALDatasetSetStyleTableDirectly*(
    a0: GDALDatasetH, a1: OGRStyleTableH
  ) {.cdecl, importc: "GDALDatasetSetStyleTableDirectly", raises: [].}

  proc GDALDatasetSetStyleTable*(
    a0: GDALDatasetH, a1: OGRStyleTableH
  ) {.cdecl, importc: "GDALDatasetSetStyleTable", raises: [].}

  proc GDALDatasetStartTransaction*(
    hDS: GDALDatasetH, bForce: cint
  ): OGRErr {.cdecl, importc: "GDALDatasetStartTransaction", raises: [].}

  proc GDALDatasetCommitTransaction*(
    hDS: GDALDatasetH
  ): OGRErr {.cdecl, importc: "GDALDatasetCommitTransaction", raises: [].}

  proc GDALDatasetRollbackTransaction*(
    hDS: GDALDatasetH
  ): OGRErr {.cdecl, importc: "GDALDatasetRollbackTransaction", raises: [].}

  proc GDALDatasetClearStatistics*(
    hDS: GDALDatasetH
  ) {.cdecl, importc: "GDALDatasetClearStatistics", raises: [].}

  proc GDALDatasetAsMDArray*(
    hDS: GDALDatasetH, papszOptions: CSLConstList
  ): GDALMDArrayH {.cdecl, importc: "GDALDatasetAsMDArray", raises: [].}

  proc GDALDatasetGetFieldDomainNames*(
    a0: GDALDatasetH, a1: CSLConstList
  ): cstringArray {.cdecl, importc: "GDALDatasetGetFieldDomainNames", raises: [].}

  proc GDALDatasetGetFieldDomain*(
    hDS: GDALDatasetH, pszName: cstring
  ): OGRFieldDomainH {.cdecl, importc: "GDALDatasetGetFieldDomain", raises: [].}

  proc GDALDatasetAddFieldDomain*(
    hDS: GDALDatasetH, hFieldDomain: OGRFieldDomainH, ppszFailureReason: cstringArray
  ): bool {.cdecl, importc: "GDALDatasetAddFieldDomain", raises: [].}

  proc GDALDatasetDeleteFieldDomain*(
    hDS: GDALDatasetH, pszName: cstring, ppszFailureReason: cstringArray
  ): bool {.cdecl, importc: "GDALDatasetDeleteFieldDomain", raises: [].}

  proc GDALDatasetUpdateFieldDomain*(
    hDS: GDALDatasetH, hFieldDomain: OGRFieldDomainH, ppszFailureReason: cstringArray
  ): bool {.cdecl, importc: "GDALDatasetUpdateFieldDomain", raises: [].}

  proc GDALDatasetGetRelationshipNames*(
    a0: GDALDatasetH, a1: CSLConstList
  ): cstringArray {.cdecl, importc: "GDALDatasetGetRelationshipNames", raises: [].}

  proc GDALDatasetGetRelationship*(
    hDS: GDALDatasetH, pszName: cstring
  ): GDALRelationshipH {.cdecl, importc: "GDALDatasetGetRelationship", raises: [].}

  proc GDALDatasetAddRelationship*(
    hDS: GDALDatasetH, hRelationship: GDALRelationshipH, ppszFailureReason: cstringArray
  ): bool {.cdecl, importc: "GDALDatasetAddRelationship", raises: [].}

  proc GDALDatasetDeleteRelationship*(
    hDS: GDALDatasetH, pszName: cstring, ppszFailureReason: cstringArray
  ): bool {.cdecl, importc: "GDALDatasetDeleteRelationship", raises: [].}

  proc GDALDatasetUpdateRelationship*(
    hDS: GDALDatasetH, hRelationship: GDALRelationshipH, ppszFailureReason: cstringArray
  ): bool {.cdecl, importc: "GDALDatasetUpdateRelationship", raises: [].}

  proc GDALDatasetSetQueryLoggerFunc*(
    hDS: GDALDatasetH,
    pfnQueryLoggerFunc: GDALQueryLoggerFunc,
    poQueryLoggerArg: pointer,
  ): bool {.cdecl, importc: "GDALDatasetSetQueryLoggerFunc", raises: [].}

  proc GDALGetSubdatasetInfo*(
    pszFileName: cstring
  ): GDALSubdatasetInfoH {.cdecl, importc: "GDALGetSubdatasetInfo", raises: [].}

  proc GDALSubdatasetInfoGetPathComponent*(
    hInfo: GDALSubdatasetInfoH
  ): cstring {.cdecl, importc: "GDALSubdatasetInfoGetPathComponent", raises: [].}

  proc GDALSubdatasetInfoGetSubdatasetComponent*(
    hInfo: GDALSubdatasetInfoH
  ): cstring {.cdecl, importc: "GDALSubdatasetInfoGetSubdatasetComponent", raises: [].}

  proc GDALSubdatasetInfoModifyPathComponent*(
    hInfo: GDALSubdatasetInfoH, pszNewPath: cstring
  ): cstring {.cdecl, importc: "GDALSubdatasetInfoModifyPathComponent", raises: [].}

  proc GDALDestroySubdatasetInfo*(
    hInfo: GDALSubdatasetInfoH
  ) {.cdecl, importc: "GDALDestroySubdatasetInfo", raises: [].}

  proc GDALGetRasterDataType*(
    a0: GDALRasterBandH
  ): GDALDataType {.gdalCall, importc: "GDALGetRasterDataType", raises: [].}

  proc GDALGetBlockSize*(
    a0: GDALRasterBandH, pnXSize: ptr cint, pnYSize: ptr cint
  ) {.gdalCall, importc: "GDALGetBlockSize", raises: [].}

  proc GDALGetActualBlockSize*(
    a0: GDALRasterBandH,
    nXBlockOff: cint,
    nYBlockOff: cint,
    pnXValid: ptr cint,
    pnYValid: ptr cint,
  ): CPLErr {.gdalCall, importc: "GDALGetActualBlockSize", raises: [].}

  proc GDALRasterAdviseRead*(
    hRB: GDALRasterBandH,
    nDSXOff: cint,
    nDSYOff: cint,
    nDSXSize: cint,
    nDSYSize: cint,
    nBXSize: cint,
    nBYSize: cint,
    eBDataType: GDALDataType,
    papszOptions: CSLConstList,
  ): CPLErr {.gdalCall, importc: "GDALRasterAdviseRead", raises: [].}

  proc GDALRasterIO*(
    hRBand: GDALRasterBandH,
    eRWFlag: GDALRWFlag,
    nDSXOff: cint,
    nDSYOff: cint,
    nDSXSize: cint,
    nDSYSize: cint,
    pBuffer: pointer,
    nBXSize: cint,
    nBYSize: cint,
    eBDataType: GDALDataType,
    nPixelSpace: cint,
    nLineSpace: cint,
  ): CPLErr {.gdalCall, importc: "GDALRasterIO", raises: [].}

  proc GDALRasterIOEx*(
    hRBand: GDALRasterBandH,
    eRWFlag: GDALRWFlag,
    nDSXOff: cint,
    nDSYOff: cint,
    nDSXSize: cint,
    nDSYSize: cint,
    pBuffer: pointer,
    nBXSize: cint,
    nBYSize: cint,
    eBDataType: GDALDataType,
    nPixelSpace: GSpacing,
    nLineSpace: GSpacing,
    psExtraArg: ptr GDALRasterIOExtraArg,
  ): CPLErr {.gdalCall, importc: "GDALRasterIOEx", raises: [].}

  proc GDALReadBlock*(
    a0: GDALRasterBandH, a1: cint, a2: cint, a3: pointer
  ): CPLErr {.gdalCall, importc: "GDALReadBlock", raises: [].}

  proc GDALWriteBlock*(
    a0: GDALRasterBandH, a1: cint, a2: cint, a3: pointer
  ): CPLErr {.gdalCall, importc: "GDALWriteBlock", raises: [].}

  proc GDALGetRasterBandXSize*(
    a0: GDALRasterBandH
  ): cint {.gdalCall, importc: "GDALGetRasterBandXSize", raises: [].}

  proc GDALGetRasterBandYSize*(
    a0: GDALRasterBandH
  ): cint {.gdalCall, importc: "GDALGetRasterBandYSize", raises: [].}

  proc GDALGetRasterAccess*(
    a0: GDALRasterBandH
  ): GDALAccess {.gdalCall, importc: "GDALGetRasterAccess", raises: [].}

  proc GDALGetBandNumber*(
    a0: GDALRasterBandH
  ): cint {.gdalCall, importc: "GDALGetBandNumber", raises: [].}

  proc GDALGetBandDataset*(
    a0: GDALRasterBandH
  ): GDALDatasetH {.gdalCall, importc: "GDALGetBandDataset", raises: [].}

  proc GDALGetRasterColorInterpretation*(
    a0: GDALRasterBandH
  ): GDALColorInterp {.
    gdalCall, importc: "GDALGetRasterColorInterpretation", raises: []
  .}

  proc GDALSetRasterColorInterpretation*(
    a0: GDALRasterBandH, a1: GDALColorInterp
  ): CPLErr {.gdalCall, importc: "GDALSetRasterColorInterpretation", raises: [].}

  proc GDALGetRasterColorTable*(
    a0: GDALRasterBandH
  ): GDALColorTableH {.gdalCall, importc: "GDALGetRasterColorTable", raises: [].}

  proc GDALSetRasterColorTable*(
    a0: GDALRasterBandH, a1: GDALColorTableH
  ): CPLErr {.gdalCall, importc: "GDALSetRasterColorTable", raises: [].}

  proc GDALHasArbitraryOverviews*(
    a0: GDALRasterBandH
  ): cint {.gdalCall, importc: "GDALHasArbitraryOverviews", raises: [].}

  proc GDALGetOverviewCount*(
    a0: GDALRasterBandH
  ): cint {.gdalCall, importc: "GDALGetOverviewCount", raises: [].}

  proc GDALGetOverview*(
    a0: GDALRasterBandH, a1: cint
  ): GDALRasterBandH {.gdalCall, importc: "GDALGetOverview", raises: [].}

  proc GDALGetRasterNoDataValue*(
    a0: GDALRasterBandH, a1: ptr cint
  ): cdouble {.gdalCall, importc: "GDALGetRasterNoDataValue", raises: [].}

  proc GDALGetRasterNoDataValueAsInt64*(
    a0: GDALRasterBandH, a1: ptr cint
  ): int64 {.gdalCall, importc: "GDALGetRasterNoDataValueAsInt64", raises: [].}

  proc GDALGetRasterNoDataValueAsUInt64*(
    a0: GDALRasterBandH, a1: ptr cint
  ): uint64 {.gdalCall, importc: "GDALGetRasterNoDataValueAsUInt64", raises: [].}

  proc GDALSetRasterNoDataValue*(
    a0: GDALRasterBandH, a1: cdouble
  ): CPLErr {.gdalCall, importc: "GDALSetRasterNoDataValue", raises: [].}

  proc GDALSetRasterNoDataValueAsInt64*(
    a0: GDALRasterBandH, a1: int64
  ): CPLErr {.gdalCall, importc: "GDALSetRasterNoDataValueAsInt64", raises: [].}

  proc GDALSetRasterNoDataValueAsUInt64*(
    a0: GDALRasterBandH, a1: uint64
  ): CPLErr {.gdalCall, importc: "GDALSetRasterNoDataValueAsUInt64", raises: [].}

  proc GDALDeleteRasterNoDataValue*(
    a0: GDALRasterBandH
  ): CPLErr {.gdalCall, importc: "GDALDeleteRasterNoDataValue", raises: [].}

  proc GDALGetRasterCategoryNames*(
    a0: GDALRasterBandH
  ): cstringArray {.gdalCall, importc: "GDALGetRasterCategoryNames", raises: [].}

  proc GDALSetRasterCategoryNames*(
    a0: GDALRasterBandH, a1: CSLConstList
  ): CPLErr {.gdalCall, importc: "GDALSetRasterCategoryNames", raises: [].}

  proc GDALGetRasterMinimum*(
    a0: GDALRasterBandH, pbSuccess: ptr cint
  ): cdouble {.gdalCall, importc: "GDALGetRasterMinimum", raises: [].}

  proc GDALGetRasterMaximum*(
    a0: GDALRasterBandH, pbSuccess: ptr cint
  ): cdouble {.gdalCall, importc: "GDALGetRasterMaximum", raises: [].}

  proc GDALGetRasterStatistics*(
    a0: GDALRasterBandH,
    bApproxOK: cint,
    bForce: cint,
    pdfMin: ptr cdouble,
    pdfMax: ptr cdouble,
    pdfMean: ptr cdouble,
    pdfStdDev: ptr cdouble,
  ): CPLErr {.gdalCall, importc: "GDALGetRasterStatistics", raises: [].}

  proc GDALComputeRasterStatistics*(
    a0: GDALRasterBandH,
    bApproxOK: cint,
    pdfMin: ptr cdouble,
    pdfMax: ptr cdouble,
    pdfMean: ptr cdouble,
    pdfStdDev: ptr cdouble,
    pfnProgress: GDALProgressFunc,
    pProgressData: pointer,
  ): CPLErr {.gdalCall, importc: "GDALComputeRasterStatistics", raises: [].}

  proc GDALSetRasterStatistics*(
    hBand: GDALRasterBandH,
    dfMin: cdouble,
    dfMax: cdouble,
    dfMean: cdouble,
    dfStdDev: cdouble,
  ): CPLErr {.gdalCall, importc: "GDALSetRasterStatistics", raises: [].}

  proc GDALRasterBandAsMDArray*(
    a0: GDALRasterBandH
  ): GDALMDArrayH {.cdecl, importc: "GDALRasterBandAsMDArray", raises: [].}

  proc GDALGetRasterUnitType*(
    a0: GDALRasterBandH
  ): cstring {.gdalCall, importc: "GDALGetRasterUnitType", raises: [].}

  proc GDALSetRasterUnitType*(
    hBand: GDALRasterBandH, pszNewValue: cstring
  ): CPLErr {.gdalCall, importc: "GDALSetRasterUnitType", raises: [].}

  proc GDALGetRasterOffset*(
    a0: GDALRasterBandH, pbSuccess: ptr cint
  ): cdouble {.gdalCall, importc: "GDALGetRasterOffset", raises: [].}

  proc GDALSetRasterOffset*(
    hBand: GDALRasterBandH, dfNewOffset: cdouble
  ): CPLErr {.gdalCall, importc: "GDALSetRasterOffset", raises: [].}

  proc GDALGetRasterScale*(
    a0: GDALRasterBandH, pbSuccess: ptr cint
  ): cdouble {.gdalCall, importc: "GDALGetRasterScale", raises: [].}

  proc GDALSetRasterScale*(
    hBand: GDALRasterBandH, dfNewOffset: cdouble
  ): CPLErr {.gdalCall, importc: "GDALSetRasterScale", raises: [].}

  proc GDALComputeRasterMinMax*(
    hBand: GDALRasterBandH, bApproxOK: cint, adfMinMax: ptr cdouble
  ): CPLErr {.gdalCall, importc: "GDALComputeRasterMinMax", raises: [].}

  proc GDALComputeRasterMinMaxLocation*(
    hBand: GDALRasterBandH,
    pdfMin: ptr cdouble,
    pdfMax: ptr cdouble,
    pnMinX: ptr cint,
    pnMinY: ptr cint,
    pnMaxX: ptr cint,
    pnMaxY: ptr cint,
  ): CPLErr {.cdecl, importc: "GDALComputeRasterMinMaxLocation", raises: [].}

  proc GDALFlushRasterCache*(
    hBand: GDALRasterBandH
  ): CPLErr {.gdalCall, importc: "GDALFlushRasterCache", raises: [].}

  proc GDALDropRasterCache*(
    hBand: GDALRasterBandH
  ): CPLErr {.gdalCall, importc: "GDALDropRasterCache", raises: [].}

  proc GDALGetRasterHistogram*(
    hBand: GDALRasterBandH,
    dfMin: cdouble,
    dfMax: cdouble,
    nBuckets: cint,
    panHistogram: ptr cint,
    bIncludeOutOfRange: cint,
    bApproxOK: cint,
    pfnProgress: GDALProgressFunc,
    pProgressData: pointer,
  ): CPLErr {.gdalCall, importc: "GDALGetRasterHistogram", raises: [].}

  proc GDALGetRasterHistogramEx*(
    hBand: GDALRasterBandH,
    dfMin: cdouble,
    dfMax: cdouble,
    nBuckets: cint,
    panHistogram: ptr GUIntBig,
    bIncludeOutOfRange: cint,
    bApproxOK: cint,
    pfnProgress: GDALProgressFunc,
    pProgressData: pointer,
  ): CPLErr {.gdalCall, importc: "GDALGetRasterHistogramEx", raises: [].}

  proc GDALGetDefaultHistogram*(
    hBand: GDALRasterBandH,
    pdfMin: ptr cdouble,
    pdfMax: ptr cdouble,
    pnBuckets: ptr cint,
    ppanHistogram: ptr ptr cint,
    bForce: cint,
    pfnProgress: GDALProgressFunc,
    pProgressData: pointer,
  ): CPLErr {.gdalCall, importc: "GDALGetDefaultHistogram", raises: [].}

  proc GDALGetDefaultHistogramEx*(
    hBand: GDALRasterBandH,
    pdfMin: ptr cdouble,
    pdfMax: ptr cdouble,
    pnBuckets: ptr cint,
    ppanHistogram: ptr ptr GUIntBig,
    bForce: cint,
    pfnProgress: GDALProgressFunc,
    pProgressData: pointer,
  ): CPLErr {.gdalCall, importc: "GDALGetDefaultHistogramEx", raises: [].}

  proc GDALSetDefaultHistogram*(
    hBand: GDALRasterBandH,
    dfMin: cdouble,
    dfMax: cdouble,
    nBuckets: cint,
    panHistogram: ptr cint,
  ): CPLErr {.gdalCall, importc: "GDALSetDefaultHistogram", raises: [].}

  proc GDALSetDefaultHistogramEx*(
    hBand: GDALRasterBandH,
    dfMin: cdouble,
    dfMax: cdouble,
    nBuckets: cint,
    panHistogram: ptr GUIntBig,
  ): CPLErr {.gdalCall, importc: "GDALSetDefaultHistogramEx", raises: [].}

  proc GDALGetRandomRasterSample*(
    a0: GDALRasterBandH, a1: cint, a2: ptr cfloat
  ): cint {.gdalCall, importc: "GDALGetRandomRasterSample", raises: [].}

  proc GDALGetRasterSampleOverview*(
    a0: GDALRasterBandH, a1: cint
  ): GDALRasterBandH {.gdalCall, importc: "GDALGetRasterSampleOverview", raises: [].}

  proc GDALGetRasterSampleOverviewEx*(
    a0: GDALRasterBandH, a1: GUIntBig
  ): GDALRasterBandH {.gdalCall, importc: "GDALGetRasterSampleOverviewEx", raises: [].}

  proc GDALFillRaster*(
    hBand: GDALRasterBandH, dfRealValue: cdouble, dfImaginaryValue: cdouble
  ): CPLErr {.gdalCall, importc: "GDALFillRaster", raises: [].}

  proc GDALComputeBandStats*(
    hBand: GDALRasterBandH,
    nSampleStep: cint,
    pdfMean: ptr cdouble,
    pdfStdDev: ptr cdouble,
    pfnProgress: GDALProgressFunc,
    pProgressData: pointer,
  ): CPLErr {.gdalCall, importc: "GDALComputeBandStats", raises: [].}

  proc GDALOverviewMagnitudeCorrection*(
    hBaseBand: GDALRasterBandH,
    nOverviewCount: cint,
    pahOverviews: ptr GDALRasterBandH,
    pfnProgress: GDALProgressFunc,
    pProgressData: pointer,
  ): CPLErr {.cdecl, importc: "GDALOverviewMagnitudeCorrection", raises: [].}

  proc GDALGetDefaultRAT*(
    hBand: GDALRasterBandH
  ): GDALRasterAttributeTableH {.gdalCall, importc: "GDALGetDefaultRAT", raises: [].}

  proc GDALSetDefaultRAT*(
    a0: GDALRasterBandH, a1: GDALRasterAttributeTableH
  ): CPLErr {.gdalCall, importc: "GDALSetDefaultRAT", raises: [].}

  proc GDALAddDerivedBandPixelFunc*(
    pszName: cstring, pfnPixelFunc: GDALDerivedPixelFunc
  ): CPLErr {.gdalCall, importc: "GDALAddDerivedBandPixelFunc", raises: [].}

  proc GDALAddDerivedBandPixelFuncWithArgs*(
    pszName: cstring, pfnPixelFunc: GDALDerivedPixelFuncWithArgs, pszMetadata: cstring
  ): CPLErr {.gdalCall, importc: "GDALAddDerivedBandPixelFuncWithArgs", raises: [].}

  proc GDALRasterInterpolateAtPoint*(
    hBand: GDALRasterBandH,
    dfPixel: cdouble,
    dfLine: cdouble,
    eInterpolation: GDALRIOResampleAlg,
    pdfRealValue: ptr cdouble,
    pdfImagValue: ptr cdouble,
  ): CPLErr {.cdecl, importc: "GDALRasterInterpolateAtPoint", raises: [].}

  proc GDALRasterInterpolateAtGeolocation*(
    hBand: GDALRasterBandH,
    dfGeolocX: cdouble,
    dfGeolocY: cdouble,
    hSRS: OGRSpatialReferenceH,
    eInterpolation: GDALRIOResampleAlg,
    pdfRealValue: ptr cdouble,
    pdfImagValue: ptr cdouble,
    papszTransformerOptions: CSLConstList,
  ): CPLErr {.cdecl, importc: "GDALRasterInterpolateAtGeolocation", raises: [].}

  proc GDALVRTRegisterProcessedDatasetFunc*(
    pszFuncName: cstring,
    pUserData: pointer,
    pszXMLMetadata: cstring,
    eRequestedInputDT: GDALDataType,
    paeSupportedInputDT: ptr GDALDataType,
    nSupportedInputDTSize: csize_t,
    panSupportedInputBandCount: ptr cint,
    nSupportedInputBandCountSize: csize_t,
    pfnInit: GDALVRTProcessedDatasetFuncInit,
    pfnFree: GDALVRTProcessedDatasetFuncFree,
    pfnProcess: GDALVRTProcessedDatasetFuncProcess,
    papszOptions: CSLConstList,
  ): CPLErr {.cdecl, importc: "GDALVRTRegisterProcessedDatasetFunc", raises: [].}

  proc GDALGetMaskBand*(
    hBand: GDALRasterBandH
  ): GDALRasterBandH {.gdalCall, importc: "GDALGetMaskBand", raises: [].}

  proc GDALGetMaskFlags*(
    hBand: GDALRasterBandH
  ): cint {.gdalCall, importc: "GDALGetMaskFlags", raises: [].}

  proc GDALCreateMaskBand*(
    hBand: GDALRasterBandH, nFlags: cint
  ): CPLErr {.gdalCall, importc: "GDALCreateMaskBand", raises: [].}

  proc GDALIsMaskBand*(
    hBand: GDALRasterBandH
  ): bool {.cdecl, importc: "GDALIsMaskBand", raises: [].}

  proc GDALGetDataCoverageStatus*(
    hBand: GDALRasterBandH,
    nXOff: cint,
    nYOff: cint,
    nXSize: cint,
    nYSize: cint,
    nMaskFlagStop: cint,
    pdfDataPct: ptr cdouble,
  ): cint {.gdalCall, importc: "GDALGetDataCoverageStatus", raises: [].}

  proc GDALComputedRasterBandRelease*(
    hBand: GDALComputedRasterBandH
  ) {.cdecl, importc: "GDALComputedRasterBandRelease", raises: [].}

  proc GDALRasterBandUnaryOp*(
    hBand: GDALRasterBandH, eOp: GDALRasterAlgebraUnaryOperation
  ): GDALComputedRasterBandH {.cdecl, importc: "GDALRasterBandUnaryOp", raises: [].}

  proc GDALRasterBandBinaryOpBand*(
    hBand: GDALRasterBandH,
    eOp: GDALRasterAlgebraBinaryOperation,
    hOtherBand: GDALRasterBandH,
  ): GDALComputedRasterBandH {.
    cdecl, importc: "GDALRasterBandBinaryOpBand", raises: []
  .}

  proc GDALRasterBandBinaryOpDouble*(
    hBand: GDALRasterBandH, eOp: GDALRasterAlgebraBinaryOperation, constant: cdouble
  ): GDALComputedRasterBandH {.
    cdecl, importc: "GDALRasterBandBinaryOpDouble", raises: []
  .}

  proc GDALRasterBandBinaryOpDoubleToBand*(
    constant: cdouble, eOp: GDALRasterAlgebraBinaryOperation, hBand: GDALRasterBandH
  ): GDALComputedRasterBandH {.
    cdecl, importc: "GDALRasterBandBinaryOpDoubleToBand", raises: []
  .}

  proc GDALRasterBandIfThenElse*(
    hCondBand: GDALRasterBandH, hThenBand: GDALRasterBandH, hElseBand: GDALRasterBandH
  ): GDALComputedRasterBandH {.cdecl, importc: "GDALRasterBandIfThenElse", raises: [].}

  proc GDALRasterBandAsDataType*(
    hBand: GDALRasterBandH, eDT: GDALDataType
  ): GDALComputedRasterBandH {.cdecl, importc: "GDALRasterBandAsDataType", raises: [].}

  proc GDALMaximumOfNBands*(
    nBandCount: csize_t, pahBands: ptr GDALRasterBandH
  ): GDALComputedRasterBandH {.cdecl, importc: "GDALMaximumOfNBands", raises: [].}

  proc GDALRasterBandMaxConstant*(
    hBand: GDALRasterBandH, dfConstant: cdouble
  ): GDALComputedRasterBandH {.cdecl, importc: "GDALRasterBandMaxConstant", raises: [].}

  proc GDALMinimumOfNBands*(
    nBandCount: csize_t, pahBands: ptr GDALRasterBandH
  ): GDALComputedRasterBandH {.cdecl, importc: "GDALMinimumOfNBands", raises: [].}

  proc GDALRasterBandMinConstant*(
    hBand: GDALRasterBandH, dfConstant: cdouble
  ): GDALComputedRasterBandH {.cdecl, importc: "GDALRasterBandMinConstant", raises: [].}

  proc GDALMeanOfNBands*(
    nBandCount: csize_t, pahBands: ptr GDALRasterBandH
  ): GDALComputedRasterBandH {.cdecl, importc: "GDALMeanOfNBands", raises: [].}

  proc GDALARGetNextUpdatedRegion*(
    hARIO: GDALAsyncReaderH,
    dfTimeout: cdouble,
    pnXBufOff: ptr cint,
    pnYBufOff: ptr cint,
    pnXBufSize: ptr cint,
    pnYBufSize: ptr cint,
  ): GDALAsyncStatusType {.gdalCall, importc: "GDALARGetNextUpdatedRegion", raises: [].}

  proc GDALARLockBuffer*(
    hARIO: GDALAsyncReaderH, dfTimeout: cdouble
  ): cint {.gdalCall, importc: "GDALARLockBuffer", raises: [].}

  proc GDALARUnlockBuffer*(
    hARIO: GDALAsyncReaderH
  ) {.gdalCall, importc: "GDALARUnlockBuffer", raises: [].}

  proc GDALGeneralCmdLineProcessor*(
    nArgc: cint, ppapszArgv: ptr cstringArray, nOptions: cint
  ): cint {.gdalCall, importc: "GDALGeneralCmdLineProcessor", raises: [].}

  proc GDALSwapWords*(
    pData: pointer, nWordSize: cint, nWordCount: cint, nWordSkip: cint
  ) {.gdalCall, importc: "GDALSwapWords", raises: [].}

  proc GDALSwapWordsEx*(
    pData: pointer, nWordSize: cint, nWordCount: csize_t, nWordSkip: cint
  ) {.gdalCall, importc: "GDALSwapWordsEx", raises: [].}

  proc GDALCopyWords*(
    pSrcData: pointer,
    eSrcType: GDALDataType,
    nSrcPixelOffset: cint,
    pDstData: pointer,
    eDstType: GDALDataType,
    nDstPixelOffset: cint,
    nWordCount: cint,
  ) {.gdalCall, importc: "GDALCopyWords", raises: [].}

  proc GDALCopyWords64*(
    pSrcData: pointer,
    eSrcType: GDALDataType,
    nSrcPixelOffset: cint,
    pDstData: pointer,
    eDstType: GDALDataType,
    nDstPixelOffset: cint,
    nWordCount: GPtrDiff_t,
  ) {.gdalCall, importc: "GDALCopyWords64", raises: [].}

  proc GDALCopyBits*(
    pabySrcData: ptr GByte,
    nSrcOffset: cint,
    nSrcStep: cint,
    pabyDstData: ptr GByte,
    nDstOffset: cint,
    nDstStep: cint,
    nBitCount: cint,
    nStepCount: cint,
  ) {.cdecl, importc: "GDALCopyBits", raises: [].}

  proc GDALDeinterleave*(
    pSourceBuffer: pointer,
    eSourceDT: GDALDataType,
    nComponents: cint,
    ppDestBuffer: ptr pointer,
    eDestDT: GDALDataType,
    nIters: csize_t,
  ) {.cdecl, importc: "GDALDeinterleave", raises: [].}

  proc GDALTranspose2D*(
    pSrc: pointer,
    eSrcType: GDALDataType,
    pDst: pointer,
    eDstType: GDALDataType,
    nSrcWidth: csize_t,
    nSrcHeight: csize_t,
  ) {.cdecl, importc: "GDALTranspose2D", raises: [].}

  proc GDALGetNoDataReplacementValue*(
    a0: GDALDataType, a1: cdouble
  ): cdouble {.cdecl, importc: "GDALGetNoDataReplacementValue", raises: [].}

  proc GDALLoadWorldFile*(
    a0: cstring, a1: ptr cdouble
  ): cint {.gdalCall, importc: "GDALLoadWorldFile", raises: [].}

  proc GDALReadWorldFile*(
    a0: cstring, a1: cstring, a2: ptr cdouble
  ): cint {.gdalCall, importc: "GDALReadWorldFile", raises: [].}

  proc GDALWriteWorldFile*(
    a0: cstring, a1: cstring, a2: ptr cdouble
  ): cint {.gdalCall, importc: "GDALWriteWorldFile", raises: [].}

  proc GDALLoadTabFile*(
    a0: cstring, a1: ptr cdouble, a2: cstringArray, a3: ptr cint, a4: ptr ptr GDAL_GCP
  ): cint {.gdalCall, importc: "GDALLoadTabFile", raises: [].}

  proc GDALReadTabFile*(
    a0: cstring, a1: ptr cdouble, a2: cstringArray, a3: ptr cint, a4: ptr ptr GDAL_GCP
  ): cint {.gdalCall, importc: "GDALReadTabFile", raises: [].}

  proc GDALLoadOziMapFile*(
    a0: cstring, a1: ptr cdouble, a2: cstringArray, a3: ptr cint, a4: ptr ptr GDAL_GCP
  ): cint {.gdalCall, importc: "GDALLoadOziMapFile", raises: [].}

  proc GDALReadOziMapFile*(
    a0: cstring, a1: ptr cdouble, a2: cstringArray, a3: ptr cint, a4: ptr ptr GDAL_GCP
  ): cint {.gdalCall, importc: "GDALReadOziMapFile", raises: [].}

  proc GDALDecToDMS*(
    a0: cdouble, a1: cstring, a2: cint
  ): cstring {.gdalCall, importc: "GDALDecToDMS", raises: [].}

  proc GDALPackedDMSToDec*(
    a0: cdouble
  ): cdouble {.gdalCall, importc: "GDALPackedDMSToDec", raises: [].}

  proc GDALDecToPackedDMS*(
    a0: cdouble
  ): cdouble {.gdalCall, importc: "GDALDecToPackedDMS", raises: [].}

  proc GDALExtractRPCInfoV1*(
    a0: CSLConstList, a1: ptr GDALRPCInfoV1
  ): cint {.gdalCall, importc: "GDALExtractRPCInfo", raises: [].}

  proc GDALExtractRPCInfoV2*(
    a0: CSLConstList, a1: ptr GDALRPCInfoV2
  ): cint {.gdalCall, importc: "GDALExtractRPCInfoV2", raises: [].}

  proc GDALCreateColorTable*(
    a0: GDALPaletteInterp
  ): GDALColorTableH {.gdalCall, importc: "GDALCreateColorTable", raises: [].}

  proc GDALDestroyColorTable*(
    a0: GDALColorTableH
  ) {.gdalCall, importc: "GDALDestroyColorTable", raises: [].}

  proc GDALCloneColorTable*(
    a0: GDALColorTableH
  ): GDALColorTableH {.gdalCall, importc: "GDALCloneColorTable", raises: [].}

  proc GDALGetPaletteInterpretation*(
    a0: GDALColorTableH
  ): GDALPaletteInterp {.gdalCall, importc: "GDALGetPaletteInterpretation", raises: [].}

  proc GDALGetColorEntryCount*(
    a0: GDALColorTableH
  ): cint {.gdalCall, importc: "GDALGetColorEntryCount", raises: [].}

  proc GDALGetColorEntry*(
    a0: GDALColorTableH, a1: cint
  ): ptr GDALColorEntry {.gdalCall, importc: "GDALGetColorEntry", raises: [].}

  proc GDALGetColorEntryAsRGB*(
    a0: GDALColorTableH, a1: cint, a2: ptr GDALColorEntry
  ): cint {.gdalCall, importc: "GDALGetColorEntryAsRGB", raises: [].}

  proc GDALSetColorEntry*(
    a0: GDALColorTableH, a1: cint, a2: ptr GDALColorEntry
  ) {.gdalCall, importc: "GDALSetColorEntry", raises: [].}

  proc GDALCreateColorRamp*(
    hTable: GDALColorTableH,
    nStartIndex: cint,
    psStartColor: ptr GDALColorEntry,
    nEndIndex: cint,
    psEndColor: ptr GDALColorEntry,
  ) {.gdalCall, importc: "GDALCreateColorRamp", raises: [].}

  proc GDALCreateRasterAttributeTable*(): GDALRasterAttributeTableH {.
    gdalCall, importc: "GDALCreateRasterAttributeTable", raises: []
  .}

  proc GDALDestroyRasterAttributeTable*(
    a0: GDALRasterAttributeTableH
  ) {.gdalCall, importc: "GDALDestroyRasterAttributeTable", raises: [].}

  proc GDALRATGetColumnCount*(
    a0: GDALRasterAttributeTableH
  ): cint {.gdalCall, importc: "GDALRATGetColumnCount", raises: [].}

  proc GDALRATGetNameOfCol*(
    a0: GDALRasterAttributeTableH, a1: cint
  ): cstring {.gdalCall, importc: "GDALRATGetNameOfCol", raises: [].}

  proc GDALRATGetUsageOfCol*(
    a0: GDALRasterAttributeTableH, a1: cint
  ): GDALRATFieldUsage {.gdalCall, importc: "GDALRATGetUsageOfCol", raises: [].}

  proc GDALRATGetTypeOfCol*(
    a0: GDALRasterAttributeTableH, a1: cint
  ): GDALRATFieldType {.gdalCall, importc: "GDALRATGetTypeOfCol", raises: [].}

  proc GDALGetRATFieldTypeName*(
    a0: GDALRATFieldType
  ): cstring {.cdecl, importc: "GDALGetRATFieldTypeName", raises: [].}

  proc GDALGetRATFieldUsageName*(
    a0: GDALRATFieldUsage
  ): cstring {.cdecl, importc: "GDALGetRATFieldUsageName", raises: [].}

  proc GDALRATGetColOfUsage*(
    a0: GDALRasterAttributeTableH, a1: GDALRATFieldUsage
  ): cint {.gdalCall, importc: "GDALRATGetColOfUsage", raises: [].}

  proc GDALRATGetRowCount*(
    a0: GDALRasterAttributeTableH
  ): cint {.gdalCall, importc: "GDALRATGetRowCount", raises: [].}

  proc GDALRATGetValueAsString*(
    a0: GDALRasterAttributeTableH, iRow: cint, iField: cint
  ): cstring {.gdalCall, importc: "GDALRATGetValueAsString", raises: [].}

  proc GDALRATGetValueAsInt*(
    a0: GDALRasterAttributeTableH, iRow: cint, iField: cint
  ): cint {.gdalCall, importc: "GDALRATGetValueAsInt", raises: [].}

  proc GDALRATGetValueAsDouble*(
    a0: GDALRasterAttributeTableH, iRow: cint, iField: cint
  ): cdouble {.gdalCall, importc: "GDALRATGetValueAsDouble", raises: [].}

  proc GDALRATGetValueAsBoolean*(
    a0: GDALRasterAttributeTableH, iRow: cint, iField: cint
  ): bool {.cdecl, importc: "GDALRATGetValueAsBoolean", raises: [].}

  proc GDALRATGetValueAsDateTime*(
    a0: GDALRasterAttributeTableH,
    iRow: cint,
    iField: cint,
    psDateTime: ptr GDALRATDateTime,
  ): CPLErr {.cdecl, importc: "GDALRATGetValueAsDateTime", raises: [].}

  proc GDALRATGetValueAsWKBGeometry*(
    a0: GDALRasterAttributeTableH, iRow: cint, iField: cint, pnWKBSize: ptr csize_t
  ): ptr GByte {.cdecl, importc: "GDALRATGetValueAsWKBGeometry", raises: [].}

  proc GDALRATSetValueAsString*(
    a0: GDALRasterAttributeTableH, iRow: cint, iField: cint, a3: cstring
  ) {.gdalCall, importc: "GDALRATSetValueAsString", raises: [].}

  proc GDALRATSetValueAsInt*(
    a0: GDALRasterAttributeTableH, iRow: cint, iField: cint, a3: cint
  ) {.gdalCall, importc: "GDALRATSetValueAsInt", raises: [].}

  proc GDALRATSetValueAsDouble*(
    a0: GDALRasterAttributeTableH, iRow: cint, iField: cint, a3: cdouble
  ) {.gdalCall, importc: "GDALRATSetValueAsDouble", raises: [].}

  proc GDALRATSetValueAsBoolean*(
    a0: GDALRasterAttributeTableH, iRow: cint, iField: cint, a3: bool
  ): CPLErr {.cdecl, importc: "GDALRATSetValueAsBoolean", raises: [].}

  proc GDALRATSetValueAsDateTime*(
    a0: GDALRasterAttributeTableH,
    iRow: cint,
    iField: cint,
    psDateTime: ptr GDALRATDateTime,
  ): CPLErr {.cdecl, importc: "GDALRATSetValueAsDateTime", raises: [].}

  proc GDALRATSetValueAsWKBGeometry*(
    a0: GDALRasterAttributeTableH,
    iRow: cint,
    iField: cint,
    pabyWKB: pointer,
    nWKBSize: csize_t,
  ): CPLErr {.cdecl, importc: "GDALRATSetValueAsWKBGeometry", raises: [].}

  proc GDALRATChangesAreWrittenToFile*(
    hRAT: GDALRasterAttributeTableH
  ): cint {.gdalCall, importc: "GDALRATChangesAreWrittenToFile", raises: [].}

  proc GDALRATValuesIOAsDouble*(
    hRAT: GDALRasterAttributeTableH,
    eRWFlag: GDALRWFlag,
    iField: cint,
    iStartRow: cint,
    iLength: cint,
    pdfData: ptr cdouble,
  ): CPLErr {.gdalCall, importc: "GDALRATValuesIOAsDouble", raises: [].}

  proc GDALRATValuesIOAsInteger*(
    hRAT: GDALRasterAttributeTableH,
    eRWFlag: GDALRWFlag,
    iField: cint,
    iStartRow: cint,
    iLength: cint,
    pnData: ptr cint,
  ): CPLErr {.gdalCall, importc: "GDALRATValuesIOAsInteger", raises: [].}

  proc GDALRATValuesIOAsString*(
    hRAT: GDALRasterAttributeTableH,
    eRWFlag: GDALRWFlag,
    iField: cint,
    iStartRow: cint,
    iLength: cint,
    papszStrList: cstringArray,
  ): CPLErr {.gdalCall, importc: "GDALRATValuesIOAsString", raises: [].}

  proc GDALRATValuesIOAsBoolean*(
    hRAT: GDALRasterAttributeTableH,
    eRWFlag: GDALRWFlag,
    iField: cint,
    iStartRow: cint,
    iLength: cint,
    pbData: ptr bool,
  ): CPLErr {.cdecl, importc: "GDALRATValuesIOAsBoolean", raises: [].}

  proc GDALRATValuesIOAsDateTime*(
    hRAT: GDALRasterAttributeTableH,
    eRWFlag: GDALRWFlag,
    iField: cint,
    iStartRow: cint,
    iLength: cint,
    pasDateTime: ptr GDALRATDateTime,
  ): CPLErr {.cdecl, importc: "GDALRATValuesIOAsDateTime", raises: [].}

  proc GDALRATValuesIOAsWKBGeometry*(
    hRAT: GDALRasterAttributeTableH,
    eRWFlag: GDALRWFlag,
    iField: cint,
    iStartRow: cint,
    iLength: cint,
    ppabyWKB: ptr ptr GByte,
    pnWKBSize: ptr csize_t,
  ): CPLErr {.cdecl, importc: "GDALRATValuesIOAsWKBGeometry", raises: [].}

  proc GDALRATSetRowCount*(
    a0: GDALRasterAttributeTableH, a1: cint
  ) {.gdalCall, importc: "GDALRATSetRowCount", raises: [].}

  proc GDALRATCreateColumn*(
    a0: GDALRasterAttributeTableH,
    a1: cstring,
    a2: GDALRATFieldType,
    a3: GDALRATFieldUsage,
  ): CPLErr {.gdalCall, importc: "GDALRATCreateColumn", raises: [].}

  proc GDALRATSetLinearBinning*(
    a0: GDALRasterAttributeTableH, a1: cdouble, a2: cdouble
  ): CPLErr {.gdalCall, importc: "GDALRATSetLinearBinning", raises: [].}

  proc GDALRATGetLinearBinning*(
    a0: GDALRasterAttributeTableH, a1: ptr cdouble, a2: ptr cdouble
  ): cint {.gdalCall, importc: "GDALRATGetLinearBinning", raises: [].}

  proc GDALRATSetTableType*(
    hRAT: GDALRasterAttributeTableH, eInTableType: GDALRATTableType
  ): CPLErr {.gdalCall, importc: "GDALRATSetTableType", raises: [].}

  proc GDALRATGetTableType*(
    hRAT: GDALRasterAttributeTableH
  ): GDALRATTableType {.gdalCall, importc: "GDALRATGetTableType", raises: [].}

  proc GDALRATInitializeFromColorTable*(
    a0: GDALRasterAttributeTableH, a1: GDALColorTableH
  ): CPLErr {.gdalCall, importc: "GDALRATInitializeFromColorTable", raises: [].}

  proc GDALRATTranslateToColorTable*(
    a0: GDALRasterAttributeTableH, nEntryCount: cint
  ): GDALColorTableH {.gdalCall, importc: "GDALRATTranslateToColorTable", raises: [].}

  proc GDALRATDumpReadable*(
    a0: GDALRasterAttributeTableH, a1: ptr GdalFile
  ) {.gdalCall, importc: "GDALRATDumpReadable", raises: [].}

  proc GDALRATClone*(
    a0: GDALRasterAttributeTableH
  ): GDALRasterAttributeTableH {.gdalCall, importc: "GDALRATClone", raises: [].}

  proc GDALRATSerializeJSON*(
    a0: GDALRasterAttributeTableH
  ): pointer {.gdalCall, importc: "GDALRATSerializeJSON", raises: [].}

  proc GDALRATGetRowOfValue*(
    a0: GDALRasterAttributeTableH, a1: cdouble
  ): cint {.gdalCall, importc: "GDALRATGetRowOfValue", raises: [].}

  proc GDALRATRemoveStatistics*(
    a0: GDALRasterAttributeTableH
  ) {.gdalCall, importc: "GDALRATRemoveStatistics", raises: [].}

  proc GDALRelationshipCreate*(
    a0: cstring, a1: cstring, a2: cstring, a3: GDALRelationshipCardinality
  ): GDALRelationshipH {.cdecl, importc: "GDALRelationshipCreate", raises: [].}

  proc GDALDestroyRelationship*(
    a0: GDALRelationshipH
  ) {.gdalCall, importc: "GDALDestroyRelationship", raises: [].}

  proc GDALRelationshipGetName*(
    a0: GDALRelationshipH
  ): cstring {.cdecl, importc: "GDALRelationshipGetName", raises: [].}

  proc GDALRelationshipGetCardinality*(
    a0: GDALRelationshipH
  ): GDALRelationshipCardinality {.
    cdecl, importc: "GDALRelationshipGetCardinality", raises: []
  .}

  proc GDALRelationshipGetLeftTableName*(
    a0: GDALRelationshipH
  ): cstring {.cdecl, importc: "GDALRelationshipGetLeftTableName", raises: [].}

  proc GDALRelationshipGetRightTableName*(
    a0: GDALRelationshipH
  ): cstring {.cdecl, importc: "GDALRelationshipGetRightTableName", raises: [].}

  proc GDALRelationshipGetMappingTableName*(
    a0: GDALRelationshipH
  ): cstring {.cdecl, importc: "GDALRelationshipGetMappingTableName", raises: [].}

  proc GDALRelationshipSetMappingTableName*(
    a0: GDALRelationshipH, a1: cstring
  ) {.cdecl, importc: "GDALRelationshipSetMappingTableName", raises: [].}

  proc GDALRelationshipGetLeftTableFields*(
    a0: GDALRelationshipH
  ): cstringArray {.cdecl, importc: "GDALRelationshipGetLeftTableFields", raises: [].}

  proc GDALRelationshipGetRightTableFields*(
    a0: GDALRelationshipH
  ): cstringArray {.cdecl, importc: "GDALRelationshipGetRightTableFields", raises: [].}

  proc GDALRelationshipSetLeftTableFields*(
    a0: GDALRelationshipH, a1: CSLConstList
  ) {.cdecl, importc: "GDALRelationshipSetLeftTableFields", raises: [].}

  proc GDALRelationshipSetRightTableFields*(
    a0: GDALRelationshipH, a1: CSLConstList
  ) {.cdecl, importc: "GDALRelationshipSetRightTableFields", raises: [].}

  proc GDALRelationshipGetLeftMappingTableFields*(
    a0: GDALRelationshipH
  ): cstringArray {.
    cdecl, importc: "GDALRelationshipGetLeftMappingTableFields", raises: []
  .}

  proc GDALRelationshipGetRightMappingTableFields*(
    a0: GDALRelationshipH
  ): cstringArray {.
    cdecl, importc: "GDALRelationshipGetRightMappingTableFields", raises: []
  .}

  proc GDALRelationshipSetLeftMappingTableFields*(
    a0: GDALRelationshipH, a1: CSLConstList
  ) {.cdecl, importc: "GDALRelationshipSetLeftMappingTableFields", raises: [].}

  proc GDALRelationshipSetRightMappingTableFields*(
    a0: GDALRelationshipH, a1: CSLConstList
  ) {.cdecl, importc: "GDALRelationshipSetRightMappingTableFields", raises: [].}

  proc GDALRelationshipGetType*(
    a0: GDALRelationshipH
  ): GDALRelationshipType {.cdecl, importc: "GDALRelationshipGetType", raises: [].}

  proc GDALRelationshipSetType*(
    a0: GDALRelationshipH, a1: GDALRelationshipType
  ) {.cdecl, importc: "GDALRelationshipSetType", raises: [].}

  proc GDALRelationshipGetForwardPathLabel*(
    a0: GDALRelationshipH
  ): cstring {.cdecl, importc: "GDALRelationshipGetForwardPathLabel", raises: [].}

  proc GDALRelationshipSetForwardPathLabel*(
    a0: GDALRelationshipH, a1: cstring
  ) {.cdecl, importc: "GDALRelationshipSetForwardPathLabel", raises: [].}

  proc GDALRelationshipGetBackwardPathLabel*(
    a0: GDALRelationshipH
  ): cstring {.cdecl, importc: "GDALRelationshipGetBackwardPathLabel", raises: [].}

  proc GDALRelationshipSetBackwardPathLabel*(
    a0: GDALRelationshipH, a1: cstring
  ) {.cdecl, importc: "GDALRelationshipSetBackwardPathLabel", raises: [].}

  proc GDALRelationshipGetRelatedTableType*(
    a0: GDALRelationshipH
  ): cstring {.cdecl, importc: "GDALRelationshipGetRelatedTableType", raises: [].}

  proc GDALRelationshipSetRelatedTableType*(
    a0: GDALRelationshipH, a1: cstring
  ) {.cdecl, importc: "GDALRelationshipSetRelatedTableType", raises: [].}

  proc GDALSetCacheMax*(
    nBytes: cint
  ) {.gdalCall, importc: "GDALSetCacheMax", raises: [].}

  proc GDALGetCacheMax*(): cint {.gdalCall, importc: "GDALGetCacheMax", raises: [].}
  proc GDALGetCacheUsed*(): cint {.gdalCall, importc: "GDALGetCacheUsed", raises: [].}
  proc GDALSetCacheMax64*(
    nBytes: GIntBig
  ) {.gdalCall, importc: "GDALSetCacheMax64", raises: [].}

  proc GDALGetCacheMax64*(): GIntBig {.
    gdalCall, importc: "GDALGetCacheMax64", raises: []
  .}

  proc GDALGetCacheUsed64*(): GIntBig {.
    gdalCall, importc: "GDALGetCacheUsed64", raises: []
  .}

  proc GDALFlushCacheBlock*(): cint {.
    gdalCall, importc: "GDALFlushCacheBlock", raises: []
  .}

  proc GDALDatasetGetVirtualMem*(
    hDS: GDALDatasetH,
    eRWFlag: GDALRWFlag,
    nXOff: cint,
    nYOff: cint,
    nXSize: cint,
    nYSize: cint,
    nBufXSize: cint,
    nBufYSize: cint,
    eBufType: GDALDataType,
    nBandCount: cint,
    panBandMap: ptr cint,
    nPixelSpace: cint,
    nLineSpace: GIntBig,
    nBandSpace: GIntBig,
    nCacheSize: csize_t,
    nPageSizeHint: csize_t,
    bSingleThreadUsage: cint,
    papszOptions: CSLConstList,
  ): ptr CPLVirtualMem {.cdecl, importc: "GDALDatasetGetVirtualMem", raises: [].}

  proc GDALRasterBandGetVirtualMem*(
    hBand: GDALRasterBandH,
    eRWFlag: GDALRWFlag,
    nXOff: cint,
    nYOff: cint,
    nXSize: cint,
    nYSize: cint,
    nBufXSize: cint,
    nBufYSize: cint,
    eBufType: GDALDataType,
    nPixelSpace: cint,
    nLineSpace: GIntBig,
    nCacheSize: csize_t,
    nPageSizeHint: csize_t,
    bSingleThreadUsage: cint,
    papszOptions: CSLConstList,
  ): ptr CPLVirtualMem {.cdecl, importc: "GDALRasterBandGetVirtualMem", raises: [].}

  proc GDALGetVirtualMemAuto*(
    hBand: GDALRasterBandH,
    eRWFlag: GDALRWFlag,
    pnPixelSpace: ptr cint,
    pnLineSpace: ptr GIntBig,
    papszOptions: CSLConstList,
  ): ptr CPLVirtualMem {.cdecl, importc: "GDALGetVirtualMemAuto", raises: [].}

  proc GDALDatasetGetTiledVirtualMem*(
    hDS: GDALDatasetH,
    eRWFlag: GDALRWFlag,
    nXOff: cint,
    nYOff: cint,
    nXSize: cint,
    nYSize: cint,
    nTileXSize: cint,
    nTileYSize: cint,
    eBufType: GDALDataType,
    nBandCount: cint,
    panBandMap: ptr cint,
    eTileOrganization: GDALTileOrganization,
    nCacheSize: csize_t,
    bSingleThreadUsage: cint,
    papszOptions: CSLConstList,
  ): ptr CPLVirtualMem {.cdecl, importc: "GDALDatasetGetTiledVirtualMem", raises: [].}

  proc GDALRasterBandGetTiledVirtualMem*(
    hBand: GDALRasterBandH,
    eRWFlag: GDALRWFlag,
    nXOff: cint,
    nYOff: cint,
    nXSize: cint,
    nYSize: cint,
    nTileXSize: cint,
    nTileYSize: cint,
    eBufType: GDALDataType,
    nCacheSize: csize_t,
    bSingleThreadUsage: cint,
    papszOptions: CSLConstList,
  ): ptr CPLVirtualMem {.
    cdecl, importc: "GDALRasterBandGetTiledVirtualMem", raises: []
  .}

  proc GDALCreatePansharpenedVRT*(
    pszXML: cstring,
    hPanchroBand: GDALRasterBandH,
    nInputSpectralBands: cint,
    pahInputSpectralBands: ptr GDALRasterBandH,
  ): GDALDatasetH {.cdecl, importc: "GDALCreatePansharpenedVRT", raises: [].}

  proc GDALGetJPEG2000Structure*(
    pszFilename: cstring, papszOptions: CSLConstList
  ): ptr CPLXMLNode {.cdecl, importc: "GDALGetJPEG2000Structure", raises: [].}

  proc GDALCreateMultiDimensional*(
    hDriver: GDALDriverH,
    pszName: cstring,
    papszRootGroupOptions: CSLConstList,
    papszOptions: CSLConstList,
  ): GDALDatasetH {.cdecl, importc: "GDALCreateMultiDimensional", raises: [].}

  proc GDALExtendedDataTypeCreate*(
    eType: GDALDataType
  ): GDALExtendedDataTypeH {.cdecl, importc: "GDALExtendedDataTypeCreate", raises: [].}

  proc GDALExtendedDataTypeCreateString*(
    nMaxStringLength: csize_t
  ): GDALExtendedDataTypeH {.
    cdecl, importc: "GDALExtendedDataTypeCreateString", raises: []
  .}

  proc GDALExtendedDataTypeCreateStringEx*(
    nMaxStringLength: csize_t, eSubType: GDALExtendedDataTypeSubType
  ): GDALExtendedDataTypeH {.
    cdecl, importc: "GDALExtendedDataTypeCreateStringEx", raises: []
  .}

  proc GDALExtendedDataTypeCreateCompound*(
    pszName: cstring,
    nTotalSize: csize_t,
    nComponents: csize_t,
    comps: ptr GDALEDTComponentH,
  ): GDALExtendedDataTypeH {.
    cdecl, importc: "GDALExtendedDataTypeCreateCompound", raises: []
  .}

  proc GDALExtendedDataTypeRelease*(
    hEDT: GDALExtendedDataTypeH
  ) {.cdecl, importc: "GDALExtendedDataTypeRelease", raises: [].}

  proc GDALExtendedDataTypeGetName*(
    hEDT: GDALExtendedDataTypeH
  ): cstring {.cdecl, importc: "GDALExtendedDataTypeGetName", raises: [].}

  proc GDALExtendedDataTypeGetClass*(
    hEDT: GDALExtendedDataTypeH
  ): GDALExtendedDataTypeClass {.
    cdecl, importc: "GDALExtendedDataTypeGetClass", raises: []
  .}

  proc GDALExtendedDataTypeGetNumericDataType*(
    hEDT: GDALExtendedDataTypeH
  ): GDALDataType {.
    cdecl, importc: "GDALExtendedDataTypeGetNumericDataType", raises: []
  .}

  proc GDALExtendedDataTypeGetSize*(
    hEDT: GDALExtendedDataTypeH
  ): csize_t {.cdecl, importc: "GDALExtendedDataTypeGetSize", raises: [].}

  proc GDALExtendedDataTypeGetMaxStringLength*(
    hEDT: GDALExtendedDataTypeH
  ): csize_t {.cdecl, importc: "GDALExtendedDataTypeGetMaxStringLength", raises: [].}

  proc GDALExtendedDataTypeGetComponents*(
    hEDT: GDALExtendedDataTypeH, pnCount: ptr csize_t
  ): ptr GDALEDTComponentH {.
    cdecl, importc: "GDALExtendedDataTypeGetComponents", raises: []
  .}

  proc GDALExtendedDataTypeFreeComponents*(
    components: ptr GDALEDTComponentH, nCount: csize_t
  ) {.cdecl, importc: "GDALExtendedDataTypeFreeComponents", raises: [].}

  proc GDALExtendedDataTypeCanConvertTo*(
    hSourceEDT: GDALExtendedDataTypeH, hTargetEDT: GDALExtendedDataTypeH
  ): cint {.cdecl, importc: "GDALExtendedDataTypeCanConvertTo", raises: [].}

  proc GDALExtendedDataTypeEquals*(
    hFirstEDT: GDALExtendedDataTypeH, hSecondEDT: GDALExtendedDataTypeH
  ): cint {.cdecl, importc: "GDALExtendedDataTypeEquals", raises: [].}

  proc GDALExtendedDataTypeGetSubType*(
    hEDT: GDALExtendedDataTypeH
  ): GDALExtendedDataTypeSubType {.
    cdecl, importc: "GDALExtendedDataTypeGetSubType", raises: []
  .}

  proc GDALExtendedDataTypeGetRAT*(
    hEDT: GDALExtendedDataTypeH
  ): GDALRasterAttributeTableH {.
    cdecl, importc: "GDALExtendedDataTypeGetRAT", raises: []
  .}

  proc GDALEDTComponentCreate*(
    pszName: cstring, nOffset: csize_t, hType: GDALExtendedDataTypeH
  ): GDALEDTComponentH {.cdecl, importc: "GDALEDTComponentCreate", raises: [].}

  proc GDALEDTComponentRelease*(
    hComp: GDALEDTComponentH
  ) {.cdecl, importc: "GDALEDTComponentRelease", raises: [].}

  proc GDALEDTComponentGetName*(
    hComp: GDALEDTComponentH
  ): cstring {.cdecl, importc: "GDALEDTComponentGetName", raises: [].}

  proc GDALEDTComponentGetOffset*(
    hComp: GDALEDTComponentH
  ): csize_t {.cdecl, importc: "GDALEDTComponentGetOffset", raises: [].}

  proc GDALEDTComponentGetType*(
    hComp: GDALEDTComponentH
  ): GDALExtendedDataTypeH {.cdecl, importc: "GDALEDTComponentGetType", raises: [].}

  proc GDALDatasetGetRootGroup*(
    hDS: GDALDatasetH
  ): GDALGroupH {.cdecl, importc: "GDALDatasetGetRootGroup", raises: [].}

  proc GDALGroupRelease*(
    hGroup: GDALGroupH
  ) {.cdecl, importc: "GDALGroupRelease", raises: [].}

  proc GDALGroupGetName*(
    hGroup: GDALGroupH
  ): cstring {.cdecl, importc: "GDALGroupGetName", raises: [].}

  proc GDALGroupGetFullName*(
    hGroup: GDALGroupH
  ): cstring {.cdecl, importc: "GDALGroupGetFullName", raises: [].}

  proc GDALGroupGetMDArrayNames*(
    hGroup: GDALGroupH, papszOptions: CSLConstList
  ): cstringArray {.cdecl, importc: "GDALGroupGetMDArrayNames", raises: [].}

  proc GDALGroupGetMDArrayFullNamesRecursive*(
    hGroup: GDALGroupH, papszGroupOptions: CSLConstList, papszArrayOptions: CSLConstList
  ): cstringArray {.
    cdecl, importc: "GDALGroupGetMDArrayFullNamesRecursive", raises: []
  .}

  proc GDALGroupOpenMDArray*(
    hGroup: GDALGroupH, pszMDArrayName: cstring, papszOptions: CSLConstList
  ): GDALMDArrayH {.cdecl, importc: "GDALGroupOpenMDArray", raises: [].}

  proc GDALGroupOpenMDArrayFromFullname*(
    hGroup: GDALGroupH, pszMDArrayName: cstring, papszOptions: CSLConstList
  ): GDALMDArrayH {.cdecl, importc: "GDALGroupOpenMDArrayFromFullname", raises: [].}

  proc GDALGroupResolveMDArray*(
    hGroup: GDALGroupH,
    pszName: cstring,
    pszStartingPoint: cstring,
    papszOptions: CSLConstList,
  ): GDALMDArrayH {.cdecl, importc: "GDALGroupResolveMDArray", raises: [].}

  proc GDALGroupGetGroupNames*(
    hGroup: GDALGroupH, papszOptions: CSLConstList
  ): cstringArray {.cdecl, importc: "GDALGroupGetGroupNames", raises: [].}

  proc GDALGroupOpenGroup*(
    hGroup: GDALGroupH, pszSubGroupName: cstring, papszOptions: CSLConstList
  ): GDALGroupH {.cdecl, importc: "GDALGroupOpenGroup", raises: [].}

  proc GDALGroupOpenGroupFromFullname*(
    hGroup: GDALGroupH, pszMDArrayName: cstring, papszOptions: CSLConstList
  ): GDALGroupH {.cdecl, importc: "GDALGroupOpenGroupFromFullname", raises: [].}

  proc GDALGroupGetVectorLayerNames*(
    hGroup: GDALGroupH, papszOptions: CSLConstList
  ): cstringArray {.cdecl, importc: "GDALGroupGetVectorLayerNames", raises: [].}

  proc GDALGroupOpenVectorLayer*(
    hGroup: GDALGroupH, pszVectorLayerName: cstring, papszOptions: CSLConstList
  ): OGRLayerH {.cdecl, importc: "GDALGroupOpenVectorLayer", raises: [].}

  proc GDALGroupGetDimensions*(
    hGroup: GDALGroupH, pnCount: ptr csize_t, papszOptions: CSLConstList
  ): ptr GDALDimensionH {.cdecl, importc: "GDALGroupGetDimensions", raises: [].}

  proc GDALGroupGetAttribute*(
    hGroup: GDALGroupH, pszName: cstring
  ): GDALAttributeH {.cdecl, importc: "GDALGroupGetAttribute", raises: [].}

  proc GDALGroupGetAttributes*(
    hGroup: GDALGroupH, pnCount: ptr csize_t, papszOptions: CSLConstList
  ): ptr GDALAttributeH {.cdecl, importc: "GDALGroupGetAttributes", raises: [].}

  proc GDALGroupGetStructuralInfo*(
    hGroup: GDALGroupH
  ): CSLConstList {.cdecl, importc: "GDALGroupGetStructuralInfo", raises: [].}

  proc GDALGroupCreateGroup*(
    hGroup: GDALGroupH, pszSubGroupName: cstring, papszOptions: CSLConstList
  ): GDALGroupH {.cdecl, importc: "GDALGroupCreateGroup", raises: [].}

  proc GDALGroupDeleteGroup*(
    hGroup: GDALGroupH, pszName: cstring, papszOptions: CSLConstList
  ): bool {.cdecl, importc: "GDALGroupDeleteGroup", raises: [].}

  proc GDALGroupCreateDimension*(
    hGroup: GDALGroupH,
    pszName: cstring,
    pszType: cstring,
    pszDirection: cstring,
    nSize: GUInt64,
    papszOptions: CSLConstList,
  ): GDALDimensionH {.cdecl, importc: "GDALGroupCreateDimension", raises: [].}

  proc GDALGroupCreateMDArray*(
    hGroup: GDALGroupH,
    pszName: cstring,
    nDimensions: csize_t,
    pahDimensions: ptr GDALDimensionH,
    hEDT: GDALExtendedDataTypeH,
    papszOptions: CSLConstList,
  ): GDALMDArrayH {.cdecl, importc: "GDALGroupCreateMDArray", raises: [].}

  proc GDALGroupDeleteMDArray*(
    hGroup: GDALGroupH, pszName: cstring, papszOptions: CSLConstList
  ): bool {.cdecl, importc: "GDALGroupDeleteMDArray", raises: [].}

  proc GDALGroupCreateAttribute*(
    hGroup: GDALGroupH,
    pszName: cstring,
    nDimensions: csize_t,
    panDimensions: ptr GUInt64,
    hEDT: GDALExtendedDataTypeH,
    papszOptions: CSLConstList,
  ): GDALAttributeH {.cdecl, importc: "GDALGroupCreateAttribute", raises: [].}

  proc GDALGroupDeleteAttribute*(
    hGroup: GDALGroupH, pszName: cstring, papszOptions: CSLConstList
  ): bool {.cdecl, importc: "GDALGroupDeleteAttribute", raises: [].}

  proc GDALGroupRename*(
    hGroup: GDALGroupH, pszNewName: cstring
  ): bool {.cdecl, importc: "GDALGroupRename", raises: [].}

  proc GDALGroupSubsetDimensionFromSelection*(
    hGroup: GDALGroupH, pszSelection: cstring, papszOptions: CSLConstList
  ): GDALGroupH {.cdecl, importc: "GDALGroupSubsetDimensionFromSelection", raises: [].}

  proc GDALGroupGetDataTypeCount*(
    hGroup: GDALGroupH
  ): csize_t {.cdecl, importc: "GDALGroupGetDataTypeCount", raises: [].}

  proc GDALGroupGetDataType*(
    hGroup: GDALGroupH, nIdx: csize_t
  ): GDALExtendedDataTypeH {.cdecl, importc: "GDALGroupGetDataType", raises: [].}

  proc GDALMDArrayRelease*(
    hMDArray: GDALMDArrayH
  ) {.cdecl, importc: "GDALMDArrayRelease", raises: [].}

  proc GDALMDArrayGetName*(
    hArray: GDALMDArrayH
  ): cstring {.cdecl, importc: "GDALMDArrayGetName", raises: [].}

  proc GDALMDArrayGetFullName*(
    hArray: GDALMDArrayH
  ): cstring {.cdecl, importc: "GDALMDArrayGetFullName", raises: [].}

  proc GDALMDArrayGetTotalElementsCount*(
    hArray: GDALMDArrayH
  ): GUInt64 {.cdecl, importc: "GDALMDArrayGetTotalElementsCount", raises: [].}

  proc GDALMDArrayGetDimensionCount*(
    hArray: GDALMDArrayH
  ): csize_t {.cdecl, importc: "GDALMDArrayGetDimensionCount", raises: [].}

  proc GDALMDArrayGetDimensions*(
    hArray: GDALMDArrayH, pnCount: ptr csize_t
  ): ptr GDALDimensionH {.cdecl, importc: "GDALMDArrayGetDimensions", raises: [].}

  proc GDALMDArrayGetDataType*(
    hArray: GDALMDArrayH
  ): GDALExtendedDataTypeH {.cdecl, importc: "GDALMDArrayGetDataType", raises: [].}

  proc GDALMDArrayRead*(
    hArray: GDALMDArrayH,
    arrayStartIdx: ptr GUInt64,
    count: ptr csize_t,
    arrayStep: ptr GInt64,
    bufferStride: ptr GPtrDiff_t,
    bufferDatatype: GDALExtendedDataTypeH,
    pDstBuffer: pointer,
    pDstBufferAllocStart: pointer,
    nDstBufferllocSize: csize_t,
  ): cint {.cdecl, importc: "GDALMDArrayRead", raises: [].}

  proc GDALMDArrayWrite*(
    hArray: GDALMDArrayH,
    arrayStartIdx: ptr GUInt64,
    count: ptr csize_t,
    arrayStep: ptr GInt64,
    bufferStride: ptr GPtrDiff_t,
    bufferDatatype: GDALExtendedDataTypeH,
    pSrcBuffer: pointer,
    psrcBufferAllocStart: pointer,
    nSrcBufferllocSize: csize_t,
  ): cint {.cdecl, importc: "GDALMDArrayWrite", raises: [].}

  proc GDALMDArrayAdviseRead*(
    hArray: GDALMDArrayH, arrayStartIdx: ptr GUInt64, count: ptr csize_t
  ): cint {.cdecl, importc: "GDALMDArrayAdviseRead", raises: [].}

  proc GDALMDArrayAdviseReadEx*(
    hArray: GDALMDArrayH,
    arrayStartIdx: ptr GUInt64,
    count: ptr csize_t,
    papszOptions: CSLConstList,
  ): cint {.cdecl, importc: "GDALMDArrayAdviseReadEx", raises: [].}

  proc GDALMDArrayGetAttribute*(
    hArray: GDALMDArrayH, pszName: cstring
  ): GDALAttributeH {.cdecl, importc: "GDALMDArrayGetAttribute", raises: [].}

  proc GDALMDArrayGetAttributes*(
    hArray: GDALMDArrayH, pnCount: ptr csize_t, papszOptions: CSLConstList
  ): ptr GDALAttributeH {.cdecl, importc: "GDALMDArrayGetAttributes", raises: [].}

  proc GDALMDArrayCreateAttribute*(
    hArray: GDALMDArrayH,
    pszName: cstring,
    nDimensions: csize_t,
    panDimensions: ptr GUInt64,
    hEDT: GDALExtendedDataTypeH,
    papszOptions: CSLConstList,
  ): GDALAttributeH {.cdecl, importc: "GDALMDArrayCreateAttribute", raises: [].}

  proc GDALMDArrayDeleteAttribute*(
    hArray: GDALMDArrayH, pszName: cstring, papszOptions: CSLConstList
  ): bool {.cdecl, importc: "GDALMDArrayDeleteAttribute", raises: [].}

  proc GDALMDArrayResize*(
    hArray: GDALMDArrayH, panNewDimSizes: ptr GUInt64, papszOptions: CSLConstList
  ): bool {.cdecl, importc: "GDALMDArrayResize", raises: [].}

  proc GDALMDArrayGetRawNoDataValue*(
    hArray: GDALMDArrayH
  ): pointer {.cdecl, importc: "GDALMDArrayGetRawNoDataValue", raises: [].}

  proc GDALMDArrayGetNoDataValueAsDouble*(
    hArray: GDALMDArrayH, pbHasNoDataValue: ptr cint
  ): cdouble {.cdecl, importc: "GDALMDArrayGetNoDataValueAsDouble", raises: [].}

  proc GDALMDArrayGetNoDataValueAsInt64*(
    hArray: GDALMDArrayH, pbHasNoDataValue: ptr cint
  ): int64 {.cdecl, importc: "GDALMDArrayGetNoDataValueAsInt64", raises: [].}

  proc GDALMDArrayGetNoDataValueAsUInt64*(
    hArray: GDALMDArrayH, pbHasNoDataValue: ptr cint
  ): uint64 {.cdecl, importc: "GDALMDArrayGetNoDataValueAsUInt64", raises: [].}

  proc GDALMDArraySetRawNoDataValue*(
    hArray: GDALMDArrayH, a1: pointer
  ): cint {.cdecl, importc: "GDALMDArraySetRawNoDataValue", raises: [].}

  proc GDALMDArraySetNoDataValueAsDouble*(
    hArray: GDALMDArrayH, dfNoDataValue: cdouble
  ): cint {.cdecl, importc: "GDALMDArraySetNoDataValueAsDouble", raises: [].}

  proc GDALMDArraySetNoDataValueAsInt64*(
    hArray: GDALMDArrayH, nNoDataValue: int64
  ): cint {.cdecl, importc: "GDALMDArraySetNoDataValueAsInt64", raises: [].}

  proc GDALMDArraySetNoDataValueAsUInt64*(
    hArray: GDALMDArrayH, nNoDataValue: uint64
  ): cint {.cdecl, importc: "GDALMDArraySetNoDataValueAsUInt64", raises: [].}

  proc GDALMDArraySetScale*(
    hArray: GDALMDArrayH, dfScale: cdouble
  ): cint {.cdecl, importc: "GDALMDArraySetScale", raises: [].}

  proc GDALMDArraySetScaleEx*(
    hArray: GDALMDArrayH, dfScale: cdouble, eStorageType: GDALDataType
  ): cint {.cdecl, importc: "GDALMDArraySetScaleEx", raises: [].}

  proc GDALMDArrayGetScale*(
    hArray: GDALMDArrayH, pbHasValue: ptr cint
  ): cdouble {.cdecl, importc: "GDALMDArrayGetScale", raises: [].}

  proc GDALMDArrayGetScaleEx*(
    hArray: GDALMDArrayH, pbHasValue: ptr cint, peStorageType: ptr GDALDataType
  ): cdouble {.cdecl, importc: "GDALMDArrayGetScaleEx", raises: [].}

  proc GDALMDArraySetOffset*(
    hArray: GDALMDArrayH, dfOffset: cdouble
  ): cint {.cdecl, importc: "GDALMDArraySetOffset", raises: [].}

  proc GDALMDArraySetOffsetEx*(
    hArray: GDALMDArrayH, dfOffset: cdouble, eStorageType: GDALDataType
  ): cint {.cdecl, importc: "GDALMDArraySetOffsetEx", raises: [].}

  proc GDALMDArrayGetOffset*(
    hArray: GDALMDArrayH, pbHasValue: ptr cint
  ): cdouble {.cdecl, importc: "GDALMDArrayGetOffset", raises: [].}

  proc GDALMDArrayGetOffsetEx*(
    hArray: GDALMDArrayH, pbHasValue: ptr cint, peStorageType: ptr GDALDataType
  ): cdouble {.cdecl, importc: "GDALMDArrayGetOffsetEx", raises: [].}

  proc GDALMDArrayGetBlockSize*(
    hArray: GDALMDArrayH, pnCount: ptr csize_t
  ): ptr GUInt64 {.cdecl, importc: "GDALMDArrayGetBlockSize", raises: [].}

  proc GDALMDArraySetUnit*(
    hArray: GDALMDArrayH, a1: cstring
  ): cint {.cdecl, importc: "GDALMDArraySetUnit", raises: [].}

  proc GDALMDArrayGetUnit*(
    hArray: GDALMDArrayH
  ): cstring {.cdecl, importc: "GDALMDArrayGetUnit", raises: [].}

  proc GDALMDArraySetSpatialRef*(
    a0: GDALMDArrayH, a1: OGRSpatialReferenceH
  ): cint {.cdecl, importc: "GDALMDArraySetSpatialRef", raises: [].}

  proc GDALMDArrayGetSpatialRef*(
    hArray: GDALMDArrayH
  ): OGRSpatialReferenceH {.cdecl, importc: "GDALMDArrayGetSpatialRef", raises: [].}

  proc GDALMDArrayGetProcessingChunkSize*(
    hArray: GDALMDArrayH, pnCount: ptr csize_t, nMaxChunkMemory: csize_t
  ): ptr csize_t {.cdecl, importc: "GDALMDArrayGetProcessingChunkSize", raises: [].}

  proc GDALMDArrayGetStructuralInfo*(
    hArray: GDALMDArrayH
  ): CSLConstList {.cdecl, importc: "GDALMDArrayGetStructuralInfo", raises: [].}

  proc GDALMDArrayGetView*(
    hArray: GDALMDArrayH, pszViewExpr: cstring
  ): GDALMDArrayH {.cdecl, importc: "GDALMDArrayGetView", raises: [].}

  proc GDALMDArrayTranspose*(
    hArray: GDALMDArrayH, nNewAxisCount: csize_t, panMapNewAxisToOldAxis: ptr cint
  ): GDALMDArrayH {.cdecl, importc: "GDALMDArrayTranspose", raises: [].}

  proc GDALMDArrayGetUnscaled*(
    hArray: GDALMDArrayH
  ): GDALMDArrayH {.cdecl, importc: "GDALMDArrayGetUnscaled", raises: [].}

  proc GDALMDArrayGetMask*(
    hArray: GDALMDArrayH, papszOptions: CSLConstList
  ): GDALMDArrayH {.cdecl, importc: "GDALMDArrayGetMask", raises: [].}

  proc GDALMDArrayAsClassicDataset*(
    hArray: GDALMDArrayH, iXDim: csize_t, iYDim: csize_t
  ): GDALDatasetH {.cdecl, importc: "GDALMDArrayAsClassicDataset", raises: [].}

  proc GDALMDArrayAsClassicDatasetEx*(
    hArray: GDALMDArrayH,
    iXDim: csize_t,
    iYDim: csize_t,
    hRootGroup: GDALGroupH,
    papszOptions: CSLConstList,
  ): GDALDatasetH {.cdecl, importc: "GDALMDArrayAsClassicDatasetEx", raises: [].}

  proc GDALMDArrayGetStatistics*(
    hArray: GDALMDArrayH,
    a1: GDALDatasetH,
    bApproxOK: cint,
    bForce: cint,
    pdfMin: ptr cdouble,
    pdfMax: ptr cdouble,
    pdfMean: ptr cdouble,
    pdfStdDev: ptr cdouble,
    pnValidCount: ptr GUInt64,
    pfnProgress: GDALProgressFunc,
    pProgressData: pointer,
  ): CPLErr {.cdecl, importc: "GDALMDArrayGetStatistics", raises: [].}

  proc GDALMDArrayComputeStatistics*(
    hArray: GDALMDArrayH,
    a1: GDALDatasetH,
    bApproxOK: cint,
    pdfMin: ptr cdouble,
    pdfMax: ptr cdouble,
    pdfMean: ptr cdouble,
    pdfStdDev: ptr cdouble,
    pnValidCount: ptr GUInt64,
    a8: GDALProgressFunc,
    pProgressData: pointer,
  ): cint {.cdecl, importc: "GDALMDArrayComputeStatistics", raises: [].}

  proc GDALMDArrayComputeStatisticsEx*(
    hArray: GDALMDArrayH,
    a1: GDALDatasetH,
    bApproxOK: cint,
    pdfMin: ptr cdouble,
    pdfMax: ptr cdouble,
    pdfMean: ptr cdouble,
    pdfStdDev: ptr cdouble,
    pnValidCount: ptr GUInt64,
    a8: GDALProgressFunc,
    pProgressData: pointer,
    papszOptions: CSLConstList,
  ): cint {.cdecl, importc: "GDALMDArrayComputeStatisticsEx", raises: [].}

  proc GDALMDArrayGetResampled*(
    hArray: GDALMDArrayH,
    nNewDimCount: csize_t,
    pahNewDims: ptr GDALDimensionH,
    resampleAlg: GDALRIOResampleAlg,
    hTargetSRS: OGRSpatialReferenceH,
    papszOptions: CSLConstList,
  ): GDALMDArrayH {.cdecl, importc: "GDALMDArrayGetResampled", raises: [].}

  proc GDALMDArrayGetGridded*(
    hArray: GDALMDArrayH,
    pszGridOptions: cstring,
    hXArray: GDALMDArrayH,
    hYArray: GDALMDArrayH,
    papszOptions: CSLConstList,
  ): GDALMDArrayH {.cdecl, importc: "GDALMDArrayGetGridded", raises: [].}

  proc GDALMDArrayGetCoordinateVariables*(
    hArray: GDALMDArrayH, pnCount: ptr csize_t
  ): ptr GDALMDArrayH {.
    cdecl, importc: "GDALMDArrayGetCoordinateVariables", raises: []
  .}

  proc GDALMDArrayGetMeshGrid*(
    pahInputArrays: ptr GDALMDArrayH,
    nCountInputArrays: csize_t,
    pnCountOutputArrays: ptr csize_t,
    papszOptions: CSLConstList,
  ): ptr GDALMDArrayH {.cdecl, importc: "GDALMDArrayGetMeshGrid", raises: [].}

  proc GDALMDArrayRawBlockInfoCreate*(): ptr GDALMDArrayRawBlockInfo {.
    cdecl, importc: "GDALMDArrayRawBlockInfoCreate", raises: []
  .}

  proc GDALMDArrayRawBlockInfoRelease*(
    psBlockInfo: ptr GDALMDArrayRawBlockInfo
  ) {.cdecl, importc: "GDALMDArrayRawBlockInfoRelease", raises: [].}

  proc GDALMDArrayGetRawBlockInfo*(
    hArray: GDALMDArrayH,
    panBlockCoordinates: ptr uint64,
    psBlockInfo: ptr GDALMDArrayRawBlockInfo,
  ): bool {.cdecl, importc: "GDALMDArrayGetRawBlockInfo", raises: [].}

  proc GDALMDArrayGetOverviewCount*(
    hArray: GDALMDArrayH
  ): cint {.cdecl, importc: "GDALMDArrayGetOverviewCount", raises: [].}

  proc GDALMDArrayGetOverview*(
    hArray: GDALMDArrayH, nIdx: cint
  ): GDALMDArrayH {.cdecl, importc: "GDALMDArrayGetOverview", raises: [].}

  proc GDALMDArrayBuildOverviews*(
    hArray: GDALMDArrayH,
    pszResampling: cstring,
    nOverviews: cint,
    panOverviewList: ptr cint,
    pfnProgress: GDALProgressFunc,
    pProgressData: pointer,
    papszOptions: CSLConstList,
  ): CPLErr {.cdecl, importc: "GDALMDArrayBuildOverviews", raises: [].}

  proc GDALReleaseArrays*(
    arrays: ptr GDALMDArrayH, nCount: csize_t
  ) {.cdecl, importc: "GDALReleaseArrays", raises: [].}

  proc GDALMDArrayCache*(
    hArray: GDALMDArrayH, papszOptions: CSLConstList
  ): cint {.cdecl, importc: "GDALMDArrayCache", raises: [].}

  proc GDALMDArrayRename*(
    hArray: GDALMDArrayH, pszNewName: cstring
  ): bool {.cdecl, importc: "GDALMDArrayRename", raises: [].}

  proc GDALCreateRasterAttributeTableFromMDArrays*(
    eTableType: GDALRATTableType,
    nArrays: cint,
    ahArrays: ptr GDALMDArrayH,
    paeUsages: ptr GDALRATFieldUsage,
  ): GDALRasterAttributeTableH {.
    cdecl, importc: "GDALCreateRasterAttributeTableFromMDArrays", raises: []
  .}

  proc GDALAttributeRelease*(
    hAttr: GDALAttributeH
  ) {.cdecl, importc: "GDALAttributeRelease", raises: [].}

  proc GDALReleaseAttributes*(
    attributes: ptr GDALAttributeH, nCount: csize_t
  ) {.cdecl, importc: "GDALReleaseAttributes", raises: [].}

  proc GDALAttributeGetName*(
    hAttr: GDALAttributeH
  ): cstring {.cdecl, importc: "GDALAttributeGetName", raises: [].}

  proc GDALAttributeGetFullName*(
    hAttr: GDALAttributeH
  ): cstring {.cdecl, importc: "GDALAttributeGetFullName", raises: [].}

  proc GDALAttributeGetTotalElementsCount*(
    hAttr: GDALAttributeH
  ): GUInt64 {.cdecl, importc: "GDALAttributeGetTotalElementsCount", raises: [].}

  proc GDALAttributeGetDimensionCount*(
    hAttr: GDALAttributeH
  ): csize_t {.cdecl, importc: "GDALAttributeGetDimensionCount", raises: [].}

  proc GDALAttributeGetDimensionsSize*(
    hAttr: GDALAttributeH, pnCount: ptr csize_t
  ): ptr GUInt64 {.cdecl, importc: "GDALAttributeGetDimensionsSize", raises: [].}

  proc GDALAttributeGetDataType*(
    hAttr: GDALAttributeH
  ): GDALExtendedDataTypeH {.cdecl, importc: "GDALAttributeGetDataType", raises: [].}

  proc GDALAttributeReadAsRaw*(
    hAttr: GDALAttributeH, pnSize: ptr csize_t
  ): ptr GByte {.cdecl, importc: "GDALAttributeReadAsRaw", raises: [].}

  proc GDALAttributeFreeRawResult*(
    hAttr: GDALAttributeH, raw: ptr GByte, nSize: csize_t
  ) {.cdecl, importc: "GDALAttributeFreeRawResult", raises: [].}

  proc GDALAttributeReadAsString*(
    hAttr: GDALAttributeH
  ): cstring {.cdecl, importc: "GDALAttributeReadAsString", raises: [].}

  proc GDALAttributeReadAsInt*(
    hAttr: GDALAttributeH
  ): cint {.cdecl, importc: "GDALAttributeReadAsInt", raises: [].}

  proc GDALAttributeReadAsInt64*(
    hAttr: GDALAttributeH
  ): int64 {.cdecl, importc: "GDALAttributeReadAsInt64", raises: [].}

  proc GDALAttributeReadAsDouble*(
    hAttr: GDALAttributeH
  ): cdouble {.cdecl, importc: "GDALAttributeReadAsDouble", raises: [].}

  proc GDALAttributeReadAsStringArray*(
    hAttr: GDALAttributeH
  ): cstringArray {.cdecl, importc: "GDALAttributeReadAsStringArray", raises: [].}

  proc GDALAttributeReadAsIntArray*(
    hAttr: GDALAttributeH, pnCount: ptr csize_t
  ): ptr cint {.cdecl, importc: "GDALAttributeReadAsIntArray", raises: [].}

  proc GDALAttributeReadAsInt64Array*(
    hAttr: GDALAttributeH, pnCount: ptr csize_t
  ): ptr int64 {.cdecl, importc: "GDALAttributeReadAsInt64Array", raises: [].}

  proc GDALAttributeReadAsDoubleArray*(
    hAttr: GDALAttributeH, pnCount: ptr csize_t
  ): ptr cdouble {.cdecl, importc: "GDALAttributeReadAsDoubleArray", raises: [].}

  proc GDALAttributeWriteRaw*(
    hAttr: GDALAttributeH, a1: pointer, a2: csize_t
  ): cint {.cdecl, importc: "GDALAttributeWriteRaw", raises: [].}

  proc GDALAttributeWriteString*(
    hAttr: GDALAttributeH, a1: cstring
  ): cint {.cdecl, importc: "GDALAttributeWriteString", raises: [].}

  proc GDALAttributeWriteStringArray*(
    hAttr: GDALAttributeH, a1: CSLConstList
  ): cint {.cdecl, importc: "GDALAttributeWriteStringArray", raises: [].}

  proc GDALAttributeWriteInt*(
    hAttr: GDALAttributeH, a1: cint
  ): cint {.cdecl, importc: "GDALAttributeWriteInt", raises: [].}

  proc GDALAttributeWriteIntArray*(
    hAttr: GDALAttributeH, a1: ptr cint, a2: csize_t
  ): cint {.cdecl, importc: "GDALAttributeWriteIntArray", raises: [].}

  proc GDALAttributeWriteInt64*(
    hAttr: GDALAttributeH, a1: int64
  ): cint {.cdecl, importc: "GDALAttributeWriteInt64", raises: [].}

  proc GDALAttributeWriteInt64Array*(
    hAttr: GDALAttributeH, a1: ptr int64, a2: csize_t
  ): cint {.cdecl, importc: "GDALAttributeWriteInt64Array", raises: [].}

  proc GDALAttributeWriteDouble*(
    hAttr: GDALAttributeH, a1: cdouble
  ): cint {.cdecl, importc: "GDALAttributeWriteDouble", raises: [].}

  proc GDALAttributeWriteDoubleArray*(
    hAttr: GDALAttributeH, a1: ptr cdouble, a2: csize_t
  ): cint {.cdecl, importc: "GDALAttributeWriteDoubleArray", raises: [].}

  proc GDALAttributeRename*(
    hAttr: GDALAttributeH, pszNewName: cstring
  ): bool {.cdecl, importc: "GDALAttributeRename", raises: [].}

  proc GDALDimensionRelease*(
    hDim: GDALDimensionH
  ) {.cdecl, importc: "GDALDimensionRelease", raises: [].}

  proc GDALReleaseDimensions*(
    dims: ptr GDALDimensionH, nCount: csize_t
  ) {.cdecl, importc: "GDALReleaseDimensions", raises: [].}

  proc GDALDimensionGetName*(
    hDim: GDALDimensionH
  ): cstring {.cdecl, importc: "GDALDimensionGetName", raises: [].}

  proc GDALDimensionGetFullName*(
    hDim: GDALDimensionH
  ): cstring {.cdecl, importc: "GDALDimensionGetFullName", raises: [].}

  proc GDALDimensionGetType*(
    hDim: GDALDimensionH
  ): cstring {.cdecl, importc: "GDALDimensionGetType", raises: [].}

  proc GDALDimensionGetDirection*(
    hDim: GDALDimensionH
  ): cstring {.cdecl, importc: "GDALDimensionGetDirection", raises: [].}

  proc GDALDimensionGetSize*(
    hDim: GDALDimensionH
  ): GUInt64 {.cdecl, importc: "GDALDimensionGetSize", raises: [].}

  proc GDALDimensionGetIndexingVariable*(
    hDim: GDALDimensionH
  ): GDALMDArrayH {.cdecl, importc: "GDALDimensionGetIndexingVariable", raises: [].}

  proc GDALDimensionSetIndexingVariable*(
    hDim: GDALDimensionH, hArray: GDALMDArrayH
  ): cint {.cdecl, importc: "GDALDimensionSetIndexingVariable", raises: [].}

  proc GDALDimensionRename*(
    hDim: GDALDimensionH, pszNewName: cstring
  ): bool {.cdecl, importc: "GDALDimensionRename", raises: [].}

  proc GDALSetAdbcLoadDriverOverride*(
    init_func: GDALAdbcLoadDriverFunc
  ) {.cdecl, importc: "GDALSetAdbcLoadDriverOverride", raises: [].}

  proc GDALGetAdbcLoadDriverOverride*(): GDALAdbcLoadDriverFunc {.
    cdecl, importc: "GDALGetAdbcLoadDriverOverride", raises: []
  .}

  proc GDALComputeMedianCutPCT*(
    hRed: GDALRasterBandH,
    hGreen: GDALRasterBandH,
    hBlue: GDALRasterBandH,
    pfnIncludePixel: proc(a0: cint, a1: cint, a2: pointer): cint {.cdecl, raises: [].},
    nColors: cint,
    hColorTable: GDALColorTableH,
    pfnProgress: GDALProgressFunc,
    pProgressArg: pointer,
  ): cint {.gdalCall, importc: "GDALComputeMedianCutPCT", raises: [].}

  proc GDALDitherRGB2PCT*(
    hRed: GDALRasterBandH,
    hGreen: GDALRasterBandH,
    hBlue: GDALRasterBandH,
    hTarget: GDALRasterBandH,
    hColorTable: GDALColorTableH,
    pfnProgress: GDALProgressFunc,
    pProgressArg: pointer,
  ): cint {.gdalCall, importc: "GDALDitherRGB2PCT", raises: [].}

  proc GDALChecksumImage*(
    hBand: GDALRasterBandH, nXOff: cint, nYOff: cint, nXSize: cint, nYSize: cint
  ): cint {.gdalCall, importc: "GDALChecksumImage", raises: [].}

  proc GDALComputeProximity*(
    hSrcBand: GDALRasterBandH,
    hProximityBand: GDALRasterBandH,
    papszOptions: cstringArray,
    pfnProgress: GDALProgressFunc,
    pProgressArg: pointer,
  ): CPLErr {.gdalCall, importc: "GDALComputeProximity", raises: [].}

  proc GDALFillNodata*(
    hTargetBand: GDALRasterBandH,
    hMaskBand: GDALRasterBandH,
    dfMaxSearchDist: cdouble,
    bDeprecatedOption: cint,
    nSmoothingIterations: cint,
    papszOptions: cstringArray,
    pfnProgress: GDALProgressFunc,
    pProgressArg: pointer,
  ): CPLErr {.gdalCall, importc: "GDALFillNodata", raises: [].}

  proc GDALPolygonize*(
    hSrcBand: GDALRasterBandH,
    hMaskBand: GDALRasterBandH,
    hOutLayer: OGRLayerH,
    iPixValField: cint,
    papszOptions: cstringArray,
    pfnProgress: GDALProgressFunc,
    pProgressArg: pointer,
  ): CPLErr {.gdalCall, importc: "GDALPolygonize", raises: [].}

  proc GDALFPolygonize*(
    hSrcBand: GDALRasterBandH,
    hMaskBand: GDALRasterBandH,
    hOutLayer: OGRLayerH,
    iPixValField: cint,
    papszOptions: cstringArray,
    pfnProgress: GDALProgressFunc,
    pProgressArg: pointer,
  ): CPLErr {.gdalCall, importc: "GDALFPolygonize", raises: [].}

  proc GDALSieveFilter*(
    hSrcBand: GDALRasterBandH,
    hMaskBand: GDALRasterBandH,
    hDstBand: GDALRasterBandH,
    nSizeThreshold: cint,
    nConnectedness: cint,
    papszOptions: cstringArray,
    pfnProgress: GDALProgressFunc,
    pProgressArg: pointer,
  ): CPLErr {.gdalCall, importc: "GDALSieveFilter", raises: [].}

  proc GDALDestroyTransformer*(
    pTransformerArg: pointer
  ) {.cdecl, importc: "GDALDestroyTransformer", raises: [].}

  proc GDALUseTransformer*(
    pTransformerArg: pointer,
    bDstToSrc: cint,
    nPointCount: cint,
    x: ptr cdouble,
    y: ptr cdouble,
    z: ptr cdouble,
    panSuccess: ptr cint,
  ): cint {.cdecl, importc: "GDALUseTransformer", raises: [].}

  proc GDALCreateSimilarTransformer*(
    psTransformerArg: pointer, dfSrcRatioX: cdouble, dfSrcRatioY: cdouble
  ): pointer {.cdecl, importc: "GDALCreateSimilarTransformer", raises: [].}

  proc GDALGetGenImgProjTranformerOptionList*(): cstring {.
    cdecl, importc: "GDALGetGenImgProjTranformerOptionList", raises: []
  .}

  proc GDALCreateGenImgProjTransformer*(
    hSrcDS: GDALDatasetH,
    pszSrcWKT: cstring,
    hDstDS: GDALDatasetH,
    pszDstWKT: cstring,
    bGCPUseOK: cint,
    dfGCPErrorThreshold: cdouble,
    nOrder: cint,
  ): pointer {.cdecl, importc: "GDALCreateGenImgProjTransformer", raises: [].}

  proc GDALCreateGenImgProjTransformer2*(
    hSrcDS: GDALDatasetH, hDstDS: GDALDatasetH, papszOptions: CSLConstList
  ): pointer {.cdecl, importc: "GDALCreateGenImgProjTransformer2", raises: [].}

  proc GDALCreateGenImgProjTransformer3*(
    pszSrcWKT: cstring,
    padfSrcGeoTransform: ptr cdouble,
    pszDstWKT: cstring,
    padfDstGeoTransform: ptr cdouble,
  ): pointer {.cdecl, importc: "GDALCreateGenImgProjTransformer3", raises: [].}

  proc GDALCreateGenImgProjTransformer4*(
    hSrcSRS: OGRSpatialReferenceH,
    padfSrcGeoTransform: ptr cdouble,
    hDstSRS: OGRSpatialReferenceH,
    padfDstGeoTransform: ptr cdouble,
    papszOptions: cstringArray,
  ): pointer {.cdecl, importc: "GDALCreateGenImgProjTransformer4", raises: [].}

  proc GDALSetGenImgProjTransformerDstGeoTransform*(
    a0: pointer, a1: ptr cdouble
  ) {.cdecl, importc: "GDALSetGenImgProjTransformerDstGeoTransform", raises: [].}

  proc GDALDestroyGenImgProjTransformer*(
    a0: pointer
  ) {.cdecl, importc: "GDALDestroyGenImgProjTransformer", raises: [].}

  proc GDALGenImgProjTransform*(
    pTransformArg: pointer,
    bDstToSrc: cint,
    nPointCount: cint,
    x: ptr cdouble,
    y: ptr cdouble,
    z: ptr cdouble,
    panSuccess: ptr cint,
  ): cint {.cdecl, importc: "GDALGenImgProjTransform", raises: [].}

  proc GDALSetTransformerDstGeoTransform*(
    a0: pointer, a1: ptr cdouble
  ) {.cdecl, importc: "GDALSetTransformerDstGeoTransform", raises: [].}

  proc GDALGetTransformerDstGeoTransform*(
    a0: pointer, a1: ptr cdouble
  ) {.cdecl, importc: "GDALGetTransformerDstGeoTransform", raises: [].}

  proc GDALCreateReprojectionTransformer*(
    pszSrcWKT: cstring, pszDstWKT: cstring
  ): pointer {.cdecl, importc: "GDALCreateReprojectionTransformer", raises: [].}

  proc GDALCreateReprojectionTransformerEx*(
    hSrcSRS: OGRSpatialReferenceH,
    hDstSRS: OGRSpatialReferenceH,
    papszOptions: cstringArray,
  ): pointer {.cdecl, importc: "GDALCreateReprojectionTransformerEx", raises: [].}

  proc GDALDestroyReprojectionTransformer*(
    a0: pointer
  ) {.cdecl, importc: "GDALDestroyReprojectionTransformer", raises: [].}

  proc GDALReprojectionTransform*(
    pTransformArg: pointer,
    bDstToSrc: cint,
    nPointCount: cint,
    x: ptr cdouble,
    y: ptr cdouble,
    z: ptr cdouble,
    panSuccess: ptr cint,
  ): cint {.cdecl, importc: "GDALReprojectionTransform", raises: [].}

  proc GDALCreateGCPTransformer*(
    nGCPCount: cint, pasGCPList: ptr GDAL_GCP, nReqOrder: cint, bReversed: cint
  ): pointer {.cdecl, importc: "GDALCreateGCPTransformer", raises: [].}

  proc GDALCreateGCPRefineTransformer*(
    nGCPCount: cint,
    pasGCPList: ptr GDAL_GCP,
    nReqOrder: cint,
    bReversed: cint,
    tolerance: cdouble,
    minimumGcps: cint,
  ): pointer {.cdecl, importc: "GDALCreateGCPRefineTransformer", raises: [].}

  proc GDALDestroyGCPTransformer*(
    pTransformArg: pointer
  ) {.cdecl, importc: "GDALDestroyGCPTransformer", raises: [].}

  proc GDALGCPTransform*(
    pTransformArg: pointer,
    bDstToSrc: cint,
    nPointCount: cint,
    x: ptr cdouble,
    y: ptr cdouble,
    z: ptr cdouble,
    panSuccess: ptr cint,
  ): cint {.cdecl, importc: "GDALGCPTransform", raises: [].}

  proc GDALCreateHomographyTransformer*(
    adfHomography: ptr cdouble
  ): pointer {.cdecl, importc: "GDALCreateHomographyTransformer", raises: [].}

  proc GDALCreateHomographyTransformerFromGCPs*(
    nGCPCount: cint, pasGCPList: ptr GDAL_GCP
  ): pointer {.cdecl, importc: "GDALCreateHomographyTransformerFromGCPs", raises: [].}

  proc GDALDestroyHomographyTransformer*(
    pTransformArg: pointer
  ) {.cdecl, importc: "GDALDestroyHomographyTransformer", raises: [].}

  proc GDALHomographyTransform*(
    pTransformArg: pointer,
    bDstToSrc: cint,
    nPointCount: cint,
    x: ptr cdouble,
    y: ptr cdouble,
    z: ptr cdouble,
    panSuccess: ptr cint,
  ): cint {.cdecl, importc: "GDALHomographyTransform", raises: [].}

  proc GDALCreateTPSTransformer*(
    nGCPCount: cint, pasGCPList: ptr GDAL_GCP, bReversed: cint
  ): pointer {.cdecl, importc: "GDALCreateTPSTransformer", raises: [].}

  proc GDALDestroyTPSTransformer*(
    pTransformArg: pointer
  ) {.cdecl, importc: "GDALDestroyTPSTransformer", raises: [].}

  proc GDALTPSTransform*(
    pTransformArg: pointer,
    bDstToSrc: cint,
    nPointCount: cint,
    x: ptr cdouble,
    y: ptr cdouble,
    z: ptr cdouble,
    panSuccess: ptr cint,
  ): cint {.cdecl, importc: "GDALTPSTransform", raises: [].}

  proc RPCInfoV1ToMD*(
    psRPCInfo: ptr GDALRPCInfoV1
  ): cstringArray {.cdecl, importc: "RPCInfoToMD", raises: [].}

  proc RPCInfoV2ToMD*(
    psRPCInfo: ptr GDALRPCInfoV2
  ): cstringArray {.cdecl, importc: "RPCInfoV2ToMD", raises: [].}

  proc GDALCreateRPCTransformerV1*(
    psRPC: ptr GDALRPCInfoV1,
    bReversed: cint,
    dfPixErrThreshold: cdouble,
    papszOptions: cstringArray,
  ): pointer {.cdecl, importc: "GDALCreateRPCTransformer", raises: [].}

  proc GDALCreateRPCTransformerV2*(
    psRPC: ptr GDALRPCInfoV2,
    bReversed: cint,
    dfPixErrThreshold: cdouble,
    papszOptions: CSLConstList,
  ): pointer {.cdecl, importc: "GDALCreateRPCTransformerV2", raises: [].}

  proc GDALDestroyRPCTransformer*(
    pTransformArg: pointer
  ) {.cdecl, importc: "GDALDestroyRPCTransformer", raises: [].}

  proc GDALRPCTransform*(
    pTransformArg: pointer,
    bDstToSrc: cint,
    nPointCount: cint,
    x: ptr cdouble,
    y: ptr cdouble,
    z: ptr cdouble,
    panSuccess: ptr cint,
  ): cint {.cdecl, importc: "GDALRPCTransform", raises: [].}

  proc GDALCreateGeoLocTransformer*(
    hBaseDS: GDALDatasetH, papszGeolocationInfo: cstringArray, bReversed: cint
  ): pointer {.cdecl, importc: "GDALCreateGeoLocTransformer", raises: [].}

  proc GDALDestroyGeoLocTransformer*(
    pTransformArg: pointer
  ) {.cdecl, importc: "GDALDestroyGeoLocTransformer", raises: [].}

  proc GDALGeoLocTransform*(
    pTransformArg: pointer,
    bDstToSrc: cint,
    nPointCount: cint,
    x: ptr cdouble,
    y: ptr cdouble,
    z: ptr cdouble,
    panSuccess: ptr cint,
  ): cint {.cdecl, importc: "GDALGeoLocTransform", raises: [].}

  proc GDALCreateApproxTransformer*(
    pfnRawTransformer: GDALTransformerFunc,
    pRawTransformerArg: pointer,
    dfMaxError: cdouble,
  ): pointer {.cdecl, importc: "GDALCreateApproxTransformer", raises: [].}

  proc GDALApproxTransformerOwnsSubtransformer*(
    pCBData: pointer, bOwnFlag: cint
  ) {.cdecl, importc: "GDALApproxTransformerOwnsSubtransformer", raises: [].}

  proc GDALDestroyApproxTransformer*(
    pApproxArg: pointer
  ) {.cdecl, importc: "GDALDestroyApproxTransformer", raises: [].}

  proc GDALApproxTransform*(
    pTransformArg: pointer,
    bDstToSrc: cint,
    nPointCount: cint,
    x: ptr cdouble,
    y: ptr cdouble,
    z: ptr cdouble,
    panSuccess: ptr cint,
  ): cint {.cdecl, importc: "GDALApproxTransform", raises: [].}

  proc GDALSimpleImageWarp*(
    hSrcDS: GDALDatasetH,
    hDstDS: GDALDatasetH,
    nBandCount: cint,
    panBandList: ptr cint,
    pfnTransform: GDALTransformerFunc,
    pTransformArg: pointer,
    pfnProgress: GDALProgressFunc,
    pProgressArg: pointer,
    papszWarpOptions: cstringArray,
  ): cint {.gdalCall, importc: "GDALSimpleImageWarp", raises: [].}

  proc GDALSuggestedWarpOutput*(
    hSrcDS: GDALDatasetH,
    pfnTransformer: GDALTransformerFunc,
    pTransformArg: pointer,
    padfGeoTransformOut: ptr cdouble,
    pnPixels: ptr cint,
    pnLines: ptr cint,
  ): CPLErr {.gdalCall, importc: "GDALSuggestedWarpOutput", raises: [].}

  proc GDALSuggestedWarpOutput2*(
    hSrcDS: GDALDatasetH,
    pfnTransformer: GDALTransformerFunc,
    pTransformArg: pointer,
    padfGeoTransformOut: ptr cdouble,
    pnPixels: ptr cint,
    pnLines: ptr cint,
    padfExtent: ptr cdouble,
    nOptions: cint,
  ): CPLErr {.gdalCall, importc: "GDALSuggestedWarpOutput2", raises: [].}

  proc GDALSerializeTransformer*(
    pfnFunc: GDALTransformerFunc, pTransformArg: pointer
  ): ptr CPLXMLNode {.cdecl, importc: "GDALSerializeTransformer", raises: [].}

  proc GDALDeserializeTransformer*(
    psTree: ptr CPLXMLNode,
    ppfnFunc: ptr GDALTransformerFunc,
    ppTransformArg: ptr pointer,
  ): CPLErr {.cdecl, importc: "GDALDeserializeTransformer", raises: [].}

  proc GDALTransformGeolocations*(
    hXBand: GDALRasterBandH,
    hYBand: GDALRasterBandH,
    hZBand: GDALRasterBandH,
    pfnTransformer: GDALTransformerFunc,
    pTransformArg: pointer,
    pfnProgress: GDALProgressFunc,
    pProgressArg: pointer,
    papszOptions: cstringArray,
  ): CPLErr {.cdecl, importc: "GDALTransformGeolocations", raises: [].}

  proc GDAL_CG_Create*(
    nWidth: cint,
    nHeight: cint,
    bNoDataSet: cint,
    dfNoDataValue: cdouble,
    dfContourInterval: cdouble,
    dfContourBase: cdouble,
    pfnWriter: GDALContourWriter,
    pCBData: pointer,
  ): GDALContourGeneratorH {.cdecl, importc: "GDAL_CG_Create", raises: [].}

  proc GDAL_CG_FeedLine*(
    hCG: GDALContourGeneratorH, padfScanline: ptr cdouble
  ): CPLErr {.cdecl, importc: "GDAL_CG_FeedLine", raises: [].}

  proc GDAL_CG_Destroy*(
    hCG: GDALContourGeneratorH
  ) {.cdecl, importc: "GDAL_CG_Destroy", raises: [].}

  proc OGRContourWriter*(
    a0: cdouble, a1: cint, a2: ptr cdouble, a3: ptr cdouble, pInfo: pointer
  ): CPLErr {.cdecl, importc: "OGRContourWriter", raises: [].}

  proc GDALContourGenerate*(
    hBand: GDALRasterBandH,
    dfContourInterval: cdouble,
    dfContourBase: cdouble,
    nFixedLevelCount: cint,
    padfFixedLevels: ptr cdouble,
    bUseNoData: cint,
    dfNoDataValue: cdouble,
    hLayer: pointer,
    iIDField: cint,
    iElevField: cint,
    pfnProgress: GDALProgressFunc,
    pProgressArg: pointer,
  ): CPLErr {.cdecl, importc: "GDALContourGenerate", raises: [].}

  proc GDALContourGenerateEx*(
    hBand: GDALRasterBandH,
    hLayer: pointer,
    options: CSLConstList,
    pfnProgress: GDALProgressFunc,
    pProgressArg: pointer,
  ): CPLErr {.cdecl, importc: "GDALContourGenerateEx", raises: [].}

  proc GDALViewshedGenerate*(
    hBand: GDALRasterBandH,
    pszDriverName: cstring,
    pszTargetRasterName: cstring,
    papszCreationOptions: CSLConstList,
    dfObserverX: cdouble,
    dfObserverY: cdouble,
    dfObserverHeight: cdouble,
    dfTargetHeight: cdouble,
    dfVisibleVal: cdouble,
    dfInvisibleVal: cdouble,
    dfOutOfRangeVal: cdouble,
    dfNoDataVal: cdouble,
    dfCurvCoeff: cdouble,
    eMode: GDALViewshedMode,
    dfMaxDistance: cdouble,
    pfnProgress: GDALProgressFunc,
    pProgressArg: pointer,
    heightMode: GDALViewshedOutputType,
    papszExtraOptions: CSLConstList,
  ): GDALDatasetH {.cdecl, importc: "GDALViewshedGenerate", raises: [].}

  proc GDALIsLineOfSightVisible*(
    a0: GDALRasterBandH,
    xA: cint,
    yA: cint,
    zA: cdouble,
    xB: cint,
    yB: cint,
    zB: cdouble,
    pnxTerrainIntersection: ptr cint,
    pnyTerrainIntersection: ptr cint,
    papszOptions: CSLConstList,
  ): bool {.cdecl, importc: "GDALIsLineOfSightVisible", raises: [].}

  proc GDALRasterizeGeometries*(
    hDS: GDALDatasetH,
    nBandCount: cint,
    panBandList: ptr cint,
    nGeomCount: cint,
    pahGeometries: ptr OGRGeometryH,
    pfnTransformer: GDALTransformerFunc,
    pTransformArg: pointer,
    padfGeomBurnValues: ptr cdouble,
    papszOptions: CSLConstList,
    pfnProgress: GDALProgressFunc,
    pProgressArg: pointer,
  ): CPLErr {.cdecl, importc: "GDALRasterizeGeometries", raises: [].}

  proc GDALRasterizeGeometriesInt64*(
    hDS: GDALDatasetH,
    nBandCount: cint,
    panBandList: ptr cint,
    nGeomCount: cint,
    pahGeometries: ptr OGRGeometryH,
    pfnTransformer: GDALTransformerFunc,
    pTransformArg: pointer,
    panGeomBurnValues: ptr int64,
    papszOptions: CSLConstList,
    pfnProgress: GDALProgressFunc,
    pProgressArg: pointer,
  ): CPLErr {.cdecl, importc: "GDALRasterizeGeometriesInt64", raises: [].}

  proc GDALRasterizeLayers*(
    hDS: GDALDatasetH,
    nBandCount: cint,
    panBandList: ptr cint,
    nLayerCount: cint,
    pahLayers: ptr OGRLayerH,
    pfnTransformer: GDALTransformerFunc,
    pTransformArg: pointer,
    padfLayerBurnValues: ptr cdouble,
    papszOptions: cstringArray,
    pfnProgress: GDALProgressFunc,
    pProgressArg: pointer,
  ): CPLErr {.cdecl, importc: "GDALRasterizeLayers", raises: [].}

  proc GDALRasterizeLayersBuf*(
    pData: pointer,
    nBufXSize: cint,
    nBufYSize: cint,
    eBufType: GDALDataType,
    nPixelSpace: cint,
    nLineSpace: cint,
    nLayerCount: cint,
    pahLayers: ptr OGRLayerH,
    pszDstProjection: cstring,
    padfDstGeoTransform: ptr cdouble,
    pfnTransformer: GDALTransformerFunc,
    pTransformArg: pointer,
    dfBurnValue: cdouble,
    papszOptions: cstringArray,
    pfnProgress: GDALProgressFunc,
    pProgressArg: pointer,
  ): CPLErr {.cdecl, importc: "GDALRasterizeLayersBuf", raises: [].}

  proc GDALGridCreate*(
    a0: GDALGridAlgorithm,
    a1: pointer,
    a2: GUInt32,
    a3: ptr cdouble,
    a4: ptr cdouble,
    a5: ptr cdouble,
    a6: cdouble,
    a7: cdouble,
    a8: cdouble,
    a9: cdouble,
    a10: GUInt32,
    a11: GUInt32,
    a12: GDALDataType,
    a13: pointer,
    a14: GDALProgressFunc,
    a15: pointer,
  ): CPLErr {.cdecl, importc: "GDALGridCreate", raises: [].}

  proc GDALGridContextCreate*(
    eAlgorithm: GDALGridAlgorithm,
    poOptions: pointer,
    nPoints: GUInt32,
    padfX: ptr cdouble,
    padfY: ptr cdouble,
    padfZ: ptr cdouble,
    bCallerWillKeepPointArraysAlive: cint,
  ): ptr GDALGridContext {.cdecl, importc: "GDALGridContextCreate", raises: [].}

  proc GDALGridContextFree*(
    psContext: ptr GDALGridContext
  ) {.cdecl, importc: "GDALGridContextFree", raises: [].}

  proc GDALGridContextProcess*(
    psContext: ptr GDALGridContext,
    dfXMin: cdouble,
    dfXMax: cdouble,
    dfYMin: cdouble,
    dfYMax: cdouble,
    nXSize: GUInt32,
    nYSize: GUInt32,
    eType: GDALDataType,
    pData: pointer,
    pfnProgress: GDALProgressFunc,
    pProgressArg: pointer,
  ): CPLErr {.cdecl, importc: "GDALGridContextProcess", raises: [].}

  proc GDALComputeMatchingPoints*(
    hFirstImage: GDALDatasetH,
    hSecondImage: GDALDatasetH,
    papszOptions: cstringArray,
    pnGCPCount: ptr cint,
  ): ptr GDAL_GCP {.cdecl, importc: "GDALComputeMatchingPoints", raises: [].}

  proc GDALHasTriangulation*(): cint {.
    cdecl, importc: "GDALHasTriangulation", raises: []
  .}

  proc GDALTriangulationCreateDelaunay*(
    nPoints: cint, padfX: ptr cdouble, padfY: ptr cdouble
  ): ptr GDALTriangulation {.
    cdecl, importc: "GDALTriangulationCreateDelaunay", raises: []
  .}

  proc GDALTriangulationComputeBarycentricCoefficients*(
    psDT: ptr GDALTriangulation, padfX: ptr cdouble, padfY: ptr cdouble
  ): cint {.
    cdecl, importc: "GDALTriangulationComputeBarycentricCoefficients", raises: []
  .}

  proc GDALTriangulationComputeBarycentricCoordinates*(
    psDT: ptr GDALTriangulation,
    nFacetIdx: cint,
    dfX: cdouble,
    dfY: cdouble,
    pdfL1: ptr cdouble,
    pdfL2: ptr cdouble,
    pdfL3: ptr cdouble,
  ): cint {.
    cdecl, importc: "GDALTriangulationComputeBarycentricCoordinates", raises: []
  .}

  proc GDALTriangulationFindFacetBruteForce*(
    psDT: ptr GDALTriangulation, dfX: cdouble, dfY: cdouble, panOutputFacetIdx: ptr cint
  ): cint {.cdecl, importc: "GDALTriangulationFindFacetBruteForce", raises: [].}

  proc GDALTriangulationFindFacetDirected*(
    psDT: ptr GDALTriangulation,
    nFacetIdx: cint,
    dfX: cdouble,
    dfY: cdouble,
    panOutputFacetIdx: ptr cint,
  ): cint {.cdecl, importc: "GDALTriangulationFindFacetDirected", raises: [].}

  proc GDALTriangulationFree*(
    psDT: ptr GDALTriangulation
  ) {.cdecl, importc: "GDALTriangulationFree", raises: [].}

  proc GDALOpenVerticalShiftGrid*(
    pszProj4Geoidgrids: cstring, pbError: ptr cint
  ): GDALDatasetH {.cdecl, importc: "GDALOpenVerticalShiftGrid", raises: [].}

  proc GDALApplyVerticalShiftGrid*(
    hSrcDataset: GDALDatasetH,
    hGridDataset: GDALDatasetH,
    bInverse: cint,
    dfSrcUnitToMeter: cdouble,
    dfDstUnitToMeter: cdouble,
    papszOptions: cstringArray,
  ): GDALDatasetH {.cdecl, importc: "GDALApplyVerticalShiftGrid", raises: [].}

  proc GDALZonalStats*(
    hSrcDS: GDALDatasetH,
    hWeightsDS: GDALDatasetH,
    hZonesDS: GDALDatasetH,
    hOutDS: GDALDatasetH,
    papszOptions: CSLConstList,
    pfnProgress: GDALProgressFunc,
    pProgressArg: pointer,
  ): CPLErr {.cdecl, importc: "GDALZonalStats", raises: [].}

  proc GDALHilbertCode*(
    poDomain: ptr OGREnvelope, dfX: cdouble, dfY: cdouble
  ): uint32 {.cdecl, importc: "GDALHilbertCode", raises: [].}

  proc GDALDefaultCSVFilename*(
    pszBasename: cstring
  ): cstring {.cdecl, importc: "GDALDefaultCSVFilename", raises: [].}

  proc GDALRegister_GTiff*() {.cdecl, importc: "GDALRegister_GTiff", raises: [].}
  proc GDALRegister_LIBERTIFF*() {.
    cdecl, importc: "GDALRegister_LIBERTIFF", raises: []
  .}

  proc GDALRegister_GXF*() {.cdecl, importc: "GDALRegister_GXF", raises: [].}
  proc GDALRegister_HFA*() {.cdecl, importc: "GDALRegister_HFA", raises: [].}
  proc GDALRegister_AAIGrid*() {.cdecl, importc: "GDALRegister_AAIGrid", raises: [].}
  proc GDALRegister_GRASSASCIIGrid*() {.
    cdecl, importc: "GDALRegister_GRASSASCIIGrid", raises: []
  .}

  proc GDALRegister_ISG*() {.cdecl, importc: "GDALRegister_ISG", raises: [].}
  proc GDALRegister_AIGrid*() {.cdecl, importc: "GDALRegister_AIGrid", raises: [].}
  proc GDALRegister_CEOS*() {.cdecl, importc: "GDALRegister_CEOS", raises: [].}
  proc GDALRegister_SAR_CEOS*() {.cdecl, importc: "GDALRegister_SAR_CEOS", raises: [].}
  proc GDALRegister_EHdr*() {.cdecl, importc: "GDALRegister_EHdr", raises: [].}
  proc GDALRegister_GenBin*() {.cdecl, importc: "GDALRegister_GenBin", raises: [].}
  proc GDALRegister_PAux*() {.cdecl, importc: "GDALRegister_PAux", raises: [].}
  proc GDALRegister_ENVI*() {.cdecl, importc: "GDALRegister_ENVI", raises: [].}
  proc GDALRegister_DOQ1*() {.cdecl, importc: "GDALRegister_DOQ1", raises: [].}
  proc GDALRegister_DOQ2*() {.cdecl, importc: "GDALRegister_DOQ2", raises: [].}
  proc GDALRegister_DTED*() {.cdecl, importc: "GDALRegister_DTED", raises: [].}
  proc GDALRegister_MFF*() {.cdecl, importc: "GDALRegister_MFF", raises: [].}
  proc GDALRegister_HKV*() {.cdecl, importc: "GDALRegister_HKV", raises: [].}
  proc GDALRegister_PNG*() {.cdecl, importc: "GDALRegister_PNG", raises: [].}
  proc DeclareDeferredPNGPlugin*() {.
    cdecl, importc: "DeclareDeferredPNGPlugin", raises: []
  .}

  proc GDALRegister_DDS*() {.cdecl, importc: "GDALRegister_DDS", raises: [].}
  proc DeclareDeferredDDSPlugin*() {.
    cdecl, importc: "DeclareDeferredDDSPlugin", raises: []
  .}

  proc GDALRegister_GTA*() {.cdecl, importc: "GDALRegister_GTA", raises: [].}
  proc DeclareDeferredGTAPlugin*() {.
    cdecl, importc: "DeclareDeferredGTAPlugin", raises: []
  .}

  proc GDALRegister_JPEG*() {.cdecl, importc: "GDALRegister_JPEG", raises: [].}
  proc DeclareDeferredJPEGPlugin*() {.
    cdecl, importc: "DeclareDeferredJPEGPlugin", raises: []
  .}

  proc GDALRegister_JP2KAK*() {.cdecl, importc: "GDALRegister_JP2KAK", raises: [].}
  proc GDALRegister_JP2Grok*() {.cdecl, importc: "GDALRegister_JP2Grok", raises: [].}
  proc DeclareDeferredJP2KAKPlugin*() {.
    cdecl, importc: "DeclareDeferredJP2KAKPlugin", raises: []
  .}

  proc GDALRegister_JPIPKAK*() {.cdecl, importc: "GDALRegister_JPIPKAK", raises: [].}
  proc DeclareDeferredJPIPKAKPlugin*() {.
    cdecl, importc: "DeclareDeferredJPIPKAKPlugin", raises: []
  .}

  proc GDALRegister_MEM*() {.cdecl, importc: "GDALRegister_MEM", raises: [].}
  proc GDALRegister_JDEM*() {.cdecl, importc: "GDALRegister_JDEM", raises: [].}
  proc GDALRegister_RASDAMAN*() {.cdecl, importc: "GDALRegister_RASDAMAN", raises: [].}
  proc GDALRegister_PNM*() {.cdecl, importc: "GDALRegister_PNM", raises: [].}
  proc GDALRegister_GIF*() {.cdecl, importc: "GDALRegister_GIF", raises: [].}
  proc DeclareDeferredGIFPlugin*() {.
    cdecl, importc: "DeclareDeferredGIFPlugin", raises: []
  .}

  proc GDALRegister_BIGGIF*() {.cdecl, importc: "GDALRegister_BIGGIF", raises: [].}
  proc GDALRegister_Envisat*() {.cdecl, importc: "GDALRegister_Envisat", raises: [].}
  proc GDALRegister_FITS*() {.cdecl, importc: "GDALRegister_FITS", raises: [].}
  proc DeclareDeferredFITSPlugin*() {.
    cdecl, importc: "DeclareDeferredFITSPlugin", raises: []
  .}

  proc GDALRegister_ECW*() {.cdecl, importc: "GDALRegister_ECW", raises: [].}
  proc DeclareDeferredECWPlugin*() {.
    cdecl, importc: "DeclareDeferredECWPlugin", raises: []
  .}

  proc GDALRegister_JP2ECW*() {.cdecl, importc: "GDALRegister_JP2ECW", raises: [].}
  proc GDALRegister_ECW_JP2ECW*() {.
    cdecl, importc: "GDALRegister_ECW_JP2ECW", raises: []
  .}

  proc GDALRegister_FujiBAS*() {.cdecl, importc: "GDALRegister_FujiBAS", raises: [].}
  proc GDALRegister_VRT*() {.cdecl, importc: "GDALRegister_VRT", raises: [].}
  proc GDALRegister_GTI*() {.cdecl, importc: "GDALRegister_GTI", raises: [].}
  proc GDALRegister_USGSDEM*() {.cdecl, importc: "GDALRegister_USGSDEM", raises: [].}
  proc GDALRegister_FAST*() {.cdecl, importc: "GDALRegister_FAST", raises: [].}
  proc GDALRegister_HDF4*() {.cdecl, importc: "GDALRegister_HDF4", raises: [].}
  proc DeclareDeferredHDF4Plugin*() {.
    cdecl, importc: "DeclareDeferredHDF4Plugin", raises: []
  .}

  proc GDALRegister_HDF4Image*() {.
    cdecl, importc: "GDALRegister_HDF4Image", raises: []
  .}

  proc GDALRegister_L1B*() {.cdecl, importc: "GDALRegister_L1B", raises: [].}
  proc GDALRegister_LDF*() {.cdecl, importc: "GDALRegister_LDF", raises: [].}
  proc GDALRegister_BSB*() {.cdecl, importc: "GDALRegister_BSB", raises: [].}
  proc GDALRegister_BMP*() {.cdecl, importc: "GDALRegister_BMP", raises: [].}
  proc GDALRegister_GSC*() {.cdecl, importc: "GDALRegister_GSC", raises: [].}
  proc GDALRegister_NITF*() {.cdecl, importc: "GDALRegister_NITF", raises: [].}
  proc DeclareDeferredNITFPlugin*() {.
    cdecl, importc: "DeclareDeferredNITFPlugin", raises: []
  .}

  proc GDALRegister_RPFTOC*() {.cdecl, importc: "GDALRegister_RPFTOC", raises: [].}
  proc GDALRegister_ECRGTOC*() {.cdecl, importc: "GDALRegister_ECRGTOC", raises: [].}
  proc GDALRegister_MrSID*() {.cdecl, importc: "GDALRegister_MrSID", raises: [].}
  proc DeclareDeferredMrSIDPlugin*() {.
    cdecl, importc: "DeclareDeferredMrSIDPlugin", raises: []
  .}

  proc GDALRegister_MG4Lidar*() {.cdecl, importc: "GDALRegister_MG4Lidar", raises: [].}
  proc GDALRegister_PCIDSK*() {.cdecl, importc: "GDALRegister_PCIDSK", raises: [].}
  proc DeclareDeferredPCIDSKPlugin*() {.
    cdecl, importc: "DeclareDeferredPCIDSKPlugin", raises: []
  .}

  proc GDALRegister_BT*() {.cdecl, importc: "GDALRegister_BT", raises: [].}
  proc GDALRegister_netCDF*() {.cdecl, importc: "GDALRegister_netCDF", raises: [].}
  proc DeclareDeferredNetCDFPlugin*() {.
    cdecl, importc: "DeclareDeferredNetCDFPlugin", raises: []
  .}

  proc GDALRegister_LAN*() {.cdecl, importc: "GDALRegister_LAN", raises: [].}
  proc GDALRegister_CPG*() {.cdecl, importc: "GDALRegister_CPG", raises: [].}
  proc GDALRegister_AirSAR*() {.cdecl, importc: "GDALRegister_AirSAR", raises: [].}
  proc GDALRegister_RS2*() {.cdecl, importc: "GDALRegister_RS2", raises: [].}
  proc GDALRegister_ILWIS*() {.cdecl, importc: "GDALRegister_ILWIS", raises: [].}
  proc GDALRegister_PCRaster*() {.cdecl, importc: "GDALRegister_PCRaster", raises: [].}
  proc DeclareDeferredPCRasterPlugin*() {.
    cdecl, importc: "DeclareDeferredPCRasterPlugin", raises: []
  .}

  proc GDALRegister_IDA*() {.cdecl, importc: "GDALRegister_IDA", raises: [].}
  proc GDALRegister_NDF*() {.cdecl, importc: "GDALRegister_NDF", raises: [].}
  proc GDALRegister_RMF*() {.cdecl, importc: "GDALRegister_RMF", raises: [].}
  proc GDALRegister_BAG*() {.cdecl, importc: "GDALRegister_BAG", raises: [].}
  proc GDALRegister_S102*() {.cdecl, importc: "GDALRegister_S102", raises: [].}
  proc GDALRegister_S104*() {.cdecl, importc: "GDALRegister_S104", raises: [].}
  proc GDALRegister_S111*() {.cdecl, importc: "GDALRegister_S111", raises: [].}
  proc GDALRegister_HDF5*() {.cdecl, importc: "GDALRegister_HDF5", raises: [].}
  proc DeclareDeferredHDF5Plugin*() {.
    cdecl, importc: "DeclareDeferredHDF5Plugin", raises: []
  .}

  proc GDALRegister_HDF5Image*() {.
    cdecl, importc: "GDALRegister_HDF5Image", raises: []
  .}

  proc GDALRegister_MSGN*() {.cdecl, importc: "GDALRegister_MSGN", raises: [].}
  proc GDALRegister_MSG*() {.cdecl, importc: "GDALRegister_MSG", raises: [].}
  proc DeclareDeferredMSGPlugin*() {.
    cdecl, importc: "DeclareDeferredMSGPlugin", raises: []
  .}

  proc GDALRegister_RIK*() {.cdecl, importc: "GDALRegister_RIK", raises: [].}
  proc GDALRegister_Leveller*() {.cdecl, importc: "GDALRegister_Leveller", raises: [].}
  proc GDALRegister_SRTMHGT*() {.cdecl, importc: "GDALRegister_SRTMHGT", raises: [].}
  proc GDALRegister_DIPEx*() {.cdecl, importc: "GDALRegister_DIPEx", raises: [].}
  proc GDALRegister_ISIS3*() {.cdecl, importc: "GDALRegister_ISIS3", raises: [].}
  proc GDALRegister_ISIS2*() {.cdecl, importc: "GDALRegister_ISIS2", raises: [].}
  proc GDALRegister_PDS*() {.cdecl, importc: "GDALRegister_PDS", raises: [].}
  proc DeclareDeferredPDSPlugin*() {.
    cdecl, importc: "DeclareDeferredPDSPlugin", raises: []
  .}

  proc GDALRegister_PDS4*() {.cdecl, importc: "GDALRegister_PDS4", raises: [].}
  proc GDALRegister_VICAR*() {.cdecl, importc: "GDALRegister_VICAR", raises: [].}
  proc GDALRegister_IDRISI*() {.cdecl, importc: "GDALRegister_IDRISI", raises: [].}
  proc GDALRegister_Terragen*() {.cdecl, importc: "GDALRegister_Terragen", raises: [].}
  proc GDALRegister_WCS*() {.cdecl, importc: "GDALRegister_WCS", raises: [].}
  proc DeclareDeferredWCSPlugin*() {.
    cdecl, importc: "DeclareDeferredWCSPlugin", raises: []
  .}

  proc GDALRegister_WMS*() {.cdecl, importc: "GDALRegister_WMS", raises: [].}
  proc DeclareDeferredWMSPlugin*() {.
    cdecl, importc: "DeclareDeferredWMSPlugin", raises: []
  .}

  proc GDALRegister_HTTP*() {.cdecl, importc: "GDALRegister_HTTP", raises: [].}
  proc GDALRegister_GSAG*() {.cdecl, importc: "GDALRegister_GSAG", raises: [].}
  proc GDALRegister_GSBG*() {.cdecl, importc: "GDALRegister_GSBG", raises: [].}
  proc GDALRegister_GS7BG*() {.cdecl, importc: "GDALRegister_GS7BG", raises: [].}
  proc GDALRegister_GRIB*() {.cdecl, importc: "GDALRegister_GRIB", raises: [].}
  proc DeclareDeferredGRIBPlugin*() {.
    cdecl, importc: "DeclareDeferredGRIBPlugin", raises: []
  .}

  proc GDALRegister_INGR*() {.cdecl, importc: "GDALRegister_INGR", raises: [].}
  proc GDALRegister_ERS*() {.cdecl, importc: "GDALRegister_ERS", raises: [].}
  proc GDALRegister_PALSARJaxa*() {.
    cdecl, importc: "GDALRegister_PALSARJaxa", raises: []
  .}

  proc GDALRegister_DIMAP*() {.cdecl, importc: "GDALRegister_DIMAP", raises: [].}
  proc GDALRegister_GFF*() {.cdecl, importc: "GDALRegister_GFF", raises: [].}
  proc GDALRegister_COSAR*() {.cdecl, importc: "GDALRegister_COSAR", raises: [].}
  proc GDALRegister_TSX*() {.cdecl, importc: "GDALRegister_TSX", raises: [].}
  proc GDALRegister_ADRG*() {.cdecl, importc: "GDALRegister_ADRG", raises: [].}
  proc GDALRegister_SRP*() {.cdecl, importc: "GDALRegister_SRP", raises: [].}
  proc GDALRegister_COASP*() {.cdecl, importc: "GDALRegister_COASP", raises: [].}
  proc GDALRegister_LCP*() {.cdecl, importc: "GDALRegister_LCP", raises: [].}
  proc GDALRegister_EIR*() {.cdecl, importc: "GDALRegister_EIR", raises: [].}
  proc GDALRegister_ESRIC*() {.cdecl, importc: "GDALRegister_ESRIC", raises: [].}
  proc GDALRegister_GEOR*() {.cdecl, importc: "GDALRegister_GEOR", raises: [].}
  proc DeclareDeferredGEORPlugin*() {.
    cdecl, importc: "DeclareDeferredGEORPlugin", raises: []
  .}

  proc GDALRegister_TIL*() {.cdecl, importc: "GDALRegister_TIL", raises: [].}
  proc GDALRegister_R*() {.cdecl, importc: "GDALRegister_R", raises: [].}
  proc GDALRegister_PostGISRaster*() {.
    cdecl, importc: "GDALRegister_PostGISRaster", raises: []
  .}

  proc DeclareDeferredPostGISRasterPlugin*() {.
    cdecl, importc: "DeclareDeferredPostGISRasterPlugin", raises: []
  .}

  proc GDALRegister_NWT_GRD*() {.cdecl, importc: "GDALRegister_NWT_GRD", raises: [].}
  proc GDALRegister_NWT_GRC*() {.cdecl, importc: "GDALRegister_NWT_GRC", raises: [].}
  proc GDALRegister_SAGA*() {.cdecl, importc: "GDALRegister_SAGA", raises: [].}
  proc GDALRegister_KMLSUPEROVERLAY*() {.
    cdecl, importc: "GDALRegister_KMLSUPEROVERLAY", raises: []
  .}

  proc GDALRegister_GTX*() {.cdecl, importc: "GDALRegister_GTX", raises: [].}
  proc GDALRegister_LOSLAS*() {.cdecl, importc: "GDALRegister_LOSLAS", raises: [].}
  proc GDALRegister_NTv2*() {.cdecl, importc: "GDALRegister_NTv2", raises: [].}
  proc GDALRegister_JP2OpenJPEG*() {.
    cdecl, importc: "GDALRegister_JP2OpenJPEG", raises: []
  .}

  proc DeclareDeferredOPENJPEGPlugin*() {.
    cdecl, importc: "DeclareDeferredOPENJPEGPlugin", raises: []
  .}

  proc GDALRegister_XYZ*() {.cdecl, importc: "GDALRegister_XYZ", raises: [].}
  proc GDALRegister_HF2*() {.cdecl, importc: "GDALRegister_HF2", raises: [].}
  proc GDALRegister_PDF*() {.cdecl, importc: "GDALRegister_PDF", raises: [].}
  proc DeclareDeferredPDFPlugin*() {.
    cdecl, importc: "DeclareDeferredPDFPlugin", raises: []
  .}

  proc GDALRegister_MAP*() {.cdecl, importc: "GDALRegister_MAP", raises: [].}
  proc GDALRegister_ACE2*() {.cdecl, importc: "GDALRegister_ACE2", raises: [].}
  proc GDALRegister_CTG*() {.cdecl, importc: "GDALRegister_CTG", raises: [].}
  proc GDALRegister_SNODAS*() {.cdecl, importc: "GDALRegister_SNODAS", raises: [].}
  proc GDALRegister_WEBP*() {.cdecl, importc: "GDALRegister_WEBP", raises: [].}
  proc DeclareDeferredWEBPPlugin*() {.
    cdecl, importc: "DeclareDeferredWEBPPlugin", raises: []
  .}

  proc GDALRegister_ZMap*() {.cdecl, importc: "GDALRegister_ZMap", raises: [].}
  proc GDALRegister_NGSGEOID*() {.cdecl, importc: "GDALRegister_NGSGEOID", raises: [].}
  proc GDALRegister_MBTiles*() {.cdecl, importc: "GDALRegister_MBTiles", raises: [].}
  proc GDALRegister_IRIS*() {.cdecl, importc: "GDALRegister_IRIS", raises: [].}
  proc GDALRegister_KRO*() {.cdecl, importc: "GDALRegister_KRO", raises: [].}
  proc GDALRegister_KEA*() {.cdecl, importc: "GDALRegister_KEA", raises: [].}
  proc DeclareDeferredKEAPlugin*() {.
    cdecl, importc: "DeclareDeferredKEAPlugin", raises: []
  .}

  proc GDALRegister_ROIPAC*() {.cdecl, importc: "GDALRegister_ROIPAC", raises: [].}
  proc GDALRegister_PLMOSAIC*() {.cdecl, importc: "GDALRegister_PLMOSAIC", raises: [].}
  proc GDALRegister_CALS*() {.cdecl, importc: "GDALRegister_CALS", raises: [].}
  proc GDALRegister_ISCE*() {.cdecl, importc: "GDALRegister_ISCE", raises: [].}
  proc GDALRegister_WMTS*() {.cdecl, importc: "GDALRegister_WMTS", raises: [].}
  proc DeclareDeferredWMTSPlugin*() {.
    cdecl, importc: "DeclareDeferredWMTSPlugin", raises: []
  .}

  proc GDALRegister_SAFE*() {.cdecl, importc: "GDALRegister_SAFE", raises: [].}
  proc GDALRegister_SENTINEL2*() {.
    cdecl, importc: "GDALRegister_SENTINEL2", raises: []
  .}

  proc GDALRegister_MRF*() {.cdecl, importc: "GDALRegister_MRF", raises: [].}
  proc DeclareDeferredMRFPlugin*() {.
    cdecl, importc: "DeclareDeferredMRFPlugin", raises: []
  .}

  proc GDALRegister_RRASTER*() {.cdecl, importc: "GDALRegister_RRASTER", raises: [].}
  proc GDALRegister_Derived*() {.cdecl, importc: "GDALRegister_Derived", raises: [].}
  proc GDALRegister_PRF*() {.cdecl, importc: "GDALRegister_PRF", raises: [].}
  proc GDALRegister_NULL*() {.cdecl, importc: "GDALRegister_NULL", raises: [].}
  proc GDALRegister_EEDAI*() {.cdecl, importc: "GDALRegister_EEDAI", raises: [].}
  proc GDALRegister_EEDA*() {.cdecl, importc: "GDALRegister_EEDA", raises: [].}
  proc GDALRegister_SIGDEM*() {.cdecl, importc: "GDALRegister_SIGDEM", raises: [].}
  proc GDALRegister_BYN*() {.cdecl, importc: "GDALRegister_BYN", raises: [].}
  proc GDALRegister_TileDB*() {.cdecl, importc: "GDALRegister_TileDB", raises: [].}
  proc DeclareDeferredTileDBPlugin*() {.
    cdecl, importc: "DeclareDeferredTileDBPlugin", raises: []
  .}

  proc GDALRegister_DAAS*() {.cdecl, importc: "GDALRegister_DAAS", raises: [].}
  proc GDALRegister_COG*() {.cdecl, importc: "GDALRegister_COG", raises: [].}
  proc GDALRegister_RDB*() {.cdecl, importc: "GDALRegister_RDB", raises: [].}
  proc GDALRegister_EXR*() {.cdecl, importc: "GDALRegister_EXR", raises: [].}
  proc DeclareDeferredEXRPlugin*() {.
    cdecl, importc: "DeclareDeferredEXRPlugin", raises: []
  .}

  proc GDALRegister_AVIF*() {.cdecl, importc: "GDALRegister_AVIF", raises: [].}
  proc DeclareDeferredAVIFPlugin*() {.
    cdecl, importc: "DeclareDeferredAVIFPlugin", raises: []
  .}

  proc GDALRegister_HEIF*() {.cdecl, importc: "GDALRegister_HEIF", raises: [].}
  proc DeclareDeferredHEIFPlugin*() {.
    cdecl, importc: "DeclareDeferredHEIFPlugin", raises: []
  .}

  proc GDALRegister_TGA*() {.cdecl, importc: "GDALRegister_TGA", raises: [].}
  proc GDALRegister_OGCAPI*() {.cdecl, importc: "GDALRegister_OGCAPI", raises: [].}
  proc GDALRegister_STACTA*() {.cdecl, importc: "GDALRegister_STACTA", raises: [].}
  proc GDALRegister_Zarr*() {.cdecl, importc: "GDALRegister_Zarr", raises: [].}
  proc DeclareDeferredZarrPlugin*() {.
    cdecl, importc: "DeclareDeferredZarrPlugin", raises: []
  .}

  proc GDALRegister_STACIT*() {.cdecl, importc: "GDALRegister_STACIT", raises: [].}
  proc GDALRegister_JPEGXL*() {.cdecl, importc: "GDALRegister_JPEGXL", raises: [].}
  proc DeclareDeferredJPEGXLPlugin*() {.
    cdecl, importc: "DeclareDeferredJPEGXLPlugin", raises: []
  .}

  proc GDALRegister_BASISU*() {.cdecl, importc: "GDALRegister_BASISU", raises: [].}
  proc GDALRegister_KTX2*() {.cdecl, importc: "GDALRegister_KTX2", raises: [].}
  proc GDALRegister_BASISU_KTX2*() {.
    cdecl, importc: "GDALRegister_BASISU_KTX2", raises: []
  .}

  proc DeclareDeferredBASISU_KTX2Plugin*() {.
    cdecl, importc: "DeclareDeferredBASISU_KTX2Plugin", raises: []
  .}

  proc GDALRegister_NOAA_B*() {.cdecl, importc: "GDALRegister_NOAA_B", raises: [].}
  proc GDALRegister_NSIDCbin*() {.cdecl, importc: "GDALRegister_NSIDCbin", raises: [].}
  proc GDALRegister_SNAP_TIFF*() {.
    cdecl, importc: "GDALRegister_SNAP_TIFF", raises: []
  .}

  proc GDALRegister_RCM*() {.cdecl, importc: "GDALRegister_RCM", raises: [].}
  proc GDALRegister_MiraMon*() {.cdecl, importc: "GDALRegister_MiraMon", raises: [].}
  proc GDALRegister_GDALG*() {.cdecl, importc: "GDALRegister_GDALG", raises: [].}
  proc GDALRegister_E57*() {.cdecl, importc: "GDALRegister_E57", raises: [].}
  proc GDALRegister_CPHD*() {.cdecl, importc: "GDALRegister_CPHD", raises: [].}
  proc MEMCreate*(
    nXSize: cint,
    nYSize: cint,
    nBands: cint,
    eType: GDALDataType,
    papszOptions: CSLConstList,
  ): GDALDatasetH {.cdecl, importc: "MEMCreate", raises: [].}

  proc GDALInfoOptionsNew*(
    papszArgv: cstringArray, psOptionsForBinary: ptr GDALInfoOptionsForBinary
  ): ptr GDALInfoOptions {.cdecl, importc: "GDALInfoOptionsNew", raises: [].}

  proc GDALInfoOptionsFree*(
    psOptions: ptr GDALInfoOptions
  ) {.cdecl, importc: "GDALInfoOptionsFree", raises: [].}

  proc GDALInfo*(
    hDataset: GDALDatasetH, psOptions: ptr GDALInfoOptions
  ): cstring {.cdecl, importc: "GDALInfo", raises: [].}

  proc GDALTranslateOptionsNew*(
    papszArgv: cstringArray, psOptionsForBinary: ptr GDALTranslateOptionsForBinary
  ): ptr GDALTranslateOptions {.cdecl, importc: "GDALTranslateOptionsNew", raises: [].}

  proc GDALTranslateOptionsFree*(
    psOptions: ptr GDALTranslateOptions
  ) {.cdecl, importc: "GDALTranslateOptionsFree", raises: [].}

  proc GDALTranslateOptionsSetProgress*(
    psOptions: ptr GDALTranslateOptions,
    pfnProgress: GDALProgressFunc,
    pProgressData: pointer,
  ) {.cdecl, importc: "GDALTranslateOptionsSetProgress", raises: [].}

  proc GDALTranslate*(
    pszDestFilename: cstring,
    hSrcDataset: GDALDatasetH,
    psOptions: ptr GDALTranslateOptions,
    pbUsageError: ptr cint,
  ): GDALDatasetH {.cdecl, importc: "GDALTranslate", raises: [].}

  proc GDALWarpAppOptionsNew*(
    papszArgv: cstringArray, psOptionsForBinary: ptr GDALWarpAppOptionsForBinary
  ): ptr GDALWarpAppOptions {.cdecl, importc: "GDALWarpAppOptionsNew", raises: [].}

  proc GDALWarpAppOptionsFree*(
    psOptions: ptr GDALWarpAppOptions
  ) {.cdecl, importc: "GDALWarpAppOptionsFree", raises: [].}

  proc GDALWarpAppOptionsSetProgress*(
    psOptions: ptr GDALWarpAppOptions,
    pfnProgress: GDALProgressFunc,
    pProgressData: pointer,
  ) {.cdecl, importc: "GDALWarpAppOptionsSetProgress", raises: [].}

  proc GDALWarpAppOptionsSetQuiet*(
    psOptions: ptr GDALWarpAppOptions, bQuiet: cint
  ) {.cdecl, importc: "GDALWarpAppOptionsSetQuiet", raises: [].}

  proc GDALWarpAppOptionsSetWarpOption*(
    psOptions: ptr GDALWarpAppOptions, pszKey: cstring, pszValue: cstring
  ) {.cdecl, importc: "GDALWarpAppOptionsSetWarpOption", raises: [].}

  proc GDALWarp*(
    pszDest: cstring,
    hDstDS: GDALDatasetH,
    nSrcCount: cint,
    pahSrcDS: ptr GDALDatasetH,
    psOptions: ptr GDALWarpAppOptions,
    pbUsageError: ptr cint,
  ): GDALDatasetH {.cdecl, importc: "GDALWarp", raises: [].}

  proc GDALVectorTranslateOptionsNew*(
    papszArgv: cstringArray, psOptionsForBinary: ptr GDALVectorTranslateOptionsForBinary
  ): ptr GDALVectorTranslateOptions {.
    cdecl, importc: "GDALVectorTranslateOptionsNew", raises: []
  .}

  proc GDALVectorTranslateOptionsFree*(
    psOptions: ptr GDALVectorTranslateOptions
  ) {.cdecl, importc: "GDALVectorTranslateOptionsFree", raises: [].}

  proc GDALVectorTranslateOptionsSetProgress*(
    psOptions: ptr GDALVectorTranslateOptions,
    pfnProgress: GDALProgressFunc,
    pProgressData: pointer,
  ) {.cdecl, importc: "GDALVectorTranslateOptionsSetProgress", raises: [].}

  proc GDALVectorTranslate*(
    pszDest: cstring,
    hDstDS: GDALDatasetH,
    nSrcCount: cint,
    pahSrcDS: ptr GDALDatasetH,
    psOptions: ptr GDALVectorTranslateOptions,
    pbUsageError: ptr cint,
  ): GDALDatasetH {.cdecl, importc: "GDALVectorTranslate", raises: [].}

  proc GDALDEMProcessingOptionsNew*(
    papszArgv: cstringArray, psOptionsForBinary: ptr GDALDEMProcessingOptionsForBinary
  ): ptr GDALDEMProcessingOptions {.
    cdecl, importc: "GDALDEMProcessingOptionsNew", raises: []
  .}

  proc GDALDEMProcessingOptionsFree*(
    psOptions: ptr GDALDEMProcessingOptions
  ) {.cdecl, importc: "GDALDEMProcessingOptionsFree", raises: [].}

  proc GDALDEMProcessingOptionsSetProgress*(
    psOptions: ptr GDALDEMProcessingOptions,
    pfnProgress: GDALProgressFunc,
    pProgressData: pointer,
  ) {.cdecl, importc: "GDALDEMProcessingOptionsSetProgress", raises: [].}

  proc GDALDEMProcessing*(
    pszDestFilename: cstring,
    hSrcDataset: GDALDatasetH,
    pszProcessing: cstring,
    pszColorFilename: cstring,
    psOptions: ptr GDALDEMProcessingOptions,
    pbUsageError: ptr cint,
  ): GDALDatasetH {.cdecl, importc: "GDALDEMProcessing", raises: [].}

  proc GDALNearblackOptionsNew*(
    papszArgv: cstringArray, psOptionsForBinary: ptr GDALNearblackOptionsForBinary
  ): ptr GDALNearblackOptions {.cdecl, importc: "GDALNearblackOptionsNew", raises: [].}

  proc GDALNearblackOptionsFree*(
    psOptions: ptr GDALNearblackOptions
  ) {.cdecl, importc: "GDALNearblackOptionsFree", raises: [].}

  proc GDALNearblackOptionsSetProgress*(
    psOptions: ptr GDALNearblackOptions,
    pfnProgress: GDALProgressFunc,
    pProgressData: pointer,
  ) {.cdecl, importc: "GDALNearblackOptionsSetProgress", raises: [].}

  proc GDALNearblack*(
    pszDest: cstring,
    hDstDS: GDALDatasetH,
    hSrcDS: GDALDatasetH,
    psOptions: ptr GDALNearblackOptions,
    pbUsageError: ptr cint,
  ): GDALDatasetH {.cdecl, importc: "GDALNearblack", raises: [].}

  proc GDALGridOptionsNew*(
    papszArgv: cstringArray, psOptionsForBinary: ptr GDALGridOptionsForBinary
  ): ptr GDALGridOptions {.cdecl, importc: "GDALGridOptionsNew", raises: [].}

  proc GDALGridOptionsFree*(
    psOptions: ptr GDALGridOptions
  ) {.cdecl, importc: "GDALGridOptionsFree", raises: [].}

  proc GDALGridOptionsSetProgress*(
    psOptions: ptr GDALGridOptions,
    pfnProgress: GDALProgressFunc,
    pProgressData: pointer,
  ) {.cdecl, importc: "GDALGridOptionsSetProgress", raises: [].}

  proc GDALGrid*(
    pszDest: cstring,
    hSrcDS: GDALDatasetH,
    psOptions: ptr GDALGridOptions,
    pbUsageError: ptr cint,
  ): GDALDatasetH {.cdecl, importc: "GDALGrid", raises: [].}

  proc GDALContourOptionsNew*(
    papszArgv: cstringArray, psOptionsForBinary: ptr GDALContourOptionsForBinary
  ): ptr GDALContourOptions {.cdecl, importc: "GDALContourOptionsNew", raises: [].}

  proc GDALContourOptionsFree*(
    psOptions: ptr GDALContourOptions
  ) {.cdecl, importc: "GDALContourOptionsFree", raises: [].}

  proc GDALContourOptionsSetProgress*(
    psOptions: ptr GDALContourOptions,
    pfnProgress: GDALProgressFunc,
    pProgressData: pointer,
  ) {.cdecl, importc: "GDALContourOptionsSetProgress", raises: [].}

  proc GDALContourOptionsSetDestDataSource*(
    psOptions: ptr GDALContourOptions, pszDestDatasource: cstring
  ) {.cdecl, importc: "GDALContourOptionsSetDestDataSource", raises: [].}

  proc GDALContourProcessOptions*(
    psOptions: ptr GDALContourOptions,
    ppapszStringOptions: ptr cstringArray,
    hSrcDS: ptr GDALDatasetH,
    hBand: ptr GDALRasterBandH,
    hDstDS: ptr GDALDatasetH,
    hLayer: ptr OGRLayerH,
  ): CPLErr {.cdecl, importc: "GDALContourProcessOptions", raises: [].}

  proc GDALRasterizeOptionsNew*(
    papszArgv: cstringArray, psOptionsForBinary: ptr GDALRasterizeOptionsForBinary
  ): ptr GDALRasterizeOptions {.cdecl, importc: "GDALRasterizeOptionsNew", raises: [].}

  proc GDALRasterizeOptionsFree*(
    psOptions: ptr GDALRasterizeOptions
  ) {.cdecl, importc: "GDALRasterizeOptionsFree", raises: [].}

  proc GDALRasterizeOptionsSetProgress*(
    psOptions: ptr GDALRasterizeOptions,
    pfnProgress: GDALProgressFunc,
    pProgressData: pointer,
  ) {.cdecl, importc: "GDALRasterizeOptionsSetProgress", raises: [].}

  proc GDALRasterize*(
    pszDest: cstring,
    hDstDS: GDALDatasetH,
    hSrcDS: GDALDatasetH,
    psOptions: ptr GDALRasterizeOptions,
    pbUsageError: ptr cint,
  ): GDALDatasetH {.cdecl, importc: "GDALRasterize", raises: [].}

  proc GDALFootprintOptionsNew*(
    papszArgv: cstringArray, psOptionsForBinary: ptr GDALFootprintOptionsForBinary
  ): ptr GDALFootprintOptions {.cdecl, importc: "GDALFootprintOptionsNew", raises: [].}

  proc GDALFootprintOptionsFree*(
    psOptions: ptr GDALFootprintOptions
  ) {.cdecl, importc: "GDALFootprintOptionsFree", raises: [].}

  proc GDALFootprintOptionsSetProgress*(
    psOptions: ptr GDALFootprintOptions,
    pfnProgress: GDALProgressFunc,
    pProgressData: pointer,
  ) {.cdecl, importc: "GDALFootprintOptionsSetProgress", raises: [].}

  proc GDALFootprint*(
    pszDest: cstring,
    hDstDS: GDALDatasetH,
    hSrcDS: GDALDatasetH,
    psOptions: ptr GDALFootprintOptions,
    pbUsageError: ptr cint,
  ): GDALDatasetH {.cdecl, importc: "GDALFootprint", raises: [].}

  proc GDALBuildVRTOptionsNew*(
    papszArgv: cstringArray, psOptionsForBinary: ptr GDALBuildVRTOptionsForBinary
  ): ptr GDALBuildVRTOptions {.cdecl, importc: "GDALBuildVRTOptionsNew", raises: [].}

  proc GDALBuildVRTOptionsFree*(
    psOptions: ptr GDALBuildVRTOptions
  ) {.cdecl, importc: "GDALBuildVRTOptionsFree", raises: [].}

  proc GDALBuildVRTOptionsSetProgress*(
    psOptions: ptr GDALBuildVRTOptions,
    pfnProgress: GDALProgressFunc,
    pProgressData: pointer,
  ) {.cdecl, importc: "GDALBuildVRTOptionsSetProgress", raises: [].}

  proc GDALBuildVRT*(
    pszDest: cstring,
    nSrcCount: cint,
    pahSrcDS: ptr GDALDatasetH,
    papszSrcDSNames: cstringArray,
    psOptions: ptr GDALBuildVRTOptions,
    pbUsageError: ptr cint,
  ): GDALDatasetH {.cdecl, importc: "GDALBuildVRT", raises: [].}

  proc GDALMultiDimInfoOptionsNew*(
    papszArgv: cstringArray, psOptionsForBinary: ptr GDALMultiDimInfoOptionsForBinary
  ): ptr GDALMultiDimInfoOptions {.
    cdecl, importc: "GDALMultiDimInfoOptionsNew", raises: []
  .}

  proc GDALMultiDimInfoOptionsFree*(
    psOptions: ptr GDALMultiDimInfoOptions
  ) {.cdecl, importc: "GDALMultiDimInfoOptionsFree", raises: [].}

  proc GDALMultiDimInfo*(
    hDataset: GDALDatasetH, psOptions: ptr GDALMultiDimInfoOptions
  ): cstring {.cdecl, importc: "GDALMultiDimInfo", raises: [].}

  proc GDALMultiDimTranslateOptionsNew*(
    papszArgv: cstringArray,
    psOptionsForBinary: ptr GDALMultiDimTranslateOptionsForBinary,
  ): ptr GDALMultiDimTranslateOptions {.
    cdecl, importc: "GDALMultiDimTranslateOptionsNew", raises: []
  .}

  proc GDALMultiDimTranslateOptionsFree*(
    psOptions: ptr GDALMultiDimTranslateOptions
  ) {.cdecl, importc: "GDALMultiDimTranslateOptionsFree", raises: [].}

  proc GDALMultiDimTranslateOptionsSetProgress*(
    psOptions: ptr GDALMultiDimTranslateOptions,
    pfnProgress: GDALProgressFunc,
    pProgressData: pointer,
  ) {.cdecl, importc: "GDALMultiDimTranslateOptionsSetProgress", raises: [].}

  proc GDALMultiDimTranslate*(
    pszDest: cstring,
    hDstDataset: GDALDatasetH,
    nSrcCount: cint,
    pahSrcDS: ptr GDALDatasetH,
    psOptions: ptr GDALMultiDimTranslateOptions,
    pbUsageError: ptr cint,
  ): GDALDatasetH {.cdecl, importc: "GDALMultiDimTranslate", raises: [].}

  proc GDALVectorInfoOptionsNew*(
    papszArgv: cstringArray, psOptionsForBinary: ptr GDALVectorInfoOptionsForBinary
  ): ptr GDALVectorInfoOptions {.
    cdecl, importc: "GDALVectorInfoOptionsNew", raises: []
  .}

  proc GDALVectorInfoOptionsFree*(
    psOptions: ptr GDALVectorInfoOptions
  ) {.cdecl, importc: "GDALVectorInfoOptionsFree", raises: [].}

  proc GDALVectorInfo*(
    hDataset: GDALDatasetH, psOptions: ptr GDALVectorInfoOptions
  ): cstring {.cdecl, importc: "GDALVectorInfo", raises: [].}

  proc GDALTileIndexOptionsNew*(
    papszArgv: cstringArray, psOptionsForBinary: ptr GDALTileIndexOptionsForBinary
  ): ptr GDALTileIndexOptions {.cdecl, importc: "GDALTileIndexOptionsNew", raises: [].}

  proc GDALTileIndexOptionsSetProgress*(
    psOptions: ptr GDALTileIndexOptions,
    pfnProgress: GDALProgressFunc,
    pProgressData: pointer,
  ) {.cdecl, importc: "GDALTileIndexOptionsSetProgress", raises: [].}

  proc GDALTileIndexOptionsFree*(
    psOptions: ptr GDALTileIndexOptions
  ) {.cdecl, importc: "GDALTileIndexOptionsFree", raises: [].}

  proc GDALTileIndex*(
    pszDest: cstring,
    nSrcCount: cint,
    papszSrcDSNames: cstringArray,
    psOptions: ptr GDALTileIndexOptions,
    pbUsageError: ptr cint,
  ): GDALDatasetH {.cdecl, importc: "GDALTileIndex", raises: [].}

  proc VRTCreate*(
    a0: cint, a1: cint
  ): VRTDatasetH {.gdalCall, importc: "VRTCreate", raises: [].}

  proc VRTFlushCache*(
    a0: VRTDatasetH
  ) {.gdalCall, importc: "VRTFlushCache", raises: [].}

  proc VRTSerializeToXML*(
    a0: VRTDatasetH, a1: cstring
  ): ptr CPLXMLNode {.gdalCall, importc: "VRTSerializeToXML", raises: [].}

  proc VRTAddBand*(
    a0: VRTDatasetH, a1: GDALDataType, a2: CSLConstList
  ): cint {.gdalCall, importc: "VRTAddBand", raises: [].}

  proc VRTAddSource*(
    a0: VRTSourcedRasterBandH, a1: VRTSourceH
  ): CPLErr {.gdalCall, importc: "VRTAddSource", raises: [].}

  proc VRTAddSimpleSource*(
    a0: VRTSourcedRasterBandH,
    a1: GDALRasterBandH,
    a2: cint,
    a3: cint,
    a4: cint,
    a5: cint,
    a6: cint,
    a7: cint,
    a8: cint,
    a9: cint,
    a10: cstring,
    a11: cdouble,
  ): CPLErr {.gdalCall, importc: "VRTAddSimpleSource", raises: [].}

  proc VRTAddComplexSource*(
    a0: VRTSourcedRasterBandH,
    a1: GDALRasterBandH,
    a2: cint,
    a3: cint,
    a4: cint,
    a5: cint,
    a6: cint,
    a7: cint,
    a8: cint,
    a9: cint,
    a10: cdouble,
    a11: cdouble,
    a12: cdouble,
  ): CPLErr {.gdalCall, importc: "VRTAddComplexSource", raises: [].}

  proc VRTAddFuncSource*(
    a0: VRTSourcedRasterBandH, a1: VRTImageReadFunc, a2: pointer, a3: cdouble
  ): CPLErr {.gdalCall, importc: "VRTAddFuncSource", raises: [].}

  proc GDALAlgorithmArgTypeIsList*(
    `type`: GDALAlgorithmArgType
  ): bool {.cdecl, importc: "GDALAlgorithmArgTypeIsList", raises: [].}

  proc GDALAlgorithmArgTypeName*(
    `type`: GDALAlgorithmArgType
  ): cstring {.cdecl, importc: "GDALAlgorithmArgTypeName", raises: [].}

  proc GDALGetGlobalAlgorithmRegistry*(): GDALAlgorithmRegistryH {.
    cdecl, importc: "GDALGetGlobalAlgorithmRegistry", raises: []
  .}

  proc GDALAlgorithmRegistryRelease*(
    a0: GDALAlgorithmRegistryH
  ) {.cdecl, importc: "GDALAlgorithmRegistryRelease", raises: [].}

  proc GDALAlgorithmRegistryGetAlgNames*(
    a0: GDALAlgorithmRegistryH
  ): cstringArray {.cdecl, importc: "GDALAlgorithmRegistryGetAlgNames", raises: [].}

  proc GDALAlgorithmRegistryInstantiateAlg*(
    a0: GDALAlgorithmRegistryH, pszAlgName: cstring
  ): GDALAlgorithmH {.
    cdecl, importc: "GDALAlgorithmRegistryInstantiateAlg", raises: []
  .}

  proc GDALAlgorithmRegistryInstantiateAlgFromPath*(
    a0: GDALAlgorithmRegistryH, papszAlgPath: cstringArray
  ): GDALAlgorithmH {.
    cdecl, importc: "GDALAlgorithmRegistryInstantiateAlgFromPath", raises: []
  .}

  proc GDALAlgorithmRelease*(
    a0: GDALAlgorithmH
  ) {.cdecl, importc: "GDALAlgorithmRelease", raises: [].}

  proc GDALAlgorithmGetName*(
    a0: GDALAlgorithmH
  ): cstring {.cdecl, importc: "GDALAlgorithmGetName", raises: [].}

  proc GDALAlgorithmGetDescription*(
    a0: GDALAlgorithmH
  ): cstring {.cdecl, importc: "GDALAlgorithmGetDescription", raises: [].}

  proc GDALAlgorithmGetLongDescription*(
    a0: GDALAlgorithmH
  ): cstring {.cdecl, importc: "GDALAlgorithmGetLongDescription", raises: [].}

  proc GDALAlgorithmGetHelpFullURL*(
    a0: GDALAlgorithmH
  ): cstring {.cdecl, importc: "GDALAlgorithmGetHelpFullURL", raises: [].}

  proc GDALAlgorithmHasSubAlgorithms*(
    a0: GDALAlgorithmH
  ): bool {.cdecl, importc: "GDALAlgorithmHasSubAlgorithms", raises: [].}

  proc GDALAlgorithmGetSubAlgorithmNames*(
    a0: GDALAlgorithmH
  ): cstringArray {.cdecl, importc: "GDALAlgorithmGetSubAlgorithmNames", raises: [].}

  proc GDALAlgorithmInstantiateSubAlgorithm*(
    a0: GDALAlgorithmH, pszSubAlgName: cstring
  ): GDALAlgorithmH {.
    cdecl, importc: "GDALAlgorithmInstantiateSubAlgorithm", raises: []
  .}

  proc GDALAlgorithmParseCommandLineArguments*(
    a0: GDALAlgorithmH, papszArgs: CSLConstList
  ): bool {.cdecl, importc: "GDALAlgorithmParseCommandLineArguments", raises: [].}

  proc GDALAlgorithmGetArgDependencies*(
    a0: GDALAlgorithmH, pszArgumentName: cstring
  ): cstringArray {.cdecl, importc: "GDALAlgorithmGetArgDependencies", raises: [].}

  proc GDALAlgorithmGetActualAlgorithm*(
    a0: GDALAlgorithmH
  ): GDALAlgorithmH {.cdecl, importc: "GDALAlgorithmGetActualAlgorithm", raises: [].}

  proc GDALAlgorithmRun*(
    a0: GDALAlgorithmH, pfnProgress: GDALProgressFunc, pProgressData: pointer
  ): bool {.cdecl, importc: "GDALAlgorithmRun", raises: [].}

  proc GDALAlgorithmFinalize*(
    a0: GDALAlgorithmH
  ): bool {.cdecl, importc: "GDALAlgorithmFinalize", raises: [].}

  proc GDALAlgorithmGetUsageAsJSON*(
    a0: GDALAlgorithmH
  ): cstring {.cdecl, importc: "GDALAlgorithmGetUsageAsJSON", raises: [].}

  proc GDALAlgorithmGetArgNames*(
    a0: GDALAlgorithmH
  ): cstringArray {.cdecl, importc: "GDALAlgorithmGetArgNames", raises: [].}

  proc GDALAlgorithmGetArg*(
    a0: GDALAlgorithmH, pszArgName: cstring
  ): GDALAlgorithmArgH {.cdecl, importc: "GDALAlgorithmGetArg", raises: [].}

  proc GDALAlgorithmGetArgNonConst*(
    a0: GDALAlgorithmH, pszArgName: cstring
  ): GDALAlgorithmArgH {.cdecl, importc: "GDALAlgorithmGetArgNonConst", raises: [].}

  proc GDALAlgorithmArgRelease*(
    a0: GDALAlgorithmArgH
  ) {.cdecl, importc: "GDALAlgorithmArgRelease", raises: [].}

  proc GDALAlgorithmArgGetName*(
    a0: GDALAlgorithmArgH
  ): cstring {.cdecl, importc: "GDALAlgorithmArgGetName", raises: [].}

  proc GDALAlgorithmArgGetType*(
    a0: GDALAlgorithmArgH
  ): GDALAlgorithmArgType {.cdecl, importc: "GDALAlgorithmArgGetType", raises: [].}

  proc GDALAlgorithmArgGetDescription*(
    a0: GDALAlgorithmArgH
  ): cstring {.cdecl, importc: "GDALAlgorithmArgGetDescription", raises: [].}

  proc GDALAlgorithmArgGetShortName*(
    a0: GDALAlgorithmArgH
  ): cstring {.cdecl, importc: "GDALAlgorithmArgGetShortName", raises: [].}

  proc GDALAlgorithmArgGetAliases*(
    a0: GDALAlgorithmArgH
  ): cstringArray {.cdecl, importc: "GDALAlgorithmArgGetAliases", raises: [].}

  proc GDALAlgorithmArgGetMetaVar*(
    a0: GDALAlgorithmArgH
  ): cstring {.cdecl, importc: "GDALAlgorithmArgGetMetaVar", raises: [].}

  proc GDALAlgorithmArgGetCategory*(
    a0: GDALAlgorithmArgH
  ): cstring {.cdecl, importc: "GDALAlgorithmArgGetCategory", raises: [].}

  proc GDALAlgorithmArgIsPositional*(
    a0: GDALAlgorithmArgH
  ): bool {.cdecl, importc: "GDALAlgorithmArgIsPositional", raises: [].}

  proc GDALAlgorithmArgIsRequired*(
    a0: GDALAlgorithmArgH
  ): bool {.cdecl, importc: "GDALAlgorithmArgIsRequired", raises: [].}

  proc GDALAlgorithmArgGetMinCount*(
    a0: GDALAlgorithmArgH
  ): cint {.cdecl, importc: "GDALAlgorithmArgGetMinCount", raises: [].}

  proc GDALAlgorithmArgGetMaxCount*(
    a0: GDALAlgorithmArgH
  ): cint {.cdecl, importc: "GDALAlgorithmArgGetMaxCount", raises: [].}

  proc GDALAlgorithmArgGetPackedValuesAllowed*(
    a0: GDALAlgorithmArgH
  ): bool {.cdecl, importc: "GDALAlgorithmArgGetPackedValuesAllowed", raises: [].}

  proc GDALAlgorithmArgGetRepeatedArgAllowed*(
    a0: GDALAlgorithmArgH
  ): bool {.cdecl, importc: "GDALAlgorithmArgGetRepeatedArgAllowed", raises: [].}

  proc GDALAlgorithmArgGetChoices*(
    a0: GDALAlgorithmArgH
  ): cstringArray {.cdecl, importc: "GDALAlgorithmArgGetChoices", raises: [].}

  proc GDALAlgorithmArgGetMetadataItem*(
    a0: GDALAlgorithmArgH, a1: cstring
  ): cstringArray {.cdecl, importc: "GDALAlgorithmArgGetMetadataItem", raises: [].}

  proc GDALAlgorithmArgIsExplicitlySet*(
    a0: GDALAlgorithmArgH
  ): bool {.cdecl, importc: "GDALAlgorithmArgIsExplicitlySet", raises: [].}

  proc GDALAlgorithmArgHasDefaultValue*(
    a0: GDALAlgorithmArgH
  ): bool {.cdecl, importc: "GDALAlgorithmArgHasDefaultValue", raises: [].}

  proc GDALAlgorithmArgGetDefaultAsBoolean*(
    a0: GDALAlgorithmArgH
  ): bool {.cdecl, importc: "GDALAlgorithmArgGetDefaultAsBoolean", raises: [].}

  proc GDALAlgorithmArgGetDefaultAsString*(
    a0: GDALAlgorithmArgH
  ): cstring {.cdecl, importc: "GDALAlgorithmArgGetDefaultAsString", raises: [].}

  proc GDALAlgorithmArgGetDefaultAsInteger*(
    a0: GDALAlgorithmArgH
  ): cint {.cdecl, importc: "GDALAlgorithmArgGetDefaultAsInteger", raises: [].}

  proc GDALAlgorithmArgGetDefaultAsDouble*(
    a0: GDALAlgorithmArgH
  ): cdouble {.cdecl, importc: "GDALAlgorithmArgGetDefaultAsDouble", raises: [].}

  proc GDALAlgorithmArgGetDefaultAsStringList*(
    a0: GDALAlgorithmArgH
  ): cstringArray {.
    cdecl, importc: "GDALAlgorithmArgGetDefaultAsStringList", raises: []
  .}

  proc GDALAlgorithmArgGetDefaultAsIntegerList*(
    a0: GDALAlgorithmArgH, pnCount: ptr csize_t
  ): ptr cint {.cdecl, importc: "GDALAlgorithmArgGetDefaultAsIntegerList", raises: [].}

  proc GDALAlgorithmArgGetDefaultAsDoubleList*(
    a0: GDALAlgorithmArgH, pnCount: ptr csize_t
  ): ptr cdouble {.
    cdecl, importc: "GDALAlgorithmArgGetDefaultAsDoubleList", raises: []
  .}

  proc GDALAlgorithmArgIsHidden*(
    a0: GDALAlgorithmArgH
  ): bool {.cdecl, importc: "GDALAlgorithmArgIsHidden", raises: [].}

  proc GDALAlgorithmArgIsHiddenForCLI*(
    a0: GDALAlgorithmArgH
  ): bool {.cdecl, importc: "GDALAlgorithmArgIsHiddenForCLI", raises: [].}

  proc GDALAlgorithmArgIsHiddenForAPI*(
    a0: GDALAlgorithmArgH
  ): bool {.cdecl, importc: "GDALAlgorithmArgIsHiddenForAPI", raises: [].}

  proc GDALAlgorithmArgIsAvailableInPipelineStep*(
    a0: GDALAlgorithmArgH
  ): bool {.cdecl, importc: "GDALAlgorithmArgIsAvailableInPipelineStep", raises: [].}

  proc GDALAlgorithmArgIsOnlyForCLI*(
    a0: GDALAlgorithmArgH
  ): bool {.cdecl, importc: "GDALAlgorithmArgIsOnlyForCLI", raises: [].}

  proc GDALAlgorithmArgIsInput*(
    a0: GDALAlgorithmArgH
  ): bool {.cdecl, importc: "GDALAlgorithmArgIsInput", raises: [].}

  proc GDALAlgorithmArgIsOutput*(
    a0: GDALAlgorithmArgH
  ): bool {.cdecl, importc: "GDALAlgorithmArgIsOutput", raises: [].}

  proc GDALAlgorithmArgGetMutualExclusionGroup*(
    a0: GDALAlgorithmArgH
  ): cstring {.cdecl, importc: "GDALAlgorithmArgGetMutualExclusionGroup", raises: [].}

  proc GDALAlgorithmArgGetMutualDependencyGroup*(
    a0: GDALAlgorithmArgH
  ): cstring {.cdecl, importc: "GDALAlgorithmArgGetMutualDependencyGroup", raises: [].}

  proc GDALAlgorithmArgGetAsBoolean*(
    a0: GDALAlgorithmArgH
  ): bool {.cdecl, importc: "GDALAlgorithmArgGetAsBoolean", raises: [].}

  proc GDALAlgorithmArgGetAsString*(
    a0: GDALAlgorithmArgH
  ): cstring {.cdecl, importc: "GDALAlgorithmArgGetAsString", raises: [].}

  proc GDALAlgorithmArgGetAsDatasetValue*(
    a0: GDALAlgorithmArgH
  ): GDALArgDatasetValueH {.
    cdecl, importc: "GDALAlgorithmArgGetAsDatasetValue", raises: []
  .}

  proc GDALAlgorithmArgGetAsInteger*(
    a0: GDALAlgorithmArgH
  ): cint {.cdecl, importc: "GDALAlgorithmArgGetAsInteger", raises: [].}

  proc GDALAlgorithmArgGetAsDouble*(
    a0: GDALAlgorithmArgH
  ): cdouble {.cdecl, importc: "GDALAlgorithmArgGetAsDouble", raises: [].}

  proc GDALAlgorithmArgGetAsStringList*(
    a0: GDALAlgorithmArgH
  ): cstringArray {.cdecl, importc: "GDALAlgorithmArgGetAsStringList", raises: [].}

  proc GDALAlgorithmArgGetDirectDependencies*(
    a0: GDALAlgorithmArgH
  ): cstringArray {.
    cdecl, importc: "GDALAlgorithmArgGetDirectDependencies", raises: []
  .}

  proc GDALAlgorithmArgGetAsIntegerList*(
    a0: GDALAlgorithmArgH, pnCount: ptr csize_t
  ): ptr cint {.cdecl, importc: "GDALAlgorithmArgGetAsIntegerList", raises: [].}

  proc GDALAlgorithmArgGetAsDoubleList*(
    a0: GDALAlgorithmArgH, pnCount: ptr csize_t
  ): ptr cdouble {.cdecl, importc: "GDALAlgorithmArgGetAsDoubleList", raises: [].}

  proc GDALAlgorithmArgSetAsBoolean*(
    a0: GDALAlgorithmArgH, a1: bool
  ): bool {.cdecl, importc: "GDALAlgorithmArgSetAsBoolean", raises: [].}

  proc GDALAlgorithmArgSetAsString*(
    a0: GDALAlgorithmArgH, a1: cstring
  ): bool {.cdecl, importc: "GDALAlgorithmArgSetAsString", raises: [].}

  proc GDALAlgorithmArgSetAsDatasetValue*(
    hArg: GDALAlgorithmArgH, value: GDALArgDatasetValueH
  ): bool {.cdecl, importc: "GDALAlgorithmArgSetAsDatasetValue", raises: [].}

  proc GDALAlgorithmArgSetDataset*(
    hArg: GDALAlgorithmArgH, a1: GDALDatasetH
  ): bool {.cdecl, importc: "GDALAlgorithmArgSetDataset", raises: [].}

  proc GDALAlgorithmArgSetDatasets*(
    hArg: GDALAlgorithmArgH, nCount: csize_t, a2: ptr GDALDatasetH
  ): bool {.cdecl, importc: "GDALAlgorithmArgSetDatasets", raises: [].}

  proc GDALAlgorithmArgSetDatasetNames*(
    hArg: GDALAlgorithmArgH, a1: CSLConstList
  ): bool {.cdecl, importc: "GDALAlgorithmArgSetDatasetNames", raises: [].}

  proc GDALAlgorithmArgSetAsInteger*(
    a0: GDALAlgorithmArgH, a1: cint
  ): bool {.cdecl, importc: "GDALAlgorithmArgSetAsInteger", raises: [].}

  proc GDALAlgorithmArgSetAsDouble*(
    a0: GDALAlgorithmArgH, a1: cdouble
  ): bool {.cdecl, importc: "GDALAlgorithmArgSetAsDouble", raises: [].}

  proc GDALAlgorithmArgSetAsStringList*(
    a0: GDALAlgorithmArgH, a1: CSLConstList
  ): bool {.cdecl, importc: "GDALAlgorithmArgSetAsStringList", raises: [].}

  proc GDALAlgorithmArgSetAsIntegerList*(
    a0: GDALAlgorithmArgH, nCount: csize_t, pnValues: ptr cint
  ): bool {.cdecl, importc: "GDALAlgorithmArgSetAsIntegerList", raises: [].}

  proc GDALAlgorithmArgSetAsDoubleList*(
    a0: GDALAlgorithmArgH, nCount: csize_t, pnValues: ptr cdouble
  ): bool {.cdecl, importc: "GDALAlgorithmArgSetAsDoubleList", raises: [].}

  proc GDALAlgorithmArgGetDatasetType*(
    a0: GDALAlgorithmArgH
  ): GDALArgDatasetType {.cdecl, importc: "GDALAlgorithmArgGetDatasetType", raises: [].}

  proc GDALAlgorithmArgGetDatasetInputFlags*(
    a0: GDALAlgorithmArgH
  ): cint {.cdecl, importc: "GDALAlgorithmArgGetDatasetInputFlags", raises: [].}

  proc GDALAlgorithmArgGetDatasetOutputFlags*(
    a0: GDALAlgorithmArgH
  ): cint {.cdecl, importc: "GDALAlgorithmArgGetDatasetOutputFlags", raises: [].}

  proc GDALArgDatasetValueCreate*(): GDALArgDatasetValueH {.
    cdecl, importc: "GDALArgDatasetValueCreate", raises: []
  .}

  proc GDALArgDatasetValueRelease*(
    a0: GDALArgDatasetValueH
  ) {.cdecl, importc: "GDALArgDatasetValueRelease", raises: [].}

  proc GDALArgDatasetValueGetName*(
    a0: GDALArgDatasetValueH
  ): cstring {.cdecl, importc: "GDALArgDatasetValueGetName", raises: [].}

  proc GDALArgDatasetValueGetDatasetRef*(
    a0: GDALArgDatasetValueH
  ): GDALDatasetH {.cdecl, importc: "GDALArgDatasetValueGetDatasetRef", raises: [].}

  proc GDALArgDatasetValueGetDatasetIncreaseRefCount*(
    a0: GDALArgDatasetValueH
  ): GDALDatasetH {.
    cdecl, importc: "GDALArgDatasetValueGetDatasetIncreaseRefCount", raises: []
  .}

  proc GDALArgDatasetValueSetName*(
    a0: GDALArgDatasetValueH, a1: cstring
  ) {.cdecl, importc: "GDALArgDatasetValueSetName", raises: [].}

  proc GDALArgDatasetValueSetDataset*(
    a0: GDALArgDatasetValueH, a1: GDALDatasetH
  ) {.cdecl, importc: "GDALArgDatasetValueSetDataset", raises: [].}

  proc GDALGridInverseDistanceToAPower*(
    a0: pointer,
    a1: GUInt32,
    a2: ptr cdouble,
    a3: ptr cdouble,
    a4: ptr cdouble,
    a5: cdouble,
    a6: cdouble,
    a7: ptr cdouble,
    a8: pointer,
  ): CPLErr {.cdecl, importc: "GDALGridInverseDistanceToAPower", raises: [].}

  proc GDALGridInverseDistanceToAPowerNearestNeighbor*(
    a0: pointer,
    a1: GUInt32,
    a2: ptr cdouble,
    a3: ptr cdouble,
    a4: ptr cdouble,
    a5: cdouble,
    a6: cdouble,
    a7: ptr cdouble,
    a8: pointer,
  ): CPLErr {.
    cdecl, importc: "GDALGridInverseDistanceToAPowerNearestNeighbor", raises: []
  .}

  proc GDALGridInverseDistanceToAPowerNoSearch*(
    a0: pointer,
    a1: GUInt32,
    a2: ptr cdouble,
    a3: ptr cdouble,
    a4: ptr cdouble,
    a5: cdouble,
    a6: cdouble,
    a7: ptr cdouble,
    a8: pointer,
  ): CPLErr {.cdecl, importc: "GDALGridInverseDistanceToAPowerNoSearch", raises: [].}

  proc GDALGridMovingAverage*(
    a0: pointer,
    a1: GUInt32,
    a2: ptr cdouble,
    a3: ptr cdouble,
    a4: ptr cdouble,
    a5: cdouble,
    a6: cdouble,
    a7: ptr cdouble,
    a8: pointer,
  ): CPLErr {.cdecl, importc: "GDALGridMovingAverage", raises: [].}

  proc GDALGridNearestNeighbor*(
    a0: pointer,
    a1: GUInt32,
    a2: ptr cdouble,
    a3: ptr cdouble,
    a4: ptr cdouble,
    a5: cdouble,
    a6: cdouble,
    a7: ptr cdouble,
    a8: pointer,
  ): CPLErr {.cdecl, importc: "GDALGridNearestNeighbor", raises: [].}

  proc GDALGridDataMetricMinimum*(
    a0: pointer,
    a1: GUInt32,
    a2: ptr cdouble,
    a3: ptr cdouble,
    a4: ptr cdouble,
    a5: cdouble,
    a6: cdouble,
    a7: ptr cdouble,
    a8: pointer,
  ): CPLErr {.cdecl, importc: "GDALGridDataMetricMinimum", raises: [].}

  proc GDALGridDataMetricMaximum*(
    a0: pointer,
    a1: GUInt32,
    a2: ptr cdouble,
    a3: ptr cdouble,
    a4: ptr cdouble,
    a5: cdouble,
    a6: cdouble,
    a7: ptr cdouble,
    a8: pointer,
  ): CPLErr {.cdecl, importc: "GDALGridDataMetricMaximum", raises: [].}

  proc GDALGridDataMetricRange*(
    a0: pointer,
    a1: GUInt32,
    a2: ptr cdouble,
    a3: ptr cdouble,
    a4: ptr cdouble,
    a5: cdouble,
    a6: cdouble,
    a7: ptr cdouble,
    a8: pointer,
  ): CPLErr {.cdecl, importc: "GDALGridDataMetricRange", raises: [].}

  proc GDALGridDataMetricCount*(
    a0: pointer,
    a1: GUInt32,
    a2: ptr cdouble,
    a3: ptr cdouble,
    a4: ptr cdouble,
    a5: cdouble,
    a6: cdouble,
    a7: ptr cdouble,
    a8: pointer,
  ): CPLErr {.cdecl, importc: "GDALGridDataMetricCount", raises: [].}

  proc GDALGridDataMetricAverageDistance*(
    a0: pointer,
    a1: GUInt32,
    a2: ptr cdouble,
    a3: ptr cdouble,
    a4: ptr cdouble,
    a5: cdouble,
    a6: cdouble,
    a7: ptr cdouble,
    a8: pointer,
  ): CPLErr {.cdecl, importc: "GDALGridDataMetricAverageDistance", raises: [].}

  proc GDALGridDataMetricAverageDistancePts*(
    a0: pointer,
    a1: GUInt32,
    a2: ptr cdouble,
    a3: ptr cdouble,
    a4: ptr cdouble,
    a5: cdouble,
    a6: cdouble,
    a7: ptr cdouble,
    a8: pointer,
  ): CPLErr {.cdecl, importc: "GDALGridDataMetricAverageDistancePts", raises: [].}

  proc GDALGridLinear*(
    a0: pointer,
    a1: GUInt32,
    a2: ptr cdouble,
    a3: ptr cdouble,
    a4: ptr cdouble,
    a5: cdouble,
    a6: cdouble,
    a7: ptr cdouble,
    a8: pointer,
  ): CPLErr {.cdecl, importc: "GDALGridLinear", raises: [].}

  proc GDALGridParseAlgorithmAndOptions*(
    a0: cstring, a1: ptr GDALGridAlgorithm, a2: ptr pointer
  ): CPLErr {.cdecl, importc: "GDALGridParseAlgorithmAndOptions", raises: [].}

  proc GDALCreatePansharpenOptions*(): ptr GDALPansharpenOptions {.
    cdecl, importc: "GDALCreatePansharpenOptions", raises: []
  .}

  proc GDALDestroyPansharpenOptions*(
    a0: ptr GDALPansharpenOptions
  ) {.cdecl, importc: "GDALDestroyPansharpenOptions", raises: [].}

  proc GDALClonePansharpenOptions*(
    psOptions: ptr GDALPansharpenOptions
  ): ptr GDALPansharpenOptions {.
    cdecl, importc: "GDALClonePansharpenOptions", raises: []
  .}

  proc GDALCreatePansharpenOperation*(
    a0: ptr GDALPansharpenOptions
  ): GDALPansharpenOperationH {.
    cdecl, importc: "GDALCreatePansharpenOperation", raises: []
  .}

  proc GDALDestroyPansharpenOperation*(
    a0: GDALPansharpenOperationH
  ) {.cdecl, importc: "GDALDestroyPansharpenOperation", raises: [].}

  proc GDALPansharpenProcessRegion*(
    hOperation: GDALPansharpenOperationH,
    nXOff: cint,
    nYOff: cint,
    nXSize: cint,
    nYSize: cint,
    pDataBuf: pointer,
    eBufDataType: GDALDataType,
  ): CPLErr {.cdecl, importc: "GDALPansharpenProcessRegion", raises: [].}

  proc GDALWarpNoDataMasker*(
    pMaskFuncArg: pointer,
    nBandCount: cint,
    eType: GDALDataType,
    nXOff: cint,
    nYOff: cint,
    nXSize: cint,
    nYSize: cint,
    papabyImageData: ptr ptr GByte,
    bMaskIsFloat: cint,
    pValidityMask: pointer,
    pbOutAllValid: ptr cint,
  ): CPLErr {.cdecl, importc: "GDALWarpNoDataMasker", raises: [].}

  proc GDALWarpDstAlphaMasker*(
    pMaskFuncArg: pointer,
    nBandCount: cint,
    eType: GDALDataType,
    nXOff: cint,
    nYOff: cint,
    nXSize: cint,
    nYSize: cint,
    a7: ptr ptr GByte,
    bMaskIsFloat: cint,
    pValidityMask: pointer,
  ): CPLErr {.cdecl, importc: "GDALWarpDstAlphaMasker", raises: [].}

  proc GDALWarpSrcAlphaMasker*(
    pMaskFuncArg: pointer,
    nBandCount: cint,
    eType: GDALDataType,
    nXOff: cint,
    nYOff: cint,
    nXSize: cint,
    nYSize: cint,
    a7: ptr ptr GByte,
    bMaskIsFloat: cint,
    pValidityMask: pointer,
    pbOutAllOpaque: ptr cint,
  ): CPLErr {.cdecl, importc: "GDALWarpSrcAlphaMasker", raises: [].}

  proc GDALWarpSrcMaskMasker*(
    pMaskFuncArg: pointer,
    nBandCount: cint,
    eType: GDALDataType,
    nXOff: cint,
    nYOff: cint,
    nXSize: cint,
    nYSize: cint,
    a7: ptr ptr GByte,
    bMaskIsFloat: cint,
    pValidityMask: pointer,
  ): CPLErr {.cdecl, importc: "GDALWarpSrcMaskMasker", raises: [].}

  proc GDALWarpCutlineMasker*(
    pMaskFuncArg: pointer,
    nBandCount: cint,
    eType: GDALDataType,
    nXOff: cint,
    nYOff: cint,
    nXSize: cint,
    nYSize: cint,
    a7: ptr ptr GByte,
    bMaskIsFloat: cint,
    pValidityMask: pointer,
  ): CPLErr {.cdecl, importc: "GDALWarpCutlineMasker", raises: [].}

  proc GDALWarpCutlineMaskerEx*(
    pMaskFuncArg: pointer,
    nBandCount: cint,
    eType: GDALDataType,
    nXOff: cint,
    nYOff: cint,
    nXSize: cint,
    nYSize: cint,
    a7: ptr ptr GByte,
    bMaskIsFloat: cint,
    pValidityMask: pointer,
    pnValidityFlag: ptr cint,
  ): CPLErr {.cdecl, importc: "GDALWarpCutlineMaskerEx", raises: [].}

  proc GDALWarpGetOptionList*(): cstring {.
    cdecl, importc: "GDALWarpGetOptionList", raises: []
  .}

  proc GDALCreateWarpOptions*(): ptr GDALWarpOptions {.
    gdalCall, importc: "GDALCreateWarpOptions", raises: []
  .}

  proc GDALDestroyWarpOptions*(
    a0: ptr GDALWarpOptions
  ) {.gdalCall, importc: "GDALDestroyWarpOptions", raises: [].}

  proc GDALCloneWarpOptions*(
    a0: ptr GDALWarpOptions
  ): ptr GDALWarpOptions {.gdalCall, importc: "GDALCloneWarpOptions", raises: [].}

  proc GDALWarpInitDstNoDataReal*(
    a0: ptr GDALWarpOptions, dNoDataReal: cdouble
  ) {.gdalCall, importc: "GDALWarpInitDstNoDataReal", raises: [].}

  proc GDALWarpInitSrcNoDataReal*(
    a0: ptr GDALWarpOptions, dNoDataReal: cdouble
  ) {.gdalCall, importc: "GDALWarpInitSrcNoDataReal", raises: [].}

  proc GDALWarpInitNoDataReal*(
    a0: ptr GDALWarpOptions, dNoDataReal: cdouble
  ) {.gdalCall, importc: "GDALWarpInitNoDataReal", raises: [].}

  proc GDALWarpInitDstNoDataImag*(
    a0: ptr GDALWarpOptions, dNoDataImag: cdouble
  ) {.gdalCall, importc: "GDALWarpInitDstNoDataImag", raises: [].}

  proc GDALWarpInitSrcNoDataImag*(
    a0: ptr GDALWarpOptions, dNoDataImag: cdouble
  ) {.gdalCall, importc: "GDALWarpInitSrcNoDataImag", raises: [].}

  proc GDALWarpResolveWorkingDataType*(
    a0: ptr GDALWarpOptions
  ) {.gdalCall, importc: "GDALWarpResolveWorkingDataType", raises: [].}

  proc GDALWarpInitDefaultBandMapping*(
    a0: ptr GDALWarpOptions, nBandCount: cint
  ) {.gdalCall, importc: "GDALWarpInitDefaultBandMapping", raises: [].}

  proc GDALSerializeWarpOptions*(
    a0: ptr GDALWarpOptions
  ): ptr CPLXMLNode {.gdalCall, importc: "GDALSerializeWarpOptions", raises: [].}

  proc GDALDeserializeWarpOptions*(
    a0: ptr CPLXMLNode
  ): ptr GDALWarpOptions {.gdalCall, importc: "GDALDeserializeWarpOptions", raises: [].}

  proc GDALReprojectImage*(
    hSrcDS: GDALDatasetH,
    pszSrcWKT: cstring,
    hDstDS: GDALDatasetH,
    pszDstWKT: cstring,
    eResampleAlg: GDALResampleAlg,
    dfWarpMemoryLimit: cdouble,
    dfMaxError: cdouble,
    pfnProgress: GDALProgressFunc,
    pProgressArg: pointer,
    psOptions: ptr GDALWarpOptions,
  ): CPLErr {.gdalCall, importc: "GDALReprojectImage", raises: [].}

  proc GDALCreateAndReprojectImage*(
    hSrcDS: GDALDatasetH,
    pszSrcWKT: cstring,
    pszDstFilename: cstring,
    pszDstWKT: cstring,
    hDstDriver: GDALDriverH,
    papszCreateOptions: cstringArray,
    eResampleAlg: GDALResampleAlg,
    dfWarpMemoryLimit: cdouble,
    dfMaxError: cdouble,
    pfnProgress: GDALProgressFunc,
    pProgressArg: pointer,
    psOptions: ptr GDALWarpOptions,
  ): CPLErr {.gdalCall, importc: "GDALCreateAndReprojectImage", raises: [].}

  proc GDALAutoCreateWarpedVRT*(
    hSrcDS: GDALDatasetH,
    pszSrcWKT: cstring,
    pszDstWKT: cstring,
    eResampleAlg: GDALResampleAlg,
    dfMaxError: cdouble,
    psOptions: ptr GDALWarpOptions,
  ): GDALDatasetH {.gdalCall, importc: "GDALAutoCreateWarpedVRT", raises: [].}

  proc GDALAutoCreateWarpedVRTEx*(
    hSrcDS: GDALDatasetH,
    pszSrcWKT: cstring,
    pszDstWKT: cstring,
    eResampleAlg: GDALResampleAlg,
    dfMaxError: cdouble,
    psOptions: ptr GDALWarpOptions,
    papszTransformerOptions: CSLConstList,
  ): GDALDatasetH {.gdalCall, importc: "GDALAutoCreateWarpedVRTEx", raises: [].}

  proc GDALCreateWarpedVRT*(
    hSrcDS: GDALDatasetH,
    nPixels: cint,
    nLines: cint,
    padfGeoTransform: ptr cdouble,
    psOptions: ptr GDALWarpOptions,
  ): GDALDatasetH {.gdalCall, importc: "GDALCreateWarpedVRT", raises: [].}

  proc GDALInitializeWarpedVRT*(
    hDS: GDALDatasetH, psWO: ptr GDALWarpOptions
  ): CPLErr {.gdalCall, importc: "GDALInitializeWarpedVRT", raises: [].}

  proc GDALCreateWarpOperation*(
    a0: ptr GDALWarpOptions
  ): GDALWarpOperationH {.cdecl, importc: "GDALCreateWarpOperation", raises: [].}

  proc GDALDestroyWarpOperation*(
    a0: GDALWarpOperationH
  ) {.cdecl, importc: "GDALDestroyWarpOperation", raises: [].}

  proc GDALChunkAndWarpImage*(
    a0: GDALWarpOperationH, a1: cint, a2: cint, a3: cint, a4: cint
  ): CPLErr {.cdecl, importc: "GDALChunkAndWarpImage", raises: [].}

  proc GDALChunkAndWarpMulti*(
    a0: GDALWarpOperationH, a1: cint, a2: cint, a3: cint, a4: cint
  ): CPLErr {.cdecl, importc: "GDALChunkAndWarpMulti", raises: [].}

  proc GDALWarpRegion*(
    a0: GDALWarpOperationH,
    a1: cint,
    a2: cint,
    a3: cint,
    a4: cint,
    a5: cint,
    a6: cint,
    a7: cint,
    a8: cint,
  ): CPLErr {.cdecl, importc: "GDALWarpRegion", raises: [].}

  proc GDALWarpRegionToBuffer*(
    a0: GDALWarpOperationH,
    a1: cint,
    a2: cint,
    a3: cint,
    a4: cint,
    a5: pointer,
    a6: GDALDataType,
    a7: cint,
    a8: cint,
    a9: cint,
    a10: cint,
  ): CPLErr {.cdecl, importc: "GDALWarpRegionToBuffer", raises: [].}

  proc GWKGetFilterRadius*(
    eResampleAlg: GDALResampleAlg
  ): cint {.cdecl, importc: "GWKGetFilterRadius", raises: [].}

  proc GWKGetFilterFunc*(
    eResampleAlg: GDALResampleAlg
  ): FilterFuncType {.cdecl, importc: "GWKGetFilterFunc", raises: [].}

  proc GWKGetFilterFunc4Values*(
    eResampleAlg: GDALResampleAlg
  ): FilterFunc4ValuesType {.cdecl, importc: "GWKGetFilterFunc4Values", raises: [].}

  proc GNMGetName*(
    hNet: GNMNetworkH
  ): cstring {.gdalCall, importc: "GNMGetName", raises: [].}

  proc GNMGetVersion*(
    hNet: GNMNetworkH
  ): cint {.gdalCall, importc: "GNMGetVersion", raises: [].}

  proc GNMDisconnectAll*(
    hNet: GNMNetworkH
  ): CPLErr {.gdalCall, importc: "GNMDisconnectAll", raises: [].}

  proc GNMGetFeatureByGlobalFID*(
    hNet: GNMNetworkH, nGFID: GIntBig
  ): OGRFeatureH {.gdalCall, importc: "GNMGetFeatureByGlobalFID", raises: [].}

  proc GNMGetPath*(
    hNet: GNMNetworkH,
    nStartFID: GIntBig,
    nEndFID: GIntBig,
    eAlgorithm: GNMGraphAlgorithmType,
    papszOptions: CSLConstList,
  ): OGRLayerH {.gdalCall, importc: "GNMGetPath", raises: [].}

  proc GNMConnectFeatures*(
    hNet: GNMGenericNetworkH,
    nSrcFID: GIntBig,
    nTgtFID: GIntBig,
    nConFID: GIntBig,
    dfCost: cdouble,
    dfInvCost: cdouble,
    eDir: GNMDirection,
  ): CPLErr {.gdalCall, importc: "GNMConnectFeatures", raises: [].}

  proc GNMDisconnectFeatures*(
    hNet: GNMGenericNetworkH, nSrcFID: GIntBig, nTgtFID: GIntBig, nConFID: GIntBig
  ): CPLErr {.gdalCall, importc: "GNMDisconnectFeatures", raises: [].}

  proc GNMDisconnectFeaturesWithId*(
    hNet: GNMGenericNetworkH, nFID: GIntBig
  ): CPLErr {.gdalCall, importc: "GNMDisconnectFeaturesWithId", raises: [].}

  proc GNMReconnectFeatures*(
    hNet: GNMGenericNetworkH,
    nSrcFID: GIntBig,
    nTgtFID: GIntBig,
    nConFID: GIntBig,
    dfCost: cdouble,
    dfInvCost: cdouble,
    eDir: GNMDirection,
  ): CPLErr {.gdalCall, importc: "GNMReconnectFeatures", raises: [].}

  proc GNMCreateRule*(
    hNet: GNMGenericNetworkH, pszRuleStr: cstring
  ): CPLErr {.gdalCall, importc: "GNMCreateRule", raises: [].}

  proc GNMDeleteAllRules*(
    hNet: GNMGenericNetworkH
  ): CPLErr {.gdalCall, importc: "GNMDeleteAllRules", raises: [].}

  proc GNMDeleteRule*(
    hNet: GNMGenericNetworkH, pszRuleStr: cstring
  ): CPLErr {.gdalCall, importc: "GNMDeleteRule", raises: [].}

  proc GNMGetRules*(
    hNet: GNMGenericNetworkH
  ): cstringArray {.gdalCall, importc: "GNMGetRules", raises: [].}

  proc GNMConnectPointsByLines*(
    hNet: GNMGenericNetworkH,
    papszLayerList: cstringArray,
    dfTolerance: cdouble,
    dfCost: cdouble,
    dfInvCost: cdouble,
    eDir: GNMDirection,
  ): CPLErr {.gdalCall, importc: "GNMConnectPointsByLines", raises: [].}

  proc GNMChangeBlockState*(
    hNet: GNMGenericNetworkH, nFID: GIntBig, bIsBlock: bool
  ): CPLErr {.gdalCall, importc: "GNMChangeBlockState", raises: [].}

  proc GNMChangeAllBlockState*(
    hNet: GNMGenericNetworkH, bIsBlock: cint
  ): CPLErr {.gdalCall, importc: "GNMChangeAllBlockState", raises: [].}

  proc GNMCastToNetwork*(
    hBase: GDALMajorObjectH
  ): GNMNetworkH {.gdalCall, importc: "GNMCastToNetwork", raises: [].}

  proc GNMCastToGenericNetwork*(
    hBase: GDALMajorObjectH
  ): GNMGenericNetworkH {.gdalCall, importc: "GNMCastToGenericNetwork", raises: [].}

  proc OGRGeocodeCreateSession*(
    papszOptions: CSLConstList
  ): OGRGeocodingSessionH {.cdecl, importc: "OGRGeocodeCreateSession", raises: [].}

  proc OGRGeocodeDestroySession*(
    hSession: OGRGeocodingSessionH
  ) {.cdecl, importc: "OGRGeocodeDestroySession", raises: [].}

  proc OGRGeocode*(
    hSession: OGRGeocodingSessionH,
    pszQuery: cstring,
    papszStructuredQuery: cstringArray,
    papszOptions: CSLConstList,
  ): OGRLayerH {.cdecl, importc: "OGRGeocode", raises: [].}

  proc OGRGeocodeReverse*(
    hSession: OGRGeocodingSessionH,
    dfLon: cdouble,
    dfLat: cdouble,
    papszOptions: CSLConstList,
  ): OGRLayerH {.cdecl, importc: "OGRGeocodeReverse", raises: [].}

  proc OGRGeocodeFreeResult*(
    hLayer: OGRLayerH
  ) {.cdecl, importc: "OGRGeocodeFreeResult", raises: [].}

  proc OSRAxisEnumToName*(
    eOrientation: OGRAxisOrientation
  ): cstring {.cdecl, importc: "OSRAxisEnumToName", raises: [].}

  proc OSRSetPROJSearchPaths*(
    papszPaths: cstringArray
  ) {.cdecl, importc: "OSRSetPROJSearchPaths", raises: [].}

  proc OSRGetPROJSearchPaths*(): cstringArray {.
    cdecl, importc: "OSRGetPROJSearchPaths", raises: []
  .}

  proc OSRSetPROJAuxDbPaths*(
    papszPaths: cstringArray
  ) {.cdecl, importc: "OSRSetPROJAuxDbPaths", raises: [].}

  proc OSRGetPROJAuxDbPaths*(): cstringArray {.
    cdecl, importc: "OSRGetPROJAuxDbPaths", raises: []
  .}

  proc OSRSetPROJEnableNetwork*(
    enabled: cint
  ) {.cdecl, importc: "OSRSetPROJEnableNetwork", raises: [].}

  proc OSRGetPROJEnableNetwork*(): cint {.
    cdecl, importc: "OSRGetPROJEnableNetwork", raises: []
  .}

  proc OSRGetPROJVersion*(
    pnMajor: ptr cint, pnMinor: ptr cint, pnPatch: ptr cint
  ) {.cdecl, importc: "OSRGetPROJVersion", raises: [].}

  proc OSRNewSpatialReference*(
    a0: cstring
  ): OGRSpatialReferenceH {.gdalCall, importc: "OSRNewSpatialReference", raises: [].}

  proc OSRCloneGeogCS*(
    a0: OGRSpatialReferenceH
  ): OGRSpatialReferenceH {.gdalCall, importc: "OSRCloneGeogCS", raises: [].}

  proc OSRClone*(
    a0: OGRSpatialReferenceH
  ): OGRSpatialReferenceH {.gdalCall, importc: "OSRClone", raises: [].}

  proc OSRDestroySpatialReference*(
    a0: OGRSpatialReferenceH
  ) {.gdalCall, importc: "OSRDestroySpatialReference", raises: [].}

  proc OSRReference*(
    a0: OGRSpatialReferenceH
  ): cint {.cdecl, importc: "OSRReference", raises: [].}

  proc OSRDereference*(
    a0: OGRSpatialReferenceH
  ): cint {.cdecl, importc: "OSRDereference", raises: [].}

  proc OSRRelease*(
    a0: OGRSpatialReferenceH
  ) {.cdecl, importc: "OSRRelease", raises: [].}

  proc OSRValidate*(
    a0: OGRSpatialReferenceH
  ): OGRErr {.cdecl, importc: "OSRValidate", raises: [].}

  proc OSRImportFromEPSG*(
    a0: OGRSpatialReferenceH, a1: cint
  ): OGRErr {.gdalCall, importc: "OSRImportFromEPSG", raises: [].}

  proc OSRImportFromEPSGA*(
    a0: OGRSpatialReferenceH, a1: cint
  ): OGRErr {.gdalCall, importc: "OSRImportFromEPSGA", raises: [].}

  proc OSRImportFromWkt*(
    a0: OGRSpatialReferenceH, a1: cstringArray
  ): OGRErr {.cdecl, importc: "OSRImportFromWkt", raises: [].}

  proc OSRImportFromProj4*(
    a0: OGRSpatialReferenceH, a1: cstring
  ): OGRErr {.cdecl, importc: "OSRImportFromProj4", raises: [].}

  proc OSRImportFromESRI*(
    a0: OGRSpatialReferenceH, a1: cstringArray
  ): OGRErr {.cdecl, importc: "OSRImportFromESRI", raises: [].}

  proc OSRImportFromPCI*(
    hSRS: OGRSpatialReferenceH, a1: cstring, a2: cstring, a3: ptr cdouble
  ): OGRErr {.cdecl, importc: "OSRImportFromPCI", raises: [].}

  proc OSRImportFromUSGS*(
    a0: OGRSpatialReferenceH, a1: clong, a2: clong, a3: ptr cdouble, a4: clong
  ): OGRErr {.cdecl, importc: "OSRImportFromUSGS", raises: [].}

  proc OSRImportFromXML*(
    a0: OGRSpatialReferenceH, a1: cstring
  ): OGRErr {.cdecl, importc: "OSRImportFromXML", raises: [].}

  proc OSRImportFromDict*(
    a0: OGRSpatialReferenceH, a1: cstring, a2: cstring
  ): OGRErr {.cdecl, importc: "OSRImportFromDict", raises: [].}

  proc OSRImportFromPanorama*(
    a0: OGRSpatialReferenceH, a1: clong, a2: clong, a3: clong, a4: ptr cdouble
  ): OGRErr {.cdecl, importc: "OSRImportFromPanorama", raises: [].}

  proc OSRImportFromOzi*(
    a0: OGRSpatialReferenceH, a1: cstringArray
  ): OGRErr {.cdecl, importc: "OSRImportFromOzi", raises: [].}

  proc OSRImportFromMICoordSys*(
    a0: OGRSpatialReferenceH, a1: cstring
  ): OGRErr {.cdecl, importc: "OSRImportFromMICoordSys", raises: [].}

  proc OSRImportFromERM*(
    a0: OGRSpatialReferenceH, a1: cstring, a2: cstring, a3: cstring
  ): OGRErr {.cdecl, importc: "OSRImportFromERM", raises: [].}

  proc OSRImportFromUrl*(
    a0: OGRSpatialReferenceH, a1: cstring
  ): OGRErr {.cdecl, importc: "OSRImportFromUrl", raises: [].}

  proc OSRImportFromCF1*(
    a0: OGRSpatialReferenceH, papszKeyValues: CSLConstList, pszUnits: cstring
  ): OGRErr {.cdecl, importc: "OSRImportFromCF1", raises: [].}

  proc OSRExportToWkt*(
    a0: OGRSpatialReferenceH, a1: cstringArray
  ): OGRErr {.gdalCall, importc: "OSRExportToWkt", raises: [].}

  proc OSRExportToWktEx*(
    a0: OGRSpatialReferenceH, ppszResult: cstringArray, papszOptions: cstringArray
  ): OGRErr {.cdecl, importc: "OSRExportToWktEx", raises: [].}

  proc OSRExportToPrettyWkt*(
    a0: OGRSpatialReferenceH, a1: cstringArray, a2: cint
  ): OGRErr {.gdalCall, importc: "OSRExportToPrettyWkt", raises: [].}

  proc OSRExportToPROJJSON*(
    hSRS: OGRSpatialReferenceH, ppszReturn: cstringArray, papszOptions: cstringArray
  ): OGRErr {.cdecl, importc: "OSRExportToPROJJSON", raises: [].}

  proc OSRExportToProj4*(
    a0: OGRSpatialReferenceH, a1: cstringArray
  ): OGRErr {.gdalCall, importc: "OSRExportToProj4", raises: [].}

  proc OSRExportToPCI*(
    a0: OGRSpatialReferenceH, a1: cstringArray, a2: cstringArray, a3: ptr ptr cdouble
  ): OGRErr {.cdecl, importc: "OSRExportToPCI", raises: [].}

  proc OSRExportToUSGS*(
    a0: OGRSpatialReferenceH,
    a1: ptr clong,
    a2: ptr clong,
    a3: ptr ptr cdouble,
    a4: ptr clong,
  ): OGRErr {.cdecl, importc: "OSRExportToUSGS", raises: [].}

  proc OSRExportToXML*(
    a0: OGRSpatialReferenceH, a1: cstringArray, a2: cstring
  ): OGRErr {.cdecl, importc: "OSRExportToXML", raises: [].}

  proc OSRExportToPanorama*(
    a0: OGRSpatialReferenceH,
    a1: ptr clong,
    a2: ptr clong,
    a3: ptr clong,
    a4: ptr clong,
    a5: ptr cdouble,
  ): OGRErr {.cdecl, importc: "OSRExportToPanorama", raises: [].}

  proc OSRExportToMICoordSys*(
    a0: OGRSpatialReferenceH, a1: cstringArray
  ): OGRErr {.cdecl, importc: "OSRExportToMICoordSys", raises: [].}

  proc OSRExportToERM*(
    a0: OGRSpatialReferenceH, a1: cstring, a2: cstring, a3: cstring
  ): OGRErr {.cdecl, importc: "OSRExportToERM", raises: [].}

  proc OSRExportToCF1*(
    a0: OGRSpatialReferenceH,
    ppszGridMappingName: cstringArray,
    ppapszKeyValues: ptr cstringArray,
    ppszUnits: cstringArray,
    papszOptions: CSLConstList,
  ): OGRErr {.cdecl, importc: "OSRExportToCF1", raises: [].}

  proc OSRMorphToESRI*(
    a0: OGRSpatialReferenceH
  ): OGRErr {.cdecl, importc: "OSRMorphToESRI", raises: [].}

  proc OSRMorphFromESRI*(
    a0: OGRSpatialReferenceH
  ): OGRErr {.cdecl, importc: "OSRMorphFromESRI", raises: [].}

  proc OSRStripVertical*(
    a0: OGRSpatialReferenceH
  ): OGRErr {.cdecl, importc: "OSRStripVertical", raises: [].}

  proc OSRConvertToOtherProjection*(
    hSRS: OGRSpatialReferenceH, pszTargetProjection: cstring, papszOptions: cstringArray
  ): OGRSpatialReferenceH {.cdecl, importc: "OSRConvertToOtherProjection", raises: [].}

  proc OSRGetName*(
    hSRS: OGRSpatialReferenceH
  ): cstring {.cdecl, importc: "OSRGetName", raises: [].}

  proc OSRGetCelestialBodyName*(
    hSRS: OGRSpatialReferenceH
  ): cstring {.cdecl, importc: "OSRGetCelestialBodyName", raises: [].}

  proc OSRSetAttrValue*(
    hSRS: OGRSpatialReferenceH, pszNodePath: cstring, pszNewNodeValue: cstring
  ): OGRErr {.gdalCall, importc: "OSRSetAttrValue", raises: [].}

  proc OSRGetAttrValue*(
    hSRS: OGRSpatialReferenceH, pszName: cstring, iChild: cint
  ): cstring {.gdalCall, importc: "OSRGetAttrValue", raises: [].}

  proc OSRSetAngularUnits*(
    a0: OGRSpatialReferenceH, a1: cstring, a2: cdouble
  ): OGRErr {.cdecl, importc: "OSRSetAngularUnits", raises: [].}

  proc OSRGetAngularUnits*(
    a0: OGRSpatialReferenceH, a1: cstringArray
  ): cdouble {.cdecl, importc: "OSRGetAngularUnits", raises: [].}

  proc OSRSetLinearUnits*(
    a0: OGRSpatialReferenceH, a1: cstring, a2: cdouble
  ): OGRErr {.cdecl, importc: "OSRSetLinearUnits", raises: [].}

  proc OSRSetTargetLinearUnits*(
    a0: OGRSpatialReferenceH, a1: cstring, a2: cstring, a3: cdouble
  ): OGRErr {.cdecl, importc: "OSRSetTargetLinearUnits", raises: [].}

  proc OSRSetLinearUnitsAndUpdateParameters*(
    a0: OGRSpatialReferenceH, a1: cstring, a2: cdouble
  ): OGRErr {.cdecl, importc: "OSRSetLinearUnitsAndUpdateParameters", raises: [].}

  proc OSRGetLinearUnits*(
    a0: OGRSpatialReferenceH, a1: cstringArray
  ): cdouble {.cdecl, importc: "OSRGetLinearUnits", raises: [].}

  proc OSRGetTargetLinearUnits*(
    a0: OGRSpatialReferenceH, a1: cstring, a2: cstringArray
  ): cdouble {.cdecl, importc: "OSRGetTargetLinearUnits", raises: [].}

  proc OSRGetPrimeMeridian*(
    a0: OGRSpatialReferenceH, a1: cstringArray
  ): cdouble {.cdecl, importc: "OSRGetPrimeMeridian", raises: [].}

  proc OSRIsGeographic*(
    a0: OGRSpatialReferenceH
  ): cint {.cdecl, importc: "OSRIsGeographic", raises: [].}

  proc OSRIsDerivedGeographic*(
    a0: OGRSpatialReferenceH
  ): cint {.cdecl, importc: "OSRIsDerivedGeographic", raises: [].}

  proc OSRIsLocal*(
    a0: OGRSpatialReferenceH
  ): cint {.cdecl, importc: "OSRIsLocal", raises: [].}

  proc OSRIsProjected*(
    a0: OGRSpatialReferenceH
  ): cint {.cdecl, importc: "OSRIsProjected", raises: [].}

  proc OSRIsDerivedProjected*(
    a0: OGRSpatialReferenceH
  ): cint {.cdecl, importc: "OSRIsDerivedProjected", raises: [].}

  proc OSRIsCompound*(
    a0: OGRSpatialReferenceH
  ): cint {.cdecl, importc: "OSRIsCompound", raises: [].}

  proc OSRIsGeocentric*(
    a0: OGRSpatialReferenceH
  ): cint {.cdecl, importc: "OSRIsGeocentric", raises: [].}

  proc OSRIsVertical*(
    a0: OGRSpatialReferenceH
  ): cint {.cdecl, importc: "OSRIsVertical", raises: [].}

  proc OSRIsDynamic*(
    a0: OGRSpatialReferenceH
  ): cint {.cdecl, importc: "OSRIsDynamic", raises: [].}

  proc OSRHasPointMotionOperation*(
    a0: OGRSpatialReferenceH
  ): cint {.cdecl, importc: "OSRHasPointMotionOperation", raises: [].}

  proc OSRIsSameGeogCS*(
    a0: OGRSpatialReferenceH, a1: OGRSpatialReferenceH
  ): cint {.cdecl, importc: "OSRIsSameGeogCS", raises: [].}

  proc OSRIsSameVertCS*(
    a0: OGRSpatialReferenceH, a1: OGRSpatialReferenceH
  ): cint {.cdecl, importc: "OSRIsSameVertCS", raises: [].}

  proc OSRIsSame*(
    a0: OGRSpatialReferenceH, a1: OGRSpatialReferenceH
  ): cint {.cdecl, importc: "OSRIsSame", raises: [].}

  proc OSRIsSameEx*(
    a0: OGRSpatialReferenceH, a1: OGRSpatialReferenceH, papszOptions: cstringArray
  ): cint {.cdecl, importc: "OSRIsSameEx", raises: [].}

  proc OSRSetCoordinateEpoch*(
    hSRS: OGRSpatialReferenceH, dfCoordinateEpoch: cdouble
  ) {.cdecl, importc: "OSRSetCoordinateEpoch", raises: [].}

  proc OSRGetCoordinateEpoch*(
    hSRS: OGRSpatialReferenceH
  ): cdouble {.cdecl, importc: "OSRGetCoordinateEpoch", raises: [].}

  proc OSRSetLocalCS*(
    hSRS: OGRSpatialReferenceH, pszName: cstring
  ): OGRErr {.cdecl, importc: "OSRSetLocalCS", raises: [].}

  proc OSRSetProjCS*(
    hSRS: OGRSpatialReferenceH, pszName: cstring
  ): OGRErr {.cdecl, importc: "OSRSetProjCS", raises: [].}

  proc OSRSetGeocCS*(
    hSRS: OGRSpatialReferenceH, pszName: cstring
  ): OGRErr {.cdecl, importc: "OSRSetGeocCS", raises: [].}

  proc OSRSetWellKnownGeogCS*(
    hSRS: OGRSpatialReferenceH, pszName: cstring
  ): OGRErr {.cdecl, importc: "OSRSetWellKnownGeogCS", raises: [].}

  proc OSRSetFromUserInput*(
    hSRS: OGRSpatialReferenceH, a1: cstring
  ): OGRErr {.gdalCall, importc: "OSRSetFromUserInput", raises: [].}

  proc OSRSetFromUserInputEx*(
    hSRS: OGRSpatialReferenceH, a1: cstring, papszOptions: CSLConstList
  ): OGRErr {.cdecl, importc: "OSRSetFromUserInputEx", raises: [].}

  proc OSRCopyGeogCSFrom*(
    hSRS: OGRSpatialReferenceH, hSrcSRS: OGRSpatialReferenceH
  ): OGRErr {.cdecl, importc: "OSRCopyGeogCSFrom", raises: [].}

  proc OSRSetTOWGS84*(
    hSRS: OGRSpatialReferenceH,
    a1: cdouble,
    a2: cdouble,
    a3: cdouble,
    a4: cdouble,
    a5: cdouble,
    a6: cdouble,
    a7: cdouble,
  ): OGRErr {.cdecl, importc: "OSRSetTOWGS84", raises: [].}

  proc OSRGetTOWGS84*(
    hSRS: OGRSpatialReferenceH, a1: ptr cdouble, a2: cint
  ): OGRErr {.cdecl, importc: "OSRGetTOWGS84", raises: [].}

  proc OSRAddGuessedTOWGS84*(
    hSRS: OGRSpatialReferenceH
  ): OGRErr {.cdecl, importc: "OSRAddGuessedTOWGS84", raises: [].}

  proc OSRSetCompoundCS*(
    hSRS: OGRSpatialReferenceH,
    pszName: cstring,
    hHorizSRS: OGRSpatialReferenceH,
    hVertSRS: OGRSpatialReferenceH,
  ): OGRErr {.cdecl, importc: "OSRSetCompoundCS", raises: [].}

  proc OSRPromoteTo3D*(
    hSRS: OGRSpatialReferenceH, pszName: cstring
  ): OGRErr {.cdecl, importc: "OSRPromoteTo3D", raises: [].}

  proc OSRDemoteTo2D*(
    hSRS: OGRSpatialReferenceH, pszName: cstring
  ): OGRErr {.cdecl, importc: "OSRDemoteTo2D", raises: [].}

  proc OSRSetGeogCS*(
    hSRS: OGRSpatialReferenceH,
    pszGeogName: cstring,
    pszDatumName: cstring,
    pszEllipsoidName: cstring,
    dfSemiMajor: cdouble,
    dfInvFlattening: cdouble,
    pszPMName: cstring,
    dfPMOffset: cdouble,
    pszUnits: cstring,
    dfConvertToRadians: cdouble,
  ): OGRErr {.cdecl, importc: "OSRSetGeogCS", raises: [].}

  proc OSRSetVertCS*(
    hSRS: OGRSpatialReferenceH,
    pszVertCSName: cstring,
    pszVertDatumName: cstring,
    nVertDatumType: cint,
  ): OGRErr {.cdecl, importc: "OSRSetVertCS", raises: [].}

  proc OSRGetSemiMajor*(
    a0: OGRSpatialReferenceH, a1: ptr OGRErr
  ): cdouble {.cdecl, importc: "OSRGetSemiMajor", raises: [].}

  proc OSRGetSemiMinor*(
    a0: OGRSpatialReferenceH, a1: ptr OGRErr
  ): cdouble {.cdecl, importc: "OSRGetSemiMinor", raises: [].}

  proc OSRGetInvFlattening*(
    a0: OGRSpatialReferenceH, a1: ptr OGRErr
  ): cdouble {.cdecl, importc: "OSRGetInvFlattening", raises: [].}

  proc OSRSetAuthority*(
    hSRS: OGRSpatialReferenceH,
    pszTargetKey: cstring,
    pszAuthority: cstring,
    nCode: cint,
  ): OGRErr {.cdecl, importc: "OSRSetAuthority", raises: [].}

  proc OSRGetAuthorityCode*(
    hSRS: OGRSpatialReferenceH, pszTargetKey: cstring
  ): cstring {.cdecl, importc: "OSRGetAuthorityCode", raises: [].}

  proc OSRGetAuthorityName*(
    hSRS: OGRSpatialReferenceH, pszTargetKey: cstring
  ): cstring {.cdecl, importc: "OSRGetAuthorityName", raises: [].}

  proc OSRGetAreaOfUse*(
    hSRS: OGRSpatialReferenceH,
    pdfWestLongitudeDeg: ptr cdouble,
    pdfSouthLatitudeDeg: ptr cdouble,
    pdfEastLongitudeDeg: ptr cdouble,
    pdfNorthLatitudeDeg: ptr cdouble,
    ppszAreaName: cstringArray,
  ): cint {.cdecl, importc: "OSRGetAreaOfUse", raises: [].}

  proc OSRSetProjection*(
    a0: OGRSpatialReferenceH, a1: cstring
  ): OGRErr {.cdecl, importc: "OSRSetProjection", raises: [].}

  proc OSRSetProjParm*(
    a0: OGRSpatialReferenceH, a1: cstring, a2: cdouble
  ): OGRErr {.cdecl, importc: "OSRSetProjParm", raises: [].}

  proc OSRGetProjParm*(
    hSRS: OGRSpatialReferenceH,
    pszParamName: cstring,
    dfDefault: cdouble,
    a3: ptr OGRErr,
  ): cdouble {.cdecl, importc: "OSRGetProjParm", raises: [].}

  proc OSRSetNormProjParm*(
    a0: OGRSpatialReferenceH, a1: cstring, a2: cdouble
  ): OGRErr {.cdecl, importc: "OSRSetNormProjParm", raises: [].}

  proc OSRGetNormProjParm*(
    hSRS: OGRSpatialReferenceH,
    pszParamName: cstring,
    dfDefault: cdouble,
    a3: ptr OGRErr,
  ): cdouble {.cdecl, importc: "OSRGetNormProjParm", raises: [].}

  proc OSRSetUTM*(
    hSRS: OGRSpatialReferenceH, nZone: cint, bNorth: cint
  ): OGRErr {.cdecl, importc: "OSRSetUTM", raises: [].}

  proc OSRGetUTMZone*(
    hSRS: OGRSpatialReferenceH, pbNorth: ptr cint
  ): cint {.cdecl, importc: "OSRGetUTMZone", raises: [].}

  proc OSRSetStatePlane*(
    hSRS: OGRSpatialReferenceH, nZone: cint, bNAD83: cint
  ): OGRErr {.cdecl, importc: "OSRSetStatePlane", raises: [].}

  proc OSRSetStatePlaneWithUnits*(
    hSRS: OGRSpatialReferenceH,
    nZone: cint,
    bNAD83: cint,
    pszOverrideUnitName: cstring,
    dfOverrideUnit: cdouble,
  ): OGRErr {.cdecl, importc: "OSRSetStatePlaneWithUnits", raises: [].}

  proc OSRAutoIdentifyEPSG*(
    hSRS: OGRSpatialReferenceH
  ): OGRErr {.cdecl, importc: "OSRAutoIdentifyEPSG", raises: [].}

  proc OSRFindMatches*(
    hSRS: OGRSpatialReferenceH,
    papszOptions: CSLConstList,
    pnEntries: ptr cint,
    ppanMatchConfidence: ptr ptr cint,
  ): ptr OGRSpatialReferenceH {.cdecl, importc: "OSRFindMatches", raises: [].}

  proc OSRFreeSRSArray*(
    pahSRS: ptr OGRSpatialReferenceH
  ) {.cdecl, importc: "OSRFreeSRSArray", raises: [].}

  proc OSREPSGTreatsAsLatLong*(
    hSRS: OGRSpatialReferenceH
  ): cint {.cdecl, importc: "OSREPSGTreatsAsLatLong", raises: [].}

  proc OSREPSGTreatsAsNorthingEasting*(
    hSRS: OGRSpatialReferenceH
  ): cint {.cdecl, importc: "OSREPSGTreatsAsNorthingEasting", raises: [].}

  proc OSRGetAxis*(
    hSRS: OGRSpatialReferenceH,
    pszTargetKey: cstring,
    iAxis: cint,
    peOrientation: ptr OGRAxisOrientation,
  ): cstring {.cdecl, importc: "OSRGetAxis", raises: [].}

  proc OSRGetAxesCount*(
    hSRS: OGRSpatialReferenceH
  ): cint {.cdecl, importc: "OSRGetAxesCount", raises: [].}

  proc OSRSetAxes*(
    hSRS: OGRSpatialReferenceH,
    pszTargetKey: cstring,
    pszXAxisName: cstring,
    eXAxisOrientation: OGRAxisOrientation,
    pszYAxisName: cstring,
    eYAxisOrientation: OGRAxisOrientation,
  ): OGRErr {.cdecl, importc: "OSRSetAxes", raises: [].}

  proc OSRGetAxisMappingStrategy*(
    hSRS: OGRSpatialReferenceH
  ): OSRAxisMappingStrategy {.cdecl, importc: "OSRGetAxisMappingStrategy", raises: [].}

  proc OSRSetAxisMappingStrategy*(
    hSRS: OGRSpatialReferenceH, strategy: OSRAxisMappingStrategy
  ) {.cdecl, importc: "OSRSetAxisMappingStrategy", raises: [].}

  proc OSRGetDataAxisToSRSAxisMapping*(
    hSRS: OGRSpatialReferenceH, pnCount: ptr cint
  ): ptr cint {.cdecl, importc: "OSRGetDataAxisToSRSAxisMapping", raises: [].}

  proc OSRSetDataAxisToSRSAxisMapping*(
    hSRS: OGRSpatialReferenceH, nMappingSize: cint, panMapping: ptr cint
  ): OGRErr {.cdecl, importc: "OSRSetDataAxisToSRSAxisMapping", raises: [].}

  proc OSRSetACEA*(
    hSRS: OGRSpatialReferenceH,
    dfStdP1: cdouble,
    dfStdP2: cdouble,
    dfCenterLat: cdouble,
    dfCenterLong: cdouble,
    dfFalseEasting: cdouble,
    dfFalseNorthing: cdouble,
  ): OGRErr {.cdecl, importc: "OSRSetACEA", raises: [].}

  proc OSRSetAE*(
    hSRS: OGRSpatialReferenceH,
    dfCenterLat: cdouble,
    dfCenterLong: cdouble,
    dfFalseEasting: cdouble,
    dfFalseNorthing: cdouble,
  ): OGRErr {.cdecl, importc: "OSRSetAE", raises: [].}

  proc OSRSetBonne*(
    hSRS: OGRSpatialReferenceH,
    dfStandardParallel: cdouble,
    dfCentralMeridian: cdouble,
    dfFalseEasting: cdouble,
    dfFalseNorthing: cdouble,
  ): OGRErr {.cdecl, importc: "OSRSetBonne", raises: [].}

  proc OSRSetCEA*(
    hSRS: OGRSpatialReferenceH,
    dfStdP1: cdouble,
    dfCentralMeridian: cdouble,
    dfFalseEasting: cdouble,
    dfFalseNorthing: cdouble,
  ): OGRErr {.cdecl, importc: "OSRSetCEA", raises: [].}

  proc OSRSetCS*(
    hSRS: OGRSpatialReferenceH,
    dfCenterLat: cdouble,
    dfCenterLong: cdouble,
    dfFalseEasting: cdouble,
    dfFalseNorthing: cdouble,
  ): OGRErr {.cdecl, importc: "OSRSetCS", raises: [].}

  proc OSRSetEC*(
    hSRS: OGRSpatialReferenceH,
    dfStdP1: cdouble,
    dfStdP2: cdouble,
    dfCenterLat: cdouble,
    dfCenterLong: cdouble,
    dfFalseEasting: cdouble,
    dfFalseNorthing: cdouble,
  ): OGRErr {.cdecl, importc: "OSRSetEC", raises: [].}

  proc OSRSetEckert*(
    hSRS: OGRSpatialReferenceH,
    nVariation: cint,
    dfCentralMeridian: cdouble,
    dfFalseEasting: cdouble,
    dfFalseNorthing: cdouble,
  ): OGRErr {.cdecl, importc: "OSRSetEckert", raises: [].}

  proc OSRSetEckertIV*(
    hSRS: OGRSpatialReferenceH,
    dfCentralMeridian: cdouble,
    dfFalseEasting: cdouble,
    dfFalseNorthing: cdouble,
  ): OGRErr {.cdecl, importc: "OSRSetEckertIV", raises: [].}

  proc OSRSetEckertVI*(
    hSRS: OGRSpatialReferenceH,
    dfCentralMeridian: cdouble,
    dfFalseEasting: cdouble,
    dfFalseNorthing: cdouble,
  ): OGRErr {.cdecl, importc: "OSRSetEckertVI", raises: [].}

  proc OSRSetEquirectangular*(
    hSRS: OGRSpatialReferenceH,
    dfCenterLat: cdouble,
    dfCenterLong: cdouble,
    dfFalseEasting: cdouble,
    dfFalseNorthing: cdouble,
  ): OGRErr {.cdecl, importc: "OSRSetEquirectangular", raises: [].}

  proc OSRSetEquirectangular2*(
    hSRS: OGRSpatialReferenceH,
    dfCenterLat: cdouble,
    dfCenterLong: cdouble,
    dfPseudoStdParallel1: cdouble,
    dfFalseEasting: cdouble,
    dfFalseNorthing: cdouble,
  ): OGRErr {.cdecl, importc: "OSRSetEquirectangular2", raises: [].}

  proc OSRSetGS*(
    hSRS: OGRSpatialReferenceH,
    dfCentralMeridian: cdouble,
    dfFalseEasting: cdouble,
    dfFalseNorthing: cdouble,
  ): OGRErr {.cdecl, importc: "OSRSetGS", raises: [].}

  proc OSRSetGH*(
    hSRS: OGRSpatialReferenceH,
    dfCentralMeridian: cdouble,
    dfFalseEasting: cdouble,
    dfFalseNorthing: cdouble,
  ): OGRErr {.cdecl, importc: "OSRSetGH", raises: [].}

  proc OSRSetIGH*(
    hSRS: OGRSpatialReferenceH
  ): OGRErr {.cdecl, importc: "OSRSetIGH", raises: [].}

  proc OSRSetGEOS*(
    hSRS: OGRSpatialReferenceH,
    dfCentralMeridian: cdouble,
    dfSatelliteHeight: cdouble,
    dfFalseEasting: cdouble,
    dfFalseNorthing: cdouble,
  ): OGRErr {.cdecl, importc: "OSRSetGEOS", raises: [].}

  proc OSRSetGaussSchreiberTMercator*(
    hSRS: OGRSpatialReferenceH,
    dfCenterLat: cdouble,
    dfCenterLong: cdouble,
    dfScale: cdouble,
    dfFalseEasting: cdouble,
    dfFalseNorthing: cdouble,
  ): OGRErr {.cdecl, importc: "OSRSetGaussSchreiberTMercator", raises: [].}

  proc OSRSetGnomonic*(
    hSRS: OGRSpatialReferenceH,
    dfCenterLat: cdouble,
    dfCenterLong: cdouble,
    dfFalseEasting: cdouble,
    dfFalseNorthing: cdouble,
  ): OGRErr {.cdecl, importc: "OSRSetGnomonic", raises: [].}

  proc OSRSetHOM*(
    hSRS: OGRSpatialReferenceH,
    dfCenterLat: cdouble,
    dfCenterLong: cdouble,
    dfAzimuth: cdouble,
    dfRectToSkew: cdouble,
    dfScale: cdouble,
    dfFalseEasting: cdouble,
    dfFalseNorthing: cdouble,
  ): OGRErr {.cdecl, importc: "OSRSetHOM", raises: [].}

  proc OSRSetHOMAC*(
    hSRS: OGRSpatialReferenceH,
    dfCenterLat: cdouble,
    dfCenterLong: cdouble,
    dfAzimuth: cdouble,
    dfRectToSkew: cdouble,
    dfScale: cdouble,
    dfFalseEasting: cdouble,
    dfFalseNorthing: cdouble,
  ): OGRErr {.cdecl, importc: "OSRSetHOMAC", raises: [].}

  proc OSRSetHOM2PNO*(
    hSRS: OGRSpatialReferenceH,
    dfCenterLat: cdouble,
    dfLat1: cdouble,
    dfLong1: cdouble,
    dfLat2: cdouble,
    dfLong2: cdouble,
    dfScale: cdouble,
    dfFalseEasting: cdouble,
    dfFalseNorthing: cdouble,
  ): OGRErr {.cdecl, importc: "OSRSetHOM2PNO", raises: [].}

  proc OSRSetIWMPolyconic*(
    hSRS: OGRSpatialReferenceH,
    dfLat1: cdouble,
    dfLat2: cdouble,
    dfCenterLong: cdouble,
    dfFalseEasting: cdouble,
    dfFalseNorthing: cdouble,
  ): OGRErr {.cdecl, importc: "OSRSetIWMPolyconic", raises: [].}

  proc OSRSetKrovak*(
    hSRS: OGRSpatialReferenceH,
    dfCenterLat: cdouble,
    dfCenterLong: cdouble,
    dfAzimuth: cdouble,
    dfPseudoStdParallelLat: cdouble,
    dfScale: cdouble,
    dfFalseEasting: cdouble,
    dfFalseNorthing: cdouble,
  ): OGRErr {.cdecl, importc: "OSRSetKrovak", raises: [].}

  proc OSRSetLAEA*(
    hSRS: OGRSpatialReferenceH,
    dfCenterLat: cdouble,
    dfCenterLong: cdouble,
    dfFalseEasting: cdouble,
    dfFalseNorthing: cdouble,
  ): OGRErr {.cdecl, importc: "OSRSetLAEA", raises: [].}

  proc OSRSetLCC*(
    hSRS: OGRSpatialReferenceH,
    dfStdP1: cdouble,
    dfStdP2: cdouble,
    dfCenterLat: cdouble,
    dfCenterLong: cdouble,
    dfFalseEasting: cdouble,
    dfFalseNorthing: cdouble,
  ): OGRErr {.cdecl, importc: "OSRSetLCC", raises: [].}

  proc OSRSetLCC1SP*(
    hSRS: OGRSpatialReferenceH,
    dfCenterLat: cdouble,
    dfCenterLong: cdouble,
    dfScale: cdouble,
    dfFalseEasting: cdouble,
    dfFalseNorthing: cdouble,
  ): OGRErr {.cdecl, importc: "OSRSetLCC1SP", raises: [].}

  proc OSRSetLCCB*(
    hSRS: OGRSpatialReferenceH,
    dfStdP1: cdouble,
    dfStdP2: cdouble,
    dfCenterLat: cdouble,
    dfCenterLong: cdouble,
    dfFalseEasting: cdouble,
    dfFalseNorthing: cdouble,
  ): OGRErr {.cdecl, importc: "OSRSetLCCB", raises: [].}

  proc OSRSetMC*(
    hSRS: OGRSpatialReferenceH,
    dfCenterLat: cdouble,
    dfCenterLong: cdouble,
    dfFalseEasting: cdouble,
    dfFalseNorthing: cdouble,
  ): OGRErr {.cdecl, importc: "OSRSetMC", raises: [].}

  proc OSRSetMercator*(
    hSRS: OGRSpatialReferenceH,
    dfCenterLat: cdouble,
    dfCenterLong: cdouble,
    dfScale: cdouble,
    dfFalseEasting: cdouble,
    dfFalseNorthing: cdouble,
  ): OGRErr {.cdecl, importc: "OSRSetMercator", raises: [].}

  proc OSRSetMercator2SP*(
    hSRS: OGRSpatialReferenceH,
    dfStdP1: cdouble,
    dfCenterLat: cdouble,
    dfCenterLong: cdouble,
    dfFalseEasting: cdouble,
    dfFalseNorthing: cdouble,
  ): OGRErr {.cdecl, importc: "OSRSetMercator2SP", raises: [].}

  proc OSRSetMollweide*(
    hSRS: OGRSpatialReferenceH,
    dfCentralMeridian: cdouble,
    dfFalseEasting: cdouble,
    dfFalseNorthing: cdouble,
  ): OGRErr {.cdecl, importc: "OSRSetMollweide", raises: [].}

  proc OSRSetNZMG*(
    hSRS: OGRSpatialReferenceH,
    dfCenterLat: cdouble,
    dfCenterLong: cdouble,
    dfFalseEasting: cdouble,
    dfFalseNorthing: cdouble,
  ): OGRErr {.cdecl, importc: "OSRSetNZMG", raises: [].}

  proc OSRSetOS*(
    hSRS: OGRSpatialReferenceH,
    dfOriginLat: cdouble,
    dfCMeridian: cdouble,
    dfScale: cdouble,
    dfFalseEasting: cdouble,
    dfFalseNorthing: cdouble,
  ): OGRErr {.cdecl, importc: "OSRSetOS", raises: [].}

  proc OSRSetOrthographic*(
    hSRS: OGRSpatialReferenceH,
    dfCenterLat: cdouble,
    dfCenterLong: cdouble,
    dfFalseEasting: cdouble,
    dfFalseNorthing: cdouble,
  ): OGRErr {.cdecl, importc: "OSRSetOrthographic", raises: [].}

  proc OSRSetPolyconic*(
    hSRS: OGRSpatialReferenceH,
    dfCenterLat: cdouble,
    dfCenterLong: cdouble,
    dfFalseEasting: cdouble,
    dfFalseNorthing: cdouble,
  ): OGRErr {.cdecl, importc: "OSRSetPolyconic", raises: [].}

  proc OSRSetPS*(
    hSRS: OGRSpatialReferenceH,
    dfCenterLat: cdouble,
    dfCenterLong: cdouble,
    dfScale: cdouble,
    dfFalseEasting: cdouble,
    dfFalseNorthing: cdouble,
  ): OGRErr {.cdecl, importc: "OSRSetPS", raises: [].}

  proc OSRSetRobinson*(
    hSRS: OGRSpatialReferenceH,
    dfCenterLong: cdouble,
    dfFalseEasting: cdouble,
    dfFalseNorthing: cdouble,
  ): OGRErr {.cdecl, importc: "OSRSetRobinson", raises: [].}

  proc OSRSetSinusoidal*(
    hSRS: OGRSpatialReferenceH,
    dfCenterLong: cdouble,
    dfFalseEasting: cdouble,
    dfFalseNorthing: cdouble,
  ): OGRErr {.cdecl, importc: "OSRSetSinusoidal", raises: [].}

  proc OSRSetStereographic*(
    hSRS: OGRSpatialReferenceH,
    dfCenterLat: cdouble,
    dfCenterLong: cdouble,
    dfScale: cdouble,
    dfFalseEasting: cdouble,
    dfFalseNorthing: cdouble,
  ): OGRErr {.cdecl, importc: "OSRSetStereographic", raises: [].}

  proc OSRSetSOC*(
    hSRS: OGRSpatialReferenceH,
    dfLatitudeOfOrigin: cdouble,
    dfCentralMeridian: cdouble,
    dfFalseEasting: cdouble,
    dfFalseNorthing: cdouble,
  ): OGRErr {.cdecl, importc: "OSRSetSOC", raises: [].}

  proc OSRSetTM*(
    hSRS: OGRSpatialReferenceH,
    dfCenterLat: cdouble,
    dfCenterLong: cdouble,
    dfScale: cdouble,
    dfFalseEasting: cdouble,
    dfFalseNorthing: cdouble,
  ): OGRErr {.cdecl, importc: "OSRSetTM", raises: [].}

  proc OSRSetTMVariant*(
    hSRS: OGRSpatialReferenceH,
    pszVariantName: cstring,
    dfCenterLat: cdouble,
    dfCenterLong: cdouble,
    dfScale: cdouble,
    dfFalseEasting: cdouble,
    dfFalseNorthing: cdouble,
  ): OGRErr {.cdecl, importc: "OSRSetTMVariant", raises: [].}

  proc OSRSetTMG*(
    hSRS: OGRSpatialReferenceH,
    dfCenterLat: cdouble,
    dfCenterLong: cdouble,
    dfFalseEasting: cdouble,
    dfFalseNorthing: cdouble,
  ): OGRErr {.cdecl, importc: "OSRSetTMG", raises: [].}

  proc OSRSetTMSO*(
    hSRS: OGRSpatialReferenceH,
    dfCenterLat: cdouble,
    dfCenterLong: cdouble,
    dfScale: cdouble,
    dfFalseEasting: cdouble,
    dfFalseNorthing: cdouble,
  ): OGRErr {.cdecl, importc: "OSRSetTMSO", raises: [].}

  proc OSRSetTPED*(
    hSRS: OGRSpatialReferenceH,
    dfLat1: cdouble,
    dfLong1: cdouble,
    dfLat2: cdouble,
    dfLong2: cdouble,
    dfFalseEasting: cdouble,
    dfFalseNorthing: cdouble,
  ): OGRErr {.cdecl, importc: "OSRSetTPED", raises: [].}

  proc OSRSetVDG*(
    hSRS: OGRSpatialReferenceH,
    dfCenterLong: cdouble,
    dfFalseEasting: cdouble,
    dfFalseNorthing: cdouble,
  ): OGRErr {.cdecl, importc: "OSRSetVDG", raises: [].}

  proc OSRSetWagner*(
    hSRS: OGRSpatialReferenceH,
    nVariation: cint,
    dfCenterLat: cdouble,
    dfFalseEasting: cdouble,
    dfFalseNorthing: cdouble,
  ): OGRErr {.cdecl, importc: "OSRSetWagner", raises: [].}

  proc OSRSetQSC*(
    hSRS: OGRSpatialReferenceH, dfCenterLat: cdouble, dfCenterLong: cdouble
  ): OGRErr {.cdecl, importc: "OSRSetQSC", raises: [].}

  proc OSRSetSCH*(
    hSRS: OGRSpatialReferenceH,
    dfPegLat: cdouble,
    dfPegLong: cdouble,
    dfPegHeading: cdouble,
    dfPegHgt: cdouble,
  ): OGRErr {.cdecl, importc: "OSRSetSCH", raises: [].}

  proc OSRSetVerticalPerspective*(
    hSRS: OGRSpatialReferenceH,
    dfTopoOriginLat: cdouble,
    dfTopoOriginLon: cdouble,
    dfTopoOriginHeight: cdouble,
    dfViewPointHeight: cdouble,
    dfFalseEasting: cdouble,
    dfFalseNorthing: cdouble,
  ): OGRErr {.cdecl, importc: "OSRSetVerticalPerspective", raises: [].}

  proc OSRCalcInvFlattening*(
    dfSemiMajor: cdouble, dfSemiMinor: cdouble
  ): cdouble {.cdecl, importc: "OSRCalcInvFlattening", raises: [].}

  proc OSRCalcSemiMinorFromInvFlattening*(
    dfSemiMajor: cdouble, dfInvFlattening: cdouble
  ): cdouble {.cdecl, importc: "OSRCalcSemiMinorFromInvFlattening", raises: [].}

  proc OSRCleanup*() {.cdecl, importc: "OSRCleanup", raises: [].}
  proc OSRGetCRSInfoListFromDatabase*(
    pszAuthName: cstring, params: ptr OSRCRSListParameters, pnOutResultCount: ptr cint
  ): ptr ptr OSRCRSInfo {.cdecl, importc: "OSRGetCRSInfoListFromDatabase", raises: [].}

  proc OSRDestroyCRSInfoList*(
    list: ptr ptr OSRCRSInfo
  ) {.cdecl, importc: "OSRDestroyCRSInfoList", raises: [].}

  proc OSRGetAuthorityListFromDatabase*(): cstringArray {.
    cdecl, importc: "OSRGetAuthorityListFromDatabase", raises: []
  .}

  proc OCTNewCoordinateTransformation*(
    hSourceSRS: OGRSpatialReferenceH, hTargetSRS: OGRSpatialReferenceH
  ): OGRCoordinateTransformationH {.
    gdalCall, importc: "OCTNewCoordinateTransformation", raises: []
  .}

  proc OCTNewCoordinateTransformationOptions*(): OGRCoordinateTransformationOptionsH {.
    cdecl, importc: "OCTNewCoordinateTransformationOptions", raises: []
  .}

  proc OCTCoordinateTransformationOptionsSetOperation*(
    hOptions: OGRCoordinateTransformationOptionsH, pszCO: cstring, bReverseCO: cint
  ): cint {.
    cdecl, importc: "OCTCoordinateTransformationOptionsSetOperation", raises: []
  .}

  proc OCTCoordinateTransformationOptionsSetAreaOfInterest*(
    hOptions: OGRCoordinateTransformationOptionsH,
    dfWestLongitudeDeg: cdouble,
    dfSouthLatitudeDeg: cdouble,
    dfEastLongitudeDeg: cdouble,
    dfNorthLatitudeDeg: cdouble,
  ): cint {.
    cdecl, importc: "OCTCoordinateTransformationOptionsSetAreaOfInterest", raises: []
  .}

  proc OCTCoordinateTransformationOptionsSetDesiredAccuracy*(
    hOptions: OGRCoordinateTransformationOptionsH, dfAccuracy: cdouble
  ): cint {.
    cdecl, importc: "OCTCoordinateTransformationOptionsSetDesiredAccuracy", raises: []
  .}

  proc OCTCoordinateTransformationOptionsSetBallparkAllowed*(
    hOptions: OGRCoordinateTransformationOptionsH, bAllowBallpark: cint
  ): cint {.
    cdecl, importc: "OCTCoordinateTransformationOptionsSetBallparkAllowed", raises: []
  .}

  proc OCTCoordinateTransformationOptionsSetOnlyBest*(
    hOptions: OGRCoordinateTransformationOptionsH, bOnlyBest: bool
  ): cint {.
    cdecl, importc: "OCTCoordinateTransformationOptionsSetOnlyBest", raises: []
  .}

  proc OCTDestroyCoordinateTransformationOptions*(
    a0: OGRCoordinateTransformationOptionsH
  ) {.cdecl, importc: "OCTDestroyCoordinateTransformationOptions", raises: [].}

  proc OCTNewCoordinateTransformationEx*(
    hSourceSRS: OGRSpatialReferenceH,
    hTargetSRS: OGRSpatialReferenceH,
    hOptions: OGRCoordinateTransformationOptionsH,
  ): OGRCoordinateTransformationH {.
    cdecl, importc: "OCTNewCoordinateTransformationEx", raises: []
  .}

  proc OCTClone*(
    hTransform: OGRCoordinateTransformationH
  ): OGRCoordinateTransformationH {.cdecl, importc: "OCTClone", raises: [].}

  proc OCTGetSourceCS*(
    hTransform: OGRCoordinateTransformationH
  ): OGRSpatialReferenceH {.cdecl, importc: "OCTGetSourceCS", raises: [].}

  proc OCTGetTargetCS*(
    hTransform: OGRCoordinateTransformationH
  ): OGRSpatialReferenceH {.cdecl, importc: "OCTGetTargetCS", raises: [].}

  proc OCTGetInverse*(
    hTransform: OGRCoordinateTransformationH
  ): OGRCoordinateTransformationH {.cdecl, importc: "OCTGetInverse", raises: [].}

  proc OCTDestroyCoordinateTransformation*(
    a0: OGRCoordinateTransformationH
  ) {.gdalCall, importc: "OCTDestroyCoordinateTransformation", raises: [].}

  proc OCTTransform*(
    hCT: OGRCoordinateTransformationH,
    nCount: cint,
    x: ptr cdouble,
    y: ptr cdouble,
    z: ptr cdouble,
  ): cint {.gdalCall, importc: "OCTTransform", raises: [].}

  proc OCTTransformEx*(
    hCT: OGRCoordinateTransformationH,
    nCount: cint,
    x: ptr cdouble,
    y: ptr cdouble,
    z: ptr cdouble,
    pabSuccess: ptr cint,
  ): cint {.gdalCall, importc: "OCTTransformEx", raises: [].}

  proc OCTTransform4D*(
    hCT: OGRCoordinateTransformationH,
    nCount: cint,
    x: ptr cdouble,
    y: ptr cdouble,
    z: ptr cdouble,
    t: ptr cdouble,
    pabSuccess: ptr cint,
  ): cint {.cdecl, importc: "OCTTransform4D", raises: [].}

  proc OCTTransform4DWithErrorCodes*(
    hCT: OGRCoordinateTransformationH,
    nCount: cint,
    x: ptr cdouble,
    y: ptr cdouble,
    z: ptr cdouble,
    t: ptr cdouble,
    panErrorCodes: ptr cint,
  ): cint {.cdecl, importc: "OCTTransform4DWithErrorCodes", raises: [].}

  proc OCTTransformBounds*(
    hCT: OGRCoordinateTransformationH,
    xmin: cdouble,
    ymin: cdouble,
    xmax: cdouble,
    ymax: cdouble,
    out_xmin: ptr cdouble,
    out_ymin: ptr cdouble,
    out_xmax: ptr cdouble,
    out_ymax: ptr cdouble,
    densify_pts: cint,
  ): cint {.gdalCall, importc: "OCTTransformBounds", raises: [].}

when not gdalRuntimeEnabled:
  try:
    loadGdal()
  except GdalLoadError:
    discard
