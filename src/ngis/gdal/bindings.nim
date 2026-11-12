## Generated from GDAL 3.13.3 public C headers. Do not edit.
## Regenerate with scripts/generate_bindings.py; see bindings.json for coverage.
import ./[library, systemtypes]
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

proc CPLAtomicAdd*(
  `ptr`: ptr cint, increment: cint
): cint {.cdecl, importc: "CPLAtomicAdd", dynlib: gdalLib, raises: [].}

proc CPLAtomicCompareAndExchange*(
  `ptr`: ptr cint, oldval: cint, newval: cint
): cint {.cdecl, importc: "CPLAtomicCompareAndExchange", dynlib: gdalLib, raises: [].}

proc CPLRegisterCompressor*(
  compressor: ptr CPLCompressor
): bool {.cdecl, importc: "CPLRegisterCompressor", dynlib: gdalLib, raises: [].}

proc CPLRegisterDecompressor*(
  decompressor: ptr CPLCompressor
): bool {.cdecl, importc: "CPLRegisterDecompressor", dynlib: gdalLib, raises: [].}

proc CPLGetCompressors*(): cstringArray {.
  cdecl, importc: "CPLGetCompressors", dynlib: gdalLib, raises: []
.}

proc CPLGetDecompressors*(): cstringArray {.
  cdecl, importc: "CPLGetDecompressors", dynlib: gdalLib, raises: []
.}

proc CPLGetCompressor*(
  pszId: cstring
): ptr CPLCompressor {.cdecl, importc: "CPLGetCompressor", dynlib: gdalLib, raises: [].}

proc CPLGetDecompressor*(
  pszId: cstring
): ptr CPLCompressor {.
  cdecl, importc: "CPLGetDecompressor", dynlib: gdalLib, raises: []
.}

proc CPLDestroyCompressorRegistry*() {.
  cdecl, importc: "CPLDestroyCompressorRegistry", dynlib: gdalLib, raises: []
.}

proc GDALDummyProgress*(
  a0: cdouble, a1: cstring, a2: pointer
): cint {.gdalCall, importc: "GDALDummyProgress", dynlib: gdalLib, raises: [].}

proc GDALTermProgress*(
  a0: cdouble, a1: cstring, a2: pointer
): cint {.gdalCall, importc: "GDALTermProgress", dynlib: gdalLib, raises: [].}

proc GDALScaledProgress*(
  a0: cdouble, a1: cstring, a2: pointer
): cint {.gdalCall, importc: "GDALScaledProgress", dynlib: gdalLib, raises: [].}

proc GDALCreateScaledProgress*(
  a0: cdouble, a1: cdouble, a2: GDALProgressFunc, a3: pointer
): pointer {.
  gdalCall, importc: "GDALCreateScaledProgress", dynlib: gdalLib, raises: []
.}

proc GDALDestroyScaledProgress*(
  a0: pointer
) {.gdalCall, importc: "GDALDestroyScaledProgress", dynlib: gdalLib, raises: [].}

proc VSIFOpen*(
  a0: cstring, a1: cstring
): ptr GdalFile {.cdecl, importc: "VSIFOpen", dynlib: gdalLib, raises: [].}

proc VSIFClose*(
  a0: ptr GdalFile
): cint {.cdecl, importc: "VSIFClose", dynlib: gdalLib, raises: [].}

proc VSIFSeek*(
  a0: ptr GdalFile, a1: clong, a2: cint
): cint {.cdecl, importc: "VSIFSeek", dynlib: gdalLib, raises: [].}

proc VSIFTell*(
  a0: ptr GdalFile
): clong {.cdecl, importc: "VSIFTell", dynlib: gdalLib, raises: [].}

proc VSIRewind*(
  a0: ptr GdalFile
) {.cdecl, importc: "VSIRewind", dynlib: gdalLib, raises: [].}

proc VSIFFlush*(
  a0: ptr GdalFile
) {.cdecl, importc: "VSIFFlush", dynlib: gdalLib, raises: [].}

proc VSIFRead*(
  a0: pointer, a1: csize_t, a2: csize_t, a3: ptr GdalFile
): csize_t {.cdecl, importc: "VSIFRead", dynlib: gdalLib, raises: [].}

proc VSIFWrite*(
  a0: pointer, a1: csize_t, a2: csize_t, a3: ptr GdalFile
): csize_t {.cdecl, importc: "VSIFWrite", dynlib: gdalLib, raises: [].}

proc VSIFGets*(
  a0: cstring, a1: cint, a2: ptr GdalFile
): cstring {.cdecl, importc: "VSIFGets", dynlib: gdalLib, raises: [].}

proc VSIFPuts*(
  a0: cstring, a1: ptr GdalFile
): cint {.cdecl, importc: "VSIFPuts", dynlib: gdalLib, raises: [].}

proc VSIFPrintf*(
  a0: ptr GdalFile, a1: cstring
): cint {.cdecl, importc: "VSIFPrintf", dynlib: gdalLib, raises: [], varargs.}

proc VSIFGetc*(
  a0: ptr GdalFile
): cint {.cdecl, importc: "VSIFGetc", dynlib: gdalLib, raises: [].}

proc VSIFPutc*(
  a0: cint, a1: ptr GdalFile
): cint {.cdecl, importc: "VSIFPutc", dynlib: gdalLib, raises: [].}

proc VSIUngetc*(
  a0: cint, a1: ptr GdalFile
): cint {.cdecl, importc: "VSIUngetc", dynlib: gdalLib, raises: [].}

proc VSIFEof*(
  a0: ptr GdalFile
): cint {.cdecl, importc: "VSIFEof", dynlib: gdalLib, raises: [].}

proc VSIStat*(
  a0: cstring, a1: ptr VSIStatBuf
): cint {.cdecl, importc: "VSIStat", dynlib: gdalLib, raises: [].}

proc VSIFOpenL*(
  a0: cstring, a1: cstring
): ptr VSILFILE {.cdecl, importc: "VSIFOpenL", dynlib: gdalLib, raises: [].}

proc VSIFOpenExL*(
  a0: cstring, a1: cstring, a2: cint
): ptr VSILFILE {.cdecl, importc: "VSIFOpenExL", dynlib: gdalLib, raises: [].}

proc VSIFOpenEx2L*(
  a0: cstring, a1: cstring, a2: cint, a3: CSLConstList
): ptr VSILFILE {.cdecl, importc: "VSIFOpenEx2L", dynlib: gdalLib, raises: [].}

proc VSIFCloseL*(
  a0: ptr VSILFILE
): cint {.cdecl, importc: "VSIFCloseL", dynlib: gdalLib, raises: [].}

proc VSIFSeekL*(
  a0: ptr VSILFILE, a1: vsi_l_offset, a2: cint
): cint {.cdecl, importc: "VSIFSeekL", dynlib: gdalLib, raises: [].}

proc VSIFTellL*(
  a0: ptr VSILFILE
): vsi_l_offset {.cdecl, importc: "VSIFTellL", dynlib: gdalLib, raises: [].}

proc VSIRewindL*(
  a0: ptr VSILFILE
) {.cdecl, importc: "VSIRewindL", dynlib: gdalLib, raises: [].}

proc VSIFReadL*(
  a0: pointer, a1: csize_t, a2: csize_t, a3: ptr VSILFILE
): csize_t {.cdecl, importc: "VSIFReadL", dynlib: gdalLib, raises: [].}

proc VSIFReadMultiRangeL*(
  nRanges: cint,
  ppData: ptr pointer,
  panOffsets: ptr vsi_l_offset,
  panSizes: ptr csize_t,
  a4: ptr VSILFILE,
): cint {.cdecl, importc: "VSIFReadMultiRangeL", dynlib: gdalLib, raises: [].}

proc VSIFWriteL*(
  a0: pointer, a1: csize_t, a2: csize_t, a3: ptr VSILFILE
): csize_t {.cdecl, importc: "VSIFWriteL", dynlib: gdalLib, raises: [].}

proc VSIFClearErrL*(
  a0: ptr VSILFILE
) {.cdecl, importc: "VSIFClearErrL", dynlib: gdalLib, raises: [].}

proc VSIFErrorL*(
  a0: ptr VSILFILE
): cint {.cdecl, importc: "VSIFErrorL", dynlib: gdalLib, raises: [].}

proc VSIFEofL*(
  a0: ptr VSILFILE
): cint {.cdecl, importc: "VSIFEofL", dynlib: gdalLib, raises: [].}

proc VSIFTruncateL*(
  a0: ptr VSILFILE, a1: vsi_l_offset
): cint {.cdecl, importc: "VSIFTruncateL", dynlib: gdalLib, raises: [].}

proc VSIFFlushL*(
  a0: ptr VSILFILE
): cint {.cdecl, importc: "VSIFFlushL", dynlib: gdalLib, raises: [].}

proc VSIFPrintfL*(
  a0: ptr VSILFILE, a1: cstring
): cint {.cdecl, importc: "VSIFPrintfL", dynlib: gdalLib, raises: [], varargs.}

proc VSIFPutcL*(
  a0: cint, a1: ptr VSILFILE
): cint {.cdecl, importc: "VSIFPutcL", dynlib: gdalLib, raises: [].}

proc VSIFGetRangeStatusL*(
  fp: ptr VSILFILE, nStart: vsi_l_offset, nLength: vsi_l_offset
): VSIRangeStatus {.cdecl, importc: "VSIFGetRangeStatusL", dynlib: gdalLib, raises: [].}

proc VSIIngestFile*(
  fp: ptr VSILFILE,
  pszFilename: cstring,
  ppabyRet: ptr ptr GByte,
  pnSize: ptr vsi_l_offset,
  nMaxSize: GIntBig,
): cint {.cdecl, importc: "VSIIngestFile", dynlib: gdalLib, raises: [].}

proc VSIOverwriteFile*(
  fpTarget: ptr VSILFILE, pszSourceFilename: cstring
): cint {.cdecl, importc: "VSIOverwriteFile", dynlib: gdalLib, raises: [].}

proc VSIStatL*(
  a0: cstring, a1: ptr VSIStatBufL
): cint {.cdecl, importc: "VSIStatL", dynlib: gdalLib, raises: [].}

proc VSIStatExL*(
  pszFilename: cstring, psStatBuf: ptr VSIStatBufL, nFlags: cint
): cint {.cdecl, importc: "VSIStatExL", dynlib: gdalLib, raises: [].}

proc VSIIsCaseSensitiveFS*(
  pszFilename: cstring
): cint {.cdecl, importc: "VSIIsCaseSensitiveFS", dynlib: gdalLib, raises: [].}

proc VSISupportsSparseFiles*(
  pszPath: cstring
): cint {.cdecl, importc: "VSISupportsSparseFiles", dynlib: gdalLib, raises: [].}

proc VSIIsLocal*(
  pszPath: cstring
): bool {.cdecl, importc: "VSIIsLocal", dynlib: gdalLib, raises: [].}

proc VSIGetCanonicalFilename*(
  pszPath: cstring
): cstring {.cdecl, importc: "VSIGetCanonicalFilename", dynlib: gdalLib, raises: [].}

proc VSISupportsSequentialWrite*(
  pszPath: cstring, bAllowLocalTempFile: bool
): bool {.cdecl, importc: "VSISupportsSequentialWrite", dynlib: gdalLib, raises: [].}

proc VSISupportsRandomWrite*(
  pszPath: cstring, bAllowLocalTempFile: bool
): bool {.cdecl, importc: "VSISupportsRandomWrite", dynlib: gdalLib, raises: [].}

proc VSIHasOptimizedReadMultiRange*(
  pszPath: cstring
): cint {.cdecl, importc: "VSIHasOptimizedReadMultiRange", dynlib: gdalLib, raises: [].}

proc VSIGetActualURL*(
  pszFilename: cstring
): cstring {.cdecl, importc: "VSIGetActualURL", dynlib: gdalLib, raises: [].}

proc VSIGetSignedURL*(
  pszFilename: cstring, papszOptions: CSLConstList
): cstring {.cdecl, importc: "VSIGetSignedURL", dynlib: gdalLib, raises: [].}

proc VSIGetFileSystemOptions*(
  pszFilename: cstring
): cstring {.cdecl, importc: "VSIGetFileSystemOptions", dynlib: gdalLib, raises: [].}

proc VSIGetFileSystemsPrefixes*(): cstringArray {.
  cdecl, importc: "VSIGetFileSystemsPrefixes", dynlib: gdalLib, raises: []
.}

proc VSIFGetNativeFileDescriptorL*(
  a0: ptr VSILFILE
): pointer {.
  cdecl, importc: "VSIFGetNativeFileDescriptorL", dynlib: gdalLib, raises: []
.}

proc VSIGetFileMetadata*(
  pszFilename: cstring, pszDomain: cstring, papszOptions: CSLConstList
): cstringArray {.cdecl, importc: "VSIGetFileMetadata", dynlib: gdalLib, raises: [].}

proc VSISetFileMetadata*(
  pszFilename: cstring,
  papszMetadata: CSLConstList,
  pszDomain: cstring,
  papszOptions: CSLConstList,
): cint {.cdecl, importc: "VSISetFileMetadata", dynlib: gdalLib, raises: [].}

proc VSISetPathSpecificOption*(
  pszPathPrefix: cstring, pszKey: cstring, pszValue: cstring
) {.cdecl, importc: "VSISetPathSpecificOption", dynlib: gdalLib, raises: [].}

proc VSIClearPathSpecificOptions*(
  pszPathPrefix: cstring
) {.cdecl, importc: "VSIClearPathSpecificOptions", dynlib: gdalLib, raises: [].}

proc VSIGetPathSpecificOption*(
  pszPath: cstring, pszKey: cstring, pszDefault: cstring
): cstring {.cdecl, importc: "VSIGetPathSpecificOption", dynlib: gdalLib, raises: [].}

proc VSISetCredential*(
  pszPathPrefix: cstring, pszKey: cstring, pszValue: cstring
) {.cdecl, importc: "VSISetCredential", dynlib: gdalLib, raises: [].}

proc VSIClearCredentials*(
  pszPathPrefix: cstring
) {.cdecl, importc: "VSIClearCredentials", dynlib: gdalLib, raises: [].}

proc VSIGetCredential*(
  pszPath: cstring, pszKey: cstring, pszDefault: cstring
): cstring {.cdecl, importc: "VSIGetCredential", dynlib: gdalLib, raises: [].}

proc VSICalloc*(
  a0: csize_t, a1: csize_t
): pointer {.cdecl, importc: "VSICalloc", dynlib: gdalLib, raises: [].}

proc VSIMalloc*(
  a0: csize_t
): pointer {.cdecl, importc: "VSIMalloc", dynlib: gdalLib, raises: [].}

proc VSIFree*(a0: pointer) {.cdecl, importc: "VSIFree", dynlib: gdalLib, raises: [].}
proc VSIRealloc*(
  a0: pointer, a1: csize_t
): pointer {.cdecl, importc: "VSIRealloc", dynlib: gdalLib, raises: [].}

proc VSIStrdup*(
  a0: cstring
): cstring {.cdecl, importc: "VSIStrdup", dynlib: gdalLib, raises: [].}

proc VSIMallocAligned*(
  nAlignment: csize_t, nSize: csize_t
): pointer {.cdecl, importc: "VSIMallocAligned", dynlib: gdalLib, raises: [].}

proc VSIMallocAlignedAuto*(
  nSize: csize_t
): pointer {.cdecl, importc: "VSIMallocAlignedAuto", dynlib: gdalLib, raises: [].}

proc VSIFreeAligned*(
  `ptr`: pointer
) {.cdecl, importc: "VSIFreeAligned", dynlib: gdalLib, raises: [].}

proc VSIMallocAlignedAutoVerbose*(
  nSize: csize_t, pszFile: cstring, nLine: cint
): pointer {.
  cdecl, importc: "VSIMallocAlignedAutoVerbose", dynlib: gdalLib, raises: []
.}

proc VSIMalloc2*(
  nSize1: csize_t, nSize2: csize_t
): pointer {.cdecl, importc: "VSIMalloc2", dynlib: gdalLib, raises: [].}

proc VSIMalloc3*(
  nSize1: csize_t, nSize2: csize_t, nSize3: csize_t
): pointer {.cdecl, importc: "VSIMalloc3", dynlib: gdalLib, raises: [].}

proc VSIMallocVerbose*(
  nSize: csize_t, pszFile: cstring, nLine: cint
): pointer {.cdecl, importc: "VSIMallocVerbose", dynlib: gdalLib, raises: [].}

proc VSIMalloc2Verbose*(
  nSize1: csize_t, nSize2: csize_t, pszFile: cstring, nLine: cint
): pointer {.cdecl, importc: "VSIMalloc2Verbose", dynlib: gdalLib, raises: [].}

proc VSIMalloc3Verbose*(
  nSize1: csize_t, nSize2: csize_t, nSize3: csize_t, pszFile: cstring, nLine: cint
): pointer {.cdecl, importc: "VSIMalloc3Verbose", dynlib: gdalLib, raises: [].}

proc VSICallocVerbose*(
  nCount: csize_t, nSize: csize_t, pszFile: cstring, nLine: cint
): pointer {.cdecl, importc: "VSICallocVerbose", dynlib: gdalLib, raises: [].}

proc VSIReallocVerbose*(
  pOldPtr: pointer, nNewSize: csize_t, pszFile: cstring, nLine: cint
): pointer {.cdecl, importc: "VSIReallocVerbose", dynlib: gdalLib, raises: [].}

proc VSIStrdupVerbose*(
  pszStr: cstring, pszFile: cstring, nLine: cint
): cstring {.cdecl, importc: "VSIStrdupVerbose", dynlib: gdalLib, raises: [].}

proc CPLGetPhysicalRAM*(): GIntBig {.
  cdecl, importc: "CPLGetPhysicalRAM", dynlib: gdalLib, raises: []
.}

proc CPLGetUsablePhysicalRAM*(): GIntBig {.
  cdecl, importc: "CPLGetUsablePhysicalRAM", dynlib: gdalLib, raises: []
.}

proc VSIReadDir*(
  a0: cstring
): cstringArray {.cdecl, importc: "VSIReadDir", dynlib: gdalLib, raises: [].}

proc VSIReadDirRecursive*(
  pszPath: cstring
): cstringArray {.cdecl, importc: "VSIReadDirRecursive", dynlib: gdalLib, raises: [].}

proc VSIReadDirEx*(
  pszPath: cstring, nMaxFiles: cint
): cstringArray {.cdecl, importc: "VSIReadDirEx", dynlib: gdalLib, raises: [].}

proc VSISiblingFiles*(
  pszPath: cstring
): cstringArray {.cdecl, importc: "VSISiblingFiles", dynlib: gdalLib, raises: [].}

proc VSIGlob*(
  pszPattern: cstring,
  papszOptions: cstringArray,
  pProgressFunc: GDALProgressFunc,
  pProgressData: pointer,
): cstringArray {.cdecl, importc: "VSIGlob", dynlib: gdalLib, raises: [].}

proc VSIGetDirectorySeparator*(
  pszPath: cstring
): cstring {.cdecl, importc: "VSIGetDirectorySeparator", dynlib: gdalLib, raises: [].}

proc VSIOpenDir*(
  pszPath: cstring, nRecurseDepth: cint, papszOptions: cstringArray
): ptr VSIDIR {.cdecl, importc: "VSIOpenDir", dynlib: gdalLib, raises: [].}

proc VSIGetNextDirEntry*(
  dir: ptr VSIDIR
): ptr VSIDIREntry {.cdecl, importc: "VSIGetNextDirEntry", dynlib: gdalLib, raises: [].}

proc VSICloseDir*(
  dir: ptr VSIDIR
) {.cdecl, importc: "VSICloseDir", dynlib: gdalLib, raises: [].}

proc VSIMkdir*(
  pszPathname: cstring, mode: clong
): cint {.cdecl, importc: "VSIMkdir", dynlib: gdalLib, raises: [].}

proc VSIMkdirRecursive*(
  pszPathname: cstring, mode: clong
): cint {.cdecl, importc: "VSIMkdirRecursive", dynlib: gdalLib, raises: [].}

proc VSIRmdir*(
  pszDirname: cstring
): cint {.cdecl, importc: "VSIRmdir", dynlib: gdalLib, raises: [].}

proc VSIRmdirRecursive*(
  pszDirname: cstring
): cint {.cdecl, importc: "VSIRmdirRecursive", dynlib: gdalLib, raises: [].}

proc VSIUnlink*(
  pszFilename: cstring
): cint {.cdecl, importc: "VSIUnlink", dynlib: gdalLib, raises: [].}

proc VSIUnlinkBatch*(
  papszFiles: CSLConstList
): ptr cint {.cdecl, importc: "VSIUnlinkBatch", dynlib: gdalLib, raises: [].}

proc VSIRename*(
  oldpath: cstring, newpath: cstring
): cint {.cdecl, importc: "VSIRename", dynlib: gdalLib, raises: [].}

proc VSIMove*(
  oldpath: cstring,
  newpath: cstring,
  papszOptions: cstringArray,
  pProgressFunc: GDALProgressFunc,
  pProgressData: pointer,
): cint {.cdecl, importc: "VSIMove", dynlib: gdalLib, raises: [].}

proc VSICopyFile*(
  pszSource: cstring,
  pszTarget: cstring,
  fpSource: ptr VSILFILE,
  nSourceSize: vsi_l_offset,
  papszOptions: cstringArray,
  pProgressFunc: GDALProgressFunc,
  pProgressData: pointer,
): cint {.cdecl, importc: "VSICopyFile", dynlib: gdalLib, raises: [].}

proc VSICopyFileRestartable*(
  pszSource: cstring,
  pszTarget: cstring,
  pszInputPayload: cstring,
  ppszOutputPayload: cstringArray,
  papszOptions: cstringArray,
  pProgressFunc: GDALProgressFunc,
  pProgressData: pointer,
): cint {.cdecl, importc: "VSICopyFileRestartable", dynlib: gdalLib, raises: [].}

proc VSISync*(
  pszSource: cstring,
  pszTarget: cstring,
  papszOptions: cstringArray,
  pProgressFunc: GDALProgressFunc,
  pProgressData: pointer,
  ppapszOutputs: ptr cstringArray,
): cint {.cdecl, importc: "VSISync", dynlib: gdalLib, raises: [].}

proc VSIMultipartUploadGetCapabilities*(
  pszFilename: cstring,
  pbNonSequentialUploadSupported: ptr cint,
  pbParallelUploadSupported: ptr cint,
  pbAbortSupported: ptr cint,
  pnMinPartSize: ptr csize_t,
  pnMaxPartSize: ptr csize_t,
  pnMaxPartCount: ptr cint,
): cint {.
  cdecl, importc: "VSIMultipartUploadGetCapabilities", dynlib: gdalLib, raises: []
.}

proc VSIMultipartUploadStart*(
  pszFilename: cstring, papszOptions: CSLConstList
): cstring {.cdecl, importc: "VSIMultipartUploadStart", dynlib: gdalLib, raises: [].}

proc VSIMultipartUploadAddPart*(
  pszFilename: cstring,
  pszUploadId: cstring,
  nPartNumber: cint,
  nFileOffset: vsi_l_offset,
  pData: pointer,
  nDataLength: csize_t,
  papszOptions: CSLConstList,
): cstring {.cdecl, importc: "VSIMultipartUploadAddPart", dynlib: gdalLib, raises: [].}

proc VSIMultipartUploadEnd*(
  pszFilename: cstring,
  pszUploadId: cstring,
  nPartIdsCount: csize_t,
  apszPartIds: cstringArray,
  nTotalSize: vsi_l_offset,
  papszOptions: CSLConstList,
): cint {.cdecl, importc: "VSIMultipartUploadEnd", dynlib: gdalLib, raises: [].}

proc VSIMultipartUploadAbort*(
  pszFilename: cstring, pszUploadId: cstring, papszOptions: CSLConstList
): cint {.cdecl, importc: "VSIMultipartUploadAbort", dynlib: gdalLib, raises: [].}

proc VSIAbortPendingUploads*(
  pszFilename: cstring
): cint {.cdecl, importc: "VSIAbortPendingUploads", dynlib: gdalLib, raises: [].}

proc VSIStrerror*(
  a0: cint
): cstring {.cdecl, importc: "VSIStrerror", dynlib: gdalLib, raises: [].}

proc VSIGetDiskFreeSpace*(
  pszDirname: cstring
): GIntBig {.cdecl, importc: "VSIGetDiskFreeSpace", dynlib: gdalLib, raises: [].}

proc VSINetworkStatsReset*() {.
  cdecl, importc: "VSINetworkStatsReset", dynlib: gdalLib, raises: []
.}

proc VSINetworkStatsGetAsSerializedJSON*(
  papszOptions: cstringArray
): cstring {.
  cdecl, importc: "VSINetworkStatsGetAsSerializedJSON", dynlib: gdalLib, raises: []
.}

proc VSIInstallMemFileHandler*() {.
  cdecl, importc: "VSIInstallMemFileHandler", dynlib: gdalLib, raises: []
.}

proc VSIInstallLargeFileHandler*() {.
  cdecl, importc: "VSIInstallLargeFileHandler", dynlib: gdalLib, raises: []
.}

proc VSIInstallSubFileHandler*() {.
  cdecl, importc: "VSIInstallSubFileHandler", dynlib: gdalLib, raises: []
.}

proc VSIInstallCurlFileHandler*() {.
  cdecl, importc: "VSIInstallCurlFileHandler", dynlib: gdalLib, raises: []
.}

proc VSICurlClearCache*() {.
  cdecl, importc: "VSICurlClearCache", dynlib: gdalLib, raises: []
.}

proc VSICurlPartialClearCache*(
  pszFilenamePrefix: cstring
) {.cdecl, importc: "VSICurlPartialClearCache", dynlib: gdalLib, raises: [].}

proc VSIInstallCurlStreamingFileHandler*() {.
  cdecl, importc: "VSIInstallCurlStreamingFileHandler", dynlib: gdalLib, raises: []
.}

proc VSIInstallS3FileHandler*() {.
  cdecl, importc: "VSIInstallS3FileHandler", dynlib: gdalLib, raises: []
.}

proc VSIInstallS3StreamingFileHandler*() {.
  cdecl, importc: "VSIInstallS3StreamingFileHandler", dynlib: gdalLib, raises: []
.}

proc VSIInstallGSFileHandler*() {.
  cdecl, importc: "VSIInstallGSFileHandler", dynlib: gdalLib, raises: []
.}

proc VSIInstallGSStreamingFileHandler*() {.
  cdecl, importc: "VSIInstallGSStreamingFileHandler", dynlib: gdalLib, raises: []
.}

proc VSIInstallAzureFileHandler*() {.
  cdecl, importc: "VSIInstallAzureFileHandler", dynlib: gdalLib, raises: []
.}

proc VSIInstallAzureStreamingFileHandler*() {.
  cdecl, importc: "VSIInstallAzureStreamingFileHandler", dynlib: gdalLib, raises: []
.}

proc VSIInstallADLSFileHandler*() {.
  cdecl, importc: "VSIInstallADLSFileHandler", dynlib: gdalLib, raises: []
.}

proc VSIInstallOSSFileHandler*() {.
  cdecl, importc: "VSIInstallOSSFileHandler", dynlib: gdalLib, raises: []
.}

proc VSIInstallOSSStreamingFileHandler*() {.
  cdecl, importc: "VSIInstallOSSStreamingFileHandler", dynlib: gdalLib, raises: []
.}

proc VSIInstallSwiftFileHandler*() {.
  cdecl, importc: "VSIInstallSwiftFileHandler", dynlib: gdalLib, raises: []
.}

proc VSIInstallSwiftStreamingFileHandler*() {.
  cdecl, importc: "VSIInstallSwiftStreamingFileHandler", dynlib: gdalLib, raises: []
.}

proc VSIInstall7zFileHandler*() {.
  cdecl, importc: "VSIInstall7zFileHandler", dynlib: gdalLib, raises: []
.}

proc VSIInstallRarFileHandler*() {.
  cdecl, importc: "VSIInstallRarFileHandler", dynlib: gdalLib, raises: []
.}

proc VSIInstallGZipFileHandler*() {.
  cdecl, importc: "VSIInstallGZipFileHandler", dynlib: gdalLib, raises: []
.}

proc VSIInstallZipFileHandler*() {.
  cdecl, importc: "VSIInstallZipFileHandler", dynlib: gdalLib, raises: []
.}

proc VSIInstallStdinHandler*() {.
  cdecl, importc: "VSIInstallStdinHandler", dynlib: gdalLib, raises: []
.}

proc VSIInstallHdfsHandler*() {.
  cdecl, importc: "VSIInstallHdfsHandler", dynlib: gdalLib, raises: []
.}

proc VSIInstallWebHdfsHandler*() {.
  cdecl, importc: "VSIInstallWebHdfsHandler", dynlib: gdalLib, raises: []
.}

proc VSIInstallStdoutHandler*() {.
  cdecl, importc: "VSIInstallStdoutHandler", dynlib: gdalLib, raises: []
.}

proc VSIInstallSparseFileHandler*() {.
  cdecl, importc: "VSIInstallSparseFileHandler", dynlib: gdalLib, raises: []
.}

proc VSIInstallTarFileHandler*() {.
  cdecl, importc: "VSIInstallTarFileHandler", dynlib: gdalLib, raises: []
.}

proc VSIInstallCachedFileHandler*() {.
  cdecl, importc: "VSIInstallCachedFileHandler", dynlib: gdalLib, raises: []
.}

proc VSIInstallCryptFileHandler*() {.
  cdecl, importc: "VSIInstallCryptFileHandler", dynlib: gdalLib, raises: []
.}

proc VSISetCryptKey*(
  pabyKey: ptr GByte, nKeySize: cint
) {.cdecl, importc: "VSISetCryptKey", dynlib: gdalLib, raises: [].}

proc VSICleanupFileManager*() {.
  cdecl, importc: "VSICleanupFileManager", dynlib: gdalLib, raises: []
.}

proc VSIDuplicateFileSystemHandler*(
  pszSourceFSName: cstring, pszNewFSName: cstring
): bool {.cdecl, importc: "VSIDuplicateFileSystemHandler", dynlib: gdalLib, raises: [].}

proc VSIFileFromMemBuffer*(
  pszFilename: cstring,
  pabyData: ptr GByte,
  nDataLength: vsi_l_offset,
  bTakeOwnership: cint,
): ptr VSILFILE {.cdecl, importc: "VSIFileFromMemBuffer", dynlib: gdalLib, raises: [].}

proc VSIGetMemFileBuffer*(
  pszFilename: cstring, pnDataLength: ptr vsi_l_offset, bUnlinkAndSeize: cint
): ptr GByte {.cdecl, importc: "VSIGetMemFileBuffer", dynlib: gdalLib, raises: [].}

proc VSIMemGenerateHiddenFilename*(
  pszFilename: cstring
): cstring {.
  cdecl, importc: "VSIMemGenerateHiddenFilename", dynlib: gdalLib, raises: []
.}

proc VSIStdoutSetRedirection*(
  pFct: VSIWriteFunction, stream: ptr GdalFile
) {.cdecl, importc: "VSIStdoutSetRedirection", dynlib: gdalLib, raises: [].}

proc VSIAllocFilesystemPluginCallbacksStruct*(): ptr VSIFilesystemPluginCallbacksStruct {.
  cdecl, importc: "VSIAllocFilesystemPluginCallbacksStruct", dynlib: gdalLib, raises: []
.}

proc VSIFreeFilesystemPluginCallbacksStruct*(
  poCb: ptr VSIFilesystemPluginCallbacksStruct
) {.
  cdecl, importc: "VSIFreeFilesystemPluginCallbacksStruct", dynlib: gdalLib, raises: []
.}

proc VSIInstallPluginHandler*(
  pszPrefix: cstring, poCb: ptr VSIFilesystemPluginCallbacksStruct
): cint {.cdecl, importc: "VSIInstallPluginHandler", dynlib: gdalLib, raises: [].}

proc VSIRemovePluginHandler*(
  pszPrefix: cstring
): cint {.cdecl, importc: "VSIRemovePluginHandler", dynlib: gdalLib, raises: [].}

proc VSITime*(
  a0: ptr culong
): culong {.cdecl, importc: "VSITime", dynlib: gdalLib, raises: [].}

proc VSICTime*(
  a0: culong
): cstring {.cdecl, importc: "VSICTime", dynlib: gdalLib, raises: [].}

proc VSIGMTime*(
  pnTime: ptr clong, poBrokenTime: ptr GdalSystemtm
): ptr GdalSystemtm {.cdecl, importc: "VSIGMTime", dynlib: gdalLib, raises: [].}

proc VSILocalTime*(
  pnTime: ptr clong, poBrokenTime: ptr GdalSystemtm
): ptr GdalSystemtm {.cdecl, importc: "VSILocalTime", dynlib: gdalLib, raises: [].}

proc CPLError*(
  eErrClass: CPLErr, err_no: CPLErrorNum, fmt: cstring
) {.cdecl, importc: "CPLError", dynlib: gdalLib, raises: [], varargs.}

proc CPLErrorV*(
  a0: CPLErr, a1: CPLErrorNum, a2: cstring, a3: GdalVaList
) {.cdecl, importc: "CPLErrorV", dynlib: gdalLib, raises: [].}

proc CPLEmergencyError*(
  a0: cstring
) {.cdecl, importc: "CPLEmergencyError", dynlib: gdalLib, raises: [].}

proc CPLErrorReset*() {.
  gdalCall, importc: "CPLErrorReset", dynlib: gdalLib, raises: []
.}

proc CPLGetLastErrorNo*(): CPLErrorNum {.
  gdalCall, importc: "CPLGetLastErrorNo", dynlib: gdalLib, raises: []
.}

proc CPLGetLastErrorType*(): CPLErr {.
  gdalCall, importc: "CPLGetLastErrorType", dynlib: gdalLib, raises: []
.}

proc CPLGetLastErrorMsg*(): cstring {.
  gdalCall, importc: "CPLGetLastErrorMsg", dynlib: gdalLib, raises: []
.}

proc CPLGetErrorCounter*(): GUInt32 {.
  gdalCall, importc: "CPLGetErrorCounter", dynlib: gdalLib, raises: []
.}

proc CPLGetErrorHandlerUserData*(): pointer {.
  gdalCall, importc: "CPLGetErrorHandlerUserData", dynlib: gdalLib, raises: []
.}

proc CPLErrorSetState*(
  eErrClass: CPLErr, err_no: CPLErrorNum, pszMsg: cstring
) {.cdecl, importc: "CPLErrorSetState", dynlib: gdalLib, raises: [].}

proc CPLCallPreviousHandler*(
  eErrClass: CPLErr, err_no: CPLErrorNum, pszMsg: cstring
) {.cdecl, importc: "CPLCallPreviousHandler", dynlib: gdalLib, raises: [].}

proc CPLCleanupErrorMutex*() {.
  cdecl, importc: "CPLCleanupErrorMutex", dynlib: gdalLib, raises: []
.}

proc CPLLoggingErrorHandler*(
  a0: CPLErr, a1: CPLErrorNum, a2: cstring
) {.gdalCall, importc: "CPLLoggingErrorHandler", dynlib: gdalLib, raises: [].}

proc CPLDefaultErrorHandler*(
  a0: CPLErr, a1: CPLErrorNum, a2: cstring
) {.gdalCall, importc: "CPLDefaultErrorHandler", dynlib: gdalLib, raises: [].}

proc CPLQuietErrorHandler*(
  a0: CPLErr, a1: CPLErrorNum, a2: cstring
) {.gdalCall, importc: "CPLQuietErrorHandler", dynlib: gdalLib, raises: [].}

proc CPLQuietWarningsErrorHandler*(
  a0: CPLErr, a1: CPLErrorNum, a2: cstring
) {.gdalCall, importc: "CPLQuietWarningsErrorHandler", dynlib: gdalLib, raises: [].}

proc CPLTurnFailureIntoWarning*(
  bOn: cint
) {.cdecl, importc: "CPLTurnFailureIntoWarning", dynlib: gdalLib, raises: [].}

proc CPLGetErrorHandler*(
  ppUserData: ptr pointer
): CPLErrorHandler {.cdecl, importc: "CPLGetErrorHandler", dynlib: gdalLib, raises: [].}

proc CPLSetErrorHandler*(
  a0: CPLErrorHandler
): CPLErrorHandler {.
  gdalCall, importc: "CPLSetErrorHandler", dynlib: gdalLib, raises: []
.}

proc CPLSetErrorHandlerEx*(
  a0: CPLErrorHandler, a1: pointer
): CPLErrorHandler {.
  gdalCall, importc: "CPLSetErrorHandlerEx", dynlib: gdalLib, raises: []
.}

proc CPLPushErrorHandler*(
  a0: CPLErrorHandler
) {.gdalCall, importc: "CPLPushErrorHandler", dynlib: gdalLib, raises: [].}

proc CPLPushErrorHandlerEx*(
  a0: CPLErrorHandler, a1: pointer
) {.gdalCall, importc: "CPLPushErrorHandlerEx", dynlib: gdalLib, raises: [].}

proc CPLSetCurrentErrorHandlerCatchDebug*(
  bCatchDebug: cint
) {.
  gdalCall, importc: "CPLSetCurrentErrorHandlerCatchDebug", dynlib: gdalLib, raises: []
.}

proc CPLPopErrorHandler*() {.
  gdalCall, importc: "CPLPopErrorHandler", dynlib: gdalLib, raises: []
.}

proc CPLDebug*(
  a0: cstring, a1: cstring
) {.cdecl, importc: "CPLDebug", dynlib: gdalLib, raises: [], varargs.}

proc CPLDebugProgress*(
  a0: cstring, a1: cstring
) {.cdecl, importc: "CPLDebugProgress", dynlib: gdalLib, raises: [], varargs.}

proc c_CPLAssert*(
  a0: cstring, a1: cstring, a2: cint
) {.gdalCall, importc: "_CPLAssert", dynlib: gdalLib, raises: [].}

proc CPLVerifyConfiguration*() {.
  cdecl, importc: "CPLVerifyConfiguration", dynlib: gdalLib, raises: []
.}

proc CPLIsDebugEnabled*(): bool {.
  cdecl, importc: "CPLIsDebugEnabled", dynlib: gdalLib, raises: []
.}

proc CPLGetConfigOption*(
  a0: cstring, a1: cstring
): cstring {.gdalCall, importc: "CPLGetConfigOption", dynlib: gdalLib, raises: [].}

proc CPLGetThreadLocalConfigOption*(
  a0: cstring, a1: cstring
): cstring {.
  gdalCall, importc: "CPLGetThreadLocalConfigOption", dynlib: gdalLib, raises: []
.}

proc CPLGetGlobalConfigOption*(
  a0: cstring, a1: cstring
): cstring {.
  gdalCall, importc: "CPLGetGlobalConfigOption", dynlib: gdalLib, raises: []
.}

proc CPLSetConfigOption*(
  a0: cstring, a1: cstring
) {.gdalCall, importc: "CPLSetConfigOption", dynlib: gdalLib, raises: [].}

proc CPLSetThreadLocalConfigOption*(
  pszKey: cstring, pszValue: cstring
) {.gdalCall, importc: "CPLSetThreadLocalConfigOption", dynlib: gdalLib, raises: [].}

proc CPLDeclareKnownConfigOption*(
  pszKey: cstring, pszDefinition: cstring
) {.cdecl, importc: "CPLDeclareKnownConfigOption", dynlib: gdalLib, raises: [].}

proc CPLGetKnownConfigOptions*(): cstringArray {.
  cdecl, importc: "CPLGetKnownConfigOptions", dynlib: gdalLib, raises: []
.}

proc CPLSubscribeToSetConfigOption*(
  pfnCallback: CPLSetConfigOptionSubscriber, pUserData: pointer
): cint {.cdecl, importc: "CPLSubscribeToSetConfigOption", dynlib: gdalLib, raises: [].}

proc CPLUnsubscribeToSetConfigOption*(
  nSubscriberId: cint
) {.cdecl, importc: "CPLUnsubscribeToSetConfigOption", dynlib: gdalLib, raises: [].}

proc CPLFreeConfig*() {.
  gdalCall, importc: "CPLFreeConfig", dynlib: gdalLib, raises: []
.}

proc CPLGetConfigOptions*(): cstringArray {.
  cdecl, importc: "CPLGetConfigOptions", dynlib: gdalLib, raises: []
.}

proc CPLSetConfigOptions*(
  papszConfigOptions: cstringArray
) {.cdecl, importc: "CPLSetConfigOptions", dynlib: gdalLib, raises: [].}

proc CPLGetThreadLocalConfigOptions*(): cstringArray {.
  cdecl, importc: "CPLGetThreadLocalConfigOptions", dynlib: gdalLib, raises: []
.}

proc CPLSetThreadLocalConfigOptions*(
  papszConfigOptions: cstringArray
) {.cdecl, importc: "CPLSetThreadLocalConfigOptions", dynlib: gdalLib, raises: [].}

proc CPLLoadConfigOptionsFromFile*(
  pszFilename: cstring, bOverrideEnvVars: cint
) {.cdecl, importc: "CPLLoadConfigOptionsFromFile", dynlib: gdalLib, raises: [].}

proc CPLLoadConfigOptionsFromPredefinedFiles*() {.
  cdecl, importc: "CPLLoadConfigOptionsFromPredefinedFiles", dynlib: gdalLib, raises: []
.}

proc CPLMalloc*(
  a0: csize_t
): pointer {.cdecl, importc: "CPLMalloc", dynlib: gdalLib, raises: [].}

proc CPLCalloc*(
  a0: csize_t, a1: csize_t
): pointer {.cdecl, importc: "CPLCalloc", dynlib: gdalLib, raises: [].}

proc CPLRealloc*(
  a0: pointer, a1: csize_t
): pointer {.cdecl, importc: "CPLRealloc", dynlib: gdalLib, raises: [].}

proc CPLStrdup*(
  a0: cstring
): cstring {.cdecl, importc: "CPLStrdup", dynlib: gdalLib, raises: [].}

proc CPLStrlwr*(
  a0: cstring
): cstring {.cdecl, importc: "CPLStrlwr", dynlib: gdalLib, raises: [].}

proc CPLFGets*(
  a0: cstring, a1: cint, a2: ptr GdalFile
): cstring {.cdecl, importc: "CPLFGets", dynlib: gdalLib, raises: [].}

proc CPLReadLine*(
  a0: ptr GdalFile
): cstring {.cdecl, importc: "CPLReadLine", dynlib: gdalLib, raises: [].}

proc CPLReadLineL*(
  a0: ptr VSILFILE
): cstring {.cdecl, importc: "CPLReadLineL", dynlib: gdalLib, raises: [].}

proc CPLReadLine2L*(
  a0: ptr VSILFILE, a1: cint, a2: CSLConstList
): cstring {.cdecl, importc: "CPLReadLine2L", dynlib: gdalLib, raises: [].}

proc CPLReadLine3L*(
  a0: ptr VSILFILE, a1: cint, a2: ptr cint, a3: CSLConstList
): cstring {.cdecl, importc: "CPLReadLine3L", dynlib: gdalLib, raises: [].}

proc CPLAtof*(
  a0: cstring
): cdouble {.cdecl, importc: "CPLAtof", dynlib: gdalLib, raises: [].}

proc CPLAtofDelim*(
  a0: cstring, a1: cchar
): cdouble {.cdecl, importc: "CPLAtofDelim", dynlib: gdalLib, raises: [].}

proc CPLStrtod*(
  a0: cstring, a1: cstringArray
): cdouble {.cdecl, importc: "CPLStrtod", dynlib: gdalLib, raises: [].}

proc CPLStrtodM*(
  a0: cstring, a1: cstringArray
): cdouble {.cdecl, importc: "CPLStrtodM", dynlib: gdalLib, raises: [].}

proc CPLStrtodDelim*(
  a0: cstring, a1: cstringArray, a2: cchar
): cdouble {.cdecl, importc: "CPLStrtodDelim", dynlib: gdalLib, raises: [].}

proc CPLStrtof*(
  a0: cstring, a1: cstringArray
): cfloat {.cdecl, importc: "CPLStrtof", dynlib: gdalLib, raises: [].}

proc CPLStrtofDelim*(
  a0: cstring, a1: cstringArray, a2: cchar
): cfloat {.cdecl, importc: "CPLStrtofDelim", dynlib: gdalLib, raises: [].}

proc CPLAtofM*(
  a0: cstring
): cdouble {.cdecl, importc: "CPLAtofM", dynlib: gdalLib, raises: [].}

proc CPLScanString*(
  a0: cstring, a1: cint, a2: cint, a3: cint
): cstring {.cdecl, importc: "CPLScanString", dynlib: gdalLib, raises: [].}

proc CPLScanDouble*(
  a0: cstring, a1: cint
): cdouble {.cdecl, importc: "CPLScanDouble", dynlib: gdalLib, raises: [].}

proc CPLScanLong*(
  a0: cstring, a1: cint
): clong {.cdecl, importc: "CPLScanLong", dynlib: gdalLib, raises: [].}

proc CPLScanULong*(
  a0: cstring, a1: cint
): culong {.cdecl, importc: "CPLScanULong", dynlib: gdalLib, raises: [].}

proc CPLScanUIntBig*(
  a0: cstring, a1: cint
): GUIntBig {.cdecl, importc: "CPLScanUIntBig", dynlib: gdalLib, raises: [].}

proc CPLAtoGIntBig*(
  pszString: cstring
): GIntBig {.cdecl, importc: "CPLAtoGIntBig", dynlib: gdalLib, raises: [].}

proc CPLAtoGIntBigEx*(
  pszString: cstring, bWarn: cint, pbOverflow: ptr cint
): GIntBig {.cdecl, importc: "CPLAtoGIntBigEx", dynlib: gdalLib, raises: [].}

proc CPLScanPointer*(
  a0: cstring, a1: cint
): pointer {.cdecl, importc: "CPLScanPointer", dynlib: gdalLib, raises: [].}

proc CPLPrintString*(
  a0: cstring, a1: cstring, a2: cint
): cint {.cdecl, importc: "CPLPrintString", dynlib: gdalLib, raises: [].}

proc CPLPrintStringFill*(
  a0: cstring, a1: cstring, a2: cint
): cint {.cdecl, importc: "CPLPrintStringFill", dynlib: gdalLib, raises: [].}

proc CPLPrintInt32*(
  a0: cstring, a1: GInt32, a2: cint
): cint {.cdecl, importc: "CPLPrintInt32", dynlib: gdalLib, raises: [].}

proc CPLPrintUIntBig*(
  a0: cstring, a1: GUIntBig, a2: cint
): cint {.cdecl, importc: "CPLPrintUIntBig", dynlib: gdalLib, raises: [].}

proc CPLPrintDouble*(
  a0: cstring, a1: cstring, a2: cdouble, a3: cstring
): cint {.cdecl, importc: "CPLPrintDouble", dynlib: gdalLib, raises: [].}

proc CPLPrintTime*(
  a0: cstring, a1: cint, a2: cstring, a3: ptr GdalSystemtm, a4: cstring
): cint {.cdecl, importc: "CPLPrintTime", dynlib: gdalLib, raises: [].}

proc CPLPrintPointer*(
  a0: cstring, a1: pointer, a2: cint
): cint {.cdecl, importc: "CPLPrintPointer", dynlib: gdalLib, raises: [].}

proc CPLGetSymbol*(
  a0: cstring, a1: cstring
): pointer {.cdecl, importc: "CPLGetSymbol", dynlib: gdalLib, raises: [].}

proc CPLGetExecPath*(
  pszPathBuf: cstring, nMaxLength: cint
): cint {.cdecl, importc: "CPLGetExecPath", dynlib: gdalLib, raises: [].}

proc CPLGetPath*(
  a0: cstring
): cstring {.cdecl, importc: "CPLGetPath", dynlib: gdalLib, raises: [].}

proc CPLGetDirname*(
  a0: cstring
): cstring {.cdecl, importc: "CPLGetDirname", dynlib: gdalLib, raises: [].}

proc CPLGetBasename*(
  a0: cstring
): cstring {.cdecl, importc: "CPLGetBasename", dynlib: gdalLib, raises: [].}

proc CPLGetExtension*(
  a0: cstring
): cstring {.cdecl, importc: "CPLGetExtension", dynlib: gdalLib, raises: [].}

proc CPLFormFilename*(
  pszPath: cstring, pszBasename: cstring, pszExtension: cstring
): cstring {.cdecl, importc: "CPLFormFilename", dynlib: gdalLib, raises: [].}

proc CPLFormCIFilename*(
  pszPath: cstring, pszBasename: cstring, pszExtension: cstring
): cstring {.cdecl, importc: "CPLFormCIFilename", dynlib: gdalLib, raises: [].}

proc CPLResetExtension*(
  a0: cstring, a1: cstring
): cstring {.cdecl, importc: "CPLResetExtension", dynlib: gdalLib, raises: [].}

proc CPLProjectRelativeFilename*(
  pszProjectDir: cstring, pszSecondaryFilename: cstring
): cstring {.cdecl, importc: "CPLProjectRelativeFilename", dynlib: gdalLib, raises: [].}

proc CPLCleanTrailingSlash*(
  a0: cstring
): cstring {.cdecl, importc: "CPLCleanTrailingSlash", dynlib: gdalLib, raises: [].}

proc CPLGenerateTempFilename*(
  pszStem: cstring
): cstring {.cdecl, importc: "CPLGenerateTempFilename", dynlib: gdalLib, raises: [].}

proc CPLExpandTilde*(
  pszFilename: cstring
): cstring {.cdecl, importc: "CPLExpandTilde", dynlib: gdalLib, raises: [].}

proc CPLLaunderForFilename*(
  pszName: cstring, pszOutputPath: cstring
): cstring {.cdecl, importc: "CPLLaunderForFilename", dynlib: gdalLib, raises: [].}

proc CPLGetCurrentDir*(): cstring {.
  cdecl, importc: "CPLGetCurrentDir", dynlib: gdalLib, raises: []
.}

proc CPLGetFilename*(
  a0: cstring
): cstring {.cdecl, importc: "CPLGetFilename", dynlib: gdalLib, raises: [].}

proc CPLIsFilenameRelative*(
  pszFilename: cstring
): cint {.cdecl, importc: "CPLIsFilenameRelative", dynlib: gdalLib, raises: [].}

proc CPLExtractRelativePath*(
  a0: cstring, a1: cstring, a2: ptr cint
): cstring {.cdecl, importc: "CPLExtractRelativePath", dynlib: gdalLib, raises: [].}

proc CPLCorrespondingPaths*(
  pszOldFilename: cstring, pszNewFilename: cstring, papszFileList: CSLConstList
): cstringArray {.cdecl, importc: "CPLCorrespondingPaths", dynlib: gdalLib, raises: [].}

proc CPLCheckForFile*(
  pszFilename: cstring, papszSiblingList: CSLConstList
): cint {.cdecl, importc: "CPLCheckForFile", dynlib: gdalLib, raises: [].}

proc CPLGetHomeDir*(): cstring {.
  cdecl, importc: "CPLGetHomeDir", dynlib: gdalLib, raises: []
.}

proc CPLHasPathTraversal*(
  pszFilename: cstring
): bool {.cdecl, importc: "CPLHasPathTraversal", dynlib: gdalLib, raises: [].}

proc CPLHasUnbalancedPathTraversal*(
  pszFilename: cstring
): bool {.cdecl, importc: "CPLHasUnbalancedPathTraversal", dynlib: gdalLib, raises: [].}

proc CPLFindFile*(
  pszClass: cstring, pszBasename: cstring
): cstring {.cdecl, importc: "CPLFindFile", dynlib: gdalLib, raises: [].}

proc CPLDefaultFindFile*(
  pszClass: cstring, pszBasename: cstring
): cstring {.cdecl, importc: "CPLDefaultFindFile", dynlib: gdalLib, raises: [].}

proc CPLPushFileFinder*(
  pfnFinder: CPLFileFinder
) {.cdecl, importc: "CPLPushFileFinder", dynlib: gdalLib, raises: [].}

proc CPLPopFileFinder*(): CPLFileFinder {.
  cdecl, importc: "CPLPopFileFinder", dynlib: gdalLib, raises: []
.}

proc CPLPushFinderLocation*(
  a0: cstring
) {.cdecl, importc: "CPLPushFinderLocation", dynlib: gdalLib, raises: [].}

proc CPLPopFinderLocation*() {.
  cdecl, importc: "CPLPopFinderLocation", dynlib: gdalLib, raises: []
.}

proc CPLFinderClean*() {.cdecl, importc: "CPLFinderClean", dynlib: gdalLib, raises: [].}
proc CPLStat*(
  a0: cstring, a1: ptr VSIStatBuf
): cint {.cdecl, importc: "CPLStat", dynlib: gdalLib, raises: [].}

proc CPLOpenShared*(
  a0: cstring, a1: cstring, a2: cint
): ptr GdalFile {.cdecl, importc: "CPLOpenShared", dynlib: gdalLib, raises: [].}

proc CPLCloseShared*(
  a0: ptr GdalFile
) {.cdecl, importc: "CPLCloseShared", dynlib: gdalLib, raises: [].}

proc CPLGetSharedList*(
  a0: ptr cint
): ptr CPLSharedFileInfo {.
  cdecl, importc: "CPLGetSharedList", dynlib: gdalLib, raises: []
.}

proc CPLDumpSharedList*(
  a0: ptr GdalFile
) {.cdecl, importc: "CPLDumpSharedList", dynlib: gdalLib, raises: [].}

proc CPLCleanupSharedFileMutex*() {.
  cdecl, importc: "CPLCleanupSharedFileMutex", dynlib: gdalLib, raises: []
.}

proc CPLDMSToDec*(
  `is`: cstring
): cdouble {.cdecl, importc: "CPLDMSToDec", dynlib: gdalLib, raises: [].}

proc CPLDecToDMS*(
  dfAngle: cdouble, pszAxis: cstring, nPrecision: cint
): cstring {.cdecl, importc: "CPLDecToDMS", dynlib: gdalLib, raises: [].}

proc CPLPackedDMSToDec*(
  a0: cdouble
): cdouble {.cdecl, importc: "CPLPackedDMSToDec", dynlib: gdalLib, raises: [].}

proc CPLDecToPackedDMS*(
  dfDec: cdouble
): cdouble {.cdecl, importc: "CPLDecToPackedDMS", dynlib: gdalLib, raises: [].}

proc CPLStringToComplex*(
  pszString: cstring, pdfReal: ptr cdouble, pdfImag: ptr cdouble
): CPLErr {.cdecl, importc: "CPLStringToComplex", dynlib: gdalLib, raises: [].}

proc CPLUnlinkTree*(
  a0: cstring
): cint {.cdecl, importc: "CPLUnlinkTree", dynlib: gdalLib, raises: [].}

proc CPLCopyFile*(
  pszNewPath: cstring, pszOldPath: cstring
): cint {.cdecl, importc: "CPLCopyFile", dynlib: gdalLib, raises: [].}

proc CPLCopyTree*(
  pszNewPath: cstring, pszOldPath: cstring
): cint {.cdecl, importc: "CPLCopyTree", dynlib: gdalLib, raises: [].}

proc CPLMoveFile*(
  pszNewPath: cstring, pszOldPath: cstring
): cint {.cdecl, importc: "CPLMoveFile", dynlib: gdalLib, raises: [].}

proc CPLSymlink*(
  pszOldPath: cstring, pszNewPath: cstring, papszOptions: CSLConstList
): cint {.cdecl, importc: "CPLSymlink", dynlib: gdalLib, raises: [].}

proc CPLGetRemainingFileDescriptorCount*(): cint {.
  cdecl, importc: "CPLGetRemainingFileDescriptorCount", dynlib: gdalLib, raises: []
.}

proc CPLLockFileEx*(
  pszLockFileName: cstring,
  phLockFileHandle: ptr CPLLockFileHandle,
  papszOptions: CSLConstList,
): CPLLockFileStatus {.cdecl, importc: "CPLLockFileEx", dynlib: gdalLib, raises: [].}

proc CPLUnlockFileEx*(
  hLockFileHandle: CPLLockFileHandle
) {.cdecl, importc: "CPLUnlockFileEx", dynlib: gdalLib, raises: [].}

proc CPLCreateZip*(
  pszZipFilename: cstring, papszOptions: cstringArray
): pointer {.cdecl, importc: "CPLCreateZip", dynlib: gdalLib, raises: [].}

proc CPLCreateFileInZip*(
  hZip: pointer, pszFilename: cstring, papszOptions: cstringArray
): CPLErr {.cdecl, importc: "CPLCreateFileInZip", dynlib: gdalLib, raises: [].}

proc CPLWriteFileInZip*(
  hZip: pointer, pBuffer: pointer, nBufferSize: cint
): CPLErr {.cdecl, importc: "CPLWriteFileInZip", dynlib: gdalLib, raises: [].}

proc CPLCloseFileInZip*(
  hZip: pointer
): CPLErr {.cdecl, importc: "CPLCloseFileInZip", dynlib: gdalLib, raises: [].}

proc CPLAddFileInZip*(
  hZip: pointer,
  pszArchiveFilename: cstring,
  pszInputFilename: cstring,
  fpInput: ptr VSILFILE,
  papszOptions: CSLConstList,
  pProgressFunc: GDALProgressFunc,
  pProgressData: pointer,
): CPLErr {.cdecl, importc: "CPLAddFileInZip", dynlib: gdalLib, raises: [].}

proc CPLCloseZip*(
  hZip: pointer
): CPLErr {.cdecl, importc: "CPLCloseZip", dynlib: gdalLib, raises: [].}

proc CPLZLibDeflate*(
  `ptr`: pointer,
  nBytes: csize_t,
  nLevel: cint,
  outptr: pointer,
  nOutAvailableBytes: csize_t,
  pnOutBytes: ptr csize_t,
): pointer {.cdecl, importc: "CPLZLibDeflate", dynlib: gdalLib, raises: [].}

proc CPLZLibInflate*(
  `ptr`: pointer,
  nBytes: csize_t,
  outptr: pointer,
  nOutAvailableBytes: csize_t,
  pnOutBytes: ptr csize_t,
): pointer {.cdecl, importc: "CPLZLibInflate", dynlib: gdalLib, raises: [].}

proc CPLZLibInflateEx*(
  `ptr`: pointer,
  nBytes: csize_t,
  outptr: pointer,
  nOutAvailableBytes: csize_t,
  bAllowResizeOutptr: bool,
  pnOutBytes: ptr csize_t,
): pointer {.cdecl, importc: "CPLZLibInflateEx", dynlib: gdalLib, raises: [].}

proc CPLValidateXML*(
  pszXMLFilename: cstring, pszXSDFilename: cstring, papszOptions: CSLConstList
): cint {.cdecl, importc: "CPLValidateXML", dynlib: gdalLib, raises: [].}

proc CPLsetlocale*(
  category: cint, locale: cstring
): cstring {.cdecl, importc: "CPLsetlocale", dynlib: gdalLib, raises: [].}

proc CPLCleanupSetlocaleMutex*() {.
  cdecl, importc: "CPLCleanupSetlocaleMutex", dynlib: gdalLib, raises: []
.}

proc CPLIsPowerOfTwo*(
  i: cuint
): cint {.cdecl, importc: "CPLIsPowerOfTwo", dynlib: gdalLib, raises: [].}

proc CPLIsInteractive*(
  f: ptr GdalFile
): bool {.cdecl, importc: "CPLIsInteractive", dynlib: gdalLib, raises: [].}

proc CSLAddString*(
  papszStrList: cstringArray, pszNewString: cstring
): cstringArray {.cdecl, importc: "CSLAddString", dynlib: gdalLib, raises: [].}

proc CSLAddStringMayFail*(
  papszStrList: cstringArray, pszNewString: cstring
): cstringArray {.cdecl, importc: "CSLAddStringMayFail", dynlib: gdalLib, raises: [].}

proc CSLCount*(
  papszStrList: CSLConstList
): cint {.cdecl, importc: "CSLCount", dynlib: gdalLib, raises: [].}

proc CSLGetField*(
  a0: CSLConstList, a1: cint
): cstring {.cdecl, importc: "CSLGetField", dynlib: gdalLib, raises: [].}

proc CSLDestroy*(
  papszStrList: cstringArray
) {.gdalCall, importc: "CSLDestroy", dynlib: gdalLib, raises: [].}

proc CSLDuplicate*(
  papszStrList: CSLConstList
): cstringArray {.cdecl, importc: "CSLDuplicate", dynlib: gdalLib, raises: [].}

proc CSLMerge*(
  papszOrig: cstringArray, papszOverride: CSLConstList
): cstringArray {.cdecl, importc: "CSLMerge", dynlib: gdalLib, raises: [].}

proc CSLTokenizeString*(
  pszString: cstring
): cstringArray {.cdecl, importc: "CSLTokenizeString", dynlib: gdalLib, raises: [].}

proc CSLTokenizeStringComplex*(
  pszString: cstring,
  pszDelimiter: cstring,
  bHonourStrings: cint,
  bAllowEmptyTokens: cint,
): cstringArray {.
  cdecl, importc: "CSLTokenizeStringComplex", dynlib: gdalLib, raises: []
.}

proc CSLTokenizeString2*(
  pszString: cstring, pszDelimiter: cstring, nCSLTFlags: cint
): cstringArray {.cdecl, importc: "CSLTokenizeString2", dynlib: gdalLib, raises: [].}

proc CSLPrint*(
  papszStrList: CSLConstList, fpOut: ptr GdalFile
): cint {.cdecl, importc: "CSLPrint", dynlib: gdalLib, raises: [].}

proc CSLLoad*(
  pszFname: cstring
): cstringArray {.cdecl, importc: "CSLLoad", dynlib: gdalLib, raises: [].}

proc CSLLoad2*(
  pszFname: cstring, nMaxLines: cint, nMaxCols: cint, papszOptions: CSLConstList
): cstringArray {.cdecl, importc: "CSLLoad2", dynlib: gdalLib, raises: [].}

proc CSLSave*(
  papszStrList: CSLConstList, pszFname: cstring
): cint {.cdecl, importc: "CSLSave", dynlib: gdalLib, raises: [].}

proc CSLInsertStrings*(
  papszStrList: cstringArray, nInsertAtLineNo: cint, papszNewLines: CSLConstList
): cstringArray {.cdecl, importc: "CSLInsertStrings", dynlib: gdalLib, raises: [].}

proc CSLInsertString*(
  papszStrList: cstringArray, nInsertAtLineNo: cint, pszNewLine: cstring
): cstringArray {.cdecl, importc: "CSLInsertString", dynlib: gdalLib, raises: [].}

proc CSLRemoveStrings*(
  papszStrList: cstringArray,
  nFirstLineToDelete: cint,
  nNumToRemove: cint,
  ppapszRetStrings: ptr cstringArray,
): cstringArray {.cdecl, importc: "CSLRemoveStrings", dynlib: gdalLib, raises: [].}

proc CSLFindString*(
  papszList: CSLConstList, pszTarget: cstring
): cint {.cdecl, importc: "CSLFindString", dynlib: gdalLib, raises: [].}

proc CSLFindStringCaseSensitive*(
  papszList: CSLConstList, pszTarget: cstring
): cint {.cdecl, importc: "CSLFindStringCaseSensitive", dynlib: gdalLib, raises: [].}

proc CSLPartialFindString*(
  papszHaystack: CSLConstList, pszNeedle: cstring
): cint {.cdecl, importc: "CSLPartialFindString", dynlib: gdalLib, raises: [].}

proc CSLFindName*(
  papszStrList: CSLConstList, pszName: cstring
): cint {.cdecl, importc: "CSLFindName", dynlib: gdalLib, raises: [].}

proc CSLFetchBoolean*(
  papszStrList: CSLConstList, pszKey: cstring, bDefault: cint
): cint {.cdecl, importc: "CSLFetchBoolean", dynlib: gdalLib, raises: [].}

proc CSLTestBoolean*(
  pszValue: cstring
): cint {.cdecl, importc: "CSLTestBoolean", dynlib: gdalLib, raises: [].}

proc CPLTestBoolean*(
  pszValue: cstring
): cint {.cdecl, importc: "CPLTestBoolean", dynlib: gdalLib, raises: [].}

proc CPLTestBool*(
  pszValue: cstring
): bool {.cdecl, importc: "CPLTestBool", dynlib: gdalLib, raises: [].}

proc CPLFetchBool*(
  papszStrList: CSLConstList, pszKey: cstring, bDefault: bool
): bool {.cdecl, importc: "CPLFetchBool", dynlib: gdalLib, raises: [].}

proc CPLParseMemorySize*(
  pszValue: cstring, pnValue: ptr GIntBig, pbUnitSpecified: ptr bool
): CPLErr {.cdecl, importc: "CPLParseMemorySize", dynlib: gdalLib, raises: [].}

proc CPLParseNameValue*(
  pszNameValue: cstring, ppszKey: cstringArray
): cstring {.cdecl, importc: "CPLParseNameValue", dynlib: gdalLib, raises: [].}

proc CPLParseNameValueSep*(
  pszNameValue: cstring, ppszKey: cstringArray, chSep: cchar
): cstring {.cdecl, importc: "CPLParseNameValueSep", dynlib: gdalLib, raises: [].}

proc CSLFetchNameValue*(
  papszStrList: CSLConstList, pszName: cstring
): cstring {.cdecl, importc: "CSLFetchNameValue", dynlib: gdalLib, raises: [].}

proc CSLFetchNameValueDef*(
  papszStrList: CSLConstList, pszName: cstring, pszDefault: cstring
): cstring {.cdecl, importc: "CSLFetchNameValueDef", dynlib: gdalLib, raises: [].}

proc CSLFetchNameValueMultiple*(
  papszStrList: CSLConstList, pszName: cstring
): cstringArray {.
  cdecl, importc: "CSLFetchNameValueMultiple", dynlib: gdalLib, raises: []
.}

proc CSLAddNameValue*(
  papszStrList: cstringArray, pszName: cstring, pszValue: cstring
): cstringArray {.cdecl, importc: "CSLAddNameValue", dynlib: gdalLib, raises: [].}

proc CSLSetNameValue*(
  papszStrList: cstringArray, pszName: cstring, pszValue: cstring
): cstringArray {.cdecl, importc: "CSLSetNameValue", dynlib: gdalLib, raises: [].}

proc CSLSetNameValueSeparator*(
  papszStrList: cstringArray, pszSeparator: cstring
) {.cdecl, importc: "CSLSetNameValueSeparator", dynlib: gdalLib, raises: [].}

proc CSLParseCommandLine*(
  pszCommandLine: cstring
): cstringArray {.cdecl, importc: "CSLParseCommandLine", dynlib: gdalLib, raises: [].}

proc CPLEscapeString*(
  pszString: cstring, nLength: cint, nScheme: cint
): cstring {.cdecl, importc: "CPLEscapeString", dynlib: gdalLib, raises: [].}

proc CPLUnescapeString*(
  pszString: cstring, pnLength: ptr cint, nScheme: cint
): cstring {.cdecl, importc: "CPLUnescapeString", dynlib: gdalLib, raises: [].}

proc CPLBinaryToHex*(
  nBytes: cint, pabyData: ptr GByte
): cstring {.cdecl, importc: "CPLBinaryToHex", dynlib: gdalLib, raises: [].}

proc CPLHexToBinary*(
  pszHex: cstring, pnBytes: ptr cint
): ptr GByte {.cdecl, importc: "CPLHexToBinary", dynlib: gdalLib, raises: [].}

proc CPLBase64Encode*(
  nBytes: cint, pabyData: ptr GByte
): cstring {.cdecl, importc: "CPLBase64Encode", dynlib: gdalLib, raises: [].}

proc CPLBase64DecodeInPlace*(
  pszBase64: ptr GByte
): cint {.cdecl, importc: "CPLBase64DecodeInPlace", dynlib: gdalLib, raises: [].}

proc CPLGetValueType*(
  pszValue: cstring
): CPLValueType {.cdecl, importc: "CPLGetValueType", dynlib: gdalLib, raises: [].}

proc CPLToupper*(
  c: cint
): cint {.cdecl, importc: "CPLToupper", dynlib: gdalLib, raises: [].}

proc CPLTolower*(
  c: cint
): cint {.cdecl, importc: "CPLTolower", dynlib: gdalLib, raises: [].}

proc CPLStrlcpy*(
  pszDest: cstring, pszSrc: cstring, nDestSize: csize_t
): csize_t {.cdecl, importc: "CPLStrlcpy", dynlib: gdalLib, raises: [].}

proc CPLStrlcat*(
  pszDest: cstring, pszSrc: cstring, nDestSize: csize_t
): csize_t {.cdecl, importc: "CPLStrlcat", dynlib: gdalLib, raises: [].}

proc CPLStrnlen*(
  pszStr: cstring, nMaxLen: csize_t
): csize_t {.cdecl, importc: "CPLStrnlen", dynlib: gdalLib, raises: [].}

proc CPLvsnprintf*(
  str: cstring, size: csize_t, fmt: cstring, args: GdalVaList
): cint {.cdecl, importc: "CPLvsnprintf", dynlib: gdalLib, raises: [].}

proc CPLsnprintf*(
  str: cstring, size: csize_t, fmt: cstring
): cint {.cdecl, importc: "CPLsnprintf", dynlib: gdalLib, raises: [], varargs.}

proc CPLsprintf*(
  str: cstring, fmt: cstring
): cint {.cdecl, importc: "CPLsprintf", dynlib: gdalLib, raises: [], varargs.}

proc CPLprintf*(
  fmt: cstring
): cint {.cdecl, importc: "CPLprintf", dynlib: gdalLib, raises: [], varargs.}

proc CPLsscanf*(
  str: cstring, fmt: cstring
): cint {.cdecl, importc: "CPLsscanf", dynlib: gdalLib, raises: [], varargs.}

proc CPLSPrintf*(
  fmt: cstring
): cstring {.cdecl, importc: "CPLSPrintf", dynlib: gdalLib, raises: [], varargs.}

proc CSLAppendPrintf*(
  papszStrList: cstringArray, fmt: cstring
): cstringArray {.
  cdecl, importc: "CSLAppendPrintf", dynlib: gdalLib, raises: [], varargs
.}

proc CPLVASPrintf*(
  buf: cstringArray, fmt: cstring, args: GdalVaList
): cint {.cdecl, importc: "CPLVASPrintf", dynlib: gdalLib, raises: [].}

proc CPLEncodingCharSize*(
  pszEncoding: cstring
): cint {.cdecl, importc: "CPLEncodingCharSize", dynlib: gdalLib, raises: [].}

proc CPLClearRecodeWarningFlags*() {.
  cdecl, importc: "CPLClearRecodeWarningFlags", dynlib: gdalLib, raises: []
.}

proc CPLRecode*(
  pszSource: cstring, pszSrcEncoding: cstring, pszDstEncoding: cstring
): cstring {.cdecl, importc: "CPLRecode", dynlib: gdalLib, raises: [].}

proc CPLRecodeFromWChar*(
  pwszSource: ptr cint, pszSrcEncoding: cstring, pszDstEncoding: cstring
): cstring {.cdecl, importc: "CPLRecodeFromWChar", dynlib: gdalLib, raises: [].}

proc CPLRecodeToWChar*(
  pszSource: cstring, pszSrcEncoding: cstring, pszDstEncoding: cstring
): ptr cint {.cdecl, importc: "CPLRecodeToWChar", dynlib: gdalLib, raises: [].}

proc CPLIsUTF8*(
  pabyData: cstring, nLen: cint
): cint {.cdecl, importc: "CPLIsUTF8", dynlib: gdalLib, raises: [].}

proc CPLIsASCII*(
  pabyData: cstring, nLen: csize_t
): bool {.cdecl, importc: "CPLIsASCII", dynlib: gdalLib, raises: [].}

proc CPLForceToASCII*(
  pabyData: cstring, nLen: cint, chReplacementChar: cchar
): cstring {.cdecl, importc: "CPLForceToASCII", dynlib: gdalLib, raises: [].}

proc CPLUTF8ForceToASCII*(
  pszStr: cstring, chReplacementChar: cchar
): cstring {.cdecl, importc: "CPLUTF8ForceToASCII", dynlib: gdalLib, raises: [].}

proc CPLStrlenUTF8*(
  pszUTF8Str: cstring
): cint {.cdecl, importc: "CPLStrlenUTF8", dynlib: gdalLib, raises: [].}

proc CPLStrlenUTF8Ex*(
  pszUTF8Str: cstring
): csize_t {.cdecl, importc: "CPLStrlenUTF8Ex", dynlib: gdalLib, raises: [].}

proc CPLCanRecode*(
  pszTestStr: cstring, pszSrcEncoding: cstring, pszDstEncoding: cstring
): cint {.cdecl, importc: "CPLCanRecode", dynlib: gdalLib, raises: [].}

proc CSVFilename*(
  a0: cstring
): cstring {.cdecl, importc: "CSVFilename", dynlib: gdalLib, raises: [].}

proc CSVDetectSeperator*(
  pszLine: cstring
): cchar {.cdecl, importc: "CSVDetectSeperator", dynlib: gdalLib, raises: [].}

proc CSVReadParseLine*(
  fp: ptr GdalFile
): cstringArray {.cdecl, importc: "CSVReadParseLine", dynlib: gdalLib, raises: [].}

proc CSVReadParseLine2*(
  fp: ptr GdalFile, chDelimiter: cchar
): cstringArray {.cdecl, importc: "CSVReadParseLine2", dynlib: gdalLib, raises: [].}

proc CSVReadParseLineL*(
  fp: ptr VSILFILE
): cstringArray {.cdecl, importc: "CSVReadParseLineL", dynlib: gdalLib, raises: [].}

proc CSVReadParseLine2L*(
  fp: ptr VSILFILE, chDelimiter: cchar
): cstringArray {.cdecl, importc: "CSVReadParseLine2L", dynlib: gdalLib, raises: [].}

proc CSVReadParseLine3L*(
  fp: ptr VSILFILE,
  nMaxLineSize: csize_t,
  pszDelimiter: cstring,
  bHonourStrings: bool,
  bKeepLeadingAndClosingQuotes: bool,
  bMergeDelimiter: bool,
  bSkipBOM: bool,
): cstringArray {.cdecl, importc: "CSVReadParseLine3L", dynlib: gdalLib, raises: [].}

proc CSVScanLines*(
  a0: ptr GdalFile, a1: cint, a2: cstring, a3: CSVCompareCriteria
): cstringArray {.cdecl, importc: "CSVScanLines", dynlib: gdalLib, raises: [].}

proc CSVScanLinesL*(
  a0: ptr VSILFILE, a1: cint, a2: cstring, a3: CSVCompareCriteria
): cstringArray {.cdecl, importc: "CSVScanLinesL", dynlib: gdalLib, raises: [].}

proc CSVScanFile*(
  a0: cstring, a1: cint, a2: cstring, a3: CSVCompareCriteria
): cstringArray {.cdecl, importc: "CSVScanFile", dynlib: gdalLib, raises: [].}

proc CSVScanFileByName*(
  a0: cstring, a1: cstring, a2: cstring, a3: CSVCompareCriteria
): cstringArray {.cdecl, importc: "CSVScanFileByName", dynlib: gdalLib, raises: [].}

proc CSVRewind*(
  a0: cstring
) {.cdecl, importc: "CSVRewind", dynlib: gdalLib, raises: [].}

proc CSVGetNextLine*(
  a0: cstring
): cstringArray {.cdecl, importc: "CSVGetNextLine", dynlib: gdalLib, raises: [].}

proc CSVGetFieldId*(
  a0: ptr GdalFile, a1: cstring
): cint {.cdecl, importc: "CSVGetFieldId", dynlib: gdalLib, raises: [].}

proc CSVGetFieldIdL*(
  a0: ptr VSILFILE, a1: cstring
): cint {.cdecl, importc: "CSVGetFieldIdL", dynlib: gdalLib, raises: [].}

proc CSVGetFileFieldId*(
  a0: cstring, a1: cstring
): cint {.cdecl, importc: "CSVGetFileFieldId", dynlib: gdalLib, raises: [].}

proc CSVDeaccess*(
  a0: cstring
) {.cdecl, importc: "CSVDeaccess", dynlib: gdalLib, raises: [].}

proc CSVGetField*(
  a0: cstring, a1: cstring, a2: cstring, a3: CSVCompareCriteria, a4: cstring
): cstring {.cdecl, importc: "CSVGetField", dynlib: gdalLib, raises: [].}

proc SetCSVFilenameHook*(
  a0: proc(a0: cstring): cstring {.cdecl, raises: [].}
) {.cdecl, importc: "SetCSVFilenameHook", dynlib: gdalLib, raises: [].}

proc CPLHalfToFloat*(
  iHalf: GUInt16
): GUInt32 {.cdecl, importc: "CPLHalfToFloat", dynlib: gdalLib, raises: [].}

proc CPLTripleToFloat*(
  iTriple: GUInt32
): GUInt32 {.cdecl, importc: "CPLTripleToFloat", dynlib: gdalLib, raises: [].}

proc CPLHashSetNew*(
  fnHashFunc: CPLHashSetHashFunc,
  fnEqualFunc: CPLHashSetEqualFunc,
  fnFreeEltFunc: CPLHashSetFreeEltFunc,
): ptr CPLHashSet {.cdecl, importc: "CPLHashSetNew", dynlib: gdalLib, raises: [].}

proc CPLHashSetDestroy*(
  set: ptr CPLHashSet
) {.cdecl, importc: "CPLHashSetDestroy", dynlib: gdalLib, raises: [].}

proc CPLHashSetClear*(
  set: ptr CPLHashSet
) {.cdecl, importc: "CPLHashSetClear", dynlib: gdalLib, raises: [].}

proc CPLHashSetSize*(
  set: ptr CPLHashSet
): cint {.cdecl, importc: "CPLHashSetSize", dynlib: gdalLib, raises: [].}

proc CPLHashSetForeach*(
  set: ptr CPLHashSet, fnIterFunc: CPLHashSetIterEltFunc, user_data: pointer
) {.cdecl, importc: "CPLHashSetForeach", dynlib: gdalLib, raises: [].}

proc CPLHashSetInsert*(
  set: ptr CPLHashSet, elt: pointer
): cint {.cdecl, importc: "CPLHashSetInsert", dynlib: gdalLib, raises: [].}

proc CPLHashSetLookup*(
  set: ptr CPLHashSet, elt: pointer
): pointer {.cdecl, importc: "CPLHashSetLookup", dynlib: gdalLib, raises: [].}

proc CPLHashSetRemove*(
  set: ptr CPLHashSet, elt: pointer
): cint {.cdecl, importc: "CPLHashSetRemove", dynlib: gdalLib, raises: [].}

proc CPLHashSetRemoveDeferRehash*(
  set: ptr CPLHashSet, elt: pointer
): cint {.cdecl, importc: "CPLHashSetRemoveDeferRehash", dynlib: gdalLib, raises: [].}

proc CPLHashSetHashPointer*(
  elt: pointer
): culong {.cdecl, importc: "CPLHashSetHashPointer", dynlib: gdalLib, raises: [].}

proc CPLHashSetEqualPointer*(
  elt1: pointer, elt2: pointer
): cint {.cdecl, importc: "CPLHashSetEqualPointer", dynlib: gdalLib, raises: [].}

proc CPLHashSetHashStr*(
  pszStr: pointer
): culong {.cdecl, importc: "CPLHashSetHashStr", dynlib: gdalLib, raises: [].}

proc CPLHashSetEqualStr*(
  pszStr1: pointer, pszStr2: pointer
): cint {.cdecl, importc: "CPLHashSetEqualStr", dynlib: gdalLib, raises: [].}

proc CPLHTTPEnabled*(): cint {.
  cdecl, importc: "CPLHTTPEnabled", dynlib: gdalLib, raises: []
.}

proc CPLHTTPFetch*(
  pszURL: cstring, papszOptions: CSLConstList
): ptr CPLHTTPResult {.cdecl, importc: "CPLHTTPFetch", dynlib: gdalLib, raises: [].}

proc CPLHTTPFetchEx*(
  pszURL: cstring,
  papszOptions: CSLConstList,
  pfnProgress: GDALProgressFunc,
  pProgressArg: pointer,
  pfnWrite: CPLHTTPFetchWriteFunc,
  pWriteArg: pointer,
): ptr CPLHTTPResult {.cdecl, importc: "CPLHTTPFetchEx", dynlib: gdalLib, raises: [].}

proc CPLHTTPMultiFetch*(
  papszURL: cstringArray,
  nURLCount: cint,
  nMaxSimultaneous: cint,
  papszOptions: CSLConstList,
): ptr ptr CPLHTTPResult {.
  cdecl, importc: "CPLHTTPMultiFetch", dynlib: gdalLib, raises: []
.}

proc CPLHTTPCleanup*() {.cdecl, importc: "CPLHTTPCleanup", dynlib: gdalLib, raises: [].}
proc CPLHTTPDestroyResult*(
  psResult: ptr CPLHTTPResult
) {.cdecl, importc: "CPLHTTPDestroyResult", dynlib: gdalLib, raises: [].}

proc CPLHTTPDestroyMultiResult*(
  papsResults: ptr ptr CPLHTTPResult, nCount: cint
) {.cdecl, importc: "CPLHTTPDestroyMultiResult", dynlib: gdalLib, raises: [].}

proc CPLHTTPParseMultipartMime*(
  psResult: ptr CPLHTTPResult
): cint {.cdecl, importc: "CPLHTTPParseMultipartMime", dynlib: gdalLib, raises: [].}

proc CPLHTTPSetDefaultUserAgent*(
  pszUserAgent: cstring
) {.cdecl, importc: "CPLHTTPSetDefaultUserAgent", dynlib: gdalLib, raises: [].}

proc CPLHTTPSetFetchCallback*(
  pFunc: CPLHTTPFetchCallbackFunc, pUserData: pointer
) {.cdecl, importc: "CPLHTTPSetFetchCallback", dynlib: gdalLib, raises: [].}

proc CPLHTTPPushFetchCallback*(
  pFunc: CPLHTTPFetchCallbackFunc, pUserData: pointer
): cint {.cdecl, importc: "CPLHTTPPushFetchCallback", dynlib: gdalLib, raises: [].}

proc CPLHTTPPopFetchCallback*(): cint {.
  cdecl, importc: "CPLHTTPPopFetchCallback", dynlib: gdalLib, raises: []
.}

proc GOA2GetAuthorizationURL*(
  pszScope: cstring
): cstring {.cdecl, importc: "GOA2GetAuthorizationURL", dynlib: gdalLib, raises: [].}

proc GOA2GetRefreshToken*(
  pszAuthToken: cstring, pszScope: cstring
): cstring {.cdecl, importc: "GOA2GetRefreshToken", dynlib: gdalLib, raises: [].}

proc GOA2GetAccessToken*(
  pszRefreshToken: cstring, pszScope: cstring
): cstring {.cdecl, importc: "GOA2GetAccessToken", dynlib: gdalLib, raises: [].}

proc GOA2GetAccessTokenFromServiceAccount*(
  pszPrivateKey: cstring,
  pszClientEmail: cstring,
  pszScope: cstring,
  papszAdditionalClaims: CSLConstList,
  papszOptions: CSLConstList,
): cstringArray {.
  cdecl, importc: "GOA2GetAccessTokenFromServiceAccount", dynlib: gdalLib, raises: []
.}

proc GOA2GetAccessTokenFromCloudEngineVM*(
  papszOptions: CSLConstList
): cstringArray {.
  cdecl, importc: "GOA2GetAccessTokenFromCloudEngineVM", dynlib: gdalLib, raises: []
.}

proc CPLListAppend*(
  psList: ptr CPLList, pData: pointer
): ptr CPLList {.cdecl, importc: "CPLListAppend", dynlib: gdalLib, raises: [].}

proc CPLListInsert*(
  psList: ptr CPLList, pData: pointer, nPosition: cint
): ptr CPLList {.cdecl, importc: "CPLListInsert", dynlib: gdalLib, raises: [].}

proc CPLListGetLast*(
  psList: ptr CPLList
): ptr CPLList {.cdecl, importc: "CPLListGetLast", dynlib: gdalLib, raises: [].}

proc CPLListGet*(
  psList: ptr CPLList, nPosition: cint
): ptr CPLList {.cdecl, importc: "CPLListGet", dynlib: gdalLib, raises: [].}

proc CPLListCount*(
  psList: ptr CPLList
): cint {.cdecl, importc: "CPLListCount", dynlib: gdalLib, raises: [].}

proc CPLListRemove*(
  psList: ptr CPLList, nPosition: cint
): ptr CPLList {.cdecl, importc: "CPLListRemove", dynlib: gdalLib, raises: [].}

proc CPLListDestroy*(
  psList: ptr CPLList
) {.cdecl, importc: "CPLListDestroy", dynlib: gdalLib, raises: [].}

proc CPLListGetNext*(
  psElement: ptr CPLList
): ptr CPLList {.cdecl, importc: "CPLListGetNext", dynlib: gdalLib, raises: [].}

proc CPLListGetData*(
  psElement: ptr CPLList
): pointer {.cdecl, importc: "CPLListGetData", dynlib: gdalLib, raises: [].}

proc CPLParseXMLString*(
  a0: cstring
): ptr CPLXMLNode {.cdecl, importc: "CPLParseXMLString", dynlib: gdalLib, raises: [].}

proc CPLDestroyXMLNode*(
  a0: ptr CPLXMLNode
) {.cdecl, importc: "CPLDestroyXMLNode", dynlib: gdalLib, raises: [].}

proc CPLGetXMLNode*(
  poRoot: ptr CPLXMLNode, pszPath: cstring
): ptr CPLXMLNode {.cdecl, importc: "CPLGetXMLNode", dynlib: gdalLib, raises: [].}

proc CPLSearchXMLNode*(
  poRoot: ptr CPLXMLNode, pszTarget: cstring
): ptr CPLXMLNode {.cdecl, importc: "CPLSearchXMLNode", dynlib: gdalLib, raises: [].}

proc CPLGetXMLValue*(
  poRoot: ptr CPLXMLNode, pszPath: cstring, pszDefault: cstring
): cstring {.cdecl, importc: "CPLGetXMLValue", dynlib: gdalLib, raises: [].}

proc CPLCreateXMLNode*(
  poParent: ptr CPLXMLNode, eType: CPLXMLNodeType, pszText: cstring
): ptr CPLXMLNode {.cdecl, importc: "CPLCreateXMLNode", dynlib: gdalLib, raises: [].}

proc CPLSerializeXMLTree*(
  psNode: ptr CPLXMLNode
): cstring {.cdecl, importc: "CPLSerializeXMLTree", dynlib: gdalLib, raises: [].}

proc CPLAddXMLChild*(
  psParent: ptr CPLXMLNode, psChild: ptr CPLXMLNode
) {.cdecl, importc: "CPLAddXMLChild", dynlib: gdalLib, raises: [].}

proc CPLRemoveXMLChild*(
  psParent: ptr CPLXMLNode, psChild: ptr CPLXMLNode
): cint {.cdecl, importc: "CPLRemoveXMLChild", dynlib: gdalLib, raises: [].}

proc CPLAddXMLSibling*(
  psOlderSibling: ptr CPLXMLNode, psNewSibling: ptr CPLXMLNode
) {.cdecl, importc: "CPLAddXMLSibling", dynlib: gdalLib, raises: [].}

proc CPLCreateXMLElementAndValue*(
  psParent: ptr CPLXMLNode, pszName: cstring, pszValue: cstring
): ptr CPLXMLNode {.
  cdecl, importc: "CPLCreateXMLElementAndValue", dynlib: gdalLib, raises: []
.}

proc CPLAddXMLAttributeAndValue*(
  psParent: ptr CPLXMLNode, pszName: cstring, pszValue: cstring
) {.cdecl, importc: "CPLAddXMLAttributeAndValue", dynlib: gdalLib, raises: [].}

proc CPLCloneXMLTree*(
  psTree: ptr CPLXMLNode
): ptr CPLXMLNode {.cdecl, importc: "CPLCloneXMLTree", dynlib: gdalLib, raises: [].}

proc CPLSetXMLValue*(
  psRoot: ptr CPLXMLNode, pszPath: cstring, pszValue: cstring
): cint {.cdecl, importc: "CPLSetXMLValue", dynlib: gdalLib, raises: [].}

proc CPLStripXMLNamespace*(
  psRoot: ptr CPLXMLNode, pszNameSpace: cstring, bRecurse: cint
) {.cdecl, importc: "CPLStripXMLNamespace", dynlib: gdalLib, raises: [].}

proc CPLCleanXMLElementName*(
  a0: cstring
) {.cdecl, importc: "CPLCleanXMLElementName", dynlib: gdalLib, raises: [].}

proc CPLParseXMLFile*(
  pszFilename: cstring
): ptr CPLXMLNode {.cdecl, importc: "CPLParseXMLFile", dynlib: gdalLib, raises: [].}

proc CPLSerializeXMLTreeToFile*(
  psTree: ptr CPLXMLNode, pszFilename: cstring
): cint {.cdecl, importc: "CPLSerializeXMLTreeToFile", dynlib: gdalLib, raises: [].}

proc CPLXMLNodeGetRAMUsageEstimate*(
  psNode: ptr CPLXMLNode
): csize_t {.
  cdecl, importc: "CPLXMLNodeGetRAMUsageEstimate", dynlib: gdalLib, raises: []
.}

proc CPLLockFile*(
  pszPath: cstring, dfWaitInSeconds: cdouble
): pointer {.cdecl, importc: "CPLLockFile", dynlib: gdalLib, raises: [].}

proc CPLUnlockFile*(
  hLock: pointer
) {.cdecl, importc: "CPLUnlockFile", dynlib: gdalLib, raises: [].}

proc CPLCreateMutex*(): ptr CPLMutex {.
  cdecl, importc: "CPLCreateMutex", dynlib: gdalLib, raises: []
.}

proc CPLCreateMutexEx*(
  nOptions: cint
): ptr CPLMutex {.cdecl, importc: "CPLCreateMutexEx", dynlib: gdalLib, raises: [].}

proc CPLCreateOrAcquireMutex*(
  a0: ptr ptr CPLMutex, dfWaitInSeconds: cdouble
): cint {.cdecl, importc: "CPLCreateOrAcquireMutex", dynlib: gdalLib, raises: [].}

proc CPLCreateOrAcquireMutexEx*(
  a0: ptr ptr CPLMutex, dfWaitInSeconds: cdouble, nOptions: cint
): cint {.cdecl, importc: "CPLCreateOrAcquireMutexEx", dynlib: gdalLib, raises: [].}

proc CPLAcquireMutex*(
  hMutex: ptr CPLMutex, dfWaitInSeconds: cdouble
): cint {.cdecl, importc: "CPLAcquireMutex", dynlib: gdalLib, raises: [].}

proc CPLReleaseMutex*(
  hMutex: ptr CPLMutex
) {.cdecl, importc: "CPLReleaseMutex", dynlib: gdalLib, raises: [].}

proc CPLDestroyMutex*(
  hMutex: ptr CPLMutex
) {.cdecl, importc: "CPLDestroyMutex", dynlib: gdalLib, raises: [].}

proc CPLCleanupMasterMutex*() {.
  cdecl, importc: "CPLCleanupMasterMutex", dynlib: gdalLib, raises: []
.}

proc CPLCreateCond*(): ptr CPLCond {.
  cdecl, importc: "CPLCreateCond", dynlib: gdalLib, raises: []
.}

proc CPLCondWait*(
  hCond: ptr CPLCond, hMutex: ptr CPLMutex
) {.cdecl, importc: "CPLCondWait", dynlib: gdalLib, raises: [].}

proc CPLCondTimedWait*(
  hCond: ptr CPLCond, hMutex: ptr CPLMutex, dfWaitInSeconds: cdouble
): CPLCondTimedWaitReason {.
  cdecl, importc: "CPLCondTimedWait", dynlib: gdalLib, raises: []
.}

proc CPLCondSignal*(
  hCond: ptr CPLCond
) {.cdecl, importc: "CPLCondSignal", dynlib: gdalLib, raises: [].}

proc CPLCondBroadcast*(
  hCond: ptr CPLCond
) {.cdecl, importc: "CPLCondBroadcast", dynlib: gdalLib, raises: [].}

proc CPLDestroyCond*(
  hCond: ptr CPLCond
) {.cdecl, importc: "CPLDestroyCond", dynlib: gdalLib, raises: [].}

proc CPLGetPID*(): GIntBig {.cdecl, importc: "CPLGetPID", dynlib: gdalLib, raises: [].}
proc CPLGetCurrentProcessID*(): cint {.
  cdecl, importc: "CPLGetCurrentProcessID", dynlib: gdalLib, raises: []
.}

proc CPLCreateThread*(
  pfnMain: CPLThreadFunc, pArg: pointer
): cint {.cdecl, importc: "CPLCreateThread", dynlib: gdalLib, raises: [].}

proc CPLCreateJoinableThread*(
  pfnMain: CPLThreadFunc, pArg: pointer
): ptr CPLJoinableThread {.
  cdecl, importc: "CPLCreateJoinableThread", dynlib: gdalLib, raises: []
.}

proc CPLJoinThread*(
  hJoinableThread: ptr CPLJoinableThread
) {.cdecl, importc: "CPLJoinThread", dynlib: gdalLib, raises: [].}

proc CPLSleep*(
  dfWaitInSeconds: cdouble
) {.cdecl, importc: "CPLSleep", dynlib: gdalLib, raises: [].}

proc CPLGetThreadingModel*(): cstring {.
  cdecl, importc: "CPLGetThreadingModel", dynlib: gdalLib, raises: []
.}

proc CPLGetNumCPUs*(): cint {.
  cdecl, importc: "CPLGetNumCPUs", dynlib: gdalLib, raises: []
.}

proc CPLGetCurrentThreadCount*(): cint {.
  cdecl, importc: "CPLGetCurrentThreadCount", dynlib: gdalLib, raises: []
.}

proc CPLCreateLock*(
  eType: CPLLockType
): ptr CPLLock {.cdecl, importc: "CPLCreateLock", dynlib: gdalLib, raises: [].}

proc CPLCreateOrAcquireLock*(
  a0: ptr ptr CPLLock, eType: CPLLockType
): cint {.cdecl, importc: "CPLCreateOrAcquireLock", dynlib: gdalLib, raises: [].}

proc CPLAcquireLock*(
  a0: ptr CPLLock
): cint {.cdecl, importc: "CPLAcquireLock", dynlib: gdalLib, raises: [].}

proc CPLReleaseLock*(
  a0: ptr CPLLock
) {.cdecl, importc: "CPLReleaseLock", dynlib: gdalLib, raises: [].}

proc CPLDestroyLock*(
  a0: ptr CPLLock
) {.cdecl, importc: "CPLDestroyLock", dynlib: gdalLib, raises: [].}

proc CPLLockSetDebugPerf*(
  a0: ptr CPLLock, bEnableIn: cint
) {.cdecl, importc: "CPLLockSetDebugPerf", dynlib: gdalLib, raises: [].}

proc CPLGetTLS*(
  nIndex: cint
): pointer {.cdecl, importc: "CPLGetTLS", dynlib: gdalLib, raises: [].}

proc CPLGetTLSEx*(
  nIndex: cint, pbMemoryErrorOccurred: ptr cint
): pointer {.cdecl, importc: "CPLGetTLSEx", dynlib: gdalLib, raises: [].}

proc CPLSetTLS*(
  nIndex: cint, pData: pointer, bFreeOnExit: cint
) {.cdecl, importc: "CPLSetTLS", dynlib: gdalLib, raises: [].}

proc CPLSetTLSWithFreeFunc*(
  nIndex: cint, pData: pointer, pfnFree: CPLTLSFreeFunc
) {.cdecl, importc: "CPLSetTLSWithFreeFunc", dynlib: gdalLib, raises: [].}

proc CPLSetTLSWithFreeFuncEx*(
  nIndex: cint, pData: pointer, pfnFree: CPLTLSFreeFunc, pbMemoryErrorOccurred: ptr cint
) {.cdecl, importc: "CPLSetTLSWithFreeFuncEx", dynlib: gdalLib, raises: [].}

proc CPLCleanupTLS*() {.cdecl, importc: "CPLCleanupTLS", dynlib: gdalLib, raises: [].}
proc CPLQuadTreeCreate*(
  pGlobalBounds: ptr CPLRectObj, pfnGetBounds: CPLQuadTreeGetBoundsFunc
): ptr CPLQuadTree {.cdecl, importc: "CPLQuadTreeCreate", dynlib: gdalLib, raises: [].}

proc CPLQuadTreeCreateEx*(
  pGlobalBounds: ptr CPLRectObj,
  pfnGetBounds: CPLQuadTreeGetBoundsExFunc,
  pUserData: pointer,
): ptr CPLQuadTree {.
  cdecl, importc: "CPLQuadTreeCreateEx", dynlib: gdalLib, raises: []
.}

proc CPLQuadTreeDestroy*(
  hQuadtree: ptr CPLQuadTree
) {.cdecl, importc: "CPLQuadTreeDestroy", dynlib: gdalLib, raises: [].}

proc CPLQuadTreeSetBucketCapacity*(
  hQuadtree: ptr CPLQuadTree, nBucketCapacity: cint
) {.cdecl, importc: "CPLQuadTreeSetBucketCapacity", dynlib: gdalLib, raises: [].}

proc CPLQuadTreeForceUseOfSubNodes*(
  hQuadTree: ptr CPLQuadTree
) {.cdecl, importc: "CPLQuadTreeForceUseOfSubNodes", dynlib: gdalLib, raises: [].}

proc CPLQuadTreeGetAdvisedMaxDepth*(
  nExpectedFeatures: cint
): cint {.cdecl, importc: "CPLQuadTreeGetAdvisedMaxDepth", dynlib: gdalLib, raises: [].}

proc CPLQuadTreeSetMaxDepth*(
  hQuadtree: ptr CPLQuadTree, nMaxDepth: cint
) {.cdecl, importc: "CPLQuadTreeSetMaxDepth", dynlib: gdalLib, raises: [].}

proc CPLQuadTreeInsert*(
  hQuadtree: ptr CPLQuadTree, hFeature: pointer
) {.cdecl, importc: "CPLQuadTreeInsert", dynlib: gdalLib, raises: [].}

proc CPLQuadTreeInsertWithBounds*(
  hQuadtree: ptr CPLQuadTree, hFeature: pointer, psBounds: ptr CPLRectObj
) {.cdecl, importc: "CPLQuadTreeInsertWithBounds", dynlib: gdalLib, raises: [].}

proc CPLQuadTreeRemove*(
  hQuadtree: ptr CPLQuadTree, hFeature: pointer, psBounds: ptr CPLRectObj
) {.cdecl, importc: "CPLQuadTreeRemove", dynlib: gdalLib, raises: [].}

proc CPLQuadTreeSearch*(
  hQuadtree: ptr CPLQuadTree, pAoi: ptr CPLRectObj, pnFeatureCount: ptr cint
): ptr pointer {.cdecl, importc: "CPLQuadTreeSearch", dynlib: gdalLib, raises: [].}

proc CPLQuadTreeHasMatch*(
  hQuadtree: ptr CPLQuadTree, pAoi: ptr CPLRectObj
): bool {.cdecl, importc: "CPLQuadTreeHasMatch", dynlib: gdalLib, raises: [].}

proc CPLQuadTreeForeach*(
  hQuadtree: ptr CPLQuadTree, pfnForeach: CPLQuadTreeForeachFunc, pUserData: pointer
) {.cdecl, importc: "CPLQuadTreeForeach", dynlib: gdalLib, raises: [].}

proc CPLQuadTreeDump*(
  hQuadtree: ptr CPLQuadTree,
  pfnDumpFeatureFunc: CPLQuadTreeDumpFeatureFunc,
  pUserData: pointer,
) {.cdecl, importc: "CPLQuadTreeDump", dynlib: gdalLib, raises: [].}

proc CPLQuadTreeGetStats*(
  hQuadtree: ptr CPLQuadTree,
  pnFeatureCount: ptr cint,
  pnNodeCount: ptr cint,
  pnMaxDepth: ptr cint,
  pnMaxBucketCapacity: ptr cint,
) {.cdecl, importc: "CPLQuadTreeGetStats", dynlib: gdalLib, raises: [].}

proc CPLSpawn*(
  papszArgv: cstringArray, fin: ptr VSILFILE, fout: ptr VSILFILE, bDisplayErr: cint
): cint {.cdecl, importc: "CPLSpawn", dynlib: gdalLib, raises: [].}

proc CPLSpawnAsync*(
  pfnMain: proc(a0: CPL_FILE_HANDLE, a1: CPL_FILE_HANDLE): cint {.cdecl, raises: [].},
  papszArgv: cstringArray,
  bCreateInputPipe: cint,
  bCreateOutputPipe: cint,
  bCreateErrorPipe: cint,
  papszOptions: cstringArray,
): ptr CPLSpawnedProcess {.
  cdecl, importc: "CPLSpawnAsync", dynlib: gdalLib, raises: []
.}

proc CPLSpawnAsyncGetChildProcessId*(
  p: ptr CPLSpawnedProcess
): CPL_PID {.
  cdecl, importc: "CPLSpawnAsyncGetChildProcessId", dynlib: gdalLib, raises: []
.}

proc CPLSpawnAsyncFinish*(
  p: ptr CPLSpawnedProcess, bWait: cint, bKill: cint
): cint {.cdecl, importc: "CPLSpawnAsyncFinish", dynlib: gdalLib, raises: [].}

proc CPLSpawnAsyncGetInputFileHandle*(
  p: ptr CPLSpawnedProcess
): CPL_FILE_HANDLE {.
  cdecl, importc: "CPLSpawnAsyncGetInputFileHandle", dynlib: gdalLib, raises: []
.}

proc CPLSpawnAsyncGetOutputFileHandle*(
  p: ptr CPLSpawnedProcess
): CPL_FILE_HANDLE {.
  cdecl, importc: "CPLSpawnAsyncGetOutputFileHandle", dynlib: gdalLib, raises: []
.}

proc CPLSpawnAsyncGetErrorFileHandle*(
  p: ptr CPLSpawnedProcess
): CPL_FILE_HANDLE {.
  cdecl, importc: "CPLSpawnAsyncGetErrorFileHandle", dynlib: gdalLib, raises: []
.}

proc CPLSpawnAsyncCloseInputFileHandle*(
  p: ptr CPLSpawnedProcess
) {.cdecl, importc: "CPLSpawnAsyncCloseInputFileHandle", dynlib: gdalLib, raises: [].}

proc CPLSpawnAsyncCloseOutputFileHandle*(
  p: ptr CPLSpawnedProcess
) {.cdecl, importc: "CPLSpawnAsyncCloseOutputFileHandle", dynlib: gdalLib, raises: [].}

proc CPLSpawnAsyncCloseErrorFileHandle*(
  p: ptr CPLSpawnedProcess
) {.cdecl, importc: "CPLSpawnAsyncCloseErrorFileHandle", dynlib: gdalLib, raises: [].}

proc CPLPipeRead*(
  fin: CPL_FILE_HANDLE, data: pointer, length: cint
): cint {.cdecl, importc: "CPLPipeRead", dynlib: gdalLib, raises: [].}

proc CPLPipeWrite*(
  fout: CPL_FILE_HANDLE, data: pointer, length: cint
): cint {.cdecl, importc: "CPLPipeWrite", dynlib: gdalLib, raises: [].}

proc CPLGetPageSize*(): csize_t {.
  cdecl, importc: "CPLGetPageSize", dynlib: gdalLib, raises: []
.}

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
): ptr CPLVirtualMem {.cdecl, importc: "CPLVirtualMemNew", dynlib: gdalLib, raises: [].}

proc CPLIsVirtualMemFileMapAvailable*(): cint {.
  cdecl, importc: "CPLIsVirtualMemFileMapAvailable", dynlib: gdalLib, raises: []
.}

proc CPLVirtualMemFileMapNew*(
  fp: ptr VSILFILE,
  nOffset: vsi_l_offset,
  nLength: vsi_l_offset,
  eAccessMode: CPLVirtualMemAccessMode,
  pfnFreeUserData: CPLVirtualMemFreeUserData,
  pCbkUserData: pointer,
): ptr CPLVirtualMem {.
  cdecl, importc: "CPLVirtualMemFileMapNew", dynlib: gdalLib, raises: []
.}

proc CPLVirtualMemDerivedNew*(
  pVMemBase: ptr CPLVirtualMem,
  nOffset: vsi_l_offset,
  nSize: vsi_l_offset,
  pfnFreeUserData: CPLVirtualMemFreeUserData,
  pCbkUserData: pointer,
): ptr CPLVirtualMem {.
  cdecl, importc: "CPLVirtualMemDerivedNew", dynlib: gdalLib, raises: []
.}

proc CPLVirtualMemFree*(
  ctxt: ptr CPLVirtualMem
) {.cdecl, importc: "CPLVirtualMemFree", dynlib: gdalLib, raises: [].}

proc CPLVirtualMemGetAddr*(
  ctxt: ptr CPLVirtualMem
): pointer {.cdecl, importc: "CPLVirtualMemGetAddr", dynlib: gdalLib, raises: [].}

proc CPLVirtualMemGetSize*(
  ctxt: ptr CPLVirtualMem
): csize_t {.cdecl, importc: "CPLVirtualMemGetSize", dynlib: gdalLib, raises: [].}

proc CPLVirtualMemIsFileMapping*(
  ctxt: ptr CPLVirtualMem
): cint {.cdecl, importc: "CPLVirtualMemIsFileMapping", dynlib: gdalLib, raises: [].}

proc CPLVirtualMemGetAccessMode*(
  ctxt: ptr CPLVirtualMem
): CPLVirtualMemAccessMode {.
  cdecl, importc: "CPLVirtualMemGetAccessMode", dynlib: gdalLib, raises: []
.}

proc CPLVirtualMemGetPageSize*(
  ctxt: ptr CPLVirtualMem
): csize_t {.cdecl, importc: "CPLVirtualMemGetPageSize", dynlib: gdalLib, raises: [].}

proc CPLVirtualMemIsAccessThreadSafe*(
  ctxt: ptr CPLVirtualMem
): cint {.
  cdecl, importc: "CPLVirtualMemIsAccessThreadSafe", dynlib: gdalLib, raises: []
.}

proc CPLVirtualMemDeclareThread*(
  ctxt: ptr CPLVirtualMem
) {.cdecl, importc: "CPLVirtualMemDeclareThread", dynlib: gdalLib, raises: [].}

proc CPLVirtualMemUnDeclareThread*(
  ctxt: ptr CPLVirtualMem
) {.cdecl, importc: "CPLVirtualMemUnDeclareThread", dynlib: gdalLib, raises: [].}

proc CPLVirtualMemPin*(
  ctxt: ptr CPLVirtualMem, pAddr: pointer, nSize: csize_t, bWriteOp: cint
) {.cdecl, importc: "CPLVirtualMemPin", dynlib: gdalLib, raises: [].}

proc CPLVirtualMemManagerTerminate*() {.
  cdecl, importc: "CPLVirtualMemManagerTerminate", dynlib: gdalLib, raises: []
.}

proc VSIError*(
  err_no: VSIErrorNum, fmt: cstring
) {.cdecl, importc: "VSIError", dynlib: gdalLib, raises: [], varargs.}

proc VSIErrorReset*() {.
  gdalCall, importc: "VSIErrorReset", dynlib: gdalLib, raises: []
.}

proc VSIGetLastErrorNo*(): VSIErrorNum {.
  gdalCall, importc: "VSIGetLastErrorNo", dynlib: gdalLib, raises: []
.}

proc VSIGetLastErrorMsg*(): cstring {.
  gdalCall, importc: "VSIGetLastErrorMsg", dynlib: gdalLib, raises: []
.}

proc VSIErrorNumToString*(
  eErr: cint
): cstring {.cdecl, importc: "VSIErrorNumToString", dynlib: gdalLib, raises: [].}

proc VSIToCPLError*(
  eErrClass: CPLErr, eDefaultErrorNo: CPLErrorNum
): cint {.gdalCall, importc: "VSIToCPLError", dynlib: gdalLib, raises: [].}

proc VSIToCPLErrorWithMsg*(
  eErrClass: CPLErr, eDefaultErrorNo: CPLErrorNum, pszMsg: cstring
) {.cdecl, importc: "VSIToCPLErrorWithMsg", dynlib: gdalLib, raises: [].}

proc OGRMalloc*(
  a0: csize_t
): pointer {.cdecl, importc: "OGRMalloc", dynlib: gdalLib, raises: [].}

proc OGRCalloc*(
  a0: csize_t, a1: csize_t
): pointer {.cdecl, importc: "OGRCalloc", dynlib: gdalLib, raises: [].}

proc OGRRealloc*(
  a0: pointer, a1: csize_t
): pointer {.cdecl, importc: "OGRRealloc", dynlib: gdalLib, raises: [].}

proc OGRStrdup*(
  a0: cstring
): cstring {.cdecl, importc: "OGRStrdup", dynlib: gdalLib, raises: [].}

proc OGRFree*(a0: pointer) {.cdecl, importc: "OGRFree", dynlib: gdalLib, raises: [].}
proc OGRGeometryTypeToName*(
  eType: OGRwkbGeometryType
): cstring {.cdecl, importc: "OGRGeometryTypeToName", dynlib: gdalLib, raises: [].}

proc OGRMergeGeometryTypes*(
  eMain: OGRwkbGeometryType, eExtra: OGRwkbGeometryType
): OGRwkbGeometryType {.
  cdecl, importc: "OGRMergeGeometryTypes", dynlib: gdalLib, raises: []
.}

proc OGRMergeGeometryTypesEx*(
  eMain: OGRwkbGeometryType, eExtra: OGRwkbGeometryType, bAllowPromotingToCurves: cint
): OGRwkbGeometryType {.
  cdecl, importc: "OGRMergeGeometryTypesEx", dynlib: gdalLib, raises: []
.}

proc OGR_GT_Flatten*(
  eType: OGRwkbGeometryType
): OGRwkbGeometryType {.cdecl, importc: "OGR_GT_Flatten", dynlib: gdalLib, raises: [].}

proc OGR_GT_SetZ*(
  eType: OGRwkbGeometryType
): OGRwkbGeometryType {.cdecl, importc: "OGR_GT_SetZ", dynlib: gdalLib, raises: [].}

proc OGR_GT_SetM*(
  eType: OGRwkbGeometryType
): OGRwkbGeometryType {.cdecl, importc: "OGR_GT_SetM", dynlib: gdalLib, raises: [].}

proc OGR_GT_SetModifier*(
  eType: OGRwkbGeometryType, bSetZ: cint, bSetM: cint
): OGRwkbGeometryType {.
  cdecl, importc: "OGR_GT_SetModifier", dynlib: gdalLib, raises: []
.}

proc OGR_GT_HasZ*(
  eType: OGRwkbGeometryType
): cint {.cdecl, importc: "OGR_GT_HasZ", dynlib: gdalLib, raises: [].}

proc OGR_GT_HasM*(
  eType: OGRwkbGeometryType
): cint {.cdecl, importc: "OGR_GT_HasM", dynlib: gdalLib, raises: [].}

proc OGR_GT_IsSubClassOf*(
  eType: OGRwkbGeometryType, eSuperType: OGRwkbGeometryType
): cint {.cdecl, importc: "OGR_GT_IsSubClassOf", dynlib: gdalLib, raises: [].}

proc OGR_GT_IsCurve*(
  a0: OGRwkbGeometryType
): cint {.cdecl, importc: "OGR_GT_IsCurve", dynlib: gdalLib, raises: [].}

proc OGR_GT_IsSurface*(
  a0: OGRwkbGeometryType
): cint {.cdecl, importc: "OGR_GT_IsSurface", dynlib: gdalLib, raises: [].}

proc OGR_GT_IsNonLinear*(
  a0: OGRwkbGeometryType
): cint {.cdecl, importc: "OGR_GT_IsNonLinear", dynlib: gdalLib, raises: [].}

proc OGR_GT_GetCollection*(
  eType: OGRwkbGeometryType
): OGRwkbGeometryType {.
  cdecl, importc: "OGR_GT_GetCollection", dynlib: gdalLib, raises: []
.}

proc OGR_GT_GetSingle*(
  eType: OGRwkbGeometryType
): OGRwkbGeometryType {.
  cdecl, importc: "OGR_GT_GetSingle", dynlib: gdalLib, raises: []
.}

proc OGR_GT_GetCurve*(
  eType: OGRwkbGeometryType
): OGRwkbGeometryType {.cdecl, importc: "OGR_GT_GetCurve", dynlib: gdalLib, raises: [].}

proc OGR_GT_GetLinear*(
  eType: OGRwkbGeometryType
): OGRwkbGeometryType {.
  cdecl, importc: "OGR_GT_GetLinear", dynlib: gdalLib, raises: []
.}

proc OGR_GET_MS*(
  fSec: cfloat
): cint {.cdecl, importc: "OGR_GET_MS", dynlib: gdalLib, raises: [].}

proc OGRParseDate*(
  pszInput: cstring, psOutput: ptr OGRField, nOptions: cint
): cint {.cdecl, importc: "OGRParseDate", dynlib: gdalLib, raises: [].}

proc GDALVersionInfo*(
  a0: cstring
): cstring {.gdalCall, importc: "GDALVersionInfo", dynlib: gdalLib, raises: [].}

proc GDALCheckVersion*(
  nVersionMajor: cint, nVersionMinor: cint, pszCallingComponentName: cstring
): cint {.gdalCall, importc: "GDALCheckVersion", dynlib: gdalLib, raises: [].}

proc OGRGetGEOSVersion*(
  pnMajor: ptr cint, pnMinor: ptr cint, pnPatch: ptr cint
): bool {.cdecl, importc: "OGRGetGEOSVersion", dynlib: gdalLib, raises: [].}

proc OGRGeomCoordinatePrecisionCreate*(): OGRGeomCoordinatePrecisionH {.
  cdecl, importc: "OGRGeomCoordinatePrecisionCreate", dynlib: gdalLib, raises: []
.}

proc OGRGeomCoordinatePrecisionDestroy*(
  a0: OGRGeomCoordinatePrecisionH
) {.cdecl, importc: "OGRGeomCoordinatePrecisionDestroy", dynlib: gdalLib, raises: [].}

proc OGRGeomCoordinatePrecisionGetXYResolution*(
  a0: OGRGeomCoordinatePrecisionH
): cdouble {.
  cdecl,
  importc: "OGRGeomCoordinatePrecisionGetXYResolution",
  dynlib: gdalLib,
  raises: []
.}

proc OGRGeomCoordinatePrecisionGetZResolution*(
  a0: OGRGeomCoordinatePrecisionH
): cdouble {.
  cdecl,
  importc: "OGRGeomCoordinatePrecisionGetZResolution",
  dynlib: gdalLib,
  raises: []
.}

proc OGRGeomCoordinatePrecisionGetMResolution*(
  a0: OGRGeomCoordinatePrecisionH
): cdouble {.
  cdecl,
  importc: "OGRGeomCoordinatePrecisionGetMResolution",
  dynlib: gdalLib,
  raises: []
.}

proc OGRGeomCoordinatePrecisionGetFormats*(
  a0: OGRGeomCoordinatePrecisionH
): cstringArray {.
  cdecl, importc: "OGRGeomCoordinatePrecisionGetFormats", dynlib: gdalLib, raises: []
.}

proc OGRGeomCoordinatePrecisionGetFormatSpecificOptions*(
  a0: OGRGeomCoordinatePrecisionH, pszFormatName: cstring
): CSLConstList {.
  cdecl,
  importc: "OGRGeomCoordinatePrecisionGetFormatSpecificOptions",
  dynlib: gdalLib,
  raises: []
.}

proc OGRGeomCoordinatePrecisionSet*(
  a0: OGRGeomCoordinatePrecisionH,
  dfXYResolution: cdouble,
  dfZResolution: cdouble,
  dfMResolution: cdouble,
) {.cdecl, importc: "OGRGeomCoordinatePrecisionSet", dynlib: gdalLib, raises: [].}

proc OGRGeomCoordinatePrecisionSetFromMeter*(
  a0: OGRGeomCoordinatePrecisionH,
  hSRS: OGRSpatialReferenceH,
  dfXYMeterResolution: cdouble,
  dfZMeterResolution: cdouble,
  dfMResolution: cdouble,
) {.
  cdecl, importc: "OGRGeomCoordinatePrecisionSetFromMeter", dynlib: gdalLib, raises: []
.}

proc OGRGeomCoordinatePrecisionSetFormatSpecificOptions*(
  a0: OGRGeomCoordinatePrecisionH, pszFormatName: cstring, papszOptions: CSLConstList
) {.
  cdecl,
  importc: "OGRGeomCoordinatePrecisionSetFormatSpecificOptions",
  dynlib: gdalLib,
  raises: []
.}

proc OGR_G_CreateFromWkb*(
  a0: pointer, a1: OGRSpatialReferenceH, a2: ptr OGRGeometryH, a3: cint
): OGRErr {.cdecl, importc: "OGR_G_CreateFromWkb", dynlib: gdalLib, raises: [].}

proc OGR_G_CreateFromWkbEx*(
  a0: pointer, a1: OGRSpatialReferenceH, a2: ptr OGRGeometryH, a3: csize_t
): OGRErr {.cdecl, importc: "OGR_G_CreateFromWkbEx", dynlib: gdalLib, raises: [].}

proc OGR_G_CreateFromWkt*(
  a0: cstringArray, a1: OGRSpatialReferenceH, a2: ptr OGRGeometryH
): OGRErr {.cdecl, importc: "OGR_G_CreateFromWkt", dynlib: gdalLib, raises: [].}

proc OGR_G_CreateFromFgf*(
  a0: pointer, a1: OGRSpatialReferenceH, a2: ptr OGRGeometryH, a3: cint, a4: ptr cint
): OGRErr {.cdecl, importc: "OGR_G_CreateFromFgf", dynlib: gdalLib, raises: [].}

proc OGR_G_CreateFromEnvelope*(
  a0: cdouble, a1: cdouble, a2: cdouble, a3: cdouble, a4: OGRSpatialReferenceH
): OGRGeometryH {.
  cdecl, importc: "OGR_G_CreateFromEnvelope", dynlib: gdalLib, raises: []
.}

proc OGR_G_DestroyGeometry*(
  a0: OGRGeometryH
) {.cdecl, importc: "OGR_G_DestroyGeometry", dynlib: gdalLib, raises: [].}

proc OGR_G_CreateGeometry*(
  a0: OGRwkbGeometryType
): OGRGeometryH {.cdecl, importc: "OGR_G_CreateGeometry", dynlib: gdalLib, raises: [].}

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
): OGRGeometryH {.
  cdecl, importc: "OGR_G_ApproximateArcAngles", dynlib: gdalLib, raises: []
.}

proc OGR_G_ForceToPolygon*(
  a0: OGRGeometryH
): OGRGeometryH {.cdecl, importc: "OGR_G_ForceToPolygon", dynlib: gdalLib, raises: [].}

proc OGR_G_ForceToLineString*(
  a0: OGRGeometryH
): OGRGeometryH {.
  cdecl, importc: "OGR_G_ForceToLineString", dynlib: gdalLib, raises: []
.}

proc OGR_G_ForceToMultiPolygon*(
  a0: OGRGeometryH
): OGRGeometryH {.
  cdecl, importc: "OGR_G_ForceToMultiPolygon", dynlib: gdalLib, raises: []
.}

proc OGR_G_ForceToMultiPoint*(
  a0: OGRGeometryH
): OGRGeometryH {.
  cdecl, importc: "OGR_G_ForceToMultiPoint", dynlib: gdalLib, raises: []
.}

proc OGR_G_ForceToMultiLineString*(
  a0: OGRGeometryH
): OGRGeometryH {.
  cdecl, importc: "OGR_G_ForceToMultiLineString", dynlib: gdalLib, raises: []
.}

proc OGR_G_ForceTo*(
  hGeom: OGRGeometryH, eTargetType: OGRwkbGeometryType, papszOptions: CSLConstList
): OGRGeometryH {.cdecl, importc: "OGR_G_ForceTo", dynlib: gdalLib, raises: [].}

proc OGR_G_RemoveLowerDimensionSubGeoms*(
  hGeom: OGRGeometryH
): OGRGeometryH {.
  cdecl, importc: "OGR_G_RemoveLowerDimensionSubGeoms", dynlib: gdalLib, raises: []
.}

proc OGR_G_GetDimension*(
  a0: OGRGeometryH
): cint {.cdecl, importc: "OGR_G_GetDimension", dynlib: gdalLib, raises: [].}

proc OGR_G_GetCoordinateDimension*(
  a0: OGRGeometryH
): cint {.cdecl, importc: "OGR_G_GetCoordinateDimension", dynlib: gdalLib, raises: [].}

proc OGR_G_CoordinateDimension*(
  a0: OGRGeometryH
): cint {.cdecl, importc: "OGR_G_CoordinateDimension", dynlib: gdalLib, raises: [].}

proc OGR_G_SetCoordinateDimension*(
  a0: OGRGeometryH, a1: cint
) {.cdecl, importc: "OGR_G_SetCoordinateDimension", dynlib: gdalLib, raises: [].}

proc OGR_G_Is3D*(
  a0: OGRGeometryH
): cint {.cdecl, importc: "OGR_G_Is3D", dynlib: gdalLib, raises: [].}

proc OGR_G_IsMeasured*(
  a0: OGRGeometryH
): cint {.cdecl, importc: "OGR_G_IsMeasured", dynlib: gdalLib, raises: [].}

proc OGR_G_Set3D*(
  a0: OGRGeometryH, a1: cint
) {.cdecl, importc: "OGR_G_Set3D", dynlib: gdalLib, raises: [].}

proc OGR_G_SetMeasured*(
  a0: OGRGeometryH, a1: cint
) {.cdecl, importc: "OGR_G_SetMeasured", dynlib: gdalLib, raises: [].}

proc OGR_G_Clone*(
  a0: OGRGeometryH
): OGRGeometryH {.cdecl, importc: "OGR_G_Clone", dynlib: gdalLib, raises: [].}

proc OGR_G_GetEnvelope*(
  a0: OGRGeometryH, a1: ptr OGREnvelope
) {.cdecl, importc: "OGR_G_GetEnvelope", dynlib: gdalLib, raises: [].}

proc OGR_G_GetEnvelope3D*(
  a0: OGRGeometryH, a1: ptr OGREnvelope3D
) {.cdecl, importc: "OGR_G_GetEnvelope3D", dynlib: gdalLib, raises: [].}

proc OGR_G_ImportFromWkb*(
  a0: OGRGeometryH, a1: pointer, a2: cint
): OGRErr {.cdecl, importc: "OGR_G_ImportFromWkb", dynlib: gdalLib, raises: [].}

proc OGR_G_ExportToWkb*(
  a0: OGRGeometryH, a1: OGRwkbByteOrder, a2: ptr uint8
): OGRErr {.cdecl, importc: "OGR_G_ExportToWkb", dynlib: gdalLib, raises: [].}

proc OGR_G_ExportToIsoWkb*(
  a0: OGRGeometryH, a1: OGRwkbByteOrder, a2: ptr uint8
): OGRErr {.cdecl, importc: "OGR_G_ExportToIsoWkb", dynlib: gdalLib, raises: [].}

proc OGRwkbExportOptionsCreate*(): ptr OGRwkbExportOptions {.
  cdecl, importc: "OGRwkbExportOptionsCreate", dynlib: gdalLib, raises: []
.}

proc OGRwkbExportOptionsDestroy*(
  a0: ptr OGRwkbExportOptions
) {.cdecl, importc: "OGRwkbExportOptionsDestroy", dynlib: gdalLib, raises: [].}

proc OGRwkbExportOptionsSetByteOrder*(
  a0: ptr OGRwkbExportOptions, a1: OGRwkbByteOrder
) {.cdecl, importc: "OGRwkbExportOptionsSetByteOrder", dynlib: gdalLib, raises: [].}

proc OGRwkbExportOptionsSetVariant*(
  a0: ptr OGRwkbExportOptions, a1: OGRwkbVariant
) {.cdecl, importc: "OGRwkbExportOptionsSetVariant", dynlib: gdalLib, raises: [].}

proc OGRwkbExportOptionsSetPrecision*(
  a0: ptr OGRwkbExportOptions, a1: OGRGeomCoordinatePrecisionH
) {.cdecl, importc: "OGRwkbExportOptionsSetPrecision", dynlib: gdalLib, raises: [].}

proc OGR_G_ExportToWkbEx*(
  a0: OGRGeometryH, a1: ptr uint8, a2: ptr OGRwkbExportOptions
): OGRErr {.cdecl, importc: "OGR_G_ExportToWkbEx", dynlib: gdalLib, raises: [].}

proc OGR_G_WkbSize*(
  hGeom: OGRGeometryH
): cint {.cdecl, importc: "OGR_G_WkbSize", dynlib: gdalLib, raises: [].}

proc OGR_G_WkbSizeEx*(
  hGeom: OGRGeometryH
): csize_t {.cdecl, importc: "OGR_G_WkbSizeEx", dynlib: gdalLib, raises: [].}

proc OGR_G_ImportFromWkt*(
  a0: OGRGeometryH, a1: cstringArray
): OGRErr {.cdecl, importc: "OGR_G_ImportFromWkt", dynlib: gdalLib, raises: [].}

proc OGR_G_ExportToWkt*(
  a0: OGRGeometryH, a1: cstringArray
): OGRErr {.cdecl, importc: "OGR_G_ExportToWkt", dynlib: gdalLib, raises: [].}

proc OGR_G_ExportToIsoWkt*(
  a0: OGRGeometryH, a1: cstringArray
): OGRErr {.cdecl, importc: "OGR_G_ExportToIsoWkt", dynlib: gdalLib, raises: [].}

proc OGR_G_GetGeometryType*(
  a0: OGRGeometryH
): OGRwkbGeometryType {.
  cdecl, importc: "OGR_G_GetGeometryType", dynlib: gdalLib, raises: []
.}

proc OGR_G_GetGeometryName*(
  a0: OGRGeometryH
): cstring {.cdecl, importc: "OGR_G_GetGeometryName", dynlib: gdalLib, raises: [].}

proc OGR_G_DumpReadable*(
  a0: OGRGeometryH, a1: ptr GdalFile, a2: cstring
) {.cdecl, importc: "OGR_G_DumpReadable", dynlib: gdalLib, raises: [].}

proc OGR_G_FlattenTo2D*(
  a0: OGRGeometryH
) {.cdecl, importc: "OGR_G_FlattenTo2D", dynlib: gdalLib, raises: [].}

proc OGR_G_CloseRings*(
  a0: OGRGeometryH
) {.cdecl, importc: "OGR_G_CloseRings", dynlib: gdalLib, raises: [].}

proc OGR_G_CreateFromGML*(
  a0: cstring
): OGRGeometryH {.cdecl, importc: "OGR_G_CreateFromGML", dynlib: gdalLib, raises: [].}

proc OGR_G_ExportToGML*(
  a0: OGRGeometryH
): cstring {.cdecl, importc: "OGR_G_ExportToGML", dynlib: gdalLib, raises: [].}

proc OGR_G_ExportToGMLEx*(
  a0: OGRGeometryH, papszOptions: CSLConstList
): cstring {.cdecl, importc: "OGR_G_ExportToGMLEx", dynlib: gdalLib, raises: [].}

proc OGR_G_CreateFromGMLTree*(
  a0: ptr CPLXMLNode
): OGRGeometryH {.
  cdecl, importc: "OGR_G_CreateFromGMLTree", dynlib: gdalLib, raises: []
.}

proc OGR_G_ExportToGMLTree*(
  a0: OGRGeometryH
): ptr CPLXMLNode {.
  cdecl, importc: "OGR_G_ExportToGMLTree", dynlib: gdalLib, raises: []
.}

proc OGR_G_ExportEnvelopeToGMLTree*(
  a0: OGRGeometryH
): ptr CPLXMLNode {.
  cdecl, importc: "OGR_G_ExportEnvelopeToGMLTree", dynlib: gdalLib, raises: []
.}

proc OGR_G_ExportToKML*(
  a0: OGRGeometryH, pszAltitudeMode: cstring
): cstring {.cdecl, importc: "OGR_G_ExportToKML", dynlib: gdalLib, raises: [].}

proc OGR_G_ExportToJson*(
  a0: OGRGeometryH
): cstring {.cdecl, importc: "OGR_G_ExportToJson", dynlib: gdalLib, raises: [].}

proc OGR_G_ExportToJsonEx*(
  a0: OGRGeometryH, papszOptions: CSLConstList
): cstring {.cdecl, importc: "OGR_G_ExportToJsonEx", dynlib: gdalLib, raises: [].}

proc OGR_G_CreateGeometryFromJson*(
  a0: cstring
): OGRGeometryH {.
  cdecl, importc: "OGR_G_CreateGeometryFromJson", dynlib: gdalLib, raises: []
.}

proc OGR_G_CreateGeometryFromEsriJson*(
  a0: cstring
): OGRGeometryH {.
  cdecl, importc: "OGR_G_CreateGeometryFromEsriJson", dynlib: gdalLib, raises: []
.}

proc OGR_G_AssignSpatialReference*(
  a0: OGRGeometryH, a1: OGRSpatialReferenceH
) {.cdecl, importc: "OGR_G_AssignSpatialReference", dynlib: gdalLib, raises: [].}

proc OGR_G_GetSpatialReference*(
  a0: OGRGeometryH
): OGRSpatialReferenceH {.
  cdecl, importc: "OGR_G_GetSpatialReference", dynlib: gdalLib, raises: []
.}

proc OGR_G_Transform*(
  a0: OGRGeometryH, a1: OGRCoordinateTransformationH
): OGRErr {.cdecl, importc: "OGR_G_Transform", dynlib: gdalLib, raises: [].}

proc OGR_G_TransformTo*(
  a0: OGRGeometryH, a1: OGRSpatialReferenceH
): OGRErr {.cdecl, importc: "OGR_G_TransformTo", dynlib: gdalLib, raises: [].}

proc OGR_GeomTransformer_Create*(
  a0: OGRCoordinateTransformationH, papszOptions: CSLConstList
): OGRGeomTransformerH {.
  cdecl, importc: "OGR_GeomTransformer_Create", dynlib: gdalLib, raises: []
.}

proc OGR_GeomTransformer_Transform*(
  hTransformer: OGRGeomTransformerH, hGeom: OGRGeometryH
): OGRGeometryH {.
  cdecl, importc: "OGR_GeomTransformer_Transform", dynlib: gdalLib, raises: []
.}

proc OGR_GeomTransformer_Destroy*(
  hTransformer: OGRGeomTransformerH
) {.cdecl, importc: "OGR_GeomTransformer_Destroy", dynlib: gdalLib, raises: [].}

proc OGR_G_Simplify*(
  hThis: OGRGeometryH, tolerance: cdouble
): OGRGeometryH {.cdecl, importc: "OGR_G_Simplify", dynlib: gdalLib, raises: [].}

proc OGR_G_SimplifyPreserveTopology*(
  hThis: OGRGeometryH, tolerance: cdouble
): OGRGeometryH {.
  cdecl, importc: "OGR_G_SimplifyPreserveTopology", dynlib: gdalLib, raises: []
.}

proc OGR_G_DelaunayTriangulation*(
  hThis: OGRGeometryH, dfTolerance: cdouble, bOnlyEdges: cint
): OGRGeometryH {.
  cdecl, importc: "OGR_G_DelaunayTriangulation", dynlib: gdalLib, raises: []
.}

proc OGR_G_ConstrainedDelaunayTriangulation*(
  hThis: OGRGeometryH
): OGRGeometryH {.
  cdecl, importc: "OGR_G_ConstrainedDelaunayTriangulation", dynlib: gdalLib, raises: []
.}

proc OGR_G_Segmentize*(
  hGeom: OGRGeometryH, dfMaxLength: cdouble
) {.cdecl, importc: "OGR_G_Segmentize", dynlib: gdalLib, raises: [].}

proc OGR_G_Intersects*(
  a0: OGRGeometryH, a1: OGRGeometryH
): cint {.cdecl, importc: "OGR_G_Intersects", dynlib: gdalLib, raises: [].}

proc OGR_G_Equals*(
  a0: OGRGeometryH, a1: OGRGeometryH
): cint {.cdecl, importc: "OGR_G_Equals", dynlib: gdalLib, raises: [].}

proc OGR_G_Disjoint*(
  a0: OGRGeometryH, a1: OGRGeometryH
): cint {.cdecl, importc: "OGR_G_Disjoint", dynlib: gdalLib, raises: [].}

proc OGR_G_Touches*(
  a0: OGRGeometryH, a1: OGRGeometryH
): cint {.cdecl, importc: "OGR_G_Touches", dynlib: gdalLib, raises: [].}

proc OGR_G_Crosses*(
  a0: OGRGeometryH, a1: OGRGeometryH
): cint {.cdecl, importc: "OGR_G_Crosses", dynlib: gdalLib, raises: [].}

proc OGR_G_Within*(
  a0: OGRGeometryH, a1: OGRGeometryH
): cint {.cdecl, importc: "OGR_G_Within", dynlib: gdalLib, raises: [].}

proc OGR_G_Contains*(
  a0: OGRGeometryH, a1: OGRGeometryH
): cint {.cdecl, importc: "OGR_G_Contains", dynlib: gdalLib, raises: [].}

proc OGR_G_Overlaps*(
  a0: OGRGeometryH, a1: OGRGeometryH
): cint {.cdecl, importc: "OGR_G_Overlaps", dynlib: gdalLib, raises: [].}

proc OGR_G_Boundary*(
  a0: OGRGeometryH
): OGRGeometryH {.cdecl, importc: "OGR_G_Boundary", dynlib: gdalLib, raises: [].}

proc OGR_G_ConvexHull*(
  a0: OGRGeometryH
): OGRGeometryH {.cdecl, importc: "OGR_G_ConvexHull", dynlib: gdalLib, raises: [].}

proc OGR_G_ConcaveHull*(
  a0: OGRGeometryH, dfRatio: cdouble, bAllowHoles: bool
): OGRGeometryH {.cdecl, importc: "OGR_G_ConcaveHull", dynlib: gdalLib, raises: [].}

proc OGR_G_ConcaveHullOfPolygons*(
  a0: OGRGeometryH, dfLengthRatio: cdouble, bIsTight: bool, bAllowHoles: bool
): OGRGeometryH {.
  cdecl, importc: "OGR_G_ConcaveHullOfPolygons", dynlib: gdalLib, raises: []
.}

proc OGR_G_Buffer*(
  a0: OGRGeometryH, dfDist: cdouble, nQuadSegs: cint
): OGRGeometryH {.cdecl, importc: "OGR_G_Buffer", dynlib: gdalLib, raises: [].}

proc OGR_G_BufferEx*(
  a0: OGRGeometryH, dfDist: cdouble, papszOptions: CSLConstList
): OGRGeometryH {.cdecl, importc: "OGR_G_BufferEx", dynlib: gdalLib, raises: [].}

proc OGR_G_Intersection*(
  a0: OGRGeometryH, a1: OGRGeometryH
): OGRGeometryH {.cdecl, importc: "OGR_G_Intersection", dynlib: gdalLib, raises: [].}

proc OGR_G_Union*(
  a0: OGRGeometryH, a1: OGRGeometryH
): OGRGeometryH {.cdecl, importc: "OGR_G_Union", dynlib: gdalLib, raises: [].}

proc OGR_G_UnionCascaded*(
  a0: OGRGeometryH
): OGRGeometryH {.cdecl, importc: "OGR_G_UnionCascaded", dynlib: gdalLib, raises: [].}

proc OGR_G_UnaryUnion*(
  a0: OGRGeometryH
): OGRGeometryH {.cdecl, importc: "OGR_G_UnaryUnion", dynlib: gdalLib, raises: [].}

proc OGR_G_PointOnSurface*(
  a0: OGRGeometryH
): OGRGeometryH {.cdecl, importc: "OGR_G_PointOnSurface", dynlib: gdalLib, raises: [].}

proc OGR_G_Difference*(
  a0: OGRGeometryH, a1: OGRGeometryH
): OGRGeometryH {.cdecl, importc: "OGR_G_Difference", dynlib: gdalLib, raises: [].}

proc OGR_G_SymDifference*(
  a0: OGRGeometryH, a1: OGRGeometryH
): OGRGeometryH {.cdecl, importc: "OGR_G_SymDifference", dynlib: gdalLib, raises: [].}

proc OGR_G_Distance*(
  a0: OGRGeometryH, a1: OGRGeometryH
): cdouble {.cdecl, importc: "OGR_G_Distance", dynlib: gdalLib, raises: [].}

proc OGR_G_Distance3D*(
  a0: OGRGeometryH, a1: OGRGeometryH
): cdouble {.cdecl, importc: "OGR_G_Distance3D", dynlib: gdalLib, raises: [].}

proc OGR_G_Length*(
  a0: OGRGeometryH
): cdouble {.cdecl, importc: "OGR_G_Length", dynlib: gdalLib, raises: [].}

proc OGR_G_GeodesicLength*(
  a0: OGRGeometryH
): cdouble {.cdecl, importc: "OGR_G_GeodesicLength", dynlib: gdalLib, raises: [].}

proc OGR_G_Area*(
  a0: OGRGeometryH
): cdouble {.cdecl, importc: "OGR_G_Area", dynlib: gdalLib, raises: [].}

proc OGR_G_GeodesicArea*(
  a0: OGRGeometryH
): cdouble {.cdecl, importc: "OGR_G_GeodesicArea", dynlib: gdalLib, raises: [].}

proc OGR_G_IsClockwise*(
  hGeom: OGRGeometryH
): bool {.cdecl, importc: "OGR_G_IsClockwise", dynlib: gdalLib, raises: [].}

proc OGR_G_Centroid*(
  a0: OGRGeometryH, a1: OGRGeometryH
): cint {.cdecl, importc: "OGR_G_Centroid", dynlib: gdalLib, raises: [].}

proc OGR_G_Value*(
  a0: OGRGeometryH, dfDistance: cdouble
): OGRGeometryH {.cdecl, importc: "OGR_G_Value", dynlib: gdalLib, raises: [].}

proc OGR_G_Empty*(
  a0: OGRGeometryH
) {.cdecl, importc: "OGR_G_Empty", dynlib: gdalLib, raises: [].}

proc OGR_G_IsEmpty*(
  a0: OGRGeometryH
): cint {.cdecl, importc: "OGR_G_IsEmpty", dynlib: gdalLib, raises: [].}

proc OGR_G_IsValid*(
  a0: OGRGeometryH
): cint {.cdecl, importc: "OGR_G_IsValid", dynlib: gdalLib, raises: [].}

proc OGR_G_GetInvalidityReason*(
  a0: OGRGeometryH
): cstring {.cdecl, importc: "OGR_G_GetInvalidityReason", dynlib: gdalLib, raises: [].}

proc OGR_G_MakeValid*(
  a0: OGRGeometryH
): OGRGeometryH {.cdecl, importc: "OGR_G_MakeValid", dynlib: gdalLib, raises: [].}

proc OGR_G_MakeValidEx*(
  a0: OGRGeometryH, a1: CSLConstList
): OGRGeometryH {.cdecl, importc: "OGR_G_MakeValidEx", dynlib: gdalLib, raises: [].}

proc OGR_G_Normalize*(
  a0: OGRGeometryH
): OGRGeometryH {.cdecl, importc: "OGR_G_Normalize", dynlib: gdalLib, raises: [].}

proc OGR_G_IsSimple*(
  a0: OGRGeometryH
): cint {.cdecl, importc: "OGR_G_IsSimple", dynlib: gdalLib, raises: [].}

proc OGR_G_IsRing*(
  a0: OGRGeometryH
): cint {.cdecl, importc: "OGR_G_IsRing", dynlib: gdalLib, raises: [].}

proc OGR_G_SetPrecision*(
  a0: OGRGeometryH, dfGridSize: cdouble, nFlags: cint
): OGRGeometryH {.cdecl, importc: "OGR_G_SetPrecision", dynlib: gdalLib, raises: [].}

proc OGR_G_Polygonize*(
  a0: OGRGeometryH
): OGRGeometryH {.cdecl, importc: "OGR_G_Polygonize", dynlib: gdalLib, raises: [].}

proc OGR_G_BuildArea*(
  a0: OGRGeometryH
): OGRGeometryH {.cdecl, importc: "OGR_G_BuildArea", dynlib: gdalLib, raises: [].}

proc OGR_G_Intersect*(
  a0: OGRGeometryH, a1: OGRGeometryH
): cint {.cdecl, importc: "OGR_G_Intersect", dynlib: gdalLib, raises: [].}

proc OGR_G_Equal*(
  a0: OGRGeometryH, a1: OGRGeometryH
): cint {.cdecl, importc: "OGR_G_Equal", dynlib: gdalLib, raises: [].}

proc OGR_G_SymmetricDifference*(
  a0: OGRGeometryH, a1: OGRGeometryH
): OGRGeometryH {.
  cdecl, importc: "OGR_G_SymmetricDifference", dynlib: gdalLib, raises: []
.}

proc OGR_G_GetArea*(
  a0: OGRGeometryH
): cdouble {.cdecl, importc: "OGR_G_GetArea", dynlib: gdalLib, raises: [].}

proc OGR_G_GetBoundary*(
  a0: OGRGeometryH
): OGRGeometryH {.cdecl, importc: "OGR_G_GetBoundary", dynlib: gdalLib, raises: [].}

proc OGR_G_GetPointCount*(
  a0: OGRGeometryH
): cint {.cdecl, importc: "OGR_G_GetPointCount", dynlib: gdalLib, raises: [].}

proc OGR_G_GetPoints*(
  hGeom: OGRGeometryH,
  pabyX: pointer,
  nXStride: cint,
  pabyY: pointer,
  nYStride: cint,
  pabyZ: pointer,
  nZStride: cint,
): cint {.cdecl, importc: "OGR_G_GetPoints", dynlib: gdalLib, raises: [].}

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
): cint {.cdecl, importc: "OGR_G_GetPointsZM", dynlib: gdalLib, raises: [].}

proc OGR_G_GetX*(
  a0: OGRGeometryH, a1: cint
): cdouble {.cdecl, importc: "OGR_G_GetX", dynlib: gdalLib, raises: [].}

proc OGR_G_GetY*(
  a0: OGRGeometryH, a1: cint
): cdouble {.cdecl, importc: "OGR_G_GetY", dynlib: gdalLib, raises: [].}

proc OGR_G_GetZ*(
  a0: OGRGeometryH, a1: cint
): cdouble {.cdecl, importc: "OGR_G_GetZ", dynlib: gdalLib, raises: [].}

proc OGR_G_GetM*(
  a0: OGRGeometryH, a1: cint
): cdouble {.cdecl, importc: "OGR_G_GetM", dynlib: gdalLib, raises: [].}

proc OGR_G_GetPoint*(
  a0: OGRGeometryH, iPoint: cint, a2: ptr cdouble, a3: ptr cdouble, a4: ptr cdouble
) {.cdecl, importc: "OGR_G_GetPoint", dynlib: gdalLib, raises: [].}

proc OGR_G_GetPointZM*(
  a0: OGRGeometryH,
  iPoint: cint,
  a2: ptr cdouble,
  a3: ptr cdouble,
  a4: ptr cdouble,
  a5: ptr cdouble,
) {.cdecl, importc: "OGR_G_GetPointZM", dynlib: gdalLib, raises: [].}

proc OGR_G_SetPointCount*(
  hGeom: OGRGeometryH, nNewPointCount: cint
): OGRErr {.cdecl, importc: "OGR_G_SetPointCount", dynlib: gdalLib, raises: [].}

proc OGR_G_SetPoint*(
  a0: OGRGeometryH, iPoint: cint, a2: cdouble, a3: cdouble, a4: cdouble
): OGRErr {.cdecl, importc: "OGR_G_SetPoint", dynlib: gdalLib, raises: [].}

proc OGR_G_SetPoint_2D*(
  a0: OGRGeometryH, iPoint: cint, a2: cdouble, a3: cdouble
): OGRErr {.cdecl, importc: "OGR_G_SetPoint_2D", dynlib: gdalLib, raises: [].}

proc OGR_G_SetPointM*(
  a0: OGRGeometryH, iPoint: cint, a2: cdouble, a3: cdouble, a4: cdouble
): OGRErr {.cdecl, importc: "OGR_G_SetPointM", dynlib: gdalLib, raises: [].}

proc OGR_G_SetPointZM*(
  a0: OGRGeometryH, iPoint: cint, a2: cdouble, a3: cdouble, a4: cdouble, a5: cdouble
): OGRErr {.cdecl, importc: "OGR_G_SetPointZM", dynlib: gdalLib, raises: [].}

proc OGR_G_AddPoint*(
  a0: OGRGeometryH, a1: cdouble, a2: cdouble, a3: cdouble
): OGRErr {.cdecl, importc: "OGR_G_AddPoint", dynlib: gdalLib, raises: [].}

proc OGR_G_AddPoint_2D*(
  a0: OGRGeometryH, a1: cdouble, a2: cdouble
): OGRErr {.cdecl, importc: "OGR_G_AddPoint_2D", dynlib: gdalLib, raises: [].}

proc OGR_G_AddPointM*(
  a0: OGRGeometryH, a1: cdouble, a2: cdouble, a3: cdouble
): OGRErr {.cdecl, importc: "OGR_G_AddPointM", dynlib: gdalLib, raises: [].}

proc OGR_G_AddPointZM*(
  a0: OGRGeometryH, a1: cdouble, a2: cdouble, a3: cdouble, a4: cdouble
): OGRErr {.cdecl, importc: "OGR_G_AddPointZM", dynlib: gdalLib, raises: [].}

proc OGR_G_SetPoints*(
  hGeom: OGRGeometryH,
  nPointsIn: cint,
  pabyX: pointer,
  nXStride: cint,
  pabyY: pointer,
  nYStride: cint,
  pabyZ: pointer,
  nZStride: cint,
): OGRErr {.cdecl, importc: "OGR_G_SetPoints", dynlib: gdalLib, raises: [].}

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
): OGRErr {.cdecl, importc: "OGR_G_SetPointsZM", dynlib: gdalLib, raises: [].}

proc OGR_G_SwapXY*(
  hGeom: OGRGeometryH
) {.cdecl, importc: "OGR_G_SwapXY", dynlib: gdalLib, raises: [].}

proc OGR_G_GetGeometryCount*(
  a0: OGRGeometryH
): cint {.cdecl, importc: "OGR_G_GetGeometryCount", dynlib: gdalLib, raises: [].}

proc OGR_G_GetGeometryRef*(
  a0: OGRGeometryH, a1: cint
): OGRGeometryH {.cdecl, importc: "OGR_G_GetGeometryRef", dynlib: gdalLib, raises: [].}

proc OGR_G_AddGeometry*(
  a0: OGRGeometryH, a1: OGRGeometryH
): OGRErr {.cdecl, importc: "OGR_G_AddGeometry", dynlib: gdalLib, raises: [].}

proc OGR_G_AddGeometryDirectly*(
  a0: OGRGeometryH, a1: OGRGeometryH
): OGRErr {.cdecl, importc: "OGR_G_AddGeometryDirectly", dynlib: gdalLib, raises: [].}

proc OGR_G_RemoveGeometry*(
  a0: OGRGeometryH, a1: cint, a2: cint
): OGRErr {.cdecl, importc: "OGR_G_RemoveGeometry", dynlib: gdalLib, raises: [].}

proc OGR_G_HasCurveGeometry*(
  a0: OGRGeometryH, bLookForNonLinear: cint
): cint {.cdecl, importc: "OGR_G_HasCurveGeometry", dynlib: gdalLib, raises: [].}

proc OGR_G_GetLinearGeometry*(
  hGeom: OGRGeometryH, dfMaxAngleStepSizeDegrees: cdouble, papszOptions: CSLConstList
): OGRGeometryH {.
  cdecl, importc: "OGR_G_GetLinearGeometry", dynlib: gdalLib, raises: []
.}

proc OGR_G_GetCurveGeometry*(
  hGeom: OGRGeometryH, papszOptions: CSLConstList
): OGRGeometryH {.
  cdecl, importc: "OGR_G_GetCurveGeometry", dynlib: gdalLib, raises: []
.}

proc OGRBuildPolygonFromEdges*(
  hLinesAsCollection: OGRGeometryH,
  bBestEffort: cint,
  bAutoClose: cint,
  dfTolerance: cdouble,
  peErr: ptr OGRErr,
): OGRGeometryH {.
  cdecl, importc: "OGRBuildPolygonFromEdges", dynlib: gdalLib, raises: []
.}

proc OGRSetGenerate_DB2_V72_BYTE_ORDER*(
  bGenerate_DB2_V72_BYTE_ORDER: cint
): OGRErr {.
  cdecl, importc: "OGRSetGenerate_DB2_V72_BYTE_ORDER", dynlib: gdalLib, raises: []
.}

proc OGRGetGenerate_DB2_V72_BYTE_ORDER*(): cint {.
  cdecl, importc: "OGRGetGenerate_DB2_V72_BYTE_ORDER", dynlib: gdalLib, raises: []
.}

proc OGRSetNonLinearGeometriesEnabledFlag*(
  bFlag: cint
) {.
  cdecl, importc: "OGRSetNonLinearGeometriesEnabledFlag", dynlib: gdalLib, raises: []
.}

proc OGRGetNonLinearGeometriesEnabledFlag*(): cint {.
  cdecl, importc: "OGRGetNonLinearGeometriesEnabledFlag", dynlib: gdalLib, raises: []
.}

proc OGRHasPreparedGeometrySupport*(): cint {.
  cdecl, importc: "OGRHasPreparedGeometrySupport", dynlib: gdalLib, raises: []
.}

proc OGRCreatePreparedGeometry*(
  hGeom: OGRGeometryH
): OGRPreparedGeometryH {.
  cdecl, importc: "OGRCreatePreparedGeometry", dynlib: gdalLib, raises: []
.}

proc OGRDestroyPreparedGeometry*(
  hPreparedGeom: OGRPreparedGeometryH
) {.cdecl, importc: "OGRDestroyPreparedGeometry", dynlib: gdalLib, raises: [].}

proc OGRPreparedGeometryIntersects*(
  hPreparedGeom: OGRPreparedGeometryH, hOtherGeom: OGRGeometryH
): cint {.cdecl, importc: "OGRPreparedGeometryIntersects", dynlib: gdalLib, raises: [].}

proc OGRPreparedGeometryContains*(
  hPreparedGeom: OGRPreparedGeometryH, hOtherGeom: OGRGeometryH
): cint {.cdecl, importc: "OGRPreparedGeometryContains", dynlib: gdalLib, raises: [].}

proc OGR_Fld_Create*(
  a0: cstring, a1: OGRFieldType
): OGRFieldDefnH {.cdecl, importc: "OGR_Fld_Create", dynlib: gdalLib, raises: [].}

proc OGR_Fld_Destroy*(
  a0: OGRFieldDefnH
) {.cdecl, importc: "OGR_Fld_Destroy", dynlib: gdalLib, raises: [].}

proc OGR_Fld_SetName*(
  a0: OGRFieldDefnH, a1: cstring
) {.cdecl, importc: "OGR_Fld_SetName", dynlib: gdalLib, raises: [].}

proc OGR_Fld_GetNameRef*(
  a0: OGRFieldDefnH
): cstring {.cdecl, importc: "OGR_Fld_GetNameRef", dynlib: gdalLib, raises: [].}

proc OGR_Fld_SetAlternativeName*(
  a0: OGRFieldDefnH, a1: cstring
) {.cdecl, importc: "OGR_Fld_SetAlternativeName", dynlib: gdalLib, raises: [].}

proc OGR_Fld_GetAlternativeNameRef*(
  a0: OGRFieldDefnH
): cstring {.
  cdecl, importc: "OGR_Fld_GetAlternativeNameRef", dynlib: gdalLib, raises: []
.}

proc OGR_Fld_GetType*(
  a0: OGRFieldDefnH
): OGRFieldType {.cdecl, importc: "OGR_Fld_GetType", dynlib: gdalLib, raises: [].}

proc OGR_Fld_SetType*(
  a0: OGRFieldDefnH, a1: OGRFieldType
) {.cdecl, importc: "OGR_Fld_SetType", dynlib: gdalLib, raises: [].}

proc OGR_Fld_GetSubType*(
  a0: OGRFieldDefnH
): OGRFieldSubType {.cdecl, importc: "OGR_Fld_GetSubType", dynlib: gdalLib, raises: [].}

proc OGR_Fld_SetSubType*(
  a0: OGRFieldDefnH, a1: OGRFieldSubType
) {.cdecl, importc: "OGR_Fld_SetSubType", dynlib: gdalLib, raises: [].}

proc OGR_Fld_GetJustify*(
  a0: OGRFieldDefnH
): OGRJustification {.
  cdecl, importc: "OGR_Fld_GetJustify", dynlib: gdalLib, raises: []
.}

proc OGR_Fld_SetJustify*(
  a0: OGRFieldDefnH, a1: OGRJustification
) {.cdecl, importc: "OGR_Fld_SetJustify", dynlib: gdalLib, raises: [].}

proc OGR_Fld_GetWidth*(
  a0: OGRFieldDefnH
): cint {.cdecl, importc: "OGR_Fld_GetWidth", dynlib: gdalLib, raises: [].}

proc OGR_Fld_SetWidth*(
  a0: OGRFieldDefnH, a1: cint
) {.cdecl, importc: "OGR_Fld_SetWidth", dynlib: gdalLib, raises: [].}

proc OGR_Fld_GetPrecision*(
  a0: OGRFieldDefnH
): cint {.cdecl, importc: "OGR_Fld_GetPrecision", dynlib: gdalLib, raises: [].}

proc OGR_Fld_SetPrecision*(
  a0: OGRFieldDefnH, a1: cint
) {.cdecl, importc: "OGR_Fld_SetPrecision", dynlib: gdalLib, raises: [].}

proc OGR_Fld_GetTZFlag*(
  a0: OGRFieldDefnH
): cint {.cdecl, importc: "OGR_Fld_GetTZFlag", dynlib: gdalLib, raises: [].}

proc OGR_Fld_SetTZFlag*(
  a0: OGRFieldDefnH, a1: cint
) {.cdecl, importc: "OGR_Fld_SetTZFlag", dynlib: gdalLib, raises: [].}

proc OGR_Fld_Set*(
  a0: OGRFieldDefnH,
  a1: cstring,
  a2: OGRFieldType,
  a3: cint,
  a4: cint,
  a5: OGRJustification,
) {.cdecl, importc: "OGR_Fld_Set", dynlib: gdalLib, raises: [].}

proc OGR_Fld_IsIgnored*(
  hDefn: OGRFieldDefnH
): cint {.cdecl, importc: "OGR_Fld_IsIgnored", dynlib: gdalLib, raises: [].}

proc OGR_Fld_SetIgnored*(
  hDefn: OGRFieldDefnH, a1: cint
) {.cdecl, importc: "OGR_Fld_SetIgnored", dynlib: gdalLib, raises: [].}

proc OGR_Fld_IsNullable*(
  hDefn: OGRFieldDefnH
): cint {.cdecl, importc: "OGR_Fld_IsNullable", dynlib: gdalLib, raises: [].}

proc OGR_Fld_SetNullable*(
  hDefn: OGRFieldDefnH, a1: cint
) {.cdecl, importc: "OGR_Fld_SetNullable", dynlib: gdalLib, raises: [].}

proc OGR_Fld_SetGenerated*(
  hDefn: OGRFieldDefnH, a1: cint
) {.cdecl, importc: "OGR_Fld_SetGenerated", dynlib: gdalLib, raises: [].}

proc OGR_Fld_IsGenerated*(
  hDefn: OGRFieldDefnH
): cint {.cdecl, importc: "OGR_Fld_IsGenerated", dynlib: gdalLib, raises: [].}

proc OGR_Fld_IsUnique*(
  hDefn: OGRFieldDefnH
): cint {.cdecl, importc: "OGR_Fld_IsUnique", dynlib: gdalLib, raises: [].}

proc OGR_Fld_SetUnique*(
  hDefn: OGRFieldDefnH, a1: cint
) {.cdecl, importc: "OGR_Fld_SetUnique", dynlib: gdalLib, raises: [].}

proc OGR_Fld_GetDefault*(
  hDefn: OGRFieldDefnH
): cstring {.cdecl, importc: "OGR_Fld_GetDefault", dynlib: gdalLib, raises: [].}

proc OGR_Fld_SetDefault*(
  hDefn: OGRFieldDefnH, a1: cstring
) {.cdecl, importc: "OGR_Fld_SetDefault", dynlib: gdalLib, raises: [].}

proc OGR_Fld_IsDefaultDriverSpecific*(
  hDefn: OGRFieldDefnH
): cint {.
  cdecl, importc: "OGR_Fld_IsDefaultDriverSpecific", dynlib: gdalLib, raises: []
.}

proc OGR_Fld_GetDomainName*(
  hDefn: OGRFieldDefnH
): cstring {.cdecl, importc: "OGR_Fld_GetDomainName", dynlib: gdalLib, raises: [].}

proc OGR_Fld_SetDomainName*(
  hDefn: OGRFieldDefnH, a1: cstring
) {.cdecl, importc: "OGR_Fld_SetDomainName", dynlib: gdalLib, raises: [].}

proc OGR_Fld_GetComment*(
  hDefn: OGRFieldDefnH
): cstring {.cdecl, importc: "OGR_Fld_GetComment", dynlib: gdalLib, raises: [].}

proc OGR_Fld_SetComment*(
  hDefn: OGRFieldDefnH, a1: cstring
) {.cdecl, importc: "OGR_Fld_SetComment", dynlib: gdalLib, raises: [].}

proc OGR_GetFieldTypeName*(
  a0: OGRFieldType
): cstring {.cdecl, importc: "OGR_GetFieldTypeName", dynlib: gdalLib, raises: [].}

proc OGR_GetFieldTypeByName*(
  a0: cstring
): OGRFieldType {.
  cdecl, importc: "OGR_GetFieldTypeByName", dynlib: gdalLib, raises: []
.}

proc OGR_GetFieldSubTypeName*(
  a0: OGRFieldSubType
): cstring {.cdecl, importc: "OGR_GetFieldSubTypeName", dynlib: gdalLib, raises: [].}

proc OGR_GetFieldSubTypeByName*(
  a0: cstring
): OGRFieldSubType {.
  cdecl, importc: "OGR_GetFieldSubTypeByName", dynlib: gdalLib, raises: []
.}

proc OGR_AreTypeSubTypeCompatible*(
  eType: OGRFieldType, eSubType: OGRFieldSubType
): cint {.cdecl, importc: "OGR_AreTypeSubTypeCompatible", dynlib: gdalLib, raises: [].}

proc OGR_GFld_Create*(
  a0: cstring, a1: OGRwkbGeometryType
): OGRGeomFieldDefnH {.cdecl, importc: "OGR_GFld_Create", dynlib: gdalLib, raises: [].}

proc OGR_GFld_Destroy*(
  a0: OGRGeomFieldDefnH
) {.cdecl, importc: "OGR_GFld_Destroy", dynlib: gdalLib, raises: [].}

proc OGR_GFld_SetName*(
  a0: OGRGeomFieldDefnH, a1: cstring
) {.cdecl, importc: "OGR_GFld_SetName", dynlib: gdalLib, raises: [].}

proc OGR_GFld_GetNameRef*(
  a0: OGRGeomFieldDefnH
): cstring {.cdecl, importc: "OGR_GFld_GetNameRef", dynlib: gdalLib, raises: [].}

proc OGR_GFld_GetType*(
  a0: OGRGeomFieldDefnH
): OGRwkbGeometryType {.
  cdecl, importc: "OGR_GFld_GetType", dynlib: gdalLib, raises: []
.}

proc OGR_GFld_SetType*(
  a0: OGRGeomFieldDefnH, a1: OGRwkbGeometryType
) {.cdecl, importc: "OGR_GFld_SetType", dynlib: gdalLib, raises: [].}

proc OGR_GFld_GetSpatialRef*(
  a0: OGRGeomFieldDefnH
): OGRSpatialReferenceH {.
  cdecl, importc: "OGR_GFld_GetSpatialRef", dynlib: gdalLib, raises: []
.}

proc OGR_GFld_SetSpatialRef*(
  a0: OGRGeomFieldDefnH, hSRS: OGRSpatialReferenceH
) {.cdecl, importc: "OGR_GFld_SetSpatialRef", dynlib: gdalLib, raises: [].}

proc OGR_GFld_IsNullable*(
  hDefn: OGRGeomFieldDefnH
): cint {.cdecl, importc: "OGR_GFld_IsNullable", dynlib: gdalLib, raises: [].}

proc OGR_GFld_SetNullable*(
  hDefn: OGRGeomFieldDefnH, a1: cint
) {.cdecl, importc: "OGR_GFld_SetNullable", dynlib: gdalLib, raises: [].}

proc OGR_GFld_IsIgnored*(
  hDefn: OGRGeomFieldDefnH
): cint {.cdecl, importc: "OGR_GFld_IsIgnored", dynlib: gdalLib, raises: [].}

proc OGR_GFld_SetIgnored*(
  hDefn: OGRGeomFieldDefnH, a1: cint
) {.cdecl, importc: "OGR_GFld_SetIgnored", dynlib: gdalLib, raises: [].}

proc OGR_GFld_GetCoordinatePrecision*(
  a0: OGRGeomFieldDefnH
): OGRGeomCoordinatePrecisionH {.
  cdecl, importc: "OGR_GFld_GetCoordinatePrecision", dynlib: gdalLib, raises: []
.}

proc OGR_GFld_SetCoordinatePrecision*(
  a0: OGRGeomFieldDefnH, a1: OGRGeomCoordinatePrecisionH
) {.cdecl, importc: "OGR_GFld_SetCoordinatePrecision", dynlib: gdalLib, raises: [].}

proc OGR_FD_Create*(
  a0: cstring
): OGRFeatureDefnH {.cdecl, importc: "OGR_FD_Create", dynlib: gdalLib, raises: [].}

proc OGR_FD_Destroy*(
  a0: OGRFeatureDefnH
) {.cdecl, importc: "OGR_FD_Destroy", dynlib: gdalLib, raises: [].}

proc OGR_FD_Release*(
  a0: OGRFeatureDefnH
) {.cdecl, importc: "OGR_FD_Release", dynlib: gdalLib, raises: [].}

proc OGR_FD_GetName*(
  a0: OGRFeatureDefnH
): cstring {.cdecl, importc: "OGR_FD_GetName", dynlib: gdalLib, raises: [].}

proc OGR_FD_GetFieldCount*(
  a0: OGRFeatureDefnH
): cint {.cdecl, importc: "OGR_FD_GetFieldCount", dynlib: gdalLib, raises: [].}

proc OGR_FD_GetFieldDefn*(
  a0: OGRFeatureDefnH, a1: cint
): OGRFieldDefnH {.cdecl, importc: "OGR_FD_GetFieldDefn", dynlib: gdalLib, raises: [].}

proc OGR_FD_GetFieldIndex*(
  a0: OGRFeatureDefnH, a1: cstring
): cint {.cdecl, importc: "OGR_FD_GetFieldIndex", dynlib: gdalLib, raises: [].}

proc OGR_FD_AddFieldDefn*(
  a0: OGRFeatureDefnH, a1: OGRFieldDefnH
) {.cdecl, importc: "OGR_FD_AddFieldDefn", dynlib: gdalLib, raises: [].}

proc OGR_FD_DeleteFieldDefn*(
  hDefn: OGRFeatureDefnH, iField: cint
): OGRErr {.cdecl, importc: "OGR_FD_DeleteFieldDefn", dynlib: gdalLib, raises: [].}

proc OGR_FD_ReorderFieldDefns*(
  hDefn: OGRFeatureDefnH, panMap: ptr cint
): OGRErr {.cdecl, importc: "OGR_FD_ReorderFieldDefns", dynlib: gdalLib, raises: [].}

proc OGR_FD_GetGeomType*(
  a0: OGRFeatureDefnH
): OGRwkbGeometryType {.
  cdecl, importc: "OGR_FD_GetGeomType", dynlib: gdalLib, raises: []
.}

proc OGR_FD_SetGeomType*(
  a0: OGRFeatureDefnH, a1: OGRwkbGeometryType
) {.cdecl, importc: "OGR_FD_SetGeomType", dynlib: gdalLib, raises: [].}

proc OGR_FD_IsGeometryIgnored*(
  a0: OGRFeatureDefnH
): cint {.cdecl, importc: "OGR_FD_IsGeometryIgnored", dynlib: gdalLib, raises: [].}

proc OGR_FD_SetGeometryIgnored*(
  a0: OGRFeatureDefnH, a1: cint
) {.cdecl, importc: "OGR_FD_SetGeometryIgnored", dynlib: gdalLib, raises: [].}

proc OGR_FD_IsStyleIgnored*(
  a0: OGRFeatureDefnH
): cint {.cdecl, importc: "OGR_FD_IsStyleIgnored", dynlib: gdalLib, raises: [].}

proc OGR_FD_SetStyleIgnored*(
  a0: OGRFeatureDefnH, a1: cint
) {.cdecl, importc: "OGR_FD_SetStyleIgnored", dynlib: gdalLib, raises: [].}

proc OGR_FD_Reference*(
  a0: OGRFeatureDefnH
): cint {.cdecl, importc: "OGR_FD_Reference", dynlib: gdalLib, raises: [].}

proc OGR_FD_Dereference*(
  a0: OGRFeatureDefnH
): cint {.cdecl, importc: "OGR_FD_Dereference", dynlib: gdalLib, raises: [].}

proc OGR_FD_GetReferenceCount*(
  a0: OGRFeatureDefnH
): cint {.cdecl, importc: "OGR_FD_GetReferenceCount", dynlib: gdalLib, raises: [].}

proc OGR_FD_GetGeomFieldCount*(
  hFDefn: OGRFeatureDefnH
): cint {.cdecl, importc: "OGR_FD_GetGeomFieldCount", dynlib: gdalLib, raises: [].}

proc OGR_FD_GetGeomFieldDefn*(
  hFDefn: OGRFeatureDefnH, i: cint
): OGRGeomFieldDefnH {.
  cdecl, importc: "OGR_FD_GetGeomFieldDefn", dynlib: gdalLib, raises: []
.}

proc OGR_FD_GetGeomFieldIndex*(
  hFDefn: OGRFeatureDefnH, pszName: cstring
): cint {.cdecl, importc: "OGR_FD_GetGeomFieldIndex", dynlib: gdalLib, raises: [].}

proc OGR_FD_AddGeomFieldDefn*(
  hFDefn: OGRFeatureDefnH, hGFldDefn: OGRGeomFieldDefnH
) {.cdecl, importc: "OGR_FD_AddGeomFieldDefn", dynlib: gdalLib, raises: [].}

proc OGR_FD_DeleteGeomFieldDefn*(
  hFDefn: OGRFeatureDefnH, iGeomField: cint
): OGRErr {.cdecl, importc: "OGR_FD_DeleteGeomFieldDefn", dynlib: gdalLib, raises: [].}

proc OGR_FD_IsSame*(
  hFDefn: OGRFeatureDefnH, hOtherFDefn: OGRFeatureDefnH
): cint {.cdecl, importc: "OGR_FD_IsSame", dynlib: gdalLib, raises: [].}

proc OGR_F_Create*(
  a0: OGRFeatureDefnH
): OGRFeatureH {.cdecl, importc: "OGR_F_Create", dynlib: gdalLib, raises: [].}

proc OGR_F_Destroy*(
  a0: OGRFeatureH
) {.cdecl, importc: "OGR_F_Destroy", dynlib: gdalLib, raises: [].}

proc OGR_F_GetDefnRef*(
  a0: OGRFeatureH
): OGRFeatureDefnH {.cdecl, importc: "OGR_F_GetDefnRef", dynlib: gdalLib, raises: [].}

proc OGR_F_SetGeometryDirectly*(
  a0: OGRFeatureH, a1: OGRGeometryH
): OGRErr {.cdecl, importc: "OGR_F_SetGeometryDirectly", dynlib: gdalLib, raises: [].}

proc OGR_F_SetGeometry*(
  a0: OGRFeatureH, a1: OGRGeometryH
): OGRErr {.cdecl, importc: "OGR_F_SetGeometry", dynlib: gdalLib, raises: [].}

proc OGR_F_GetGeometryRef*(
  a0: OGRFeatureH
): OGRGeometryH {.cdecl, importc: "OGR_F_GetGeometryRef", dynlib: gdalLib, raises: [].}

proc OGR_F_StealGeometry*(
  a0: OGRFeatureH
): OGRGeometryH {.cdecl, importc: "OGR_F_StealGeometry", dynlib: gdalLib, raises: [].}

proc OGR_F_StealGeometryEx*(
  a0: OGRFeatureH, iGeomField: cint
): OGRGeometryH {.cdecl, importc: "OGR_F_StealGeometryEx", dynlib: gdalLib, raises: [].}

proc OGR_F_Clone*(
  a0: OGRFeatureH
): OGRFeatureH {.cdecl, importc: "OGR_F_Clone", dynlib: gdalLib, raises: [].}

proc OGR_F_Equal*(
  a0: OGRFeatureH, a1: OGRFeatureH
): cint {.cdecl, importc: "OGR_F_Equal", dynlib: gdalLib, raises: [].}

proc OGR_F_GetFieldCount*(
  a0: OGRFeatureH
): cint {.cdecl, importc: "OGR_F_GetFieldCount", dynlib: gdalLib, raises: [].}

proc OGR_F_GetFieldDefnRef*(
  a0: OGRFeatureH, a1: cint
): OGRFieldDefnH {.
  cdecl, importc: "OGR_F_GetFieldDefnRef", dynlib: gdalLib, raises: []
.}

proc OGR_F_GetFieldIndex*(
  a0: OGRFeatureH, a1: cstring
): cint {.cdecl, importc: "OGR_F_GetFieldIndex", dynlib: gdalLib, raises: [].}

proc OGR_F_IsFieldSet*(
  a0: OGRFeatureH, a1: cint
): cint {.cdecl, importc: "OGR_F_IsFieldSet", dynlib: gdalLib, raises: [].}

proc OGR_F_UnsetField*(
  a0: OGRFeatureH, a1: cint
) {.cdecl, importc: "OGR_F_UnsetField", dynlib: gdalLib, raises: [].}

proc OGR_F_IsFieldNull*(
  a0: OGRFeatureH, a1: cint
): cint {.cdecl, importc: "OGR_F_IsFieldNull", dynlib: gdalLib, raises: [].}

proc OGR_F_IsFieldSetAndNotNull*(
  a0: OGRFeatureH, a1: cint
): cint {.cdecl, importc: "OGR_F_IsFieldSetAndNotNull", dynlib: gdalLib, raises: [].}

proc OGR_F_SetFieldNull*(
  a0: OGRFeatureH, a1: cint
) {.cdecl, importc: "OGR_F_SetFieldNull", dynlib: gdalLib, raises: [].}

proc OGR_F_GetRawFieldRef*(
  a0: OGRFeatureH, a1: cint
): ptr OGRField {.cdecl, importc: "OGR_F_GetRawFieldRef", dynlib: gdalLib, raises: [].}

proc OGR_RawField_IsUnset*(
  a0: ptr OGRField
): cint {.cdecl, importc: "OGR_RawField_IsUnset", dynlib: gdalLib, raises: [].}

proc OGR_RawField_IsNull*(
  a0: ptr OGRField
): cint {.cdecl, importc: "OGR_RawField_IsNull", dynlib: gdalLib, raises: [].}

proc OGR_RawField_SetUnset*(
  a0: ptr OGRField
) {.cdecl, importc: "OGR_RawField_SetUnset", dynlib: gdalLib, raises: [].}

proc OGR_RawField_SetNull*(
  a0: ptr OGRField
) {.cdecl, importc: "OGR_RawField_SetNull", dynlib: gdalLib, raises: [].}

proc OGR_F_GetFieldAsInteger*(
  a0: OGRFeatureH, a1: cint
): cint {.cdecl, importc: "OGR_F_GetFieldAsInteger", dynlib: gdalLib, raises: [].}

proc OGR_F_GetFieldAsInteger64*(
  a0: OGRFeatureH, a1: cint
): GIntBig {.cdecl, importc: "OGR_F_GetFieldAsInteger64", dynlib: gdalLib, raises: [].}

proc OGR_F_GetFieldAsDouble*(
  a0: OGRFeatureH, a1: cint
): cdouble {.cdecl, importc: "OGR_F_GetFieldAsDouble", dynlib: gdalLib, raises: [].}

proc OGR_F_GetFieldAsString*(
  a0: OGRFeatureH, a1: cint
): cstring {.cdecl, importc: "OGR_F_GetFieldAsString", dynlib: gdalLib, raises: [].}

proc OGR_F_GetFieldAsISO8601DateTime*(
  a0: OGRFeatureH, a1: cint, a2: CSLConstList
): cstring {.
  cdecl, importc: "OGR_F_GetFieldAsISO8601DateTime", dynlib: gdalLib, raises: []
.}

proc OGR_F_GetFieldAsIntegerList*(
  a0: OGRFeatureH, a1: cint, a2: ptr cint
): ptr cint {.
  cdecl, importc: "OGR_F_GetFieldAsIntegerList", dynlib: gdalLib, raises: []
.}

proc OGR_F_GetFieldAsInteger64List*(
  a0: OGRFeatureH, a1: cint, a2: ptr cint
): ptr GIntBig {.
  cdecl, importc: "OGR_F_GetFieldAsInteger64List", dynlib: gdalLib, raises: []
.}

proc OGR_F_GetFieldAsDoubleList*(
  a0: OGRFeatureH, a1: cint, a2: ptr cint
): ptr cdouble {.
  cdecl, importc: "OGR_F_GetFieldAsDoubleList", dynlib: gdalLib, raises: []
.}

proc OGR_F_GetFieldAsStringList*(
  a0: OGRFeatureH, a1: cint
): cstringArray {.
  cdecl, importc: "OGR_F_GetFieldAsStringList", dynlib: gdalLib, raises: []
.}

proc OGR_F_GetFieldAsBinary*(
  a0: OGRFeatureH, a1: cint, a2: ptr cint
): ptr GByte {.cdecl, importc: "OGR_F_GetFieldAsBinary", dynlib: gdalLib, raises: [].}

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
): cint {.cdecl, importc: "OGR_F_GetFieldAsDateTime", dynlib: gdalLib, raises: [].}

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
): cint {.cdecl, importc: "OGR_F_GetFieldAsDateTimeEx", dynlib: gdalLib, raises: [].}

proc OGR_F_SetFieldInteger*(
  a0: OGRFeatureH, a1: cint, a2: cint
) {.cdecl, importc: "OGR_F_SetFieldInteger", dynlib: gdalLib, raises: [].}

proc OGR_F_SetFieldInteger64*(
  a0: OGRFeatureH, a1: cint, a2: GIntBig
) {.cdecl, importc: "OGR_F_SetFieldInteger64", dynlib: gdalLib, raises: [].}

proc OGR_F_SetFieldDouble*(
  a0: OGRFeatureH, a1: cint, a2: cdouble
) {.cdecl, importc: "OGR_F_SetFieldDouble", dynlib: gdalLib, raises: [].}

proc OGR_F_SetFieldString*(
  a0: OGRFeatureH, a1: cint, a2: cstring
) {.cdecl, importc: "OGR_F_SetFieldString", dynlib: gdalLib, raises: [].}

proc OGR_F_SetFieldIntegerList*(
  a0: OGRFeatureH, a1: cint, a2: cint, a3: ptr cint
) {.cdecl, importc: "OGR_F_SetFieldIntegerList", dynlib: gdalLib, raises: [].}

proc OGR_F_SetFieldInteger64List*(
  a0: OGRFeatureH, a1: cint, a2: cint, a3: ptr GIntBig
) {.cdecl, importc: "OGR_F_SetFieldInteger64List", dynlib: gdalLib, raises: [].}

proc OGR_F_SetFieldDoubleList*(
  a0: OGRFeatureH, a1: cint, a2: cint, a3: ptr cdouble
) {.cdecl, importc: "OGR_F_SetFieldDoubleList", dynlib: gdalLib, raises: [].}

proc OGR_F_SetFieldStringList*(
  a0: OGRFeatureH, a1: cint, a2: CSLConstList
) {.cdecl, importc: "OGR_F_SetFieldStringList", dynlib: gdalLib, raises: [].}

proc OGR_F_SetFieldRaw*(
  a0: OGRFeatureH, a1: cint, a2: ptr OGRField
) {.cdecl, importc: "OGR_F_SetFieldRaw", dynlib: gdalLib, raises: [].}

proc OGR_F_SetFieldBinary*(
  a0: OGRFeatureH, a1: cint, a2: cint, a3: pointer
) {.cdecl, importc: "OGR_F_SetFieldBinary", dynlib: gdalLib, raises: [].}

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
) {.cdecl, importc: "OGR_F_SetFieldDateTime", dynlib: gdalLib, raises: [].}

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
) {.cdecl, importc: "OGR_F_SetFieldDateTimeEx", dynlib: gdalLib, raises: [].}

proc OGR_F_GetGeomFieldCount*(
  hFeat: OGRFeatureH
): cint {.cdecl, importc: "OGR_F_GetGeomFieldCount", dynlib: gdalLib, raises: [].}

proc OGR_F_GetGeomFieldDefnRef*(
  hFeat: OGRFeatureH, iField: cint
): OGRGeomFieldDefnH {.
  cdecl, importc: "OGR_F_GetGeomFieldDefnRef", dynlib: gdalLib, raises: []
.}

proc OGR_F_GetGeomFieldIndex*(
  hFeat: OGRFeatureH, pszName: cstring
): cint {.cdecl, importc: "OGR_F_GetGeomFieldIndex", dynlib: gdalLib, raises: [].}

proc OGR_F_GetGeomFieldRef*(
  hFeat: OGRFeatureH, iField: cint
): OGRGeometryH {.cdecl, importc: "OGR_F_GetGeomFieldRef", dynlib: gdalLib, raises: [].}

proc OGR_F_SetGeomFieldDirectly*(
  hFeat: OGRFeatureH, iField: cint, hGeom: OGRGeometryH
): OGRErr {.cdecl, importc: "OGR_F_SetGeomFieldDirectly", dynlib: gdalLib, raises: [].}

proc OGR_F_SetGeomField*(
  hFeat: OGRFeatureH, iField: cint, hGeom: OGRGeometryH
): OGRErr {.cdecl, importc: "OGR_F_SetGeomField", dynlib: gdalLib, raises: [].}

proc OGR_F_GetFID*(
  a0: OGRFeatureH
): GIntBig {.cdecl, importc: "OGR_F_GetFID", dynlib: gdalLib, raises: [].}

proc OGR_F_SetFID*(
  a0: OGRFeatureH, a1: GIntBig
): OGRErr {.cdecl, importc: "OGR_F_SetFID", dynlib: gdalLib, raises: [].}

proc OGR_F_DumpReadable*(
  a0: OGRFeatureH, a1: ptr GdalFile
) {.cdecl, importc: "OGR_F_DumpReadable", dynlib: gdalLib, raises: [].}

proc OGR_F_DumpReadableAsString*(
  a0: OGRFeatureH, a1: CSLConstList
): cstring {.cdecl, importc: "OGR_F_DumpReadableAsString", dynlib: gdalLib, raises: [].}

proc OGR_F_SetFrom*(
  a0: OGRFeatureH, a1: OGRFeatureH, a2: cint
): OGRErr {.cdecl, importc: "OGR_F_SetFrom", dynlib: gdalLib, raises: [].}

proc OGR_F_SetFromWithMap*(
  a0: OGRFeatureH, a1: OGRFeatureH, a2: cint, a3: ptr cint
): OGRErr {.cdecl, importc: "OGR_F_SetFromWithMap", dynlib: gdalLib, raises: [].}

proc OGR_F_GetStyleString*(
  a0: OGRFeatureH
): cstring {.cdecl, importc: "OGR_F_GetStyleString", dynlib: gdalLib, raises: [].}

proc OGR_F_SetStyleString*(
  a0: OGRFeatureH, a1: cstring
) {.cdecl, importc: "OGR_F_SetStyleString", dynlib: gdalLib, raises: [].}

proc OGR_F_SetStyleStringDirectly*(
  a0: OGRFeatureH, a1: cstring
) {.cdecl, importc: "OGR_F_SetStyleStringDirectly", dynlib: gdalLib, raises: [].}

proc OGR_F_GetStyleTable*(
  a0: OGRFeatureH
): OGRStyleTableH {.cdecl, importc: "OGR_F_GetStyleTable", dynlib: gdalLib, raises: [].}

proc OGR_F_SetStyleTableDirectly*(
  a0: OGRFeatureH, a1: OGRStyleTableH
) {.cdecl, importc: "OGR_F_SetStyleTableDirectly", dynlib: gdalLib, raises: [].}

proc OGR_F_SetStyleTable*(
  a0: OGRFeatureH, a1: OGRStyleTableH
) {.cdecl, importc: "OGR_F_SetStyleTable", dynlib: gdalLib, raises: [].}

proc OGR_F_GetNativeData*(
  a0: OGRFeatureH
): cstring {.cdecl, importc: "OGR_F_GetNativeData", dynlib: gdalLib, raises: [].}

proc OGR_F_SetNativeData*(
  a0: OGRFeatureH, a1: cstring
) {.cdecl, importc: "OGR_F_SetNativeData", dynlib: gdalLib, raises: [].}

proc OGR_F_GetNativeMediaType*(
  a0: OGRFeatureH
): cstring {.cdecl, importc: "OGR_F_GetNativeMediaType", dynlib: gdalLib, raises: [].}

proc OGR_F_SetNativeMediaType*(
  a0: OGRFeatureH, a1: cstring
) {.cdecl, importc: "OGR_F_SetNativeMediaType", dynlib: gdalLib, raises: [].}

proc OGR_F_FillUnsetWithDefault*(
  hFeat: OGRFeatureH, bNotNullableOnly: cint, papszOptions: CSLConstList
) {.cdecl, importc: "OGR_F_FillUnsetWithDefault", dynlib: gdalLib, raises: [].}

proc OGR_F_Validate*(
  a0: OGRFeatureH, nValidateFlags: cint, bEmitError: cint
): cint {.cdecl, importc: "OGR_F_Validate", dynlib: gdalLib, raises: [].}

proc OGR_FldDomain_Destroy*(
  a0: OGRFieldDomainH
) {.cdecl, importc: "OGR_FldDomain_Destroy", dynlib: gdalLib, raises: [].}

proc OGR_FldDomain_GetName*(
  a0: OGRFieldDomainH
): cstring {.cdecl, importc: "OGR_FldDomain_GetName", dynlib: gdalLib, raises: [].}

proc OGR_FldDomain_GetDescription*(
  a0: OGRFieldDomainH
): cstring {.
  cdecl, importc: "OGR_FldDomain_GetDescription", dynlib: gdalLib, raises: []
.}

proc OGR_FldDomain_GetDomainType*(
  a0: OGRFieldDomainH
): OGRFieldDomainType {.
  cdecl, importc: "OGR_FldDomain_GetDomainType", dynlib: gdalLib, raises: []
.}

proc OGR_FldDomain_GetFieldType*(
  a0: OGRFieldDomainH
): OGRFieldType {.
  cdecl, importc: "OGR_FldDomain_GetFieldType", dynlib: gdalLib, raises: []
.}

proc OGR_FldDomain_GetFieldSubType*(
  a0: OGRFieldDomainH
): OGRFieldSubType {.
  cdecl, importc: "OGR_FldDomain_GetFieldSubType", dynlib: gdalLib, raises: []
.}

proc OGR_FldDomain_GetSplitPolicy*(
  a0: OGRFieldDomainH
): OGRFieldDomainSplitPolicy {.
  cdecl, importc: "OGR_FldDomain_GetSplitPolicy", dynlib: gdalLib, raises: []
.}

proc OGR_FldDomain_SetSplitPolicy*(
  a0: OGRFieldDomainH, a1: OGRFieldDomainSplitPolicy
) {.cdecl, importc: "OGR_FldDomain_SetSplitPolicy", dynlib: gdalLib, raises: [].}

proc OGR_FldDomain_GetMergePolicy*(
  a0: OGRFieldDomainH
): OGRFieldDomainMergePolicy {.
  cdecl, importc: "OGR_FldDomain_GetMergePolicy", dynlib: gdalLib, raises: []
.}

proc OGR_FldDomain_SetMergePolicy*(
  a0: OGRFieldDomainH, a1: OGRFieldDomainMergePolicy
) {.cdecl, importc: "OGR_FldDomain_SetMergePolicy", dynlib: gdalLib, raises: [].}

proc OGR_CodedFldDomain_Create*(
  pszName: cstring,
  pszDescription: cstring,
  eFieldType: OGRFieldType,
  eFieldSubType: OGRFieldSubType,
  enumeration: ptr OGRCodedValue,
): OGRFieldDomainH {.
  cdecl, importc: "OGR_CodedFldDomain_Create", dynlib: gdalLib, raises: []
.}

proc OGR_CodedFldDomain_GetEnumeration*(
  a0: OGRFieldDomainH
): ptr OGRCodedValue {.
  cdecl, importc: "OGR_CodedFldDomain_GetEnumeration", dynlib: gdalLib, raises: []
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
): OGRFieldDomainH {.
  cdecl, importc: "OGR_RangeFldDomain_Create", dynlib: gdalLib, raises: []
.}

proc OGR_RangeFldDomain_GetMin*(
  a0: OGRFieldDomainH, pbIsInclusiveOut: ptr bool
): ptr OGRField {.
  cdecl, importc: "OGR_RangeFldDomain_GetMin", dynlib: gdalLib, raises: []
.}

proc OGR_RangeFldDomain_GetMax*(
  a0: OGRFieldDomainH, pbIsInclusiveOut: ptr bool
): ptr OGRField {.
  cdecl, importc: "OGR_RangeFldDomain_GetMax", dynlib: gdalLib, raises: []
.}

proc OGR_GlobFldDomain_Create*(
  pszName: cstring,
  pszDescription: cstring,
  eFieldType: OGRFieldType,
  eFieldSubType: OGRFieldSubType,
  pszGlob: cstring,
): OGRFieldDomainH {.
  cdecl, importc: "OGR_GlobFldDomain_Create", dynlib: gdalLib, raises: []
.}

proc OGR_GlobFldDomain_GetGlob*(
  a0: OGRFieldDomainH
): cstring {.cdecl, importc: "OGR_GlobFldDomain_GetGlob", dynlib: gdalLib, raises: [].}

proc OGR_L_GetName*(
  a0: OGRLayerH
): cstring {.cdecl, importc: "OGR_L_GetName", dynlib: gdalLib, raises: [].}

proc OGR_L_GetGeomType*(
  a0: OGRLayerH
): OGRwkbGeometryType {.
  cdecl, importc: "OGR_L_GetGeomType", dynlib: gdalLib, raises: []
.}

proc OGR_L_GetGeometryTypes*(
  hLayer: OGRLayerH,
  iGeomField: cint,
  nFlags: cint,
  pnEntryCount: ptr cint,
  pfnProgress: GDALProgressFunc,
  pProgressData: pointer,
): ptr OGRGeometryTypeCounter {.
  cdecl, importc: "OGR_L_GetGeometryTypes", dynlib: gdalLib, raises: []
.}

proc OGR_L_GetSpatialFilter*(
  a0: OGRLayerH
): OGRGeometryH {.
  cdecl, importc: "OGR_L_GetSpatialFilter", dynlib: gdalLib, raises: []
.}

proc OGR_L_SetSpatialFilter*(
  a0: OGRLayerH, a1: OGRGeometryH
) {.cdecl, importc: "OGR_L_SetSpatialFilter", dynlib: gdalLib, raises: [].}

proc OGR_L_SetSpatialFilterRect*(
  a0: OGRLayerH, a1: cdouble, a2: cdouble, a3: cdouble, a4: cdouble
) {.cdecl, importc: "OGR_L_SetSpatialFilterRect", dynlib: gdalLib, raises: [].}

proc OGR_L_SetSpatialFilterEx*(
  a0: OGRLayerH, iGeomField: cint, hGeom: OGRGeometryH
) {.cdecl, importc: "OGR_L_SetSpatialFilterEx", dynlib: gdalLib, raises: [].}

proc OGR_L_SetSpatialFilterRectEx*(
  a0: OGRLayerH,
  iGeomField: cint,
  dfMinX: cdouble,
  dfMinY: cdouble,
  dfMaxX: cdouble,
  dfMaxY: cdouble,
) {.cdecl, importc: "OGR_L_SetSpatialFilterRectEx", dynlib: gdalLib, raises: [].}

proc OGR_L_SetAttributeFilter*(
  a0: OGRLayerH, a1: cstring
): OGRErr {.cdecl, importc: "OGR_L_SetAttributeFilter", dynlib: gdalLib, raises: [].}

proc OGR_L_GetAttributeFilter*(
  a0: OGRLayerH
): cstring {.cdecl, importc: "OGR_L_GetAttributeFilter", dynlib: gdalLib, raises: [].}

proc OGR_L_ResetReading*(
  a0: OGRLayerH
) {.cdecl, importc: "OGR_L_ResetReading", dynlib: gdalLib, raises: [].}

proc OGR_L_GetNextFeature*(
  a0: OGRLayerH
): OGRFeatureH {.cdecl, importc: "OGR_L_GetNextFeature", dynlib: gdalLib, raises: [].}

proc OGR_L_GetArrowStream*(
  hLayer: OGRLayerH, out_stream: ptr ArrowArrayStream, papszOptions: CSLConstList
): bool {.cdecl, importc: "OGR_L_GetArrowStream", dynlib: gdalLib, raises: [].}

proc OGR_L_IsArrowSchemaSupported*(
  hLayer: OGRLayerH,
  schema: ptr ArrowSchema,
  papszOptions: CSLConstList,
  ppszErrorMsg: cstringArray,
): bool {.cdecl, importc: "OGR_L_IsArrowSchemaSupported", dynlib: gdalLib, raises: [].}

proc OGR_L_CreateFieldFromArrowSchema*(
  hLayer: OGRLayerH, schema: ptr ArrowSchema, papszOptions: CSLConstList
): bool {.
  cdecl, importc: "OGR_L_CreateFieldFromArrowSchema", dynlib: gdalLib, raises: []
.}

proc OGR_L_WriteArrowBatch*(
  hLayer: OGRLayerH,
  schema: ptr ArrowSchema,
  array: ptr ArrowArray,
  papszOptions: CSLConstList,
): bool {.cdecl, importc: "OGR_L_WriteArrowBatch", dynlib: gdalLib, raises: [].}

proc OGR_L_SetNextByIndex*(
  a0: OGRLayerH, a1: GIntBig
): OGRErr {.cdecl, importc: "OGR_L_SetNextByIndex", dynlib: gdalLib, raises: [].}

proc OGR_L_GetFeature*(
  a0: OGRLayerH, a1: GIntBig
): OGRFeatureH {.cdecl, importc: "OGR_L_GetFeature", dynlib: gdalLib, raises: [].}

proc OGR_L_SetFeature*(
  a0: OGRLayerH, a1: OGRFeatureH
): OGRErr {.cdecl, importc: "OGR_L_SetFeature", dynlib: gdalLib, raises: [].}

proc OGR_L_CreateFeature*(
  a0: OGRLayerH, a1: OGRFeatureH
): OGRErr {.cdecl, importc: "OGR_L_CreateFeature", dynlib: gdalLib, raises: [].}

proc OGR_L_DeleteFeature*(
  a0: OGRLayerH, a1: GIntBig
): OGRErr {.cdecl, importc: "OGR_L_DeleteFeature", dynlib: gdalLib, raises: [].}

proc OGR_L_UpsertFeature*(
  a0: OGRLayerH, a1: OGRFeatureH
): OGRErr {.cdecl, importc: "OGR_L_UpsertFeature", dynlib: gdalLib, raises: [].}

proc OGR_L_UpdateFeature*(
  a0: OGRLayerH,
  a1: OGRFeatureH,
  nUpdatedFieldsCount: cint,
  panUpdatedFieldsIdx: ptr cint,
  nUpdatedGeomFieldsCount: cint,
  panUpdatedGeomFieldsIdx: ptr cint,
  bUpdateStyleString: bool,
): OGRErr {.cdecl, importc: "OGR_L_UpdateFeature", dynlib: gdalLib, raises: [].}

proc OGR_L_GetLayerDefn*(
  a0: OGRLayerH
): OGRFeatureDefnH {.cdecl, importc: "OGR_L_GetLayerDefn", dynlib: gdalLib, raises: [].}

proc OGR_L_GetSpatialRef*(
  a0: OGRLayerH
): OGRSpatialReferenceH {.
  cdecl, importc: "OGR_L_GetSpatialRef", dynlib: gdalLib, raises: []
.}

proc OGR_L_GetSupportedSRSList*(
  hLayer: OGRLayerH, iGeomField: cint, pnCount: ptr cint
): ptr OGRSpatialReferenceH {.
  cdecl, importc: "OGR_L_GetSupportedSRSList", dynlib: gdalLib, raises: []
.}

proc OGR_L_SetActiveSRS*(
  hLayer: OGRLayerH, iGeomField: cint, hSRS: OGRSpatialReferenceH
): OGRErr {.cdecl, importc: "OGR_L_SetActiveSRS", dynlib: gdalLib, raises: [].}

proc OGR_L_FindFieldIndex*(
  a0: OGRLayerH, a1: cstring, bExactMatch: cint
): cint {.cdecl, importc: "OGR_L_FindFieldIndex", dynlib: gdalLib, raises: [].}

proc OGR_L_GetFeatureCount*(
  a0: OGRLayerH, a1: cint
): GIntBig {.cdecl, importc: "OGR_L_GetFeatureCount", dynlib: gdalLib, raises: [].}

proc OGR_L_GetExtent*(
  a0: OGRLayerH, a1: ptr OGREnvelope, a2: cint
): OGRErr {.cdecl, importc: "OGR_L_GetExtent", dynlib: gdalLib, raises: [].}

proc OGR_L_GetExtentEx*(
  a0: OGRLayerH, iGeomField: cint, psExtent: ptr OGREnvelope, bForce: cint
): OGRErr {.cdecl, importc: "OGR_L_GetExtentEx", dynlib: gdalLib, raises: [].}

proc OGR_L_GetExtent3D*(
  hLayer: OGRLayerH, iGeomField: cint, psExtent3D: ptr OGREnvelope3D, bForce: cint
): OGRErr {.cdecl, importc: "OGR_L_GetExtent3D", dynlib: gdalLib, raises: [].}

proc OGR_L_TestCapability*(
  a0: OGRLayerH, a1: cstring
): cint {.cdecl, importc: "OGR_L_TestCapability", dynlib: gdalLib, raises: [].}

proc OGR_L_CreateField*(
  a0: OGRLayerH, a1: OGRFieldDefnH, a2: cint
): OGRErr {.cdecl, importc: "OGR_L_CreateField", dynlib: gdalLib, raises: [].}

proc OGR_L_CreateGeomField*(
  hLayer: OGRLayerH, hFieldDefn: OGRGeomFieldDefnH, bForce: cint
): OGRErr {.cdecl, importc: "OGR_L_CreateGeomField", dynlib: gdalLib, raises: [].}

proc OGR_L_DeleteField*(
  a0: OGRLayerH, iField: cint
): OGRErr {.cdecl, importc: "OGR_L_DeleteField", dynlib: gdalLib, raises: [].}

proc OGR_L_ReorderFields*(
  a0: OGRLayerH, panMap: ptr cint
): OGRErr {.cdecl, importc: "OGR_L_ReorderFields", dynlib: gdalLib, raises: [].}

proc OGR_L_ReorderField*(
  a0: OGRLayerH, iOldFieldPos: cint, iNewFieldPos: cint
): OGRErr {.cdecl, importc: "OGR_L_ReorderField", dynlib: gdalLib, raises: [].}

proc OGR_L_AlterFieldDefn*(
  a0: OGRLayerH, iField: cint, hNewFieldDefn: OGRFieldDefnH, nFlags: cint
): OGRErr {.cdecl, importc: "OGR_L_AlterFieldDefn", dynlib: gdalLib, raises: [].}

proc OGR_L_AlterGeomFieldDefn*(
  a0: OGRLayerH, iField: cint, hNewGeomFieldDefn: OGRGeomFieldDefnH, nFlags: cint
): OGRErr {.cdecl, importc: "OGR_L_AlterGeomFieldDefn", dynlib: gdalLib, raises: [].}

proc OGR_L_StartTransaction*(
  a0: OGRLayerH
): OGRErr {.cdecl, importc: "OGR_L_StartTransaction", dynlib: gdalLib, raises: [].}

proc OGR_L_CommitTransaction*(
  a0: OGRLayerH
): OGRErr {.cdecl, importc: "OGR_L_CommitTransaction", dynlib: gdalLib, raises: [].}

proc OGR_L_RollbackTransaction*(
  a0: OGRLayerH
): OGRErr {.cdecl, importc: "OGR_L_RollbackTransaction", dynlib: gdalLib, raises: [].}

proc OGR_L_Rename*(
  hLayer: OGRLayerH, pszNewName: cstring
): OGRErr {.cdecl, importc: "OGR_L_Rename", dynlib: gdalLib, raises: [].}

proc OGR_L_Reference*(
  a0: OGRLayerH
): cint {.cdecl, importc: "OGR_L_Reference", dynlib: gdalLib, raises: [].}

proc OGR_L_Dereference*(
  a0: OGRLayerH
): cint {.cdecl, importc: "OGR_L_Dereference", dynlib: gdalLib, raises: [].}

proc OGR_L_GetRefCount*(
  a0: OGRLayerH
): cint {.cdecl, importc: "OGR_L_GetRefCount", dynlib: gdalLib, raises: [].}

proc OGR_L_SyncToDisk*(
  a0: OGRLayerH
): OGRErr {.cdecl, importc: "OGR_L_SyncToDisk", dynlib: gdalLib, raises: [].}

proc OGR_L_GetFeaturesRead*(
  a0: OGRLayerH
): GIntBig {.cdecl, importc: "OGR_L_GetFeaturesRead", dynlib: gdalLib, raises: [].}

proc OGR_L_GetFIDColumn*(
  a0: OGRLayerH
): cstring {.cdecl, importc: "OGR_L_GetFIDColumn", dynlib: gdalLib, raises: [].}

proc OGR_L_GetGeometryColumn*(
  a0: OGRLayerH
): cstring {.cdecl, importc: "OGR_L_GetGeometryColumn", dynlib: gdalLib, raises: [].}

proc OGR_L_GetStyleTable*(
  a0: OGRLayerH
): OGRStyleTableH {.cdecl, importc: "OGR_L_GetStyleTable", dynlib: gdalLib, raises: [].}

proc OGR_L_SetStyleTableDirectly*(
  a0: OGRLayerH, a1: OGRStyleTableH
) {.cdecl, importc: "OGR_L_SetStyleTableDirectly", dynlib: gdalLib, raises: [].}

proc OGR_L_SetStyleTable*(
  a0: OGRLayerH, a1: OGRStyleTableH
) {.cdecl, importc: "OGR_L_SetStyleTable", dynlib: gdalLib, raises: [].}

proc OGR_L_SetIgnoredFields*(
  a0: OGRLayerH, a1: cstringArray
): OGRErr {.cdecl, importc: "OGR_L_SetIgnoredFields", dynlib: gdalLib, raises: [].}

proc OGR_L_Intersection*(
  a0: OGRLayerH,
  a1: OGRLayerH,
  a2: OGRLayerH,
  a3: CSLConstList,
  a4: GDALProgressFunc,
  a5: pointer,
): OGRErr {.cdecl, importc: "OGR_L_Intersection", dynlib: gdalLib, raises: [].}

proc OGR_L_Union*(
  a0: OGRLayerH,
  a1: OGRLayerH,
  a2: OGRLayerH,
  a3: CSLConstList,
  a4: GDALProgressFunc,
  a5: pointer,
): OGRErr {.cdecl, importc: "OGR_L_Union", dynlib: gdalLib, raises: [].}

proc OGR_L_SymDifference*(
  a0: OGRLayerH,
  a1: OGRLayerH,
  a2: OGRLayerH,
  a3: CSLConstList,
  a4: GDALProgressFunc,
  a5: pointer,
): OGRErr {.cdecl, importc: "OGR_L_SymDifference", dynlib: gdalLib, raises: [].}

proc OGR_L_Identity*(
  a0: OGRLayerH,
  a1: OGRLayerH,
  a2: OGRLayerH,
  a3: CSLConstList,
  a4: GDALProgressFunc,
  a5: pointer,
): OGRErr {.cdecl, importc: "OGR_L_Identity", dynlib: gdalLib, raises: [].}

proc OGR_L_Update*(
  a0: OGRLayerH,
  a1: OGRLayerH,
  a2: OGRLayerH,
  a3: CSLConstList,
  a4: GDALProgressFunc,
  a5: pointer,
): OGRErr {.cdecl, importc: "OGR_L_Update", dynlib: gdalLib, raises: [].}

proc OGR_L_Clip*(
  a0: OGRLayerH,
  a1: OGRLayerH,
  a2: OGRLayerH,
  a3: CSLConstList,
  a4: GDALProgressFunc,
  a5: pointer,
): OGRErr {.cdecl, importc: "OGR_L_Clip", dynlib: gdalLib, raises: [].}

proc OGR_L_Erase*(
  a0: OGRLayerH,
  a1: OGRLayerH,
  a2: OGRLayerH,
  a3: CSLConstList,
  a4: GDALProgressFunc,
  a5: pointer,
): OGRErr {.cdecl, importc: "OGR_L_Erase", dynlib: gdalLib, raises: [].}

proc OGR_DS_Destroy*(
  a0: OGRDataSourceH
) {.cdecl, importc: "OGR_DS_Destroy", dynlib: gdalLib, raises: [].}

proc OGR_DS_GetName*(
  a0: OGRDataSourceH
): cstring {.cdecl, importc: "OGR_DS_GetName", dynlib: gdalLib, raises: [].}

proc OGR_DS_GetLayerCount*(
  a0: OGRDataSourceH
): cint {.cdecl, importc: "OGR_DS_GetLayerCount", dynlib: gdalLib, raises: [].}

proc OGR_DS_GetLayer*(
  a0: OGRDataSourceH, a1: cint
): OGRLayerH {.cdecl, importc: "OGR_DS_GetLayer", dynlib: gdalLib, raises: [].}

proc OGR_DS_GetLayerByName*(
  a0: OGRDataSourceH, a1: cstring
): OGRLayerH {.cdecl, importc: "OGR_DS_GetLayerByName", dynlib: gdalLib, raises: [].}

proc OGR_DS_DeleteLayer*(
  a0: OGRDataSourceH, a1: cint
): OGRErr {.cdecl, importc: "OGR_DS_DeleteLayer", dynlib: gdalLib, raises: [].}

proc OGR_DS_GetDriver*(
  a0: OGRDataSourceH
): OGRSFDriverH {.cdecl, importc: "OGR_DS_GetDriver", dynlib: gdalLib, raises: [].}

proc OGR_DS_CreateLayer*(
  a0: OGRDataSourceH,
  a1: cstring,
  a2: OGRSpatialReferenceH,
  a3: OGRwkbGeometryType,
  a4: cstringArray,
): OGRLayerH {.cdecl, importc: "OGR_DS_CreateLayer", dynlib: gdalLib, raises: [].}

proc OGR_DS_CopyLayer*(
  a0: OGRDataSourceH, a1: OGRLayerH, a2: cstring, a3: cstringArray
): OGRLayerH {.cdecl, importc: "OGR_DS_CopyLayer", dynlib: gdalLib, raises: [].}

proc OGR_DS_TestCapability*(
  a0: OGRDataSourceH, a1: cstring
): cint {.cdecl, importc: "OGR_DS_TestCapability", dynlib: gdalLib, raises: [].}

proc OGR_DS_ExecuteSQL*(
  a0: OGRDataSourceH, a1: cstring, a2: OGRGeometryH, a3: cstring
): OGRLayerH {.cdecl, importc: "OGR_DS_ExecuteSQL", dynlib: gdalLib, raises: [].}

proc OGR_DS_ReleaseResultSet*(
  a0: OGRDataSourceH, a1: OGRLayerH
) {.cdecl, importc: "OGR_DS_ReleaseResultSet", dynlib: gdalLib, raises: [].}

proc OGR_DS_Reference*(
  a0: OGRDataSourceH
): cint {.cdecl, importc: "OGR_DS_Reference", dynlib: gdalLib, raises: [].}

proc OGR_DS_Dereference*(
  a0: OGRDataSourceH
): cint {.cdecl, importc: "OGR_DS_Dereference", dynlib: gdalLib, raises: [].}

proc OGR_DS_GetRefCount*(
  a0: OGRDataSourceH
): cint {.cdecl, importc: "OGR_DS_GetRefCount", dynlib: gdalLib, raises: [].}

proc OGR_DS_GetSummaryRefCount*(
  a0: OGRDataSourceH
): cint {.cdecl, importc: "OGR_DS_GetSummaryRefCount", dynlib: gdalLib, raises: [].}

proc OGR_DS_SyncToDisk*(
  a0: OGRDataSourceH
): OGRErr {.cdecl, importc: "OGR_DS_SyncToDisk", dynlib: gdalLib, raises: [].}

proc OGR_DS_GetStyleTable*(
  a0: OGRDataSourceH
): OGRStyleTableH {.
  cdecl, importc: "OGR_DS_GetStyleTable", dynlib: gdalLib, raises: []
.}

proc OGR_DS_SetStyleTableDirectly*(
  a0: OGRDataSourceH, a1: OGRStyleTableH
) {.cdecl, importc: "OGR_DS_SetStyleTableDirectly", dynlib: gdalLib, raises: [].}

proc OGR_DS_SetStyleTable*(
  a0: OGRDataSourceH, a1: OGRStyleTableH
) {.cdecl, importc: "OGR_DS_SetStyleTable", dynlib: gdalLib, raises: [].}

proc OGR_Dr_GetName*(
  a0: OGRSFDriverH
): cstring {.cdecl, importc: "OGR_Dr_GetName", dynlib: gdalLib, raises: [].}

proc OGR_Dr_Open*(
  a0: OGRSFDriverH, a1: cstring, a2: cint
): OGRDataSourceH {.cdecl, importc: "OGR_Dr_Open", dynlib: gdalLib, raises: [].}

proc OGR_Dr_TestCapability*(
  a0: OGRSFDriverH, a1: cstring
): cint {.cdecl, importc: "OGR_Dr_TestCapability", dynlib: gdalLib, raises: [].}

proc OGR_Dr_CreateDataSource*(
  a0: OGRSFDriverH, a1: cstring, a2: cstringArray
): OGRDataSourceH {.
  cdecl, importc: "OGR_Dr_CreateDataSource", dynlib: gdalLib, raises: []
.}

proc OGR_Dr_CopyDataSource*(
  a0: OGRSFDriverH, a1: OGRDataSourceH, a2: cstring, a3: cstringArray
): OGRDataSourceH {.
  cdecl, importc: "OGR_Dr_CopyDataSource", dynlib: gdalLib, raises: []
.}

proc OGR_Dr_DeleteDataSource*(
  a0: OGRSFDriverH, a1: cstring
): OGRErr {.cdecl, importc: "OGR_Dr_DeleteDataSource", dynlib: gdalLib, raises: [].}

proc OGROpen*(
  a0: cstring, a1: cint, a2: ptr OGRSFDriverH
): OGRDataSourceH {.cdecl, importc: "OGROpen", dynlib: gdalLib, raises: [].}

proc OGROpenShared*(
  a0: cstring, a1: cint, a2: ptr OGRSFDriverH
): OGRDataSourceH {.cdecl, importc: "OGROpenShared", dynlib: gdalLib, raises: [].}

proc OGRReleaseDataSource*(
  a0: OGRDataSourceH
): OGRErr {.cdecl, importc: "OGRReleaseDataSource", dynlib: gdalLib, raises: [].}

proc OGRRegisterDriver*(
  a0: OGRSFDriverH
) {.cdecl, importc: "OGRRegisterDriver", dynlib: gdalLib, raises: [].}

proc OGRDeregisterDriver*(
  a0: OGRSFDriverH
) {.cdecl, importc: "OGRDeregisterDriver", dynlib: gdalLib, raises: [].}

proc OGRGetDriverCount*(): cint {.
  cdecl, importc: "OGRGetDriverCount", dynlib: gdalLib, raises: []
.}

proc OGRGetDriver*(
  a0: cint
): OGRSFDriverH {.cdecl, importc: "OGRGetDriver", dynlib: gdalLib, raises: [].}

proc OGRGetDriverByName*(
  a0: cstring
): OGRSFDriverH {.cdecl, importc: "OGRGetDriverByName", dynlib: gdalLib, raises: [].}

proc OGRGetOpenDSCount*(): cint {.
  cdecl, importc: "OGRGetOpenDSCount", dynlib: gdalLib, raises: []
.}

proc OGRGetOpenDS*(
  iDS: cint
): OGRDataSourceH {.cdecl, importc: "OGRGetOpenDS", dynlib: gdalLib, raises: [].}

proc OGRRegisterAll*() {.cdecl, importc: "OGRRegisterAll", dynlib: gdalLib, raises: [].}
proc OGRCleanupAll*() {.cdecl, importc: "OGRCleanupAll", dynlib: gdalLib, raises: [].}
proc OGR_SM_Create*(
  hStyleTable: OGRStyleTableH
): OGRStyleMgrH {.cdecl, importc: "OGR_SM_Create", dynlib: gdalLib, raises: [].}

proc OGR_SM_Destroy*(
  hSM: OGRStyleMgrH
) {.cdecl, importc: "OGR_SM_Destroy", dynlib: gdalLib, raises: [].}

proc OGR_SM_InitFromFeature*(
  hSM: OGRStyleMgrH, hFeat: OGRFeatureH
): cstring {.cdecl, importc: "OGR_SM_InitFromFeature", dynlib: gdalLib, raises: [].}

proc OGR_SM_InitStyleString*(
  hSM: OGRStyleMgrH, pszStyleString: cstring
): cint {.cdecl, importc: "OGR_SM_InitStyleString", dynlib: gdalLib, raises: [].}

proc OGR_SM_GetPartCount*(
  hSM: OGRStyleMgrH, pszStyleString: cstring
): cint {.cdecl, importc: "OGR_SM_GetPartCount", dynlib: gdalLib, raises: [].}

proc OGR_SM_GetPart*(
  hSM: OGRStyleMgrH, nPartId: cint, pszStyleString: cstring
): OGRStyleToolH {.cdecl, importc: "OGR_SM_GetPart", dynlib: gdalLib, raises: [].}

proc OGR_SM_AddPart*(
  hSM: OGRStyleMgrH, hST: OGRStyleToolH
): cint {.cdecl, importc: "OGR_SM_AddPart", dynlib: gdalLib, raises: [].}

proc OGR_SM_AddStyle*(
  hSM: OGRStyleMgrH, pszStyleName: cstring, pszStyleString: cstring
): cint {.cdecl, importc: "OGR_SM_AddStyle", dynlib: gdalLib, raises: [].}

proc OGR_ST_Create*(
  eClassId: OGRSTClassId
): OGRStyleToolH {.cdecl, importc: "OGR_ST_Create", dynlib: gdalLib, raises: [].}

proc OGR_ST_Destroy*(
  hST: OGRStyleToolH
) {.cdecl, importc: "OGR_ST_Destroy", dynlib: gdalLib, raises: [].}

proc OGR_ST_GetType*(
  hST: OGRStyleToolH
): OGRSTClassId {.cdecl, importc: "OGR_ST_GetType", dynlib: gdalLib, raises: [].}

proc OGR_ST_GetUnit*(
  hST: OGRStyleToolH
): OGRSTUnitId {.cdecl, importc: "OGR_ST_GetUnit", dynlib: gdalLib, raises: [].}

proc OGR_ST_SetUnit*(
  hST: OGRStyleToolH, eUnit: OGRSTUnitId, dfGroundPaperScale: cdouble
) {.cdecl, importc: "OGR_ST_SetUnit", dynlib: gdalLib, raises: [].}

proc OGR_ST_GetParamStr*(
  hST: OGRStyleToolH, eParam: cint, bValueIsNull: ptr cint
): cstring {.cdecl, importc: "OGR_ST_GetParamStr", dynlib: gdalLib, raises: [].}

proc OGR_ST_GetParamNum*(
  hST: OGRStyleToolH, eParam: cint, bValueIsNull: ptr cint
): cint {.cdecl, importc: "OGR_ST_GetParamNum", dynlib: gdalLib, raises: [].}

proc OGR_ST_GetParamDbl*(
  hST: OGRStyleToolH, eParam: cint, bValueIsNull: ptr cint
): cdouble {.cdecl, importc: "OGR_ST_GetParamDbl", dynlib: gdalLib, raises: [].}

proc OGR_ST_SetParamStr*(
  hST: OGRStyleToolH, eParam: cint, pszValue: cstring
) {.cdecl, importc: "OGR_ST_SetParamStr", dynlib: gdalLib, raises: [].}

proc OGR_ST_SetParamNum*(
  hST: OGRStyleToolH, eParam: cint, nValue: cint
) {.cdecl, importc: "OGR_ST_SetParamNum", dynlib: gdalLib, raises: [].}

proc OGR_ST_SetParamDbl*(
  hST: OGRStyleToolH, eParam: cint, dfValue: cdouble
) {.cdecl, importc: "OGR_ST_SetParamDbl", dynlib: gdalLib, raises: [].}

proc OGR_ST_GetStyleString*(
  hST: OGRStyleToolH
): cstring {.cdecl, importc: "OGR_ST_GetStyleString", dynlib: gdalLib, raises: [].}

proc OGR_ST_GetRGBFromString*(
  hST: OGRStyleToolH,
  pszColor: cstring,
  pnRed: ptr cint,
  pnGreen: ptr cint,
  pnBlue: ptr cint,
  pnAlpha: ptr cint,
): cint {.cdecl, importc: "OGR_ST_GetRGBFromString", dynlib: gdalLib, raises: [].}

proc OGR_STBL_Create*(): OGRStyleTableH {.
  cdecl, importc: "OGR_STBL_Create", dynlib: gdalLib, raises: []
.}

proc OGR_STBL_Destroy*(
  hSTBL: OGRStyleTableH
) {.cdecl, importc: "OGR_STBL_Destroy", dynlib: gdalLib, raises: [].}

proc OGR_STBL_AddStyle*(
  hStyleTable: OGRStyleTableH, pszName: cstring, pszStyleString: cstring
): cint {.cdecl, importc: "OGR_STBL_AddStyle", dynlib: gdalLib, raises: [].}

proc OGR_STBL_SaveStyleTable*(
  hStyleTable: OGRStyleTableH, pszFilename: cstring
): cint {.cdecl, importc: "OGR_STBL_SaveStyleTable", dynlib: gdalLib, raises: [].}

proc OGR_STBL_LoadStyleTable*(
  hStyleTable: OGRStyleTableH, pszFilename: cstring
): cint {.cdecl, importc: "OGR_STBL_LoadStyleTable", dynlib: gdalLib, raises: [].}

proc OGR_STBL_Find*(
  hStyleTable: OGRStyleTableH, pszName: cstring
): cstring {.cdecl, importc: "OGR_STBL_Find", dynlib: gdalLib, raises: [].}

proc OGR_STBL_ResetStyleStringReading*(
  hStyleTable: OGRStyleTableH
) {.cdecl, importc: "OGR_STBL_ResetStyleStringReading", dynlib: gdalLib, raises: [].}

proc OGR_STBL_GetNextStyle*(
  hStyleTable: OGRStyleTableH
): cstring {.cdecl, importc: "OGR_STBL_GetNextStyle", dynlib: gdalLib, raises: [].}

proc OGR_STBL_GetLastStyleName*(
  hStyleTable: OGRStyleTableH
): cstring {.cdecl, importc: "OGR_STBL_GetLastStyleName", dynlib: gdalLib, raises: [].}

proc GDALGetDataTypeSize*(
  a0: GDALDataType
): cint {.gdalCall, importc: "GDALGetDataTypeSize", dynlib: gdalLib, raises: [].}

proc GDALGetDataTypeSizeBits*(
  eDataType: GDALDataType
): cint {.gdalCall, importc: "GDALGetDataTypeSizeBits", dynlib: gdalLib, raises: [].}

proc GDALGetDataTypeSizeBytes*(
  a0: GDALDataType
): cint {.gdalCall, importc: "GDALGetDataTypeSizeBytes", dynlib: gdalLib, raises: [].}

proc GDALDataTypeIsComplex*(
  a0: GDALDataType
): cint {.gdalCall, importc: "GDALDataTypeIsComplex", dynlib: gdalLib, raises: [].}

proc GDALDataTypeIsInteger*(
  a0: GDALDataType
): cint {.gdalCall, importc: "GDALDataTypeIsInteger", dynlib: gdalLib, raises: [].}

proc GDALDataTypeIsFloating*(
  a0: GDALDataType
): cint {.gdalCall, importc: "GDALDataTypeIsFloating", dynlib: gdalLib, raises: [].}

proc GDALDataTypeIsSigned*(
  a0: GDALDataType
): cint {.gdalCall, importc: "GDALDataTypeIsSigned", dynlib: gdalLib, raises: [].}

proc GDALGetDataTypeName*(
  a0: GDALDataType
): cstring {.gdalCall, importc: "GDALGetDataTypeName", dynlib: gdalLib, raises: [].}

proc GDALGetDataTypeByName*(
  a0: cstring
): GDALDataType {.
  gdalCall, importc: "GDALGetDataTypeByName", dynlib: gdalLib, raises: []
.}

proc GDALDataTypeUnion*(
  a0: GDALDataType, a1: GDALDataType
): GDALDataType {.gdalCall, importc: "GDALDataTypeUnion", dynlib: gdalLib, raises: [].}

proc GDALDataTypeUnionWithValue*(
  eDT: GDALDataType, dValue: cdouble, bComplex: cint
): GDALDataType {.
  gdalCall, importc: "GDALDataTypeUnionWithValue", dynlib: gdalLib, raises: []
.}

proc GDALFindDataType*(
  nBits: cint, bSigned: cint, bFloating: cint, bComplex: cint
): GDALDataType {.gdalCall, importc: "GDALFindDataType", dynlib: gdalLib, raises: [].}

proc GDALFindDataTypeForValue*(
  dValue: cdouble, bComplex: cint
): GDALDataType {.
  gdalCall, importc: "GDALFindDataTypeForValue", dynlib: gdalLib, raises: []
.}

proc GDALAdjustValueToDataType*(
  eDT: GDALDataType, dfValue: cdouble, pbClamped: ptr cint, pbRounded: ptr cint
): cdouble {.cdecl, importc: "GDALAdjustValueToDataType", dynlib: gdalLib, raises: [].}

proc GDALIsValueExactAs*(
  dfValue: cdouble, eDT: GDALDataType
): bool {.cdecl, importc: "GDALIsValueExactAs", dynlib: gdalLib, raises: [].}

proc GDALIsValueInRangeOf*(
  dfValue: cdouble, eDT: GDALDataType
): bool {.cdecl, importc: "GDALIsValueInRangeOf", dynlib: gdalLib, raises: [].}

proc GDALGetNonComplexDataType*(
  a0: GDALDataType
): GDALDataType {.
  gdalCall, importc: "GDALGetNonComplexDataType", dynlib: gdalLib, raises: []
.}

proc GDALDataTypeIsConversionLossy*(
  eTypeFrom: GDALDataType, eTypeTo: GDALDataType
): cint {.
  gdalCall, importc: "GDALDataTypeIsConversionLossy", dynlib: gdalLib, raises: []
.}

proc GDALGetAsyncStatusTypeName*(
  a0: GDALAsyncStatusType
): cstring {.
  gdalCall, importc: "GDALGetAsyncStatusTypeName", dynlib: gdalLib, raises: []
.}

proc GDALGetAsyncStatusTypeByName*(
  a0: cstring
): GDALAsyncStatusType {.
  gdalCall, importc: "GDALGetAsyncStatusTypeByName", dynlib: gdalLib, raises: []
.}

proc GDALGetColorInterpretationName*(
  a0: GDALColorInterp
): cstring {.
  cdecl, importc: "GDALGetColorInterpretationName", dynlib: gdalLib, raises: []
.}

proc GDALGetColorInterpretationByName*(
  pszName: cstring
): GDALColorInterp {.
  cdecl, importc: "GDALGetColorInterpretationByName", dynlib: gdalLib, raises: []
.}

proc GDALGetColorInterpretationList*(
  pnCount: ptr cint
): ptr GDALColorInterp {.
  cdecl, importc: "GDALGetColorInterpretationList", dynlib: gdalLib, raises: []
.}

proc GDALGetPaletteInterpretationName*(
  a0: GDALPaletteInterp
): cstring {.
  cdecl, importc: "GDALGetPaletteInterpretationName", dynlib: gdalLib, raises: []
.}

proc GDALAllRegister*() {.
  gdalCall, importc: "GDALAllRegister", dynlib: gdalLib, raises: []
.}

proc GDALRegisterPlugins*() {.
  cdecl, importc: "GDALRegisterPlugins", dynlib: gdalLib, raises: []
.}

proc GDALRegisterPlugin*(
  name: cstring
): CPLErr {.cdecl, importc: "GDALRegisterPlugin", dynlib: gdalLib, raises: [].}

proc GDALCreate*(
  hDriver: GDALDriverH,
  a1: cstring,
  a2: cint,
  a3: cint,
  a4: cint,
  a5: GDALDataType,
  a6: CSLConstList,
): GDALDatasetH {.gdalCall, importc: "GDALCreate", dynlib: gdalLib, raises: [].}

proc GDALCreateCopy*(
  a0: GDALDriverH,
  a1: cstring,
  a2: GDALDatasetH,
  a3: cint,
  a4: CSLConstList,
  a5: GDALProgressFunc,
  a6: pointer,
): GDALDatasetH {.gdalCall, importc: "GDALCreateCopy", dynlib: gdalLib, raises: [].}

proc GDALIdentifyDriver*(
  pszFilename: cstring, papszFileList: CSLConstList
): GDALDriverH {.gdalCall, importc: "GDALIdentifyDriver", dynlib: gdalLib, raises: [].}

proc GDALIdentifyDriverEx*(
  pszFilename: cstring,
  nIdentifyFlags: cuint,
  papszAllowedDrivers: cstringArray,
  papszFileList: cstringArray,
): GDALDriverH {.
  gdalCall, importc: "GDALIdentifyDriverEx", dynlib: gdalLib, raises: []
.}

proc GDALOpen*(
  pszFilename: cstring, eAccess: GDALAccess
): GDALDatasetH {.gdalCall, importc: "GDALOpen", dynlib: gdalLib, raises: [].}

proc GDALOpenShared*(
  a0: cstring, a1: GDALAccess
): GDALDatasetH {.gdalCall, importc: "GDALOpenShared", dynlib: gdalLib, raises: [].}

proc GDALOpenEx*(
  pszFilename: cstring,
  nOpenFlags: cuint,
  papszAllowedDrivers: cstringArray,
  papszOpenOptions: cstringArray,
  papszSiblingFiles: cstringArray,
): GDALDatasetH {.gdalCall, importc: "GDALOpenEx", dynlib: gdalLib, raises: [].}

proc GDALDumpOpenDatasets*(
  a0: ptr GdalFile
): cint {.gdalCall, importc: "GDALDumpOpenDatasets", dynlib: gdalLib, raises: [].}

proc GDALGetDriverByName*(
  a0: cstring
): GDALDriverH {.gdalCall, importc: "GDALGetDriverByName", dynlib: gdalLib, raises: [].}

proc GDALGetDriverCount*(): cint {.
  gdalCall, importc: "GDALGetDriverCount", dynlib: gdalLib, raises: []
.}

proc GDALGetDriver*(
  a0: cint
): GDALDriverH {.gdalCall, importc: "GDALGetDriver", dynlib: gdalLib, raises: [].}

proc GDALCreateDriver*(): GDALDriverH {.
  gdalCall, importc: "GDALCreateDriver", dynlib: gdalLib, raises: []
.}

proc GDALDestroyDriver*(
  a0: GDALDriverH
) {.gdalCall, importc: "GDALDestroyDriver", dynlib: gdalLib, raises: [].}

proc GDALRegisterDriver*(
  a0: GDALDriverH
): cint {.gdalCall, importc: "GDALRegisterDriver", dynlib: gdalLib, raises: [].}

proc GDALDeregisterDriver*(
  a0: GDALDriverH
) {.gdalCall, importc: "GDALDeregisterDriver", dynlib: gdalLib, raises: [].}

proc GDALDestroyDriverManager*() {.
  gdalCall, importc: "GDALDestroyDriverManager", dynlib: gdalLib, raises: []
.}

proc GDALClearMemoryCaches*() {.
  cdecl, importc: "GDALClearMemoryCaches", dynlib: gdalLib, raises: []
.}

proc GDALDestroy*() {.cdecl, importc: "GDALDestroy", dynlib: gdalLib, raises: [].}
proc GDALDeleteDataset*(
  a0: GDALDriverH, a1: cstring
): CPLErr {.gdalCall, importc: "GDALDeleteDataset", dynlib: gdalLib, raises: [].}

proc GDALRenameDataset*(
  a0: GDALDriverH, pszNewName: cstring, pszOldName: cstring
): CPLErr {.gdalCall, importc: "GDALRenameDataset", dynlib: gdalLib, raises: [].}

proc GDALCopyDatasetFiles*(
  a0: GDALDriverH, pszNewName: cstring, pszOldName: cstring
): CPLErr {.gdalCall, importc: "GDALCopyDatasetFiles", dynlib: gdalLib, raises: [].}

proc GDALValidateCreationOptions*(
  a0: GDALDriverH, papszCreationOptions: CSLConstList
): cint {.
  gdalCall, importc: "GDALValidateCreationOptions", dynlib: gdalLib, raises: []
.}

proc GDALGetOutputDriversForDatasetName*(
  pszDestFilename: cstring,
  nFlagRasterVector: cint,
  bSingleMatch: bool,
  bEmitWarning: bool,
): cstringArray {.
  cdecl, importc: "GDALGetOutputDriversForDatasetName", dynlib: gdalLib, raises: []
.}

proc GDALDriverHasOpenOption*(
  a0: GDALDriverH, pszOpenOptionName: cstring
): bool {.cdecl, importc: "GDALDriverHasOpenOption", dynlib: gdalLib, raises: [].}

proc GDALGetDriverShortName*(
  a0: GDALDriverH
): cstring {.gdalCall, importc: "GDALGetDriverShortName", dynlib: gdalLib, raises: [].}

proc GDALGetDriverLongName*(
  a0: GDALDriverH
): cstring {.gdalCall, importc: "GDALGetDriverLongName", dynlib: gdalLib, raises: [].}

proc GDALGetDriverHelpTopic*(
  a0: GDALDriverH
): cstring {.gdalCall, importc: "GDALGetDriverHelpTopic", dynlib: gdalLib, raises: [].}

proc GDALGetDriverCreationOptionList*(
  a0: GDALDriverH
): cstring {.
  gdalCall, importc: "GDALGetDriverCreationOptionList", dynlib: gdalLib, raises: []
.}

proc GDALInitGCPs*(
  a0: cint, a1: ptr GDAL_GCP
) {.gdalCall, importc: "GDALInitGCPs", dynlib: gdalLib, raises: [].}

proc GDALDeinitGCPs*(
  a0: cint, a1: ptr GDAL_GCP
) {.gdalCall, importc: "GDALDeinitGCPs", dynlib: gdalLib, raises: [].}

proc GDALDuplicateGCPs*(
  a0: cint, a1: ptr GDAL_GCP
): ptr GDAL_GCP {.gdalCall, importc: "GDALDuplicateGCPs", dynlib: gdalLib, raises: [].}

proc GDALGCPsToGeoTransform*(
  nGCPCount: cint, pasGCPs: ptr GDAL_GCP, padfGeoTransform: ptr cdouble, bApproxOK: cint
): cint {.gdalCall, importc: "GDALGCPsToGeoTransform", dynlib: gdalLib, raises: [].}

proc GDALInvGeoTransform*(
  padfGeoTransformIn: ptr cdouble, padfInvGeoTransformOut: ptr cdouble
): cint {.gdalCall, importc: "GDALInvGeoTransform", dynlib: gdalLib, raises: [].}

proc GDALApplyGeoTransform*(
  a0: ptr cdouble, a1: cdouble, a2: cdouble, a3: ptr cdouble, a4: ptr cdouble
) {.gdalCall, importc: "GDALApplyGeoTransform", dynlib: gdalLib, raises: [].}

proc GDALComposeGeoTransforms*(
  padfGeoTransform1: ptr cdouble,
  padfGeoTransform2: ptr cdouble,
  padfGeoTransformOut: ptr cdouble,
) {.cdecl, importc: "GDALComposeGeoTransforms", dynlib: gdalLib, raises: [].}

proc GDALGCPsToHomography*(
  nGCPCount: cint, pasGCPs: ptr GDAL_GCP, padfHomography: ptr cdouble
): cint {.cdecl, importc: "GDALGCPsToHomography", dynlib: gdalLib, raises: [].}

proc GDALInvHomography*(
  padfHomographyIn: ptr cdouble, padfInvHomographyOut: ptr cdouble
): cint {.cdecl, importc: "GDALInvHomography", dynlib: gdalLib, raises: [].}

proc GDALApplyHomography*(
  a0: ptr cdouble, a1: cdouble, a2: cdouble, a3: ptr cdouble, a4: ptr cdouble
): cint {.cdecl, importc: "GDALApplyHomography", dynlib: gdalLib, raises: [].}

proc GDALComposeHomographies*(
  padfHomography1: ptr cdouble,
  padfHomography2: ptr cdouble,
  padfHomographyOut: ptr cdouble,
) {.cdecl, importc: "GDALComposeHomographies", dynlib: gdalLib, raises: [].}

proc GDALGetMetadataDomainList*(
  hObject: GDALMajorObjectH
): cstringArray {.
  gdalCall, importc: "GDALGetMetadataDomainList", dynlib: gdalLib, raises: []
.}

proc GDALGetMetadata*(
  a0: GDALMajorObjectH, a1: cstring
): CSLConstList {.gdalCall, importc: "GDALGetMetadata", dynlib: gdalLib, raises: [].}

proc GDALSetMetadata*(
  a0: GDALMajorObjectH, a1: CSLConstList, a2: cstring
): CPLErr {.gdalCall, importc: "GDALSetMetadata", dynlib: gdalLib, raises: [].}

proc GDALGetMetadataItem*(
  a0: GDALMajorObjectH, a1: cstring, a2: cstring
): cstring {.gdalCall, importc: "GDALGetMetadataItem", dynlib: gdalLib, raises: [].}

proc GDALSetMetadataItem*(
  a0: GDALMajorObjectH, a1: cstring, a2: cstring, a3: cstring
): CPLErr {.gdalCall, importc: "GDALSetMetadataItem", dynlib: gdalLib, raises: [].}

proc GDALGetDescription*(
  a0: GDALMajorObjectH
): cstring {.gdalCall, importc: "GDALGetDescription", dynlib: gdalLib, raises: [].}

proc GDALSetDescription*(
  a0: GDALMajorObjectH, a1: cstring
) {.gdalCall, importc: "GDALSetDescription", dynlib: gdalLib, raises: [].}

proc GDALGetDatasetDriver*(
  a0: GDALDatasetH
): GDALDriverH {.
  gdalCall, importc: "GDALGetDatasetDriver", dynlib: gdalLib, raises: []
.}

proc GDALGetFileList*(
  a0: GDALDatasetH
): cstringArray {.gdalCall, importc: "GDALGetFileList", dynlib: gdalLib, raises: [].}

proc GDALDatasetMarkSuppressOnClose*(
  a0: GDALDatasetH
) {.cdecl, importc: "GDALDatasetMarkSuppressOnClose", dynlib: gdalLib, raises: [].}

proc GDALClose*(
  a0: GDALDatasetH
): CPLErr {.gdalCall, importc: "GDALClose", dynlib: gdalLib, raises: [].}

proc GDALCloseEx*(
  hDS: GDALDatasetH, pfnProgress: GDALProgressFunc, pProgressData: pointer
): CPLErr {.cdecl, importc: "GDALCloseEx", dynlib: gdalLib, raises: [].}

proc GDALDatasetGetCloseReportsProgress*(
  hDS: GDALDatasetH
): bool {.
  cdecl, importc: "GDALDatasetGetCloseReportsProgress", dynlib: gdalLib, raises: []
.}

proc GDALDatasetRunCloseWithoutDestroying*(
  hDS: GDALDatasetH
): CPLErr {.
  cdecl, importc: "GDALDatasetRunCloseWithoutDestroying", dynlib: gdalLib, raises: []
.}

proc GDALDatasetRunCloseWithoutDestroyingEx*(
  hDS: GDALDatasetH, pfnProgress: GDALProgressFunc, pProgressData: pointer
): CPLErr {.
  cdecl, importc: "GDALDatasetRunCloseWithoutDestroyingEx", dynlib: gdalLib, raises: []
.}

proc GDALGetRasterXSize*(
  a0: GDALDatasetH
): cint {.gdalCall, importc: "GDALGetRasterXSize", dynlib: gdalLib, raises: [].}

proc GDALGetRasterYSize*(
  a0: GDALDatasetH
): cint {.gdalCall, importc: "GDALGetRasterYSize", dynlib: gdalLib, raises: [].}

proc GDALGetRasterCount*(
  a0: GDALDatasetH
): cint {.gdalCall, importc: "GDALGetRasterCount", dynlib: gdalLib, raises: [].}

proc GDALGetRasterBand*(
  a0: GDALDatasetH, a1: cint
): GDALRasterBandH {.
  gdalCall, importc: "GDALGetRasterBand", dynlib: gdalLib, raises: []
.}

proc GDALDatasetIsThreadSafe*(
  a0: GDALDatasetH, nScopeFlags: cint, papszOptions: CSLConstList
): bool {.cdecl, importc: "GDALDatasetIsThreadSafe", dynlib: gdalLib, raises: [].}

proc GDALGetThreadSafeDataset*(
  a0: GDALDatasetH, nScopeFlags: cint, papszOptions: CSLConstList
): GDALDatasetH {.
  cdecl, importc: "GDALGetThreadSafeDataset", dynlib: gdalLib, raises: []
.}

proc GDALAddBand*(
  hDS: GDALDatasetH, eType: GDALDataType, papszOptions: CSLConstList
): CPLErr {.gdalCall, importc: "GDALAddBand", dynlib: gdalLib, raises: [].}

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
): GDALAsyncReaderH {.
  gdalCall, importc: "GDALBeginAsyncReader", dynlib: gdalLib, raises: []
.}

proc GDALEndAsyncReader*(
  hDS: GDALDatasetH, hAsynchReaderH: GDALAsyncReaderH
) {.gdalCall, importc: "GDALEndAsyncReader", dynlib: gdalLib, raises: [].}

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
): CPLErr {.gdalCall, importc: "GDALDatasetRasterIO", dynlib: gdalLib, raises: [].}

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
): CPLErr {.gdalCall, importc: "GDALDatasetRasterIOEx", dynlib: gdalLib, raises: [].}

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
): CPLErr {.gdalCall, importc: "GDALDatasetAdviseRead", dynlib: gdalLib, raises: [].}

proc GDALDatasetGetCompressionFormats*(
  hDS: GDALDatasetH,
  nXOff: cint,
  nYOff: cint,
  nXSize: cint,
  nYSize: cint,
  nBandCount: cint,
  panBandList: ptr cint,
): cstringArray {.
  cdecl, importc: "GDALDatasetGetCompressionFormats", dynlib: gdalLib, raises: []
.}

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
): CPLErr {.
  cdecl, importc: "GDALDatasetReadCompressedData", dynlib: gdalLib, raises: []
.}

proc GDALGetProjectionRef*(
  a0: GDALDatasetH
): cstring {.gdalCall, importc: "GDALGetProjectionRef", dynlib: gdalLib, raises: [].}

proc GDALGetSpatialRef*(
  a0: GDALDatasetH
): OGRSpatialReferenceH {.
  cdecl, importc: "GDALGetSpatialRef", dynlib: gdalLib, raises: []
.}

proc GDALSetProjection*(
  a0: GDALDatasetH, a1: cstring
): CPLErr {.gdalCall, importc: "GDALSetProjection", dynlib: gdalLib, raises: [].}

proc GDALSetSpatialRef*(
  a0: GDALDatasetH, a1: OGRSpatialReferenceH
): CPLErr {.cdecl, importc: "GDALSetSpatialRef", dynlib: gdalLib, raises: [].}

proc GDALGetGeoTransform*(
  a0: GDALDatasetH, a1: ptr cdouble
): CPLErr {.gdalCall, importc: "GDALGetGeoTransform", dynlib: gdalLib, raises: [].}

proc GDALSetGeoTransform*(
  a0: GDALDatasetH, a1: ptr cdouble
): CPLErr {.gdalCall, importc: "GDALSetGeoTransform", dynlib: gdalLib, raises: [].}

proc GDALGetExtent*(
  a0: GDALDatasetH, a1: ptr OGREnvelope, hCRS: OGRSpatialReferenceH
): CPLErr {.cdecl, importc: "GDALGetExtent", dynlib: gdalLib, raises: [].}

proc GDALGetExtentWGS84LongLat*(
  a0: GDALDatasetH, a1: ptr OGREnvelope
): CPLErr {.cdecl, importc: "GDALGetExtentWGS84LongLat", dynlib: gdalLib, raises: [].}

proc GDALDatasetGeolocationToPixelLine*(
  a0: GDALDatasetH,
  dfGeolocX: cdouble,
  dfGeolocY: cdouble,
  hSRS: OGRSpatialReferenceH,
  pdfPixel: ptr cdouble,
  pdfLine: ptr cdouble,
  papszTransformerOptions: CSLConstList,
): CPLErr {.
  cdecl, importc: "GDALDatasetGeolocationToPixelLine", dynlib: gdalLib, raises: []
.}

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
): CPLErr {.
  cdecl, importc: "GDALDatasetGetInterBandCovarianceMatrix", dynlib: gdalLib, raises: []
.}

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
  cdecl,
  importc: "GDALDatasetComputeInterBandCovarianceMatrix",
  dynlib: gdalLib,
  raises: []
.}

proc GDALGetGCPCount*(
  a0: GDALDatasetH
): cint {.gdalCall, importc: "GDALGetGCPCount", dynlib: gdalLib, raises: [].}

proc GDALGetGCPProjection*(
  a0: GDALDatasetH
): cstring {.gdalCall, importc: "GDALGetGCPProjection", dynlib: gdalLib, raises: [].}

proc GDALGetGCPSpatialRef*(
  a0: GDALDatasetH
): OGRSpatialReferenceH {.
  cdecl, importc: "GDALGetGCPSpatialRef", dynlib: gdalLib, raises: []
.}

proc GDALGetGCPs*(
  a0: GDALDatasetH
): ptr GDAL_GCP {.gdalCall, importc: "GDALGetGCPs", dynlib: gdalLib, raises: [].}

proc GDALSetGCPs*(
  a0: GDALDatasetH, a1: cint, a2: ptr GDAL_GCP, a3: cstring
): CPLErr {.gdalCall, importc: "GDALSetGCPs", dynlib: gdalLib, raises: [].}

proc GDALSetGCPs2*(
  a0: GDALDatasetH, a1: cint, a2: ptr GDAL_GCP, a3: OGRSpatialReferenceH
): CPLErr {.cdecl, importc: "GDALSetGCPs2", dynlib: gdalLib, raises: [].}

proc GDALGetInternalHandle*(
  a0: GDALDatasetH, a1: cstring
): pointer {.gdalCall, importc: "GDALGetInternalHandle", dynlib: gdalLib, raises: [].}

proc GDALReferenceDataset*(
  a0: GDALDatasetH
): cint {.gdalCall, importc: "GDALReferenceDataset", dynlib: gdalLib, raises: [].}

proc GDALDereferenceDataset*(
  a0: GDALDatasetH
): cint {.gdalCall, importc: "GDALDereferenceDataset", dynlib: gdalLib, raises: [].}

proc GDALReleaseDataset*(
  a0: GDALDatasetH
): cint {.gdalCall, importc: "GDALReleaseDataset", dynlib: gdalLib, raises: [].}

proc GDALBuildOverviews*(
  a0: GDALDatasetH,
  a1: cstring,
  a2: cint,
  a3: ptr cint,
  a4: cint,
  a5: ptr cint,
  a6: GDALProgressFunc,
  a7: pointer,
): CPLErr {.gdalCall, importc: "GDALBuildOverviews", dynlib: gdalLib, raises: [].}

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
): CPLErr {.gdalCall, importc: "GDALBuildOverviewsEx", dynlib: gdalLib, raises: [].}

proc GDALGetOpenDatasets*(
  hDS: ptr ptr GDALDatasetH, pnCount: ptr cint
) {.gdalCall, importc: "GDALGetOpenDatasets", dynlib: gdalLib, raises: [].}

proc GDALGetAccess*(
  hDS: GDALDatasetH
): cint {.gdalCall, importc: "GDALGetAccess", dynlib: gdalLib, raises: [].}

proc GDALFlushCache*(
  hDS: GDALDatasetH
): CPLErr {.gdalCall, importc: "GDALFlushCache", dynlib: gdalLib, raises: [].}

proc GDALDropCache*(
  hDS: GDALDatasetH
): CPLErr {.gdalCall, importc: "GDALDropCache", dynlib: gdalLib, raises: [].}

proc GDALCreateDatasetMaskBand*(
  hDS: GDALDatasetH, nFlags: cint
): CPLErr {.
  gdalCall, importc: "GDALCreateDatasetMaskBand", dynlib: gdalLib, raises: []
.}

proc GDALDatasetCopyWholeRaster*(
  hSrcDS: GDALDatasetH,
  hDstDS: GDALDatasetH,
  papszOptions: CSLConstList,
  pfnProgress: GDALProgressFunc,
  pProgressData: pointer,
): CPLErr {.
  gdalCall, importc: "GDALDatasetCopyWholeRaster", dynlib: gdalLib, raises: []
.}

proc GDALRasterBandCopyWholeRaster*(
  hSrcBand: GDALRasterBandH,
  hDstBand: GDALRasterBandH,
  constpapszOptions: cstringArray,
  pfnProgress: GDALProgressFunc,
  pProgressData: pointer,
): CPLErr {.
  gdalCall, importc: "GDALRasterBandCopyWholeRaster", dynlib: gdalLib, raises: []
.}

proc GDALRegenerateOverviews*(
  hSrcBand: GDALRasterBandH,
  nOverviewCount: cint,
  pahOverviewBands: ptr GDALRasterBandH,
  pszResampling: cstring,
  pfnProgress: GDALProgressFunc,
  pProgressData: pointer,
): CPLErr {.cdecl, importc: "GDALRegenerateOverviews", dynlib: gdalLib, raises: [].}

proc GDALRegenerateOverviewsEx*(
  hSrcBand: GDALRasterBandH,
  nOverviewCount: cint,
  pahOverviewBands: ptr GDALRasterBandH,
  pszResampling: cstring,
  pfnProgress: GDALProgressFunc,
  pProgressData: pointer,
  papszOptions: CSLConstList,
): CPLErr {.cdecl, importc: "GDALRegenerateOverviewsEx", dynlib: gdalLib, raises: [].}

proc GDALDatasetGetLayerCount*(
  a0: GDALDatasetH
): cint {.cdecl, importc: "GDALDatasetGetLayerCount", dynlib: gdalLib, raises: [].}

proc GDALDatasetGetLayer*(
  a0: GDALDatasetH, a1: cint
): OGRLayerH {.cdecl, importc: "GDALDatasetGetLayer", dynlib: gdalLib, raises: [].}

proc OGR_L_GetDataset*(
  hLayer: OGRLayerH
): GDALDatasetH {.cdecl, importc: "OGR_L_GetDataset", dynlib: gdalLib, raises: [].}

proc GDALDatasetGetLayerByName*(
  a0: GDALDatasetH, a1: cstring
): OGRLayerH {.
  cdecl, importc: "GDALDatasetGetLayerByName", dynlib: gdalLib, raises: []
.}

proc GDALDatasetIsLayerPrivate*(
  a0: GDALDatasetH, a1: cint
): cint {.cdecl, importc: "GDALDatasetIsLayerPrivate", dynlib: gdalLib, raises: [].}

proc GDALDatasetDeleteLayer*(
  a0: GDALDatasetH, a1: cint
): OGRErr {.cdecl, importc: "GDALDatasetDeleteLayer", dynlib: gdalLib, raises: [].}

proc GDALDatasetCreateLayer*(
  a0: GDALDatasetH,
  a1: cstring,
  a2: OGRSpatialReferenceH,
  a3: OGRwkbGeometryType,
  a4: CSLConstList,
): OGRLayerH {.cdecl, importc: "GDALDatasetCreateLayer", dynlib: gdalLib, raises: [].}

proc GDALDatasetCreateLayerFromGeomFieldDefn*(
  a0: GDALDatasetH, a1: cstring, a2: OGRGeomFieldDefnH, a3: CSLConstList
): OGRLayerH {.
  cdecl, importc: "GDALDatasetCreateLayerFromGeomFieldDefn", dynlib: gdalLib, raises: []
.}

proc GDALDatasetCopyLayer*(
  a0: GDALDatasetH, a1: OGRLayerH, a2: cstring, a3: CSLConstList
): OGRLayerH {.cdecl, importc: "GDALDatasetCopyLayer", dynlib: gdalLib, raises: [].}

proc GDALDatasetResetReading*(
  a0: GDALDatasetH
) {.cdecl, importc: "GDALDatasetResetReading", dynlib: gdalLib, raises: [].}

proc GDALDatasetGetNextFeature*(
  hDS: GDALDatasetH,
  phBelongingLayer: ptr OGRLayerH,
  pdfProgressPct: ptr cdouble,
  pfnProgress: GDALProgressFunc,
  pProgressData: pointer,
): OGRFeatureH {.
  cdecl, importc: "GDALDatasetGetNextFeature", dynlib: gdalLib, raises: []
.}

proc GDALDatasetTestCapability*(
  a0: GDALDatasetH, a1: cstring
): cint {.cdecl, importc: "GDALDatasetTestCapability", dynlib: gdalLib, raises: [].}

proc GDALDatasetExecuteSQL*(
  a0: GDALDatasetH, a1: cstring, a2: OGRGeometryH, a3: cstring
): OGRLayerH {.cdecl, importc: "GDALDatasetExecuteSQL", dynlib: gdalLib, raises: [].}

proc GDALDatasetAbortSQL*(
  a0: GDALDatasetH
): OGRErr {.cdecl, importc: "GDALDatasetAbortSQL", dynlib: gdalLib, raises: [].}

proc GDALDatasetReleaseResultSet*(
  a0: GDALDatasetH, a1: OGRLayerH
) {.cdecl, importc: "GDALDatasetReleaseResultSet", dynlib: gdalLib, raises: [].}

proc GDALDatasetGetStyleTable*(
  a0: GDALDatasetH
): OGRStyleTableH {.
  cdecl, importc: "GDALDatasetGetStyleTable", dynlib: gdalLib, raises: []
.}

proc GDALDatasetSetStyleTableDirectly*(
  a0: GDALDatasetH, a1: OGRStyleTableH
) {.cdecl, importc: "GDALDatasetSetStyleTableDirectly", dynlib: gdalLib, raises: [].}

proc GDALDatasetSetStyleTable*(
  a0: GDALDatasetH, a1: OGRStyleTableH
) {.cdecl, importc: "GDALDatasetSetStyleTable", dynlib: gdalLib, raises: [].}

proc GDALDatasetStartTransaction*(
  hDS: GDALDatasetH, bForce: cint
): OGRErr {.cdecl, importc: "GDALDatasetStartTransaction", dynlib: gdalLib, raises: [].}

proc GDALDatasetCommitTransaction*(
  hDS: GDALDatasetH
): OGRErr {.
  cdecl, importc: "GDALDatasetCommitTransaction", dynlib: gdalLib, raises: []
.}

proc GDALDatasetRollbackTransaction*(
  hDS: GDALDatasetH
): OGRErr {.
  cdecl, importc: "GDALDatasetRollbackTransaction", dynlib: gdalLib, raises: []
.}

proc GDALDatasetClearStatistics*(
  hDS: GDALDatasetH
) {.cdecl, importc: "GDALDatasetClearStatistics", dynlib: gdalLib, raises: [].}

proc GDALDatasetAsMDArray*(
  hDS: GDALDatasetH, papszOptions: CSLConstList
): GDALMDArrayH {.cdecl, importc: "GDALDatasetAsMDArray", dynlib: gdalLib, raises: [].}

proc GDALDatasetGetFieldDomainNames*(
  a0: GDALDatasetH, a1: CSLConstList
): cstringArray {.
  cdecl, importc: "GDALDatasetGetFieldDomainNames", dynlib: gdalLib, raises: []
.}

proc GDALDatasetGetFieldDomain*(
  hDS: GDALDatasetH, pszName: cstring
): OGRFieldDomainH {.
  cdecl, importc: "GDALDatasetGetFieldDomain", dynlib: gdalLib, raises: []
.}

proc GDALDatasetAddFieldDomain*(
  hDS: GDALDatasetH, hFieldDomain: OGRFieldDomainH, ppszFailureReason: cstringArray
): bool {.cdecl, importc: "GDALDatasetAddFieldDomain", dynlib: gdalLib, raises: [].}

proc GDALDatasetDeleteFieldDomain*(
  hDS: GDALDatasetH, pszName: cstring, ppszFailureReason: cstringArray
): bool {.cdecl, importc: "GDALDatasetDeleteFieldDomain", dynlib: gdalLib, raises: [].}

proc GDALDatasetUpdateFieldDomain*(
  hDS: GDALDatasetH, hFieldDomain: OGRFieldDomainH, ppszFailureReason: cstringArray
): bool {.cdecl, importc: "GDALDatasetUpdateFieldDomain", dynlib: gdalLib, raises: [].}

proc GDALDatasetGetRelationshipNames*(
  a0: GDALDatasetH, a1: CSLConstList
): cstringArray {.
  cdecl, importc: "GDALDatasetGetRelationshipNames", dynlib: gdalLib, raises: []
.}

proc GDALDatasetGetRelationship*(
  hDS: GDALDatasetH, pszName: cstring
): GDALRelationshipH {.
  cdecl, importc: "GDALDatasetGetRelationship", dynlib: gdalLib, raises: []
.}

proc GDALDatasetAddRelationship*(
  hDS: GDALDatasetH, hRelationship: GDALRelationshipH, ppszFailureReason: cstringArray
): bool {.cdecl, importc: "GDALDatasetAddRelationship", dynlib: gdalLib, raises: [].}

proc GDALDatasetDeleteRelationship*(
  hDS: GDALDatasetH, pszName: cstring, ppszFailureReason: cstringArray
): bool {.cdecl, importc: "GDALDatasetDeleteRelationship", dynlib: gdalLib, raises: [].}

proc GDALDatasetUpdateRelationship*(
  hDS: GDALDatasetH, hRelationship: GDALRelationshipH, ppszFailureReason: cstringArray
): bool {.cdecl, importc: "GDALDatasetUpdateRelationship", dynlib: gdalLib, raises: [].}

proc GDALDatasetSetQueryLoggerFunc*(
  hDS: GDALDatasetH, pfnQueryLoggerFunc: GDALQueryLoggerFunc, poQueryLoggerArg: pointer
): bool {.cdecl, importc: "GDALDatasetSetQueryLoggerFunc", dynlib: gdalLib, raises: [].}

proc GDALGetSubdatasetInfo*(
  pszFileName: cstring
): GDALSubdatasetInfoH {.
  cdecl, importc: "GDALGetSubdatasetInfo", dynlib: gdalLib, raises: []
.}

proc GDALSubdatasetInfoGetPathComponent*(
  hInfo: GDALSubdatasetInfoH
): cstring {.
  cdecl, importc: "GDALSubdatasetInfoGetPathComponent", dynlib: gdalLib, raises: []
.}

proc GDALSubdatasetInfoGetSubdatasetComponent*(
  hInfo: GDALSubdatasetInfoH
): cstring {.
  cdecl,
  importc: "GDALSubdatasetInfoGetSubdatasetComponent",
  dynlib: gdalLib,
  raises: []
.}

proc GDALSubdatasetInfoModifyPathComponent*(
  hInfo: GDALSubdatasetInfoH, pszNewPath: cstring
): cstring {.
  cdecl, importc: "GDALSubdatasetInfoModifyPathComponent", dynlib: gdalLib, raises: []
.}

proc GDALDestroySubdatasetInfo*(
  hInfo: GDALSubdatasetInfoH
) {.cdecl, importc: "GDALDestroySubdatasetInfo", dynlib: gdalLib, raises: [].}

proc GDALGetRasterDataType*(
  a0: GDALRasterBandH
): GDALDataType {.
  gdalCall, importc: "GDALGetRasterDataType", dynlib: gdalLib, raises: []
.}

proc GDALGetBlockSize*(
  a0: GDALRasterBandH, pnXSize: ptr cint, pnYSize: ptr cint
) {.gdalCall, importc: "GDALGetBlockSize", dynlib: gdalLib, raises: [].}

proc GDALGetActualBlockSize*(
  a0: GDALRasterBandH,
  nXBlockOff: cint,
  nYBlockOff: cint,
  pnXValid: ptr cint,
  pnYValid: ptr cint,
): CPLErr {.gdalCall, importc: "GDALGetActualBlockSize", dynlib: gdalLib, raises: [].}

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
): CPLErr {.gdalCall, importc: "GDALRasterAdviseRead", dynlib: gdalLib, raises: [].}

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
): CPLErr {.gdalCall, importc: "GDALRasterIO", dynlib: gdalLib, raises: [].}

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
): CPLErr {.gdalCall, importc: "GDALRasterIOEx", dynlib: gdalLib, raises: [].}

proc GDALReadBlock*(
  a0: GDALRasterBandH, a1: cint, a2: cint, a3: pointer
): CPLErr {.gdalCall, importc: "GDALReadBlock", dynlib: gdalLib, raises: [].}

proc GDALWriteBlock*(
  a0: GDALRasterBandH, a1: cint, a2: cint, a3: pointer
): CPLErr {.gdalCall, importc: "GDALWriteBlock", dynlib: gdalLib, raises: [].}

proc GDALGetRasterBandXSize*(
  a0: GDALRasterBandH
): cint {.gdalCall, importc: "GDALGetRasterBandXSize", dynlib: gdalLib, raises: [].}

proc GDALGetRasterBandYSize*(
  a0: GDALRasterBandH
): cint {.gdalCall, importc: "GDALGetRasterBandYSize", dynlib: gdalLib, raises: [].}

proc GDALGetRasterAccess*(
  a0: GDALRasterBandH
): GDALAccess {.gdalCall, importc: "GDALGetRasterAccess", dynlib: gdalLib, raises: [].}

proc GDALGetBandNumber*(
  a0: GDALRasterBandH
): cint {.gdalCall, importc: "GDALGetBandNumber", dynlib: gdalLib, raises: [].}

proc GDALGetBandDataset*(
  a0: GDALRasterBandH
): GDALDatasetH {.gdalCall, importc: "GDALGetBandDataset", dynlib: gdalLib, raises: [].}

proc GDALGetRasterColorInterpretation*(
  a0: GDALRasterBandH
): GDALColorInterp {.
  gdalCall, importc: "GDALGetRasterColorInterpretation", dynlib: gdalLib, raises: []
.}

proc GDALSetRasterColorInterpretation*(
  a0: GDALRasterBandH, a1: GDALColorInterp
): CPLErr {.
  gdalCall, importc: "GDALSetRasterColorInterpretation", dynlib: gdalLib, raises: []
.}

proc GDALGetRasterColorTable*(
  a0: GDALRasterBandH
): GDALColorTableH {.
  gdalCall, importc: "GDALGetRasterColorTable", dynlib: gdalLib, raises: []
.}

proc GDALSetRasterColorTable*(
  a0: GDALRasterBandH, a1: GDALColorTableH
): CPLErr {.gdalCall, importc: "GDALSetRasterColorTable", dynlib: gdalLib, raises: [].}

proc GDALHasArbitraryOverviews*(
  a0: GDALRasterBandH
): cint {.gdalCall, importc: "GDALHasArbitraryOverviews", dynlib: gdalLib, raises: [].}

proc GDALGetOverviewCount*(
  a0: GDALRasterBandH
): cint {.gdalCall, importc: "GDALGetOverviewCount", dynlib: gdalLib, raises: [].}

proc GDALGetOverview*(
  a0: GDALRasterBandH, a1: cint
): GDALRasterBandH {.gdalCall, importc: "GDALGetOverview", dynlib: gdalLib, raises: [].}

proc GDALGetRasterNoDataValue*(
  a0: GDALRasterBandH, a1: ptr cint
): cdouble {.
  gdalCall, importc: "GDALGetRasterNoDataValue", dynlib: gdalLib, raises: []
.}

proc GDALGetRasterNoDataValueAsInt64*(
  a0: GDALRasterBandH, a1: ptr cint
): int64 {.
  gdalCall, importc: "GDALGetRasterNoDataValueAsInt64", dynlib: gdalLib, raises: []
.}

proc GDALGetRasterNoDataValueAsUInt64*(
  a0: GDALRasterBandH, a1: ptr cint
): uint64 {.
  gdalCall, importc: "GDALGetRasterNoDataValueAsUInt64", dynlib: gdalLib, raises: []
.}

proc GDALSetRasterNoDataValue*(
  a0: GDALRasterBandH, a1: cdouble
): CPLErr {.gdalCall, importc: "GDALSetRasterNoDataValue", dynlib: gdalLib, raises: [].}

proc GDALSetRasterNoDataValueAsInt64*(
  a0: GDALRasterBandH, a1: int64
): CPLErr {.
  gdalCall, importc: "GDALSetRasterNoDataValueAsInt64", dynlib: gdalLib, raises: []
.}

proc GDALSetRasterNoDataValueAsUInt64*(
  a0: GDALRasterBandH, a1: uint64
): CPLErr {.
  gdalCall, importc: "GDALSetRasterNoDataValueAsUInt64", dynlib: gdalLib, raises: []
.}

proc GDALDeleteRasterNoDataValue*(
  a0: GDALRasterBandH
): CPLErr {.
  gdalCall, importc: "GDALDeleteRasterNoDataValue", dynlib: gdalLib, raises: []
.}

proc GDALGetRasterCategoryNames*(
  a0: GDALRasterBandH
): cstringArray {.
  gdalCall, importc: "GDALGetRasterCategoryNames", dynlib: gdalLib, raises: []
.}

proc GDALSetRasterCategoryNames*(
  a0: GDALRasterBandH, a1: CSLConstList
): CPLErr {.
  gdalCall, importc: "GDALSetRasterCategoryNames", dynlib: gdalLib, raises: []
.}

proc GDALGetRasterMinimum*(
  a0: GDALRasterBandH, pbSuccess: ptr cint
): cdouble {.gdalCall, importc: "GDALGetRasterMinimum", dynlib: gdalLib, raises: [].}

proc GDALGetRasterMaximum*(
  a0: GDALRasterBandH, pbSuccess: ptr cint
): cdouble {.gdalCall, importc: "GDALGetRasterMaximum", dynlib: gdalLib, raises: [].}

proc GDALGetRasterStatistics*(
  a0: GDALRasterBandH,
  bApproxOK: cint,
  bForce: cint,
  pdfMin: ptr cdouble,
  pdfMax: ptr cdouble,
  pdfMean: ptr cdouble,
  pdfStdDev: ptr cdouble,
): CPLErr {.gdalCall, importc: "GDALGetRasterStatistics", dynlib: gdalLib, raises: [].}

proc GDALComputeRasterStatistics*(
  a0: GDALRasterBandH,
  bApproxOK: cint,
  pdfMin: ptr cdouble,
  pdfMax: ptr cdouble,
  pdfMean: ptr cdouble,
  pdfStdDev: ptr cdouble,
  pfnProgress: GDALProgressFunc,
  pProgressData: pointer,
): CPLErr {.
  gdalCall, importc: "GDALComputeRasterStatistics", dynlib: gdalLib, raises: []
.}

proc GDALSetRasterStatistics*(
  hBand: GDALRasterBandH,
  dfMin: cdouble,
  dfMax: cdouble,
  dfMean: cdouble,
  dfStdDev: cdouble,
): CPLErr {.gdalCall, importc: "GDALSetRasterStatistics", dynlib: gdalLib, raises: [].}

proc GDALRasterBandAsMDArray*(
  a0: GDALRasterBandH
): GDALMDArrayH {.
  cdecl, importc: "GDALRasterBandAsMDArray", dynlib: gdalLib, raises: []
.}

proc GDALGetRasterUnitType*(
  a0: GDALRasterBandH
): cstring {.gdalCall, importc: "GDALGetRasterUnitType", dynlib: gdalLib, raises: [].}

proc GDALSetRasterUnitType*(
  hBand: GDALRasterBandH, pszNewValue: cstring
): CPLErr {.gdalCall, importc: "GDALSetRasterUnitType", dynlib: gdalLib, raises: [].}

proc GDALGetRasterOffset*(
  a0: GDALRasterBandH, pbSuccess: ptr cint
): cdouble {.gdalCall, importc: "GDALGetRasterOffset", dynlib: gdalLib, raises: [].}

proc GDALSetRasterOffset*(
  hBand: GDALRasterBandH, dfNewOffset: cdouble
): CPLErr {.gdalCall, importc: "GDALSetRasterOffset", dynlib: gdalLib, raises: [].}

proc GDALGetRasterScale*(
  a0: GDALRasterBandH, pbSuccess: ptr cint
): cdouble {.gdalCall, importc: "GDALGetRasterScale", dynlib: gdalLib, raises: [].}

proc GDALSetRasterScale*(
  hBand: GDALRasterBandH, dfNewOffset: cdouble
): CPLErr {.gdalCall, importc: "GDALSetRasterScale", dynlib: gdalLib, raises: [].}

proc GDALComputeRasterMinMax*(
  hBand: GDALRasterBandH, bApproxOK: cint, adfMinMax: ptr cdouble
): CPLErr {.gdalCall, importc: "GDALComputeRasterMinMax", dynlib: gdalLib, raises: [].}

proc GDALComputeRasterMinMaxLocation*(
  hBand: GDALRasterBandH,
  pdfMin: ptr cdouble,
  pdfMax: ptr cdouble,
  pnMinX: ptr cint,
  pnMinY: ptr cint,
  pnMaxX: ptr cint,
  pnMaxY: ptr cint,
): CPLErr {.
  cdecl, importc: "GDALComputeRasterMinMaxLocation", dynlib: gdalLib, raises: []
.}

proc GDALFlushRasterCache*(
  hBand: GDALRasterBandH
): CPLErr {.gdalCall, importc: "GDALFlushRasterCache", dynlib: gdalLib, raises: [].}

proc GDALDropRasterCache*(
  hBand: GDALRasterBandH
): CPLErr {.gdalCall, importc: "GDALDropRasterCache", dynlib: gdalLib, raises: [].}

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
): CPLErr {.gdalCall, importc: "GDALGetRasterHistogram", dynlib: gdalLib, raises: [].}

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
): CPLErr {.gdalCall, importc: "GDALGetRasterHistogramEx", dynlib: gdalLib, raises: [].}

proc GDALGetDefaultHistogram*(
  hBand: GDALRasterBandH,
  pdfMin: ptr cdouble,
  pdfMax: ptr cdouble,
  pnBuckets: ptr cint,
  ppanHistogram: ptr ptr cint,
  bForce: cint,
  pfnProgress: GDALProgressFunc,
  pProgressData: pointer,
): CPLErr {.gdalCall, importc: "GDALGetDefaultHistogram", dynlib: gdalLib, raises: [].}

proc GDALGetDefaultHistogramEx*(
  hBand: GDALRasterBandH,
  pdfMin: ptr cdouble,
  pdfMax: ptr cdouble,
  pnBuckets: ptr cint,
  ppanHistogram: ptr ptr GUIntBig,
  bForce: cint,
  pfnProgress: GDALProgressFunc,
  pProgressData: pointer,
): CPLErr {.
  gdalCall, importc: "GDALGetDefaultHistogramEx", dynlib: gdalLib, raises: []
.}

proc GDALSetDefaultHistogram*(
  hBand: GDALRasterBandH,
  dfMin: cdouble,
  dfMax: cdouble,
  nBuckets: cint,
  panHistogram: ptr cint,
): CPLErr {.gdalCall, importc: "GDALSetDefaultHistogram", dynlib: gdalLib, raises: [].}

proc GDALSetDefaultHistogramEx*(
  hBand: GDALRasterBandH,
  dfMin: cdouble,
  dfMax: cdouble,
  nBuckets: cint,
  panHistogram: ptr GUIntBig,
): CPLErr {.
  gdalCall, importc: "GDALSetDefaultHistogramEx", dynlib: gdalLib, raises: []
.}

proc GDALGetRandomRasterSample*(
  a0: GDALRasterBandH, a1: cint, a2: ptr cfloat
): cint {.gdalCall, importc: "GDALGetRandomRasterSample", dynlib: gdalLib, raises: [].}

proc GDALGetRasterSampleOverview*(
  a0: GDALRasterBandH, a1: cint
): GDALRasterBandH {.
  gdalCall, importc: "GDALGetRasterSampleOverview", dynlib: gdalLib, raises: []
.}

proc GDALGetRasterSampleOverviewEx*(
  a0: GDALRasterBandH, a1: GUIntBig
): GDALRasterBandH {.
  gdalCall, importc: "GDALGetRasterSampleOverviewEx", dynlib: gdalLib, raises: []
.}

proc GDALFillRaster*(
  hBand: GDALRasterBandH, dfRealValue: cdouble, dfImaginaryValue: cdouble
): CPLErr {.gdalCall, importc: "GDALFillRaster", dynlib: gdalLib, raises: [].}

proc GDALComputeBandStats*(
  hBand: GDALRasterBandH,
  nSampleStep: cint,
  pdfMean: ptr cdouble,
  pdfStdDev: ptr cdouble,
  pfnProgress: GDALProgressFunc,
  pProgressData: pointer,
): CPLErr {.gdalCall, importc: "GDALComputeBandStats", dynlib: gdalLib, raises: [].}

proc GDALOverviewMagnitudeCorrection*(
  hBaseBand: GDALRasterBandH,
  nOverviewCount: cint,
  pahOverviews: ptr GDALRasterBandH,
  pfnProgress: GDALProgressFunc,
  pProgressData: pointer,
): CPLErr {.
  cdecl, importc: "GDALOverviewMagnitudeCorrection", dynlib: gdalLib, raises: []
.}

proc GDALGetDefaultRAT*(
  hBand: GDALRasterBandH
): GDALRasterAttributeTableH {.
  gdalCall, importc: "GDALGetDefaultRAT", dynlib: gdalLib, raises: []
.}

proc GDALSetDefaultRAT*(
  a0: GDALRasterBandH, a1: GDALRasterAttributeTableH
): CPLErr {.gdalCall, importc: "GDALSetDefaultRAT", dynlib: gdalLib, raises: [].}

proc GDALAddDerivedBandPixelFunc*(
  pszName: cstring, pfnPixelFunc: GDALDerivedPixelFunc
): CPLErr {.
  gdalCall, importc: "GDALAddDerivedBandPixelFunc", dynlib: gdalLib, raises: []
.}

proc GDALAddDerivedBandPixelFuncWithArgs*(
  pszName: cstring, pfnPixelFunc: GDALDerivedPixelFuncWithArgs, pszMetadata: cstring
): CPLErr {.
  gdalCall, importc: "GDALAddDerivedBandPixelFuncWithArgs", dynlib: gdalLib, raises: []
.}

proc GDALRasterInterpolateAtPoint*(
  hBand: GDALRasterBandH,
  dfPixel: cdouble,
  dfLine: cdouble,
  eInterpolation: GDALRIOResampleAlg,
  pdfRealValue: ptr cdouble,
  pdfImagValue: ptr cdouble,
): CPLErr {.
  cdecl, importc: "GDALRasterInterpolateAtPoint", dynlib: gdalLib, raises: []
.}

proc GDALRasterInterpolateAtGeolocation*(
  hBand: GDALRasterBandH,
  dfGeolocX: cdouble,
  dfGeolocY: cdouble,
  hSRS: OGRSpatialReferenceH,
  eInterpolation: GDALRIOResampleAlg,
  pdfRealValue: ptr cdouble,
  pdfImagValue: ptr cdouble,
  papszTransformerOptions: CSLConstList,
): CPLErr {.
  cdecl, importc: "GDALRasterInterpolateAtGeolocation", dynlib: gdalLib, raises: []
.}

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
): CPLErr {.
  cdecl, importc: "GDALVRTRegisterProcessedDatasetFunc", dynlib: gdalLib, raises: []
.}

proc GDALGetMaskBand*(
  hBand: GDALRasterBandH
): GDALRasterBandH {.gdalCall, importc: "GDALGetMaskBand", dynlib: gdalLib, raises: [].}

proc GDALGetMaskFlags*(
  hBand: GDALRasterBandH
): cint {.gdalCall, importc: "GDALGetMaskFlags", dynlib: gdalLib, raises: [].}

proc GDALCreateMaskBand*(
  hBand: GDALRasterBandH, nFlags: cint
): CPLErr {.gdalCall, importc: "GDALCreateMaskBand", dynlib: gdalLib, raises: [].}

proc GDALIsMaskBand*(
  hBand: GDALRasterBandH
): bool {.cdecl, importc: "GDALIsMaskBand", dynlib: gdalLib, raises: [].}

proc GDALGetDataCoverageStatus*(
  hBand: GDALRasterBandH,
  nXOff: cint,
  nYOff: cint,
  nXSize: cint,
  nYSize: cint,
  nMaskFlagStop: cint,
  pdfDataPct: ptr cdouble,
): cint {.gdalCall, importc: "GDALGetDataCoverageStatus", dynlib: gdalLib, raises: [].}

proc GDALComputedRasterBandRelease*(
  hBand: GDALComputedRasterBandH
) {.cdecl, importc: "GDALComputedRasterBandRelease", dynlib: gdalLib, raises: [].}

proc GDALRasterBandUnaryOp*(
  hBand: GDALRasterBandH, eOp: GDALRasterAlgebraUnaryOperation
): GDALComputedRasterBandH {.
  cdecl, importc: "GDALRasterBandUnaryOp", dynlib: gdalLib, raises: []
.}

proc GDALRasterBandBinaryOpBand*(
  hBand: GDALRasterBandH,
  eOp: GDALRasterAlgebraBinaryOperation,
  hOtherBand: GDALRasterBandH,
): GDALComputedRasterBandH {.
  cdecl, importc: "GDALRasterBandBinaryOpBand", dynlib: gdalLib, raises: []
.}

proc GDALRasterBandBinaryOpDouble*(
  hBand: GDALRasterBandH, eOp: GDALRasterAlgebraBinaryOperation, constant: cdouble
): GDALComputedRasterBandH {.
  cdecl, importc: "GDALRasterBandBinaryOpDouble", dynlib: gdalLib, raises: []
.}

proc GDALRasterBandBinaryOpDoubleToBand*(
  constant: cdouble, eOp: GDALRasterAlgebraBinaryOperation, hBand: GDALRasterBandH
): GDALComputedRasterBandH {.
  cdecl, importc: "GDALRasterBandBinaryOpDoubleToBand", dynlib: gdalLib, raises: []
.}

proc GDALRasterBandIfThenElse*(
  hCondBand: GDALRasterBandH, hThenBand: GDALRasterBandH, hElseBand: GDALRasterBandH
): GDALComputedRasterBandH {.
  cdecl, importc: "GDALRasterBandIfThenElse", dynlib: gdalLib, raises: []
.}

proc GDALRasterBandAsDataType*(
  hBand: GDALRasterBandH, eDT: GDALDataType
): GDALComputedRasterBandH {.
  cdecl, importc: "GDALRasterBandAsDataType", dynlib: gdalLib, raises: []
.}

proc GDALMaximumOfNBands*(
  nBandCount: csize_t, pahBands: ptr GDALRasterBandH
): GDALComputedRasterBandH {.
  cdecl, importc: "GDALMaximumOfNBands", dynlib: gdalLib, raises: []
.}

proc GDALRasterBandMaxConstant*(
  hBand: GDALRasterBandH, dfConstant: cdouble
): GDALComputedRasterBandH {.
  cdecl, importc: "GDALRasterBandMaxConstant", dynlib: gdalLib, raises: []
.}

proc GDALMinimumOfNBands*(
  nBandCount: csize_t, pahBands: ptr GDALRasterBandH
): GDALComputedRasterBandH {.
  cdecl, importc: "GDALMinimumOfNBands", dynlib: gdalLib, raises: []
.}

proc GDALRasterBandMinConstant*(
  hBand: GDALRasterBandH, dfConstant: cdouble
): GDALComputedRasterBandH {.
  cdecl, importc: "GDALRasterBandMinConstant", dynlib: gdalLib, raises: []
.}

proc GDALMeanOfNBands*(
  nBandCount: csize_t, pahBands: ptr GDALRasterBandH
): GDALComputedRasterBandH {.
  cdecl, importc: "GDALMeanOfNBands", dynlib: gdalLib, raises: []
.}

proc GDALARGetNextUpdatedRegion*(
  hARIO: GDALAsyncReaderH,
  dfTimeout: cdouble,
  pnXBufOff: ptr cint,
  pnYBufOff: ptr cint,
  pnXBufSize: ptr cint,
  pnYBufSize: ptr cint,
): GDALAsyncStatusType {.
  gdalCall, importc: "GDALARGetNextUpdatedRegion", dynlib: gdalLib, raises: []
.}

proc GDALARLockBuffer*(
  hARIO: GDALAsyncReaderH, dfTimeout: cdouble
): cint {.gdalCall, importc: "GDALARLockBuffer", dynlib: gdalLib, raises: [].}

proc GDALARUnlockBuffer*(
  hARIO: GDALAsyncReaderH
) {.gdalCall, importc: "GDALARUnlockBuffer", dynlib: gdalLib, raises: [].}

proc GDALGeneralCmdLineProcessor*(
  nArgc: cint, ppapszArgv: ptr cstringArray, nOptions: cint
): cint {.
  gdalCall, importc: "GDALGeneralCmdLineProcessor", dynlib: gdalLib, raises: []
.}

proc GDALSwapWords*(
  pData: pointer, nWordSize: cint, nWordCount: cint, nWordSkip: cint
) {.gdalCall, importc: "GDALSwapWords", dynlib: gdalLib, raises: [].}

proc GDALSwapWordsEx*(
  pData: pointer, nWordSize: cint, nWordCount: csize_t, nWordSkip: cint
) {.gdalCall, importc: "GDALSwapWordsEx", dynlib: gdalLib, raises: [].}

proc GDALCopyWords*(
  pSrcData: pointer,
  eSrcType: GDALDataType,
  nSrcPixelOffset: cint,
  pDstData: pointer,
  eDstType: GDALDataType,
  nDstPixelOffset: cint,
  nWordCount: cint,
) {.gdalCall, importc: "GDALCopyWords", dynlib: gdalLib, raises: [].}

proc GDALCopyWords64*(
  pSrcData: pointer,
  eSrcType: GDALDataType,
  nSrcPixelOffset: cint,
  pDstData: pointer,
  eDstType: GDALDataType,
  nDstPixelOffset: cint,
  nWordCount: GPtrDiff_t,
) {.gdalCall, importc: "GDALCopyWords64", dynlib: gdalLib, raises: [].}

proc GDALCopyBits*(
  pabySrcData: ptr GByte,
  nSrcOffset: cint,
  nSrcStep: cint,
  pabyDstData: ptr GByte,
  nDstOffset: cint,
  nDstStep: cint,
  nBitCount: cint,
  nStepCount: cint,
) {.cdecl, importc: "GDALCopyBits", dynlib: gdalLib, raises: [].}

proc GDALDeinterleave*(
  pSourceBuffer: pointer,
  eSourceDT: GDALDataType,
  nComponents: cint,
  ppDestBuffer: ptr pointer,
  eDestDT: GDALDataType,
  nIters: csize_t,
) {.cdecl, importc: "GDALDeinterleave", dynlib: gdalLib, raises: [].}

proc GDALTranspose2D*(
  pSrc: pointer,
  eSrcType: GDALDataType,
  pDst: pointer,
  eDstType: GDALDataType,
  nSrcWidth: csize_t,
  nSrcHeight: csize_t,
) {.cdecl, importc: "GDALTranspose2D", dynlib: gdalLib, raises: [].}

proc GDALGetNoDataReplacementValue*(
  a0: GDALDataType, a1: cdouble
): cdouble {.
  cdecl, importc: "GDALGetNoDataReplacementValue", dynlib: gdalLib, raises: []
.}

proc GDALLoadWorldFile*(
  a0: cstring, a1: ptr cdouble
): cint {.gdalCall, importc: "GDALLoadWorldFile", dynlib: gdalLib, raises: [].}

proc GDALReadWorldFile*(
  a0: cstring, a1: cstring, a2: ptr cdouble
): cint {.gdalCall, importc: "GDALReadWorldFile", dynlib: gdalLib, raises: [].}

proc GDALWriteWorldFile*(
  a0: cstring, a1: cstring, a2: ptr cdouble
): cint {.gdalCall, importc: "GDALWriteWorldFile", dynlib: gdalLib, raises: [].}

proc GDALLoadTabFile*(
  a0: cstring, a1: ptr cdouble, a2: cstringArray, a3: ptr cint, a4: ptr ptr GDAL_GCP
): cint {.gdalCall, importc: "GDALLoadTabFile", dynlib: gdalLib, raises: [].}

proc GDALReadTabFile*(
  a0: cstring, a1: ptr cdouble, a2: cstringArray, a3: ptr cint, a4: ptr ptr GDAL_GCP
): cint {.gdalCall, importc: "GDALReadTabFile", dynlib: gdalLib, raises: [].}

proc GDALLoadOziMapFile*(
  a0: cstring, a1: ptr cdouble, a2: cstringArray, a3: ptr cint, a4: ptr ptr GDAL_GCP
): cint {.gdalCall, importc: "GDALLoadOziMapFile", dynlib: gdalLib, raises: [].}

proc GDALReadOziMapFile*(
  a0: cstring, a1: ptr cdouble, a2: cstringArray, a3: ptr cint, a4: ptr ptr GDAL_GCP
): cint {.gdalCall, importc: "GDALReadOziMapFile", dynlib: gdalLib, raises: [].}

proc GDALDecToDMS*(
  a0: cdouble, a1: cstring, a2: cint
): cstring {.gdalCall, importc: "GDALDecToDMS", dynlib: gdalLib, raises: [].}

proc GDALPackedDMSToDec*(
  a0: cdouble
): cdouble {.gdalCall, importc: "GDALPackedDMSToDec", dynlib: gdalLib, raises: [].}

proc GDALDecToPackedDMS*(
  a0: cdouble
): cdouble {.gdalCall, importc: "GDALDecToPackedDMS", dynlib: gdalLib, raises: [].}

proc GDALExtractRPCInfoV1*(
  a0: CSLConstList, a1: ptr GDALRPCInfoV1
): cint {.gdalCall, importc: "GDALExtractRPCInfo", dynlib: gdalLib, raises: [].}

proc GDALExtractRPCInfoV2*(
  a0: CSLConstList, a1: ptr GDALRPCInfoV2
): cint {.gdalCall, importc: "GDALExtractRPCInfoV2", dynlib: gdalLib, raises: [].}

proc GDALCreateColorTable*(
  a0: GDALPaletteInterp
): GDALColorTableH {.
  gdalCall, importc: "GDALCreateColorTable", dynlib: gdalLib, raises: []
.}

proc GDALDestroyColorTable*(
  a0: GDALColorTableH
) {.gdalCall, importc: "GDALDestroyColorTable", dynlib: gdalLib, raises: [].}

proc GDALCloneColorTable*(
  a0: GDALColorTableH
): GDALColorTableH {.
  gdalCall, importc: "GDALCloneColorTable", dynlib: gdalLib, raises: []
.}

proc GDALGetPaletteInterpretation*(
  a0: GDALColorTableH
): GDALPaletteInterp {.
  gdalCall, importc: "GDALGetPaletteInterpretation", dynlib: gdalLib, raises: []
.}

proc GDALGetColorEntryCount*(
  a0: GDALColorTableH
): cint {.gdalCall, importc: "GDALGetColorEntryCount", dynlib: gdalLib, raises: [].}

proc GDALGetColorEntry*(
  a0: GDALColorTableH, a1: cint
): ptr GDALColorEntry {.
  gdalCall, importc: "GDALGetColorEntry", dynlib: gdalLib, raises: []
.}

proc GDALGetColorEntryAsRGB*(
  a0: GDALColorTableH, a1: cint, a2: ptr GDALColorEntry
): cint {.gdalCall, importc: "GDALGetColorEntryAsRGB", dynlib: gdalLib, raises: [].}

proc GDALSetColorEntry*(
  a0: GDALColorTableH, a1: cint, a2: ptr GDALColorEntry
) {.gdalCall, importc: "GDALSetColorEntry", dynlib: gdalLib, raises: [].}

proc GDALCreateColorRamp*(
  hTable: GDALColorTableH,
  nStartIndex: cint,
  psStartColor: ptr GDALColorEntry,
  nEndIndex: cint,
  psEndColor: ptr GDALColorEntry,
) {.gdalCall, importc: "GDALCreateColorRamp", dynlib: gdalLib, raises: [].}

proc GDALCreateRasterAttributeTable*(): GDALRasterAttributeTableH {.
  gdalCall, importc: "GDALCreateRasterAttributeTable", dynlib: gdalLib, raises: []
.}

proc GDALDestroyRasterAttributeTable*(
  a0: GDALRasterAttributeTableH
) {.gdalCall, importc: "GDALDestroyRasterAttributeTable", dynlib: gdalLib, raises: [].}

proc GDALRATGetColumnCount*(
  a0: GDALRasterAttributeTableH
): cint {.gdalCall, importc: "GDALRATGetColumnCount", dynlib: gdalLib, raises: [].}

proc GDALRATGetNameOfCol*(
  a0: GDALRasterAttributeTableH, a1: cint
): cstring {.gdalCall, importc: "GDALRATGetNameOfCol", dynlib: gdalLib, raises: [].}

proc GDALRATGetUsageOfCol*(
  a0: GDALRasterAttributeTableH, a1: cint
): GDALRATFieldUsage {.
  gdalCall, importc: "GDALRATGetUsageOfCol", dynlib: gdalLib, raises: []
.}

proc GDALRATGetTypeOfCol*(
  a0: GDALRasterAttributeTableH, a1: cint
): GDALRATFieldType {.
  gdalCall, importc: "GDALRATGetTypeOfCol", dynlib: gdalLib, raises: []
.}

proc GDALGetRATFieldTypeName*(
  a0: GDALRATFieldType
): cstring {.cdecl, importc: "GDALGetRATFieldTypeName", dynlib: gdalLib, raises: [].}

proc GDALGetRATFieldUsageName*(
  a0: GDALRATFieldUsage
): cstring {.cdecl, importc: "GDALGetRATFieldUsageName", dynlib: gdalLib, raises: [].}

proc GDALRATGetColOfUsage*(
  a0: GDALRasterAttributeTableH, a1: GDALRATFieldUsage
): cint {.gdalCall, importc: "GDALRATGetColOfUsage", dynlib: gdalLib, raises: [].}

proc GDALRATGetRowCount*(
  a0: GDALRasterAttributeTableH
): cint {.gdalCall, importc: "GDALRATGetRowCount", dynlib: gdalLib, raises: [].}

proc GDALRATGetValueAsString*(
  a0: GDALRasterAttributeTableH, iRow: cint, iField: cint
): cstring {.gdalCall, importc: "GDALRATGetValueAsString", dynlib: gdalLib, raises: [].}

proc GDALRATGetValueAsInt*(
  a0: GDALRasterAttributeTableH, iRow: cint, iField: cint
): cint {.gdalCall, importc: "GDALRATGetValueAsInt", dynlib: gdalLib, raises: [].}

proc GDALRATGetValueAsDouble*(
  a0: GDALRasterAttributeTableH, iRow: cint, iField: cint
): cdouble {.gdalCall, importc: "GDALRATGetValueAsDouble", dynlib: gdalLib, raises: [].}

proc GDALRATGetValueAsBoolean*(
  a0: GDALRasterAttributeTableH, iRow: cint, iField: cint
): bool {.cdecl, importc: "GDALRATGetValueAsBoolean", dynlib: gdalLib, raises: [].}

proc GDALRATGetValueAsDateTime*(
  a0: GDALRasterAttributeTableH,
  iRow: cint,
  iField: cint,
  psDateTime: ptr GDALRATDateTime,
): CPLErr {.cdecl, importc: "GDALRATGetValueAsDateTime", dynlib: gdalLib, raises: [].}

proc GDALRATGetValueAsWKBGeometry*(
  a0: GDALRasterAttributeTableH, iRow: cint, iField: cint, pnWKBSize: ptr csize_t
): ptr GByte {.
  cdecl, importc: "GDALRATGetValueAsWKBGeometry", dynlib: gdalLib, raises: []
.}

proc GDALRATSetValueAsString*(
  a0: GDALRasterAttributeTableH, iRow: cint, iField: cint, a3: cstring
) {.gdalCall, importc: "GDALRATSetValueAsString", dynlib: gdalLib, raises: [].}

proc GDALRATSetValueAsInt*(
  a0: GDALRasterAttributeTableH, iRow: cint, iField: cint, a3: cint
) {.gdalCall, importc: "GDALRATSetValueAsInt", dynlib: gdalLib, raises: [].}

proc GDALRATSetValueAsDouble*(
  a0: GDALRasterAttributeTableH, iRow: cint, iField: cint, a3: cdouble
) {.gdalCall, importc: "GDALRATSetValueAsDouble", dynlib: gdalLib, raises: [].}

proc GDALRATSetValueAsBoolean*(
  a0: GDALRasterAttributeTableH, iRow: cint, iField: cint, a3: bool
): CPLErr {.cdecl, importc: "GDALRATSetValueAsBoolean", dynlib: gdalLib, raises: [].}

proc GDALRATSetValueAsDateTime*(
  a0: GDALRasterAttributeTableH,
  iRow: cint,
  iField: cint,
  psDateTime: ptr GDALRATDateTime,
): CPLErr {.cdecl, importc: "GDALRATSetValueAsDateTime", dynlib: gdalLib, raises: [].}

proc GDALRATSetValueAsWKBGeometry*(
  a0: GDALRasterAttributeTableH,
  iRow: cint,
  iField: cint,
  pabyWKB: pointer,
  nWKBSize: csize_t,
): CPLErr {.
  cdecl, importc: "GDALRATSetValueAsWKBGeometry", dynlib: gdalLib, raises: []
.}

proc GDALRATChangesAreWrittenToFile*(
  hRAT: GDALRasterAttributeTableH
): cint {.
  gdalCall, importc: "GDALRATChangesAreWrittenToFile", dynlib: gdalLib, raises: []
.}

proc GDALRATValuesIOAsDouble*(
  hRAT: GDALRasterAttributeTableH,
  eRWFlag: GDALRWFlag,
  iField: cint,
  iStartRow: cint,
  iLength: cint,
  pdfData: ptr cdouble,
): CPLErr {.gdalCall, importc: "GDALRATValuesIOAsDouble", dynlib: gdalLib, raises: [].}

proc GDALRATValuesIOAsInteger*(
  hRAT: GDALRasterAttributeTableH,
  eRWFlag: GDALRWFlag,
  iField: cint,
  iStartRow: cint,
  iLength: cint,
  pnData: ptr cint,
): CPLErr {.gdalCall, importc: "GDALRATValuesIOAsInteger", dynlib: gdalLib, raises: [].}

proc GDALRATValuesIOAsString*(
  hRAT: GDALRasterAttributeTableH,
  eRWFlag: GDALRWFlag,
  iField: cint,
  iStartRow: cint,
  iLength: cint,
  papszStrList: cstringArray,
): CPLErr {.gdalCall, importc: "GDALRATValuesIOAsString", dynlib: gdalLib, raises: [].}

proc GDALRATValuesIOAsBoolean*(
  hRAT: GDALRasterAttributeTableH,
  eRWFlag: GDALRWFlag,
  iField: cint,
  iStartRow: cint,
  iLength: cint,
  pbData: ptr bool,
): CPLErr {.cdecl, importc: "GDALRATValuesIOAsBoolean", dynlib: gdalLib, raises: [].}

proc GDALRATValuesIOAsDateTime*(
  hRAT: GDALRasterAttributeTableH,
  eRWFlag: GDALRWFlag,
  iField: cint,
  iStartRow: cint,
  iLength: cint,
  pasDateTime: ptr GDALRATDateTime,
): CPLErr {.cdecl, importc: "GDALRATValuesIOAsDateTime", dynlib: gdalLib, raises: [].}

proc GDALRATValuesIOAsWKBGeometry*(
  hRAT: GDALRasterAttributeTableH,
  eRWFlag: GDALRWFlag,
  iField: cint,
  iStartRow: cint,
  iLength: cint,
  ppabyWKB: ptr ptr GByte,
  pnWKBSize: ptr csize_t,
): CPLErr {.
  cdecl, importc: "GDALRATValuesIOAsWKBGeometry", dynlib: gdalLib, raises: []
.}

proc GDALRATSetRowCount*(
  a0: GDALRasterAttributeTableH, a1: cint
) {.gdalCall, importc: "GDALRATSetRowCount", dynlib: gdalLib, raises: [].}

proc GDALRATCreateColumn*(
  a0: GDALRasterAttributeTableH,
  a1: cstring,
  a2: GDALRATFieldType,
  a3: GDALRATFieldUsage,
): CPLErr {.gdalCall, importc: "GDALRATCreateColumn", dynlib: gdalLib, raises: [].}

proc GDALRATSetLinearBinning*(
  a0: GDALRasterAttributeTableH, a1: cdouble, a2: cdouble
): CPLErr {.gdalCall, importc: "GDALRATSetLinearBinning", dynlib: gdalLib, raises: [].}

proc GDALRATGetLinearBinning*(
  a0: GDALRasterAttributeTableH, a1: ptr cdouble, a2: ptr cdouble
): cint {.gdalCall, importc: "GDALRATGetLinearBinning", dynlib: gdalLib, raises: [].}

proc GDALRATSetTableType*(
  hRAT: GDALRasterAttributeTableH, eInTableType: GDALRATTableType
): CPLErr {.gdalCall, importc: "GDALRATSetTableType", dynlib: gdalLib, raises: [].}

proc GDALRATGetTableType*(
  hRAT: GDALRasterAttributeTableH
): GDALRATTableType {.
  gdalCall, importc: "GDALRATGetTableType", dynlib: gdalLib, raises: []
.}

proc GDALRATInitializeFromColorTable*(
  a0: GDALRasterAttributeTableH, a1: GDALColorTableH
): CPLErr {.
  gdalCall, importc: "GDALRATInitializeFromColorTable", dynlib: gdalLib, raises: []
.}

proc GDALRATTranslateToColorTable*(
  a0: GDALRasterAttributeTableH, nEntryCount: cint
): GDALColorTableH {.
  gdalCall, importc: "GDALRATTranslateToColorTable", dynlib: gdalLib, raises: []
.}

proc GDALRATDumpReadable*(
  a0: GDALRasterAttributeTableH, a1: ptr GdalFile
) {.gdalCall, importc: "GDALRATDumpReadable", dynlib: gdalLib, raises: [].}

proc GDALRATClone*(
  a0: GDALRasterAttributeTableH
): GDALRasterAttributeTableH {.
  gdalCall, importc: "GDALRATClone", dynlib: gdalLib, raises: []
.}

proc GDALRATSerializeJSON*(
  a0: GDALRasterAttributeTableH
): pointer {.gdalCall, importc: "GDALRATSerializeJSON", dynlib: gdalLib, raises: [].}

proc GDALRATGetRowOfValue*(
  a0: GDALRasterAttributeTableH, a1: cdouble
): cint {.gdalCall, importc: "GDALRATGetRowOfValue", dynlib: gdalLib, raises: [].}

proc GDALRATRemoveStatistics*(
  a0: GDALRasterAttributeTableH
) {.gdalCall, importc: "GDALRATRemoveStatistics", dynlib: gdalLib, raises: [].}

proc GDALRelationshipCreate*(
  a0: cstring, a1: cstring, a2: cstring, a3: GDALRelationshipCardinality
): GDALRelationshipH {.
  cdecl, importc: "GDALRelationshipCreate", dynlib: gdalLib, raises: []
.}

proc GDALDestroyRelationship*(
  a0: GDALRelationshipH
) {.gdalCall, importc: "GDALDestroyRelationship", dynlib: gdalLib, raises: [].}

proc GDALRelationshipGetName*(
  a0: GDALRelationshipH
): cstring {.cdecl, importc: "GDALRelationshipGetName", dynlib: gdalLib, raises: [].}

proc GDALRelationshipGetCardinality*(
  a0: GDALRelationshipH
): GDALRelationshipCardinality {.
  cdecl, importc: "GDALRelationshipGetCardinality", dynlib: gdalLib, raises: []
.}

proc GDALRelationshipGetLeftTableName*(
  a0: GDALRelationshipH
): cstring {.
  cdecl, importc: "GDALRelationshipGetLeftTableName", dynlib: gdalLib, raises: []
.}

proc GDALRelationshipGetRightTableName*(
  a0: GDALRelationshipH
): cstring {.
  cdecl, importc: "GDALRelationshipGetRightTableName", dynlib: gdalLib, raises: []
.}

proc GDALRelationshipGetMappingTableName*(
  a0: GDALRelationshipH
): cstring {.
  cdecl, importc: "GDALRelationshipGetMappingTableName", dynlib: gdalLib, raises: []
.}

proc GDALRelationshipSetMappingTableName*(
  a0: GDALRelationshipH, a1: cstring
) {.cdecl, importc: "GDALRelationshipSetMappingTableName", dynlib: gdalLib, raises: [].}

proc GDALRelationshipGetLeftTableFields*(
  a0: GDALRelationshipH
): cstringArray {.
  cdecl, importc: "GDALRelationshipGetLeftTableFields", dynlib: gdalLib, raises: []
.}

proc GDALRelationshipGetRightTableFields*(
  a0: GDALRelationshipH
): cstringArray {.
  cdecl, importc: "GDALRelationshipGetRightTableFields", dynlib: gdalLib, raises: []
.}

proc GDALRelationshipSetLeftTableFields*(
  a0: GDALRelationshipH, a1: CSLConstList
) {.cdecl, importc: "GDALRelationshipSetLeftTableFields", dynlib: gdalLib, raises: [].}

proc GDALRelationshipSetRightTableFields*(
  a0: GDALRelationshipH, a1: CSLConstList
) {.cdecl, importc: "GDALRelationshipSetRightTableFields", dynlib: gdalLib, raises: [].}

proc GDALRelationshipGetLeftMappingTableFields*(
  a0: GDALRelationshipH
): cstringArray {.
  cdecl,
  importc: "GDALRelationshipGetLeftMappingTableFields",
  dynlib: gdalLib,
  raises: []
.}

proc GDALRelationshipGetRightMappingTableFields*(
  a0: GDALRelationshipH
): cstringArray {.
  cdecl,
  importc: "GDALRelationshipGetRightMappingTableFields",
  dynlib: gdalLib,
  raises: []
.}

proc GDALRelationshipSetLeftMappingTableFields*(
  a0: GDALRelationshipH, a1: CSLConstList
) {.
  cdecl,
  importc: "GDALRelationshipSetLeftMappingTableFields",
  dynlib: gdalLib,
  raises: []
.}

proc GDALRelationshipSetRightMappingTableFields*(
  a0: GDALRelationshipH, a1: CSLConstList
) {.
  cdecl,
  importc: "GDALRelationshipSetRightMappingTableFields",
  dynlib: gdalLib,
  raises: []
.}

proc GDALRelationshipGetType*(
  a0: GDALRelationshipH
): GDALRelationshipType {.
  cdecl, importc: "GDALRelationshipGetType", dynlib: gdalLib, raises: []
.}

proc GDALRelationshipSetType*(
  a0: GDALRelationshipH, a1: GDALRelationshipType
) {.cdecl, importc: "GDALRelationshipSetType", dynlib: gdalLib, raises: [].}

proc GDALRelationshipGetForwardPathLabel*(
  a0: GDALRelationshipH
): cstring {.
  cdecl, importc: "GDALRelationshipGetForwardPathLabel", dynlib: gdalLib, raises: []
.}

proc GDALRelationshipSetForwardPathLabel*(
  a0: GDALRelationshipH, a1: cstring
) {.cdecl, importc: "GDALRelationshipSetForwardPathLabel", dynlib: gdalLib, raises: [].}

proc GDALRelationshipGetBackwardPathLabel*(
  a0: GDALRelationshipH
): cstring {.
  cdecl, importc: "GDALRelationshipGetBackwardPathLabel", dynlib: gdalLib, raises: []
.}

proc GDALRelationshipSetBackwardPathLabel*(
  a0: GDALRelationshipH, a1: cstring
) {.
  cdecl, importc: "GDALRelationshipSetBackwardPathLabel", dynlib: gdalLib, raises: []
.}

proc GDALRelationshipGetRelatedTableType*(
  a0: GDALRelationshipH
): cstring {.
  cdecl, importc: "GDALRelationshipGetRelatedTableType", dynlib: gdalLib, raises: []
.}

proc GDALRelationshipSetRelatedTableType*(
  a0: GDALRelationshipH, a1: cstring
) {.cdecl, importc: "GDALRelationshipSetRelatedTableType", dynlib: gdalLib, raises: [].}

proc GDALSetCacheMax*(
  nBytes: cint
) {.gdalCall, importc: "GDALSetCacheMax", dynlib: gdalLib, raises: [].}

proc GDALGetCacheMax*(): cint {.
  gdalCall, importc: "GDALGetCacheMax", dynlib: gdalLib, raises: []
.}

proc GDALGetCacheUsed*(): cint {.
  gdalCall, importc: "GDALGetCacheUsed", dynlib: gdalLib, raises: []
.}

proc GDALSetCacheMax64*(
  nBytes: GIntBig
) {.gdalCall, importc: "GDALSetCacheMax64", dynlib: gdalLib, raises: [].}

proc GDALGetCacheMax64*(): GIntBig {.
  gdalCall, importc: "GDALGetCacheMax64", dynlib: gdalLib, raises: []
.}

proc GDALGetCacheUsed64*(): GIntBig {.
  gdalCall, importc: "GDALGetCacheUsed64", dynlib: gdalLib, raises: []
.}

proc GDALFlushCacheBlock*(): cint {.
  gdalCall, importc: "GDALFlushCacheBlock", dynlib: gdalLib, raises: []
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
): ptr CPLVirtualMem {.
  cdecl, importc: "GDALDatasetGetVirtualMem", dynlib: gdalLib, raises: []
.}

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
): ptr CPLVirtualMem {.
  cdecl, importc: "GDALRasterBandGetVirtualMem", dynlib: gdalLib, raises: []
.}

proc GDALGetVirtualMemAuto*(
  hBand: GDALRasterBandH,
  eRWFlag: GDALRWFlag,
  pnPixelSpace: ptr cint,
  pnLineSpace: ptr GIntBig,
  papszOptions: CSLConstList,
): ptr CPLVirtualMem {.
  cdecl, importc: "GDALGetVirtualMemAuto", dynlib: gdalLib, raises: []
.}

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
): ptr CPLVirtualMem {.
  cdecl, importc: "GDALDatasetGetTiledVirtualMem", dynlib: gdalLib, raises: []
.}

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
  cdecl, importc: "GDALRasterBandGetTiledVirtualMem", dynlib: gdalLib, raises: []
.}

proc GDALCreatePansharpenedVRT*(
  pszXML: cstring,
  hPanchroBand: GDALRasterBandH,
  nInputSpectralBands: cint,
  pahInputSpectralBands: ptr GDALRasterBandH,
): GDALDatasetH {.
  cdecl, importc: "GDALCreatePansharpenedVRT", dynlib: gdalLib, raises: []
.}

proc GDALGetJPEG2000Structure*(
  pszFilename: cstring, papszOptions: CSLConstList
): ptr CPLXMLNode {.
  cdecl, importc: "GDALGetJPEG2000Structure", dynlib: gdalLib, raises: []
.}

proc GDALCreateMultiDimensional*(
  hDriver: GDALDriverH,
  pszName: cstring,
  papszRootGroupOptions: CSLConstList,
  papszOptions: CSLConstList,
): GDALDatasetH {.
  cdecl, importc: "GDALCreateMultiDimensional", dynlib: gdalLib, raises: []
.}

proc GDALExtendedDataTypeCreate*(
  eType: GDALDataType
): GDALExtendedDataTypeH {.
  cdecl, importc: "GDALExtendedDataTypeCreate", dynlib: gdalLib, raises: []
.}

proc GDALExtendedDataTypeCreateString*(
  nMaxStringLength: csize_t
): GDALExtendedDataTypeH {.
  cdecl, importc: "GDALExtendedDataTypeCreateString", dynlib: gdalLib, raises: []
.}

proc GDALExtendedDataTypeCreateStringEx*(
  nMaxStringLength: csize_t, eSubType: GDALExtendedDataTypeSubType
): GDALExtendedDataTypeH {.
  cdecl, importc: "GDALExtendedDataTypeCreateStringEx", dynlib: gdalLib, raises: []
.}

proc GDALExtendedDataTypeCreateCompound*(
  pszName: cstring,
  nTotalSize: csize_t,
  nComponents: csize_t,
  comps: ptr GDALEDTComponentH,
): GDALExtendedDataTypeH {.
  cdecl, importc: "GDALExtendedDataTypeCreateCompound", dynlib: gdalLib, raises: []
.}

proc GDALExtendedDataTypeRelease*(
  hEDT: GDALExtendedDataTypeH
) {.cdecl, importc: "GDALExtendedDataTypeRelease", dynlib: gdalLib, raises: [].}

proc GDALExtendedDataTypeGetName*(
  hEDT: GDALExtendedDataTypeH
): cstring {.
  cdecl, importc: "GDALExtendedDataTypeGetName", dynlib: gdalLib, raises: []
.}

proc GDALExtendedDataTypeGetClass*(
  hEDT: GDALExtendedDataTypeH
): GDALExtendedDataTypeClass {.
  cdecl, importc: "GDALExtendedDataTypeGetClass", dynlib: gdalLib, raises: []
.}

proc GDALExtendedDataTypeGetNumericDataType*(
  hEDT: GDALExtendedDataTypeH
): GDALDataType {.
  cdecl, importc: "GDALExtendedDataTypeGetNumericDataType", dynlib: gdalLib, raises: []
.}

proc GDALExtendedDataTypeGetSize*(
  hEDT: GDALExtendedDataTypeH
): csize_t {.
  cdecl, importc: "GDALExtendedDataTypeGetSize", dynlib: gdalLib, raises: []
.}

proc GDALExtendedDataTypeGetMaxStringLength*(
  hEDT: GDALExtendedDataTypeH
): csize_t {.
  cdecl, importc: "GDALExtendedDataTypeGetMaxStringLength", dynlib: gdalLib, raises: []
.}

proc GDALExtendedDataTypeGetComponents*(
  hEDT: GDALExtendedDataTypeH, pnCount: ptr csize_t
): ptr GDALEDTComponentH {.
  cdecl, importc: "GDALExtendedDataTypeGetComponents", dynlib: gdalLib, raises: []
.}

proc GDALExtendedDataTypeFreeComponents*(
  components: ptr GDALEDTComponentH, nCount: csize_t
) {.cdecl, importc: "GDALExtendedDataTypeFreeComponents", dynlib: gdalLib, raises: [].}

proc GDALExtendedDataTypeCanConvertTo*(
  hSourceEDT: GDALExtendedDataTypeH, hTargetEDT: GDALExtendedDataTypeH
): cint {.
  cdecl, importc: "GDALExtendedDataTypeCanConvertTo", dynlib: gdalLib, raises: []
.}

proc GDALExtendedDataTypeEquals*(
  hFirstEDT: GDALExtendedDataTypeH, hSecondEDT: GDALExtendedDataTypeH
): cint {.cdecl, importc: "GDALExtendedDataTypeEquals", dynlib: gdalLib, raises: [].}

proc GDALExtendedDataTypeGetSubType*(
  hEDT: GDALExtendedDataTypeH
): GDALExtendedDataTypeSubType {.
  cdecl, importc: "GDALExtendedDataTypeGetSubType", dynlib: gdalLib, raises: []
.}

proc GDALExtendedDataTypeGetRAT*(
  hEDT: GDALExtendedDataTypeH
): GDALRasterAttributeTableH {.
  cdecl, importc: "GDALExtendedDataTypeGetRAT", dynlib: gdalLib, raises: []
.}

proc GDALEDTComponentCreate*(
  pszName: cstring, nOffset: csize_t, hType: GDALExtendedDataTypeH
): GDALEDTComponentH {.
  cdecl, importc: "GDALEDTComponentCreate", dynlib: gdalLib, raises: []
.}

proc GDALEDTComponentRelease*(
  hComp: GDALEDTComponentH
) {.cdecl, importc: "GDALEDTComponentRelease", dynlib: gdalLib, raises: [].}

proc GDALEDTComponentGetName*(
  hComp: GDALEDTComponentH
): cstring {.cdecl, importc: "GDALEDTComponentGetName", dynlib: gdalLib, raises: [].}

proc GDALEDTComponentGetOffset*(
  hComp: GDALEDTComponentH
): csize_t {.cdecl, importc: "GDALEDTComponentGetOffset", dynlib: gdalLib, raises: [].}

proc GDALEDTComponentGetType*(
  hComp: GDALEDTComponentH
): GDALExtendedDataTypeH {.
  cdecl, importc: "GDALEDTComponentGetType", dynlib: gdalLib, raises: []
.}

proc GDALDatasetGetRootGroup*(
  hDS: GDALDatasetH
): GDALGroupH {.cdecl, importc: "GDALDatasetGetRootGroup", dynlib: gdalLib, raises: [].}

proc GDALGroupRelease*(
  hGroup: GDALGroupH
) {.cdecl, importc: "GDALGroupRelease", dynlib: gdalLib, raises: [].}

proc GDALGroupGetName*(
  hGroup: GDALGroupH
): cstring {.cdecl, importc: "GDALGroupGetName", dynlib: gdalLib, raises: [].}

proc GDALGroupGetFullName*(
  hGroup: GDALGroupH
): cstring {.cdecl, importc: "GDALGroupGetFullName", dynlib: gdalLib, raises: [].}

proc GDALGroupGetMDArrayNames*(
  hGroup: GDALGroupH, papszOptions: CSLConstList
): cstringArray {.
  cdecl, importc: "GDALGroupGetMDArrayNames", dynlib: gdalLib, raises: []
.}

proc GDALGroupGetMDArrayFullNamesRecursive*(
  hGroup: GDALGroupH, papszGroupOptions: CSLConstList, papszArrayOptions: CSLConstList
): cstringArray {.
  cdecl, importc: "GDALGroupGetMDArrayFullNamesRecursive", dynlib: gdalLib, raises: []
.}

proc GDALGroupOpenMDArray*(
  hGroup: GDALGroupH, pszMDArrayName: cstring, papszOptions: CSLConstList
): GDALMDArrayH {.cdecl, importc: "GDALGroupOpenMDArray", dynlib: gdalLib, raises: [].}

proc GDALGroupOpenMDArrayFromFullname*(
  hGroup: GDALGroupH, pszMDArrayName: cstring, papszOptions: CSLConstList
): GDALMDArrayH {.
  cdecl, importc: "GDALGroupOpenMDArrayFromFullname", dynlib: gdalLib, raises: []
.}

proc GDALGroupResolveMDArray*(
  hGroup: GDALGroupH,
  pszName: cstring,
  pszStartingPoint: cstring,
  papszOptions: CSLConstList,
): GDALMDArrayH {.
  cdecl, importc: "GDALGroupResolveMDArray", dynlib: gdalLib, raises: []
.}

proc GDALGroupGetGroupNames*(
  hGroup: GDALGroupH, papszOptions: CSLConstList
): cstringArray {.
  cdecl, importc: "GDALGroupGetGroupNames", dynlib: gdalLib, raises: []
.}

proc GDALGroupOpenGroup*(
  hGroup: GDALGroupH, pszSubGroupName: cstring, papszOptions: CSLConstList
): GDALGroupH {.cdecl, importc: "GDALGroupOpenGroup", dynlib: gdalLib, raises: [].}

proc GDALGroupOpenGroupFromFullname*(
  hGroup: GDALGroupH, pszMDArrayName: cstring, papszOptions: CSLConstList
): GDALGroupH {.
  cdecl, importc: "GDALGroupOpenGroupFromFullname", dynlib: gdalLib, raises: []
.}

proc GDALGroupGetVectorLayerNames*(
  hGroup: GDALGroupH, papszOptions: CSLConstList
): cstringArray {.
  cdecl, importc: "GDALGroupGetVectorLayerNames", dynlib: gdalLib, raises: []
.}

proc GDALGroupOpenVectorLayer*(
  hGroup: GDALGroupH, pszVectorLayerName: cstring, papszOptions: CSLConstList
): OGRLayerH {.cdecl, importc: "GDALGroupOpenVectorLayer", dynlib: gdalLib, raises: [].}

proc GDALGroupGetDimensions*(
  hGroup: GDALGroupH, pnCount: ptr csize_t, papszOptions: CSLConstList
): ptr GDALDimensionH {.
  cdecl, importc: "GDALGroupGetDimensions", dynlib: gdalLib, raises: []
.}

proc GDALGroupGetAttribute*(
  hGroup: GDALGroupH, pszName: cstring
): GDALAttributeH {.
  cdecl, importc: "GDALGroupGetAttribute", dynlib: gdalLib, raises: []
.}

proc GDALGroupGetAttributes*(
  hGroup: GDALGroupH, pnCount: ptr csize_t, papszOptions: CSLConstList
): ptr GDALAttributeH {.
  cdecl, importc: "GDALGroupGetAttributes", dynlib: gdalLib, raises: []
.}

proc GDALGroupGetStructuralInfo*(
  hGroup: GDALGroupH
): CSLConstList {.
  cdecl, importc: "GDALGroupGetStructuralInfo", dynlib: gdalLib, raises: []
.}

proc GDALGroupCreateGroup*(
  hGroup: GDALGroupH, pszSubGroupName: cstring, papszOptions: CSLConstList
): GDALGroupH {.cdecl, importc: "GDALGroupCreateGroup", dynlib: gdalLib, raises: [].}

proc GDALGroupDeleteGroup*(
  hGroup: GDALGroupH, pszName: cstring, papszOptions: CSLConstList
): bool {.cdecl, importc: "GDALGroupDeleteGroup", dynlib: gdalLib, raises: [].}

proc GDALGroupCreateDimension*(
  hGroup: GDALGroupH,
  pszName: cstring,
  pszType: cstring,
  pszDirection: cstring,
  nSize: GUInt64,
  papszOptions: CSLConstList,
): GDALDimensionH {.
  cdecl, importc: "GDALGroupCreateDimension", dynlib: gdalLib, raises: []
.}

proc GDALGroupCreateMDArray*(
  hGroup: GDALGroupH,
  pszName: cstring,
  nDimensions: csize_t,
  pahDimensions: ptr GDALDimensionH,
  hEDT: GDALExtendedDataTypeH,
  papszOptions: CSLConstList,
): GDALMDArrayH {.
  cdecl, importc: "GDALGroupCreateMDArray", dynlib: gdalLib, raises: []
.}

proc GDALGroupDeleteMDArray*(
  hGroup: GDALGroupH, pszName: cstring, papszOptions: CSLConstList
): bool {.cdecl, importc: "GDALGroupDeleteMDArray", dynlib: gdalLib, raises: [].}

proc GDALGroupCreateAttribute*(
  hGroup: GDALGroupH,
  pszName: cstring,
  nDimensions: csize_t,
  panDimensions: ptr GUInt64,
  hEDT: GDALExtendedDataTypeH,
  papszOptions: CSLConstList,
): GDALAttributeH {.
  cdecl, importc: "GDALGroupCreateAttribute", dynlib: gdalLib, raises: []
.}

proc GDALGroupDeleteAttribute*(
  hGroup: GDALGroupH, pszName: cstring, papszOptions: CSLConstList
): bool {.cdecl, importc: "GDALGroupDeleteAttribute", dynlib: gdalLib, raises: [].}

proc GDALGroupRename*(
  hGroup: GDALGroupH, pszNewName: cstring
): bool {.cdecl, importc: "GDALGroupRename", dynlib: gdalLib, raises: [].}

proc GDALGroupSubsetDimensionFromSelection*(
  hGroup: GDALGroupH, pszSelection: cstring, papszOptions: CSLConstList
): GDALGroupH {.
  cdecl, importc: "GDALGroupSubsetDimensionFromSelection", dynlib: gdalLib, raises: []
.}

proc GDALGroupGetDataTypeCount*(
  hGroup: GDALGroupH
): csize_t {.cdecl, importc: "GDALGroupGetDataTypeCount", dynlib: gdalLib, raises: [].}

proc GDALGroupGetDataType*(
  hGroup: GDALGroupH, nIdx: csize_t
): GDALExtendedDataTypeH {.
  cdecl, importc: "GDALGroupGetDataType", dynlib: gdalLib, raises: []
.}

proc GDALMDArrayRelease*(
  hMDArray: GDALMDArrayH
) {.cdecl, importc: "GDALMDArrayRelease", dynlib: gdalLib, raises: [].}

proc GDALMDArrayGetName*(
  hArray: GDALMDArrayH
): cstring {.cdecl, importc: "GDALMDArrayGetName", dynlib: gdalLib, raises: [].}

proc GDALMDArrayGetFullName*(
  hArray: GDALMDArrayH
): cstring {.cdecl, importc: "GDALMDArrayGetFullName", dynlib: gdalLib, raises: [].}

proc GDALMDArrayGetTotalElementsCount*(
  hArray: GDALMDArrayH
): GUInt64 {.
  cdecl, importc: "GDALMDArrayGetTotalElementsCount", dynlib: gdalLib, raises: []
.}

proc GDALMDArrayGetDimensionCount*(
  hArray: GDALMDArrayH
): csize_t {.
  cdecl, importc: "GDALMDArrayGetDimensionCount", dynlib: gdalLib, raises: []
.}

proc GDALMDArrayGetDimensions*(
  hArray: GDALMDArrayH, pnCount: ptr csize_t
): ptr GDALDimensionH {.
  cdecl, importc: "GDALMDArrayGetDimensions", dynlib: gdalLib, raises: []
.}

proc GDALMDArrayGetDataType*(
  hArray: GDALMDArrayH
): GDALExtendedDataTypeH {.
  cdecl, importc: "GDALMDArrayGetDataType", dynlib: gdalLib, raises: []
.}

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
): cint {.cdecl, importc: "GDALMDArrayRead", dynlib: gdalLib, raises: [].}

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
): cint {.cdecl, importc: "GDALMDArrayWrite", dynlib: gdalLib, raises: [].}

proc GDALMDArrayAdviseRead*(
  hArray: GDALMDArrayH, arrayStartIdx: ptr GUInt64, count: ptr csize_t
): cint {.cdecl, importc: "GDALMDArrayAdviseRead", dynlib: gdalLib, raises: [].}

proc GDALMDArrayAdviseReadEx*(
  hArray: GDALMDArrayH,
  arrayStartIdx: ptr GUInt64,
  count: ptr csize_t,
  papszOptions: CSLConstList,
): cint {.cdecl, importc: "GDALMDArrayAdviseReadEx", dynlib: gdalLib, raises: [].}

proc GDALMDArrayGetAttribute*(
  hArray: GDALMDArrayH, pszName: cstring
): GDALAttributeH {.
  cdecl, importc: "GDALMDArrayGetAttribute", dynlib: gdalLib, raises: []
.}

proc GDALMDArrayGetAttributes*(
  hArray: GDALMDArrayH, pnCount: ptr csize_t, papszOptions: CSLConstList
): ptr GDALAttributeH {.
  cdecl, importc: "GDALMDArrayGetAttributes", dynlib: gdalLib, raises: []
.}

proc GDALMDArrayCreateAttribute*(
  hArray: GDALMDArrayH,
  pszName: cstring,
  nDimensions: csize_t,
  panDimensions: ptr GUInt64,
  hEDT: GDALExtendedDataTypeH,
  papszOptions: CSLConstList,
): GDALAttributeH {.
  cdecl, importc: "GDALMDArrayCreateAttribute", dynlib: gdalLib, raises: []
.}

proc GDALMDArrayDeleteAttribute*(
  hArray: GDALMDArrayH, pszName: cstring, papszOptions: CSLConstList
): bool {.cdecl, importc: "GDALMDArrayDeleteAttribute", dynlib: gdalLib, raises: [].}

proc GDALMDArrayResize*(
  hArray: GDALMDArrayH, panNewDimSizes: ptr GUInt64, papszOptions: CSLConstList
): bool {.cdecl, importc: "GDALMDArrayResize", dynlib: gdalLib, raises: [].}

proc GDALMDArrayGetRawNoDataValue*(
  hArray: GDALMDArrayH
): pointer {.
  cdecl, importc: "GDALMDArrayGetRawNoDataValue", dynlib: gdalLib, raises: []
.}

proc GDALMDArrayGetNoDataValueAsDouble*(
  hArray: GDALMDArrayH, pbHasNoDataValue: ptr cint
): cdouble {.
  cdecl, importc: "GDALMDArrayGetNoDataValueAsDouble", dynlib: gdalLib, raises: []
.}

proc GDALMDArrayGetNoDataValueAsInt64*(
  hArray: GDALMDArrayH, pbHasNoDataValue: ptr cint
): int64 {.
  cdecl, importc: "GDALMDArrayGetNoDataValueAsInt64", dynlib: gdalLib, raises: []
.}

proc GDALMDArrayGetNoDataValueAsUInt64*(
  hArray: GDALMDArrayH, pbHasNoDataValue: ptr cint
): uint64 {.
  cdecl, importc: "GDALMDArrayGetNoDataValueAsUInt64", dynlib: gdalLib, raises: []
.}

proc GDALMDArraySetRawNoDataValue*(
  hArray: GDALMDArrayH, a1: pointer
): cint {.cdecl, importc: "GDALMDArraySetRawNoDataValue", dynlib: gdalLib, raises: [].}

proc GDALMDArraySetNoDataValueAsDouble*(
  hArray: GDALMDArrayH, dfNoDataValue: cdouble
): cint {.
  cdecl, importc: "GDALMDArraySetNoDataValueAsDouble", dynlib: gdalLib, raises: []
.}

proc GDALMDArraySetNoDataValueAsInt64*(
  hArray: GDALMDArrayH, nNoDataValue: int64
): cint {.
  cdecl, importc: "GDALMDArraySetNoDataValueAsInt64", dynlib: gdalLib, raises: []
.}

proc GDALMDArraySetNoDataValueAsUInt64*(
  hArray: GDALMDArrayH, nNoDataValue: uint64
): cint {.
  cdecl, importc: "GDALMDArraySetNoDataValueAsUInt64", dynlib: gdalLib, raises: []
.}

proc GDALMDArraySetScale*(
  hArray: GDALMDArrayH, dfScale: cdouble
): cint {.cdecl, importc: "GDALMDArraySetScale", dynlib: gdalLib, raises: [].}

proc GDALMDArraySetScaleEx*(
  hArray: GDALMDArrayH, dfScale: cdouble, eStorageType: GDALDataType
): cint {.cdecl, importc: "GDALMDArraySetScaleEx", dynlib: gdalLib, raises: [].}

proc GDALMDArrayGetScale*(
  hArray: GDALMDArrayH, pbHasValue: ptr cint
): cdouble {.cdecl, importc: "GDALMDArrayGetScale", dynlib: gdalLib, raises: [].}

proc GDALMDArrayGetScaleEx*(
  hArray: GDALMDArrayH, pbHasValue: ptr cint, peStorageType: ptr GDALDataType
): cdouble {.cdecl, importc: "GDALMDArrayGetScaleEx", dynlib: gdalLib, raises: [].}

proc GDALMDArraySetOffset*(
  hArray: GDALMDArrayH, dfOffset: cdouble
): cint {.cdecl, importc: "GDALMDArraySetOffset", dynlib: gdalLib, raises: [].}

proc GDALMDArraySetOffsetEx*(
  hArray: GDALMDArrayH, dfOffset: cdouble, eStorageType: GDALDataType
): cint {.cdecl, importc: "GDALMDArraySetOffsetEx", dynlib: gdalLib, raises: [].}

proc GDALMDArrayGetOffset*(
  hArray: GDALMDArrayH, pbHasValue: ptr cint
): cdouble {.cdecl, importc: "GDALMDArrayGetOffset", dynlib: gdalLib, raises: [].}

proc GDALMDArrayGetOffsetEx*(
  hArray: GDALMDArrayH, pbHasValue: ptr cint, peStorageType: ptr GDALDataType
): cdouble {.cdecl, importc: "GDALMDArrayGetOffsetEx", dynlib: gdalLib, raises: [].}

proc GDALMDArrayGetBlockSize*(
  hArray: GDALMDArrayH, pnCount: ptr csize_t
): ptr GUInt64 {.
  cdecl, importc: "GDALMDArrayGetBlockSize", dynlib: gdalLib, raises: []
.}

proc GDALMDArraySetUnit*(
  hArray: GDALMDArrayH, a1: cstring
): cint {.cdecl, importc: "GDALMDArraySetUnit", dynlib: gdalLib, raises: [].}

proc GDALMDArrayGetUnit*(
  hArray: GDALMDArrayH
): cstring {.cdecl, importc: "GDALMDArrayGetUnit", dynlib: gdalLib, raises: [].}

proc GDALMDArraySetSpatialRef*(
  a0: GDALMDArrayH, a1: OGRSpatialReferenceH
): cint {.cdecl, importc: "GDALMDArraySetSpatialRef", dynlib: gdalLib, raises: [].}

proc GDALMDArrayGetSpatialRef*(
  hArray: GDALMDArrayH
): OGRSpatialReferenceH {.
  cdecl, importc: "GDALMDArrayGetSpatialRef", dynlib: gdalLib, raises: []
.}

proc GDALMDArrayGetProcessingChunkSize*(
  hArray: GDALMDArrayH, pnCount: ptr csize_t, nMaxChunkMemory: csize_t
): ptr csize_t {.
  cdecl, importc: "GDALMDArrayGetProcessingChunkSize", dynlib: gdalLib, raises: []
.}

proc GDALMDArrayGetStructuralInfo*(
  hArray: GDALMDArrayH
): CSLConstList {.
  cdecl, importc: "GDALMDArrayGetStructuralInfo", dynlib: gdalLib, raises: []
.}

proc GDALMDArrayGetView*(
  hArray: GDALMDArrayH, pszViewExpr: cstring
): GDALMDArrayH {.cdecl, importc: "GDALMDArrayGetView", dynlib: gdalLib, raises: [].}

proc GDALMDArrayTranspose*(
  hArray: GDALMDArrayH, nNewAxisCount: csize_t, panMapNewAxisToOldAxis: ptr cint
): GDALMDArrayH {.cdecl, importc: "GDALMDArrayTranspose", dynlib: gdalLib, raises: [].}

proc GDALMDArrayGetUnscaled*(
  hArray: GDALMDArrayH
): GDALMDArrayH {.
  cdecl, importc: "GDALMDArrayGetUnscaled", dynlib: gdalLib, raises: []
.}

proc GDALMDArrayGetMask*(
  hArray: GDALMDArrayH, papszOptions: CSLConstList
): GDALMDArrayH {.cdecl, importc: "GDALMDArrayGetMask", dynlib: gdalLib, raises: [].}

proc GDALMDArrayAsClassicDataset*(
  hArray: GDALMDArrayH, iXDim: csize_t, iYDim: csize_t
): GDALDatasetH {.
  cdecl, importc: "GDALMDArrayAsClassicDataset", dynlib: gdalLib, raises: []
.}

proc GDALMDArrayAsClassicDatasetEx*(
  hArray: GDALMDArrayH,
  iXDim: csize_t,
  iYDim: csize_t,
  hRootGroup: GDALGroupH,
  papszOptions: CSLConstList,
): GDALDatasetH {.
  cdecl, importc: "GDALMDArrayAsClassicDatasetEx", dynlib: gdalLib, raises: []
.}

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
): CPLErr {.cdecl, importc: "GDALMDArrayGetStatistics", dynlib: gdalLib, raises: [].}

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
): cint {.cdecl, importc: "GDALMDArrayComputeStatistics", dynlib: gdalLib, raises: [].}

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
): cint {.
  cdecl, importc: "GDALMDArrayComputeStatisticsEx", dynlib: gdalLib, raises: []
.}

proc GDALMDArrayGetResampled*(
  hArray: GDALMDArrayH,
  nNewDimCount: csize_t,
  pahNewDims: ptr GDALDimensionH,
  resampleAlg: GDALRIOResampleAlg,
  hTargetSRS: OGRSpatialReferenceH,
  papszOptions: CSLConstList,
): GDALMDArrayH {.
  cdecl, importc: "GDALMDArrayGetResampled", dynlib: gdalLib, raises: []
.}

proc GDALMDArrayGetGridded*(
  hArray: GDALMDArrayH,
  pszGridOptions: cstring,
  hXArray: GDALMDArrayH,
  hYArray: GDALMDArrayH,
  papszOptions: CSLConstList,
): GDALMDArrayH {.cdecl, importc: "GDALMDArrayGetGridded", dynlib: gdalLib, raises: [].}

proc GDALMDArrayGetCoordinateVariables*(
  hArray: GDALMDArrayH, pnCount: ptr csize_t
): ptr GDALMDArrayH {.
  cdecl, importc: "GDALMDArrayGetCoordinateVariables", dynlib: gdalLib, raises: []
.}

proc GDALMDArrayGetMeshGrid*(
  pahInputArrays: ptr GDALMDArrayH,
  nCountInputArrays: csize_t,
  pnCountOutputArrays: ptr csize_t,
  papszOptions: CSLConstList,
): ptr GDALMDArrayH {.
  cdecl, importc: "GDALMDArrayGetMeshGrid", dynlib: gdalLib, raises: []
.}

proc GDALMDArrayRawBlockInfoCreate*(): ptr GDALMDArrayRawBlockInfo {.
  cdecl, importc: "GDALMDArrayRawBlockInfoCreate", dynlib: gdalLib, raises: []
.}

proc GDALMDArrayRawBlockInfoRelease*(
  psBlockInfo: ptr GDALMDArrayRawBlockInfo
) {.cdecl, importc: "GDALMDArrayRawBlockInfoRelease", dynlib: gdalLib, raises: [].}

proc GDALMDArrayGetRawBlockInfo*(
  hArray: GDALMDArrayH,
  panBlockCoordinates: ptr uint64,
  psBlockInfo: ptr GDALMDArrayRawBlockInfo,
): bool {.cdecl, importc: "GDALMDArrayGetRawBlockInfo", dynlib: gdalLib, raises: [].}

proc GDALMDArrayGetOverviewCount*(
  hArray: GDALMDArrayH
): cint {.cdecl, importc: "GDALMDArrayGetOverviewCount", dynlib: gdalLib, raises: [].}

proc GDALMDArrayGetOverview*(
  hArray: GDALMDArrayH, nIdx: cint
): GDALMDArrayH {.
  cdecl, importc: "GDALMDArrayGetOverview", dynlib: gdalLib, raises: []
.}

proc GDALMDArrayBuildOverviews*(
  hArray: GDALMDArrayH,
  pszResampling: cstring,
  nOverviews: cint,
  panOverviewList: ptr cint,
  pfnProgress: GDALProgressFunc,
  pProgressData: pointer,
  papszOptions: CSLConstList,
): CPLErr {.cdecl, importc: "GDALMDArrayBuildOverviews", dynlib: gdalLib, raises: [].}

proc GDALReleaseArrays*(
  arrays: ptr GDALMDArrayH, nCount: csize_t
) {.cdecl, importc: "GDALReleaseArrays", dynlib: gdalLib, raises: [].}

proc GDALMDArrayCache*(
  hArray: GDALMDArrayH, papszOptions: CSLConstList
): cint {.cdecl, importc: "GDALMDArrayCache", dynlib: gdalLib, raises: [].}

proc GDALMDArrayRename*(
  hArray: GDALMDArrayH, pszNewName: cstring
): bool {.cdecl, importc: "GDALMDArrayRename", dynlib: gdalLib, raises: [].}

proc GDALCreateRasterAttributeTableFromMDArrays*(
  eTableType: GDALRATTableType,
  nArrays: cint,
  ahArrays: ptr GDALMDArrayH,
  paeUsages: ptr GDALRATFieldUsage,
): GDALRasterAttributeTableH {.
  cdecl,
  importc: "GDALCreateRasterAttributeTableFromMDArrays",
  dynlib: gdalLib,
  raises: []
.}

proc GDALAttributeRelease*(
  hAttr: GDALAttributeH
) {.cdecl, importc: "GDALAttributeRelease", dynlib: gdalLib, raises: [].}

proc GDALReleaseAttributes*(
  attributes: ptr GDALAttributeH, nCount: csize_t
) {.cdecl, importc: "GDALReleaseAttributes", dynlib: gdalLib, raises: [].}

proc GDALAttributeGetName*(
  hAttr: GDALAttributeH
): cstring {.cdecl, importc: "GDALAttributeGetName", dynlib: gdalLib, raises: [].}

proc GDALAttributeGetFullName*(
  hAttr: GDALAttributeH
): cstring {.cdecl, importc: "GDALAttributeGetFullName", dynlib: gdalLib, raises: [].}

proc GDALAttributeGetTotalElementsCount*(
  hAttr: GDALAttributeH
): GUInt64 {.
  cdecl, importc: "GDALAttributeGetTotalElementsCount", dynlib: gdalLib, raises: []
.}

proc GDALAttributeGetDimensionCount*(
  hAttr: GDALAttributeH
): csize_t {.
  cdecl, importc: "GDALAttributeGetDimensionCount", dynlib: gdalLib, raises: []
.}

proc GDALAttributeGetDimensionsSize*(
  hAttr: GDALAttributeH, pnCount: ptr csize_t
): ptr GUInt64 {.
  cdecl, importc: "GDALAttributeGetDimensionsSize", dynlib: gdalLib, raises: []
.}

proc GDALAttributeGetDataType*(
  hAttr: GDALAttributeH
): GDALExtendedDataTypeH {.
  cdecl, importc: "GDALAttributeGetDataType", dynlib: gdalLib, raises: []
.}

proc GDALAttributeReadAsRaw*(
  hAttr: GDALAttributeH, pnSize: ptr csize_t
): ptr GByte {.cdecl, importc: "GDALAttributeReadAsRaw", dynlib: gdalLib, raises: [].}

proc GDALAttributeFreeRawResult*(
  hAttr: GDALAttributeH, raw: ptr GByte, nSize: csize_t
) {.cdecl, importc: "GDALAttributeFreeRawResult", dynlib: gdalLib, raises: [].}

proc GDALAttributeReadAsString*(
  hAttr: GDALAttributeH
): cstring {.cdecl, importc: "GDALAttributeReadAsString", dynlib: gdalLib, raises: [].}

proc GDALAttributeReadAsInt*(
  hAttr: GDALAttributeH
): cint {.cdecl, importc: "GDALAttributeReadAsInt", dynlib: gdalLib, raises: [].}

proc GDALAttributeReadAsInt64*(
  hAttr: GDALAttributeH
): int64 {.cdecl, importc: "GDALAttributeReadAsInt64", dynlib: gdalLib, raises: [].}

proc GDALAttributeReadAsDouble*(
  hAttr: GDALAttributeH
): cdouble {.cdecl, importc: "GDALAttributeReadAsDouble", dynlib: gdalLib, raises: [].}

proc GDALAttributeReadAsStringArray*(
  hAttr: GDALAttributeH
): cstringArray {.
  cdecl, importc: "GDALAttributeReadAsStringArray", dynlib: gdalLib, raises: []
.}

proc GDALAttributeReadAsIntArray*(
  hAttr: GDALAttributeH, pnCount: ptr csize_t
): ptr cint {.
  cdecl, importc: "GDALAttributeReadAsIntArray", dynlib: gdalLib, raises: []
.}

proc GDALAttributeReadAsInt64Array*(
  hAttr: GDALAttributeH, pnCount: ptr csize_t
): ptr int64 {.
  cdecl, importc: "GDALAttributeReadAsInt64Array", dynlib: gdalLib, raises: []
.}

proc GDALAttributeReadAsDoubleArray*(
  hAttr: GDALAttributeH, pnCount: ptr csize_t
): ptr cdouble {.
  cdecl, importc: "GDALAttributeReadAsDoubleArray", dynlib: gdalLib, raises: []
.}

proc GDALAttributeWriteRaw*(
  hAttr: GDALAttributeH, a1: pointer, a2: csize_t
): cint {.cdecl, importc: "GDALAttributeWriteRaw", dynlib: gdalLib, raises: [].}

proc GDALAttributeWriteString*(
  hAttr: GDALAttributeH, a1: cstring
): cint {.cdecl, importc: "GDALAttributeWriteString", dynlib: gdalLib, raises: [].}

proc GDALAttributeWriteStringArray*(
  hAttr: GDALAttributeH, a1: CSLConstList
): cint {.cdecl, importc: "GDALAttributeWriteStringArray", dynlib: gdalLib, raises: [].}

proc GDALAttributeWriteInt*(
  hAttr: GDALAttributeH, a1: cint
): cint {.cdecl, importc: "GDALAttributeWriteInt", dynlib: gdalLib, raises: [].}

proc GDALAttributeWriteIntArray*(
  hAttr: GDALAttributeH, a1: ptr cint, a2: csize_t
): cint {.cdecl, importc: "GDALAttributeWriteIntArray", dynlib: gdalLib, raises: [].}

proc GDALAttributeWriteInt64*(
  hAttr: GDALAttributeH, a1: int64
): cint {.cdecl, importc: "GDALAttributeWriteInt64", dynlib: gdalLib, raises: [].}

proc GDALAttributeWriteInt64Array*(
  hAttr: GDALAttributeH, a1: ptr int64, a2: csize_t
): cint {.cdecl, importc: "GDALAttributeWriteInt64Array", dynlib: gdalLib, raises: [].}

proc GDALAttributeWriteDouble*(
  hAttr: GDALAttributeH, a1: cdouble
): cint {.cdecl, importc: "GDALAttributeWriteDouble", dynlib: gdalLib, raises: [].}

proc GDALAttributeWriteDoubleArray*(
  hAttr: GDALAttributeH, a1: ptr cdouble, a2: csize_t
): cint {.cdecl, importc: "GDALAttributeWriteDoubleArray", dynlib: gdalLib, raises: [].}

proc GDALAttributeRename*(
  hAttr: GDALAttributeH, pszNewName: cstring
): bool {.cdecl, importc: "GDALAttributeRename", dynlib: gdalLib, raises: [].}

proc GDALDimensionRelease*(
  hDim: GDALDimensionH
) {.cdecl, importc: "GDALDimensionRelease", dynlib: gdalLib, raises: [].}

proc GDALReleaseDimensions*(
  dims: ptr GDALDimensionH, nCount: csize_t
) {.cdecl, importc: "GDALReleaseDimensions", dynlib: gdalLib, raises: [].}

proc GDALDimensionGetName*(
  hDim: GDALDimensionH
): cstring {.cdecl, importc: "GDALDimensionGetName", dynlib: gdalLib, raises: [].}

proc GDALDimensionGetFullName*(
  hDim: GDALDimensionH
): cstring {.cdecl, importc: "GDALDimensionGetFullName", dynlib: gdalLib, raises: [].}

proc GDALDimensionGetType*(
  hDim: GDALDimensionH
): cstring {.cdecl, importc: "GDALDimensionGetType", dynlib: gdalLib, raises: [].}

proc GDALDimensionGetDirection*(
  hDim: GDALDimensionH
): cstring {.cdecl, importc: "GDALDimensionGetDirection", dynlib: gdalLib, raises: [].}

proc GDALDimensionGetSize*(
  hDim: GDALDimensionH
): GUInt64 {.cdecl, importc: "GDALDimensionGetSize", dynlib: gdalLib, raises: [].}

proc GDALDimensionGetIndexingVariable*(
  hDim: GDALDimensionH
): GDALMDArrayH {.
  cdecl, importc: "GDALDimensionGetIndexingVariable", dynlib: gdalLib, raises: []
.}

proc GDALDimensionSetIndexingVariable*(
  hDim: GDALDimensionH, hArray: GDALMDArrayH
): cint {.
  cdecl, importc: "GDALDimensionSetIndexingVariable", dynlib: gdalLib, raises: []
.}

proc GDALDimensionRename*(
  hDim: GDALDimensionH, pszNewName: cstring
): bool {.cdecl, importc: "GDALDimensionRename", dynlib: gdalLib, raises: [].}

proc GDALSetAdbcLoadDriverOverride*(
  init_func: GDALAdbcLoadDriverFunc
) {.cdecl, importc: "GDALSetAdbcLoadDriverOverride", dynlib: gdalLib, raises: [].}

proc GDALGetAdbcLoadDriverOverride*(): GDALAdbcLoadDriverFunc {.
  cdecl, importc: "GDALGetAdbcLoadDriverOverride", dynlib: gdalLib, raises: []
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
): cint {.gdalCall, importc: "GDALComputeMedianCutPCT", dynlib: gdalLib, raises: [].}

proc GDALDitherRGB2PCT*(
  hRed: GDALRasterBandH,
  hGreen: GDALRasterBandH,
  hBlue: GDALRasterBandH,
  hTarget: GDALRasterBandH,
  hColorTable: GDALColorTableH,
  pfnProgress: GDALProgressFunc,
  pProgressArg: pointer,
): cint {.gdalCall, importc: "GDALDitherRGB2PCT", dynlib: gdalLib, raises: [].}

proc GDALChecksumImage*(
  hBand: GDALRasterBandH, nXOff: cint, nYOff: cint, nXSize: cint, nYSize: cint
): cint {.gdalCall, importc: "GDALChecksumImage", dynlib: gdalLib, raises: [].}

proc GDALComputeProximity*(
  hSrcBand: GDALRasterBandH,
  hProximityBand: GDALRasterBandH,
  papszOptions: cstringArray,
  pfnProgress: GDALProgressFunc,
  pProgressArg: pointer,
): CPLErr {.gdalCall, importc: "GDALComputeProximity", dynlib: gdalLib, raises: [].}

proc GDALFillNodata*(
  hTargetBand: GDALRasterBandH,
  hMaskBand: GDALRasterBandH,
  dfMaxSearchDist: cdouble,
  bDeprecatedOption: cint,
  nSmoothingIterations: cint,
  papszOptions: cstringArray,
  pfnProgress: GDALProgressFunc,
  pProgressArg: pointer,
): CPLErr {.gdalCall, importc: "GDALFillNodata", dynlib: gdalLib, raises: [].}

proc GDALPolygonize*(
  hSrcBand: GDALRasterBandH,
  hMaskBand: GDALRasterBandH,
  hOutLayer: OGRLayerH,
  iPixValField: cint,
  papszOptions: cstringArray,
  pfnProgress: GDALProgressFunc,
  pProgressArg: pointer,
): CPLErr {.gdalCall, importc: "GDALPolygonize", dynlib: gdalLib, raises: [].}

proc GDALFPolygonize*(
  hSrcBand: GDALRasterBandH,
  hMaskBand: GDALRasterBandH,
  hOutLayer: OGRLayerH,
  iPixValField: cint,
  papszOptions: cstringArray,
  pfnProgress: GDALProgressFunc,
  pProgressArg: pointer,
): CPLErr {.gdalCall, importc: "GDALFPolygonize", dynlib: gdalLib, raises: [].}

proc GDALSieveFilter*(
  hSrcBand: GDALRasterBandH,
  hMaskBand: GDALRasterBandH,
  hDstBand: GDALRasterBandH,
  nSizeThreshold: cint,
  nConnectedness: cint,
  papszOptions: cstringArray,
  pfnProgress: GDALProgressFunc,
  pProgressArg: pointer,
): CPLErr {.gdalCall, importc: "GDALSieveFilter", dynlib: gdalLib, raises: [].}

proc GDALDestroyTransformer*(
  pTransformerArg: pointer
) {.cdecl, importc: "GDALDestroyTransformer", dynlib: gdalLib, raises: [].}

proc GDALUseTransformer*(
  pTransformerArg: pointer,
  bDstToSrc: cint,
  nPointCount: cint,
  x: ptr cdouble,
  y: ptr cdouble,
  z: ptr cdouble,
  panSuccess: ptr cint,
): cint {.cdecl, importc: "GDALUseTransformer", dynlib: gdalLib, raises: [].}

proc GDALCreateSimilarTransformer*(
  psTransformerArg: pointer, dfSrcRatioX: cdouble, dfSrcRatioY: cdouble
): pointer {.
  cdecl, importc: "GDALCreateSimilarTransformer", dynlib: gdalLib, raises: []
.}

proc GDALGetGenImgProjTranformerOptionList*(): cstring {.
  cdecl, importc: "GDALGetGenImgProjTranformerOptionList", dynlib: gdalLib, raises: []
.}

proc GDALCreateGenImgProjTransformer*(
  hSrcDS: GDALDatasetH,
  pszSrcWKT: cstring,
  hDstDS: GDALDatasetH,
  pszDstWKT: cstring,
  bGCPUseOK: cint,
  dfGCPErrorThreshold: cdouble,
  nOrder: cint,
): pointer {.
  cdecl, importc: "GDALCreateGenImgProjTransformer", dynlib: gdalLib, raises: []
.}

proc GDALCreateGenImgProjTransformer2*(
  hSrcDS: GDALDatasetH, hDstDS: GDALDatasetH, papszOptions: CSLConstList
): pointer {.
  cdecl, importc: "GDALCreateGenImgProjTransformer2", dynlib: gdalLib, raises: []
.}

proc GDALCreateGenImgProjTransformer3*(
  pszSrcWKT: cstring,
  padfSrcGeoTransform: ptr cdouble,
  pszDstWKT: cstring,
  padfDstGeoTransform: ptr cdouble,
): pointer {.
  cdecl, importc: "GDALCreateGenImgProjTransformer3", dynlib: gdalLib, raises: []
.}

proc GDALCreateGenImgProjTransformer4*(
  hSrcSRS: OGRSpatialReferenceH,
  padfSrcGeoTransform: ptr cdouble,
  hDstSRS: OGRSpatialReferenceH,
  padfDstGeoTransform: ptr cdouble,
  papszOptions: cstringArray,
): pointer {.
  cdecl, importc: "GDALCreateGenImgProjTransformer4", dynlib: gdalLib, raises: []
.}

proc GDALSetGenImgProjTransformerDstGeoTransform*(
  a0: pointer, a1: ptr cdouble
) {.
  cdecl,
  importc: "GDALSetGenImgProjTransformerDstGeoTransform",
  dynlib: gdalLib,
  raises: []
.}

proc GDALDestroyGenImgProjTransformer*(
  a0: pointer
) {.cdecl, importc: "GDALDestroyGenImgProjTransformer", dynlib: gdalLib, raises: [].}

proc GDALGenImgProjTransform*(
  pTransformArg: pointer,
  bDstToSrc: cint,
  nPointCount: cint,
  x: ptr cdouble,
  y: ptr cdouble,
  z: ptr cdouble,
  panSuccess: ptr cint,
): cint {.cdecl, importc: "GDALGenImgProjTransform", dynlib: gdalLib, raises: [].}

proc GDALSetTransformerDstGeoTransform*(
  a0: pointer, a1: ptr cdouble
) {.cdecl, importc: "GDALSetTransformerDstGeoTransform", dynlib: gdalLib, raises: [].}

proc GDALGetTransformerDstGeoTransform*(
  a0: pointer, a1: ptr cdouble
) {.cdecl, importc: "GDALGetTransformerDstGeoTransform", dynlib: gdalLib, raises: [].}

proc GDALCreateReprojectionTransformer*(
  pszSrcWKT: cstring, pszDstWKT: cstring
): pointer {.
  cdecl, importc: "GDALCreateReprojectionTransformer", dynlib: gdalLib, raises: []
.}

proc GDALCreateReprojectionTransformerEx*(
  hSrcSRS: OGRSpatialReferenceH,
  hDstSRS: OGRSpatialReferenceH,
  papszOptions: cstringArray,
): pointer {.
  cdecl, importc: "GDALCreateReprojectionTransformerEx", dynlib: gdalLib, raises: []
.}

proc GDALDestroyReprojectionTransformer*(
  a0: pointer
) {.cdecl, importc: "GDALDestroyReprojectionTransformer", dynlib: gdalLib, raises: [].}

proc GDALReprojectionTransform*(
  pTransformArg: pointer,
  bDstToSrc: cint,
  nPointCount: cint,
  x: ptr cdouble,
  y: ptr cdouble,
  z: ptr cdouble,
  panSuccess: ptr cint,
): cint {.cdecl, importc: "GDALReprojectionTransform", dynlib: gdalLib, raises: [].}

proc GDALCreateGCPTransformer*(
  nGCPCount: cint, pasGCPList: ptr GDAL_GCP, nReqOrder: cint, bReversed: cint
): pointer {.cdecl, importc: "GDALCreateGCPTransformer", dynlib: gdalLib, raises: [].}

proc GDALCreateGCPRefineTransformer*(
  nGCPCount: cint,
  pasGCPList: ptr GDAL_GCP,
  nReqOrder: cint,
  bReversed: cint,
  tolerance: cdouble,
  minimumGcps: cint,
): pointer {.
  cdecl, importc: "GDALCreateGCPRefineTransformer", dynlib: gdalLib, raises: []
.}

proc GDALDestroyGCPTransformer*(
  pTransformArg: pointer
) {.cdecl, importc: "GDALDestroyGCPTransformer", dynlib: gdalLib, raises: [].}

proc GDALGCPTransform*(
  pTransformArg: pointer,
  bDstToSrc: cint,
  nPointCount: cint,
  x: ptr cdouble,
  y: ptr cdouble,
  z: ptr cdouble,
  panSuccess: ptr cint,
): cint {.cdecl, importc: "GDALGCPTransform", dynlib: gdalLib, raises: [].}

proc GDALCreateHomographyTransformer*(
  adfHomography: ptr cdouble
): pointer {.
  cdecl, importc: "GDALCreateHomographyTransformer", dynlib: gdalLib, raises: []
.}

proc GDALCreateHomographyTransformerFromGCPs*(
  nGCPCount: cint, pasGCPList: ptr GDAL_GCP
): pointer {.
  cdecl, importc: "GDALCreateHomographyTransformerFromGCPs", dynlib: gdalLib, raises: []
.}

proc GDALDestroyHomographyTransformer*(
  pTransformArg: pointer
) {.cdecl, importc: "GDALDestroyHomographyTransformer", dynlib: gdalLib, raises: [].}

proc GDALHomographyTransform*(
  pTransformArg: pointer,
  bDstToSrc: cint,
  nPointCount: cint,
  x: ptr cdouble,
  y: ptr cdouble,
  z: ptr cdouble,
  panSuccess: ptr cint,
): cint {.cdecl, importc: "GDALHomographyTransform", dynlib: gdalLib, raises: [].}

proc GDALCreateTPSTransformer*(
  nGCPCount: cint, pasGCPList: ptr GDAL_GCP, bReversed: cint
): pointer {.cdecl, importc: "GDALCreateTPSTransformer", dynlib: gdalLib, raises: [].}

proc GDALDestroyTPSTransformer*(
  pTransformArg: pointer
) {.cdecl, importc: "GDALDestroyTPSTransformer", dynlib: gdalLib, raises: [].}

proc GDALTPSTransform*(
  pTransformArg: pointer,
  bDstToSrc: cint,
  nPointCount: cint,
  x: ptr cdouble,
  y: ptr cdouble,
  z: ptr cdouble,
  panSuccess: ptr cint,
): cint {.cdecl, importc: "GDALTPSTransform", dynlib: gdalLib, raises: [].}

proc RPCInfoV1ToMD*(
  psRPCInfo: ptr GDALRPCInfoV1
): cstringArray {.cdecl, importc: "RPCInfoToMD", dynlib: gdalLib, raises: [].}

proc RPCInfoV2ToMD*(
  psRPCInfo: ptr GDALRPCInfoV2
): cstringArray {.cdecl, importc: "RPCInfoV2ToMD", dynlib: gdalLib, raises: [].}

proc GDALCreateRPCTransformerV1*(
  psRPC: ptr GDALRPCInfoV1,
  bReversed: cint,
  dfPixErrThreshold: cdouble,
  papszOptions: cstringArray,
): pointer {.cdecl, importc: "GDALCreateRPCTransformer", dynlib: gdalLib, raises: [].}

proc GDALCreateRPCTransformerV2*(
  psRPC: ptr GDALRPCInfoV2,
  bReversed: cint,
  dfPixErrThreshold: cdouble,
  papszOptions: CSLConstList,
): pointer {.cdecl, importc: "GDALCreateRPCTransformerV2", dynlib: gdalLib, raises: [].}

proc GDALDestroyRPCTransformer*(
  pTransformArg: pointer
) {.cdecl, importc: "GDALDestroyRPCTransformer", dynlib: gdalLib, raises: [].}

proc GDALRPCTransform*(
  pTransformArg: pointer,
  bDstToSrc: cint,
  nPointCount: cint,
  x: ptr cdouble,
  y: ptr cdouble,
  z: ptr cdouble,
  panSuccess: ptr cint,
): cint {.cdecl, importc: "GDALRPCTransform", dynlib: gdalLib, raises: [].}

proc GDALCreateGeoLocTransformer*(
  hBaseDS: GDALDatasetH, papszGeolocationInfo: cstringArray, bReversed: cint
): pointer {.
  cdecl, importc: "GDALCreateGeoLocTransformer", dynlib: gdalLib, raises: []
.}

proc GDALDestroyGeoLocTransformer*(
  pTransformArg: pointer
) {.cdecl, importc: "GDALDestroyGeoLocTransformer", dynlib: gdalLib, raises: [].}

proc GDALGeoLocTransform*(
  pTransformArg: pointer,
  bDstToSrc: cint,
  nPointCount: cint,
  x: ptr cdouble,
  y: ptr cdouble,
  z: ptr cdouble,
  panSuccess: ptr cint,
): cint {.cdecl, importc: "GDALGeoLocTransform", dynlib: gdalLib, raises: [].}

proc GDALCreateApproxTransformer*(
  pfnRawTransformer: GDALTransformerFunc,
  pRawTransformerArg: pointer,
  dfMaxError: cdouble,
): pointer {.
  cdecl, importc: "GDALCreateApproxTransformer", dynlib: gdalLib, raises: []
.}

proc GDALApproxTransformerOwnsSubtransformer*(
  pCBData: pointer, bOwnFlag: cint
) {.
  cdecl, importc: "GDALApproxTransformerOwnsSubtransformer", dynlib: gdalLib, raises: []
.}

proc GDALDestroyApproxTransformer*(
  pApproxArg: pointer
) {.cdecl, importc: "GDALDestroyApproxTransformer", dynlib: gdalLib, raises: [].}

proc GDALApproxTransform*(
  pTransformArg: pointer,
  bDstToSrc: cint,
  nPointCount: cint,
  x: ptr cdouble,
  y: ptr cdouble,
  z: ptr cdouble,
  panSuccess: ptr cint,
): cint {.cdecl, importc: "GDALApproxTransform", dynlib: gdalLib, raises: [].}

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
): cint {.gdalCall, importc: "GDALSimpleImageWarp", dynlib: gdalLib, raises: [].}

proc GDALSuggestedWarpOutput*(
  hSrcDS: GDALDatasetH,
  pfnTransformer: GDALTransformerFunc,
  pTransformArg: pointer,
  padfGeoTransformOut: ptr cdouble,
  pnPixels: ptr cint,
  pnLines: ptr cint,
): CPLErr {.gdalCall, importc: "GDALSuggestedWarpOutput", dynlib: gdalLib, raises: [].}

proc GDALSuggestedWarpOutput2*(
  hSrcDS: GDALDatasetH,
  pfnTransformer: GDALTransformerFunc,
  pTransformArg: pointer,
  padfGeoTransformOut: ptr cdouble,
  pnPixels: ptr cint,
  pnLines: ptr cint,
  padfExtent: ptr cdouble,
  nOptions: cint,
): CPLErr {.gdalCall, importc: "GDALSuggestedWarpOutput2", dynlib: gdalLib, raises: [].}

proc GDALSerializeTransformer*(
  pfnFunc: GDALTransformerFunc, pTransformArg: pointer
): ptr CPLXMLNode {.
  cdecl, importc: "GDALSerializeTransformer", dynlib: gdalLib, raises: []
.}

proc GDALDeserializeTransformer*(
  psTree: ptr CPLXMLNode, ppfnFunc: ptr GDALTransformerFunc, ppTransformArg: ptr pointer
): CPLErr {.cdecl, importc: "GDALDeserializeTransformer", dynlib: gdalLib, raises: [].}

proc GDALTransformGeolocations*(
  hXBand: GDALRasterBandH,
  hYBand: GDALRasterBandH,
  hZBand: GDALRasterBandH,
  pfnTransformer: GDALTransformerFunc,
  pTransformArg: pointer,
  pfnProgress: GDALProgressFunc,
  pProgressArg: pointer,
  papszOptions: cstringArray,
): CPLErr {.cdecl, importc: "GDALTransformGeolocations", dynlib: gdalLib, raises: [].}

proc GDAL_CG_Create*(
  nWidth: cint,
  nHeight: cint,
  bNoDataSet: cint,
  dfNoDataValue: cdouble,
  dfContourInterval: cdouble,
  dfContourBase: cdouble,
  pfnWriter: GDALContourWriter,
  pCBData: pointer,
): GDALContourGeneratorH {.
  cdecl, importc: "GDAL_CG_Create", dynlib: gdalLib, raises: []
.}

proc GDAL_CG_FeedLine*(
  hCG: GDALContourGeneratorH, padfScanline: ptr cdouble
): CPLErr {.cdecl, importc: "GDAL_CG_FeedLine", dynlib: gdalLib, raises: [].}

proc GDAL_CG_Destroy*(
  hCG: GDALContourGeneratorH
) {.cdecl, importc: "GDAL_CG_Destroy", dynlib: gdalLib, raises: [].}

proc OGRContourWriter*(
  a0: cdouble, a1: cint, a2: ptr cdouble, a3: ptr cdouble, pInfo: pointer
): CPLErr {.cdecl, importc: "OGRContourWriter", dynlib: gdalLib, raises: [].}

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
): CPLErr {.cdecl, importc: "GDALContourGenerate", dynlib: gdalLib, raises: [].}

proc GDALContourGenerateEx*(
  hBand: GDALRasterBandH,
  hLayer: pointer,
  options: CSLConstList,
  pfnProgress: GDALProgressFunc,
  pProgressArg: pointer,
): CPLErr {.cdecl, importc: "GDALContourGenerateEx", dynlib: gdalLib, raises: [].}

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
): GDALDatasetH {.cdecl, importc: "GDALViewshedGenerate", dynlib: gdalLib, raises: [].}

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
): bool {.cdecl, importc: "GDALIsLineOfSightVisible", dynlib: gdalLib, raises: [].}

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
): CPLErr {.cdecl, importc: "GDALRasterizeGeometries", dynlib: gdalLib, raises: [].}

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
): CPLErr {.
  cdecl, importc: "GDALRasterizeGeometriesInt64", dynlib: gdalLib, raises: []
.}

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
): CPLErr {.cdecl, importc: "GDALRasterizeLayers", dynlib: gdalLib, raises: [].}

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
): CPLErr {.cdecl, importc: "GDALRasterizeLayersBuf", dynlib: gdalLib, raises: [].}

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
): CPLErr {.cdecl, importc: "GDALGridCreate", dynlib: gdalLib, raises: [].}

proc GDALGridContextCreate*(
  eAlgorithm: GDALGridAlgorithm,
  poOptions: pointer,
  nPoints: GUInt32,
  padfX: ptr cdouble,
  padfY: ptr cdouble,
  padfZ: ptr cdouble,
  bCallerWillKeepPointArraysAlive: cint,
): ptr GDALGridContext {.
  cdecl, importc: "GDALGridContextCreate", dynlib: gdalLib, raises: []
.}

proc GDALGridContextFree*(
  psContext: ptr GDALGridContext
) {.cdecl, importc: "GDALGridContextFree", dynlib: gdalLib, raises: [].}

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
): CPLErr {.cdecl, importc: "GDALGridContextProcess", dynlib: gdalLib, raises: [].}

proc GDALComputeMatchingPoints*(
  hFirstImage: GDALDatasetH,
  hSecondImage: GDALDatasetH,
  papszOptions: cstringArray,
  pnGCPCount: ptr cint,
): ptr GDAL_GCP {.
  cdecl, importc: "GDALComputeMatchingPoints", dynlib: gdalLib, raises: []
.}

proc GDALHasTriangulation*(): cint {.
  cdecl, importc: "GDALHasTriangulation", dynlib: gdalLib, raises: []
.}

proc GDALTriangulationCreateDelaunay*(
  nPoints: cint, padfX: ptr cdouble, padfY: ptr cdouble
): ptr GDALTriangulation {.
  cdecl, importc: "GDALTriangulationCreateDelaunay", dynlib: gdalLib, raises: []
.}

proc GDALTriangulationComputeBarycentricCoefficients*(
  psDT: ptr GDALTriangulation, padfX: ptr cdouble, padfY: ptr cdouble
): cint {.
  cdecl,
  importc: "GDALTriangulationComputeBarycentricCoefficients",
  dynlib: gdalLib,
  raises: []
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
  cdecl,
  importc: "GDALTriangulationComputeBarycentricCoordinates",
  dynlib: gdalLib,
  raises: []
.}

proc GDALTriangulationFindFacetBruteForce*(
  psDT: ptr GDALTriangulation, dfX: cdouble, dfY: cdouble, panOutputFacetIdx: ptr cint
): cint {.
  cdecl, importc: "GDALTriangulationFindFacetBruteForce", dynlib: gdalLib, raises: []
.}

proc GDALTriangulationFindFacetDirected*(
  psDT: ptr GDALTriangulation,
  nFacetIdx: cint,
  dfX: cdouble,
  dfY: cdouble,
  panOutputFacetIdx: ptr cint,
): cint {.
  cdecl, importc: "GDALTriangulationFindFacetDirected", dynlib: gdalLib, raises: []
.}

proc GDALTriangulationFree*(
  psDT: ptr GDALTriangulation
) {.cdecl, importc: "GDALTriangulationFree", dynlib: gdalLib, raises: [].}

proc GDALOpenVerticalShiftGrid*(
  pszProj4Geoidgrids: cstring, pbError: ptr cint
): GDALDatasetH {.
  cdecl, importc: "GDALOpenVerticalShiftGrid", dynlib: gdalLib, raises: []
.}

proc GDALApplyVerticalShiftGrid*(
  hSrcDataset: GDALDatasetH,
  hGridDataset: GDALDatasetH,
  bInverse: cint,
  dfSrcUnitToMeter: cdouble,
  dfDstUnitToMeter: cdouble,
  papszOptions: cstringArray,
): GDALDatasetH {.
  cdecl, importc: "GDALApplyVerticalShiftGrid", dynlib: gdalLib, raises: []
.}

proc GDALZonalStats*(
  hSrcDS: GDALDatasetH,
  hWeightsDS: GDALDatasetH,
  hZonesDS: GDALDatasetH,
  hOutDS: GDALDatasetH,
  papszOptions: CSLConstList,
  pfnProgress: GDALProgressFunc,
  pProgressArg: pointer,
): CPLErr {.cdecl, importc: "GDALZonalStats", dynlib: gdalLib, raises: [].}

proc GDALHilbertCode*(
  poDomain: ptr OGREnvelope, dfX: cdouble, dfY: cdouble
): uint32 {.cdecl, importc: "GDALHilbertCode", dynlib: gdalLib, raises: [].}

proc GDALDefaultCSVFilename*(
  pszBasename: cstring
): cstring {.cdecl, importc: "GDALDefaultCSVFilename", dynlib: gdalLib, raises: [].}

proc GDALRegister_GTiff*() {.
  cdecl, importc: "GDALRegister_GTiff", dynlib: gdalLib, raises: []
.}

proc GDALRegister_LIBERTIFF*() {.
  cdecl, importc: "GDALRegister_LIBERTIFF", dynlib: gdalLib, raises: []
.}

proc GDALRegister_GXF*() {.
  cdecl, importc: "GDALRegister_GXF", dynlib: gdalLib, raises: []
.}

proc GDALRegister_HFA*() {.
  cdecl, importc: "GDALRegister_HFA", dynlib: gdalLib, raises: []
.}

proc GDALRegister_AAIGrid*() {.
  cdecl, importc: "GDALRegister_AAIGrid", dynlib: gdalLib, raises: []
.}

proc GDALRegister_GRASSASCIIGrid*() {.
  cdecl, importc: "GDALRegister_GRASSASCIIGrid", dynlib: gdalLib, raises: []
.}

proc GDALRegister_ISG*() {.
  cdecl, importc: "GDALRegister_ISG", dynlib: gdalLib, raises: []
.}

proc GDALRegister_AIGrid*() {.
  cdecl, importc: "GDALRegister_AIGrid", dynlib: gdalLib, raises: []
.}

proc GDALRegister_CEOS*() {.
  cdecl, importc: "GDALRegister_CEOS", dynlib: gdalLib, raises: []
.}

proc GDALRegister_SAR_CEOS*() {.
  cdecl, importc: "GDALRegister_SAR_CEOS", dynlib: gdalLib, raises: []
.}

proc GDALRegister_EHdr*() {.
  cdecl, importc: "GDALRegister_EHdr", dynlib: gdalLib, raises: []
.}

proc GDALRegister_GenBin*() {.
  cdecl, importc: "GDALRegister_GenBin", dynlib: gdalLib, raises: []
.}

proc GDALRegister_PAux*() {.
  cdecl, importc: "GDALRegister_PAux", dynlib: gdalLib, raises: []
.}

proc GDALRegister_ENVI*() {.
  cdecl, importc: "GDALRegister_ENVI", dynlib: gdalLib, raises: []
.}

proc GDALRegister_DOQ1*() {.
  cdecl, importc: "GDALRegister_DOQ1", dynlib: gdalLib, raises: []
.}

proc GDALRegister_DOQ2*() {.
  cdecl, importc: "GDALRegister_DOQ2", dynlib: gdalLib, raises: []
.}

proc GDALRegister_DTED*() {.
  cdecl, importc: "GDALRegister_DTED", dynlib: gdalLib, raises: []
.}

proc GDALRegister_MFF*() {.
  cdecl, importc: "GDALRegister_MFF", dynlib: gdalLib, raises: []
.}

proc GDALRegister_HKV*() {.
  cdecl, importc: "GDALRegister_HKV", dynlib: gdalLib, raises: []
.}

proc GDALRegister_PNG*() {.
  cdecl, importc: "GDALRegister_PNG", dynlib: gdalLib, raises: []
.}

proc DeclareDeferredPNGPlugin*() {.
  cdecl, importc: "DeclareDeferredPNGPlugin", dynlib: gdalLib, raises: []
.}

proc GDALRegister_DDS*() {.
  cdecl, importc: "GDALRegister_DDS", dynlib: gdalLib, raises: []
.}

proc DeclareDeferredDDSPlugin*() {.
  cdecl, importc: "DeclareDeferredDDSPlugin", dynlib: gdalLib, raises: []
.}

proc GDALRegister_GTA*() {.
  cdecl, importc: "GDALRegister_GTA", dynlib: gdalLib, raises: []
.}

proc DeclareDeferredGTAPlugin*() {.
  cdecl, importc: "DeclareDeferredGTAPlugin", dynlib: gdalLib, raises: []
.}

proc GDALRegister_JPEG*() {.
  cdecl, importc: "GDALRegister_JPEG", dynlib: gdalLib, raises: []
.}

proc DeclareDeferredJPEGPlugin*() {.
  cdecl, importc: "DeclareDeferredJPEGPlugin", dynlib: gdalLib, raises: []
.}

proc GDALRegister_JP2KAK*() {.
  cdecl, importc: "GDALRegister_JP2KAK", dynlib: gdalLib, raises: []
.}

proc GDALRegister_JP2Grok*() {.
  cdecl, importc: "GDALRegister_JP2Grok", dynlib: gdalLib, raises: []
.}

proc DeclareDeferredJP2KAKPlugin*() {.
  cdecl, importc: "DeclareDeferredJP2KAKPlugin", dynlib: gdalLib, raises: []
.}

proc GDALRegister_JPIPKAK*() {.
  cdecl, importc: "GDALRegister_JPIPKAK", dynlib: gdalLib, raises: []
.}

proc DeclareDeferredJPIPKAKPlugin*() {.
  cdecl, importc: "DeclareDeferredJPIPKAKPlugin", dynlib: gdalLib, raises: []
.}

proc GDALRegister_MEM*() {.
  cdecl, importc: "GDALRegister_MEM", dynlib: gdalLib, raises: []
.}

proc GDALRegister_JDEM*() {.
  cdecl, importc: "GDALRegister_JDEM", dynlib: gdalLib, raises: []
.}

proc GDALRegister_RASDAMAN*() {.
  cdecl, importc: "GDALRegister_RASDAMAN", dynlib: gdalLib, raises: []
.}

proc GDALRegister_PNM*() {.
  cdecl, importc: "GDALRegister_PNM", dynlib: gdalLib, raises: []
.}

proc GDALRegister_GIF*() {.
  cdecl, importc: "GDALRegister_GIF", dynlib: gdalLib, raises: []
.}

proc DeclareDeferredGIFPlugin*() {.
  cdecl, importc: "DeclareDeferredGIFPlugin", dynlib: gdalLib, raises: []
.}

proc GDALRegister_BIGGIF*() {.
  cdecl, importc: "GDALRegister_BIGGIF", dynlib: gdalLib, raises: []
.}

proc GDALRegister_Envisat*() {.
  cdecl, importc: "GDALRegister_Envisat", dynlib: gdalLib, raises: []
.}

proc GDALRegister_FITS*() {.
  cdecl, importc: "GDALRegister_FITS", dynlib: gdalLib, raises: []
.}

proc DeclareDeferredFITSPlugin*() {.
  cdecl, importc: "DeclareDeferredFITSPlugin", dynlib: gdalLib, raises: []
.}

proc GDALRegister_ECW*() {.
  cdecl, importc: "GDALRegister_ECW", dynlib: gdalLib, raises: []
.}

proc DeclareDeferredECWPlugin*() {.
  cdecl, importc: "DeclareDeferredECWPlugin", dynlib: gdalLib, raises: []
.}

proc GDALRegister_JP2ECW*() {.
  cdecl, importc: "GDALRegister_JP2ECW", dynlib: gdalLib, raises: []
.}

proc GDALRegister_ECW_JP2ECW*() {.
  cdecl, importc: "GDALRegister_ECW_JP2ECW", dynlib: gdalLib, raises: []
.}

proc GDALRegister_FujiBAS*() {.
  cdecl, importc: "GDALRegister_FujiBAS", dynlib: gdalLib, raises: []
.}

proc GDALRegister_VRT*() {.
  cdecl, importc: "GDALRegister_VRT", dynlib: gdalLib, raises: []
.}

proc GDALRegister_GTI*() {.
  cdecl, importc: "GDALRegister_GTI", dynlib: gdalLib, raises: []
.}

proc GDALRegister_USGSDEM*() {.
  cdecl, importc: "GDALRegister_USGSDEM", dynlib: gdalLib, raises: []
.}

proc GDALRegister_FAST*() {.
  cdecl, importc: "GDALRegister_FAST", dynlib: gdalLib, raises: []
.}

proc GDALRegister_HDF4*() {.
  cdecl, importc: "GDALRegister_HDF4", dynlib: gdalLib, raises: []
.}

proc DeclareDeferredHDF4Plugin*() {.
  cdecl, importc: "DeclareDeferredHDF4Plugin", dynlib: gdalLib, raises: []
.}

proc GDALRegister_HDF4Image*() {.
  cdecl, importc: "GDALRegister_HDF4Image", dynlib: gdalLib, raises: []
.}

proc GDALRegister_L1B*() {.
  cdecl, importc: "GDALRegister_L1B", dynlib: gdalLib, raises: []
.}

proc GDALRegister_LDF*() {.
  cdecl, importc: "GDALRegister_LDF", dynlib: gdalLib, raises: []
.}

proc GDALRegister_BSB*() {.
  cdecl, importc: "GDALRegister_BSB", dynlib: gdalLib, raises: []
.}

proc GDALRegister_BMP*() {.
  cdecl, importc: "GDALRegister_BMP", dynlib: gdalLib, raises: []
.}

proc GDALRegister_GSC*() {.
  cdecl, importc: "GDALRegister_GSC", dynlib: gdalLib, raises: []
.}

proc GDALRegister_NITF*() {.
  cdecl, importc: "GDALRegister_NITF", dynlib: gdalLib, raises: []
.}

proc DeclareDeferredNITFPlugin*() {.
  cdecl, importc: "DeclareDeferredNITFPlugin", dynlib: gdalLib, raises: []
.}

proc GDALRegister_RPFTOC*() {.
  cdecl, importc: "GDALRegister_RPFTOC", dynlib: gdalLib, raises: []
.}

proc GDALRegister_ECRGTOC*() {.
  cdecl, importc: "GDALRegister_ECRGTOC", dynlib: gdalLib, raises: []
.}

proc GDALRegister_MrSID*() {.
  cdecl, importc: "GDALRegister_MrSID", dynlib: gdalLib, raises: []
.}

proc DeclareDeferredMrSIDPlugin*() {.
  cdecl, importc: "DeclareDeferredMrSIDPlugin", dynlib: gdalLib, raises: []
.}

proc GDALRegister_MG4Lidar*() {.
  cdecl, importc: "GDALRegister_MG4Lidar", dynlib: gdalLib, raises: []
.}

proc GDALRegister_PCIDSK*() {.
  cdecl, importc: "GDALRegister_PCIDSK", dynlib: gdalLib, raises: []
.}

proc DeclareDeferredPCIDSKPlugin*() {.
  cdecl, importc: "DeclareDeferredPCIDSKPlugin", dynlib: gdalLib, raises: []
.}

proc GDALRegister_BT*() {.
  cdecl, importc: "GDALRegister_BT", dynlib: gdalLib, raises: []
.}

proc GDALRegister_netCDF*() {.
  cdecl, importc: "GDALRegister_netCDF", dynlib: gdalLib, raises: []
.}

proc DeclareDeferredNetCDFPlugin*() {.
  cdecl, importc: "DeclareDeferredNetCDFPlugin", dynlib: gdalLib, raises: []
.}

proc GDALRegister_LAN*() {.
  cdecl, importc: "GDALRegister_LAN", dynlib: gdalLib, raises: []
.}

proc GDALRegister_CPG*() {.
  cdecl, importc: "GDALRegister_CPG", dynlib: gdalLib, raises: []
.}

proc GDALRegister_AirSAR*() {.
  cdecl, importc: "GDALRegister_AirSAR", dynlib: gdalLib, raises: []
.}

proc GDALRegister_RS2*() {.
  cdecl, importc: "GDALRegister_RS2", dynlib: gdalLib, raises: []
.}

proc GDALRegister_ILWIS*() {.
  cdecl, importc: "GDALRegister_ILWIS", dynlib: gdalLib, raises: []
.}

proc GDALRegister_PCRaster*() {.
  cdecl, importc: "GDALRegister_PCRaster", dynlib: gdalLib, raises: []
.}

proc DeclareDeferredPCRasterPlugin*() {.
  cdecl, importc: "DeclareDeferredPCRasterPlugin", dynlib: gdalLib, raises: []
.}

proc GDALRegister_IDA*() {.
  cdecl, importc: "GDALRegister_IDA", dynlib: gdalLib, raises: []
.}

proc GDALRegister_NDF*() {.
  cdecl, importc: "GDALRegister_NDF", dynlib: gdalLib, raises: []
.}

proc GDALRegister_RMF*() {.
  cdecl, importc: "GDALRegister_RMF", dynlib: gdalLib, raises: []
.}

proc GDALRegister_BAG*() {.
  cdecl, importc: "GDALRegister_BAG", dynlib: gdalLib, raises: []
.}

proc GDALRegister_S102*() {.
  cdecl, importc: "GDALRegister_S102", dynlib: gdalLib, raises: []
.}

proc GDALRegister_S104*() {.
  cdecl, importc: "GDALRegister_S104", dynlib: gdalLib, raises: []
.}

proc GDALRegister_S111*() {.
  cdecl, importc: "GDALRegister_S111", dynlib: gdalLib, raises: []
.}

proc GDALRegister_HDF5*() {.
  cdecl, importc: "GDALRegister_HDF5", dynlib: gdalLib, raises: []
.}

proc DeclareDeferredHDF5Plugin*() {.
  cdecl, importc: "DeclareDeferredHDF5Plugin", dynlib: gdalLib, raises: []
.}

proc GDALRegister_HDF5Image*() {.
  cdecl, importc: "GDALRegister_HDF5Image", dynlib: gdalLib, raises: []
.}

proc GDALRegister_MSGN*() {.
  cdecl, importc: "GDALRegister_MSGN", dynlib: gdalLib, raises: []
.}

proc GDALRegister_MSG*() {.
  cdecl, importc: "GDALRegister_MSG", dynlib: gdalLib, raises: []
.}

proc DeclareDeferredMSGPlugin*() {.
  cdecl, importc: "DeclareDeferredMSGPlugin", dynlib: gdalLib, raises: []
.}

proc GDALRegister_RIK*() {.
  cdecl, importc: "GDALRegister_RIK", dynlib: gdalLib, raises: []
.}

proc GDALRegister_Leveller*() {.
  cdecl, importc: "GDALRegister_Leveller", dynlib: gdalLib, raises: []
.}

proc GDALRegister_SRTMHGT*() {.
  cdecl, importc: "GDALRegister_SRTMHGT", dynlib: gdalLib, raises: []
.}

proc GDALRegister_DIPEx*() {.
  cdecl, importc: "GDALRegister_DIPEx", dynlib: gdalLib, raises: []
.}

proc GDALRegister_ISIS3*() {.
  cdecl, importc: "GDALRegister_ISIS3", dynlib: gdalLib, raises: []
.}

proc GDALRegister_ISIS2*() {.
  cdecl, importc: "GDALRegister_ISIS2", dynlib: gdalLib, raises: []
.}

proc GDALRegister_PDS*() {.
  cdecl, importc: "GDALRegister_PDS", dynlib: gdalLib, raises: []
.}

proc DeclareDeferredPDSPlugin*() {.
  cdecl, importc: "DeclareDeferredPDSPlugin", dynlib: gdalLib, raises: []
.}

proc GDALRegister_PDS4*() {.
  cdecl, importc: "GDALRegister_PDS4", dynlib: gdalLib, raises: []
.}

proc GDALRegister_VICAR*() {.
  cdecl, importc: "GDALRegister_VICAR", dynlib: gdalLib, raises: []
.}

proc GDALRegister_IDRISI*() {.
  cdecl, importc: "GDALRegister_IDRISI", dynlib: gdalLib, raises: []
.}

proc GDALRegister_Terragen*() {.
  cdecl, importc: "GDALRegister_Terragen", dynlib: gdalLib, raises: []
.}

proc GDALRegister_WCS*() {.
  cdecl, importc: "GDALRegister_WCS", dynlib: gdalLib, raises: []
.}

proc DeclareDeferredWCSPlugin*() {.
  cdecl, importc: "DeclareDeferredWCSPlugin", dynlib: gdalLib, raises: []
.}

proc GDALRegister_WMS*() {.
  cdecl, importc: "GDALRegister_WMS", dynlib: gdalLib, raises: []
.}

proc DeclareDeferredWMSPlugin*() {.
  cdecl, importc: "DeclareDeferredWMSPlugin", dynlib: gdalLib, raises: []
.}

proc GDALRegister_HTTP*() {.
  cdecl, importc: "GDALRegister_HTTP", dynlib: gdalLib, raises: []
.}

proc GDALRegister_GSAG*() {.
  cdecl, importc: "GDALRegister_GSAG", dynlib: gdalLib, raises: []
.}

proc GDALRegister_GSBG*() {.
  cdecl, importc: "GDALRegister_GSBG", dynlib: gdalLib, raises: []
.}

proc GDALRegister_GS7BG*() {.
  cdecl, importc: "GDALRegister_GS7BG", dynlib: gdalLib, raises: []
.}

proc GDALRegister_GRIB*() {.
  cdecl, importc: "GDALRegister_GRIB", dynlib: gdalLib, raises: []
.}

proc DeclareDeferredGRIBPlugin*() {.
  cdecl, importc: "DeclareDeferredGRIBPlugin", dynlib: gdalLib, raises: []
.}

proc GDALRegister_INGR*() {.
  cdecl, importc: "GDALRegister_INGR", dynlib: gdalLib, raises: []
.}

proc GDALRegister_ERS*() {.
  cdecl, importc: "GDALRegister_ERS", dynlib: gdalLib, raises: []
.}

proc GDALRegister_PALSARJaxa*() {.
  cdecl, importc: "GDALRegister_PALSARJaxa", dynlib: gdalLib, raises: []
.}

proc GDALRegister_DIMAP*() {.
  cdecl, importc: "GDALRegister_DIMAP", dynlib: gdalLib, raises: []
.}

proc GDALRegister_GFF*() {.
  cdecl, importc: "GDALRegister_GFF", dynlib: gdalLib, raises: []
.}

proc GDALRegister_COSAR*() {.
  cdecl, importc: "GDALRegister_COSAR", dynlib: gdalLib, raises: []
.}

proc GDALRegister_TSX*() {.
  cdecl, importc: "GDALRegister_TSX", dynlib: gdalLib, raises: []
.}

proc GDALRegister_ADRG*() {.
  cdecl, importc: "GDALRegister_ADRG", dynlib: gdalLib, raises: []
.}

proc GDALRegister_SRP*() {.
  cdecl, importc: "GDALRegister_SRP", dynlib: gdalLib, raises: []
.}

proc GDALRegister_COASP*() {.
  cdecl, importc: "GDALRegister_COASP", dynlib: gdalLib, raises: []
.}

proc GDALRegister_LCP*() {.
  cdecl, importc: "GDALRegister_LCP", dynlib: gdalLib, raises: []
.}

proc GDALRegister_EIR*() {.
  cdecl, importc: "GDALRegister_EIR", dynlib: gdalLib, raises: []
.}

proc GDALRegister_ESRIC*() {.
  cdecl, importc: "GDALRegister_ESRIC", dynlib: gdalLib, raises: []
.}

proc GDALRegister_GEOR*() {.
  cdecl, importc: "GDALRegister_GEOR", dynlib: gdalLib, raises: []
.}

proc DeclareDeferredGEORPlugin*() {.
  cdecl, importc: "DeclareDeferredGEORPlugin", dynlib: gdalLib, raises: []
.}

proc GDALRegister_TIL*() {.
  cdecl, importc: "GDALRegister_TIL", dynlib: gdalLib, raises: []
.}

proc GDALRegister_R*() {.cdecl, importc: "GDALRegister_R", dynlib: gdalLib, raises: [].}
proc GDALRegister_PostGISRaster*() {.
  cdecl, importc: "GDALRegister_PostGISRaster", dynlib: gdalLib, raises: []
.}

proc DeclareDeferredPostGISRasterPlugin*() {.
  cdecl, importc: "DeclareDeferredPostGISRasterPlugin", dynlib: gdalLib, raises: []
.}

proc GDALRegister_NWT_GRD*() {.
  cdecl, importc: "GDALRegister_NWT_GRD", dynlib: gdalLib, raises: []
.}

proc GDALRegister_NWT_GRC*() {.
  cdecl, importc: "GDALRegister_NWT_GRC", dynlib: gdalLib, raises: []
.}

proc GDALRegister_SAGA*() {.
  cdecl, importc: "GDALRegister_SAGA", dynlib: gdalLib, raises: []
.}

proc GDALRegister_KMLSUPEROVERLAY*() {.
  cdecl, importc: "GDALRegister_KMLSUPEROVERLAY", dynlib: gdalLib, raises: []
.}

proc GDALRegister_GTX*() {.
  cdecl, importc: "GDALRegister_GTX", dynlib: gdalLib, raises: []
.}

proc GDALRegister_LOSLAS*() {.
  cdecl, importc: "GDALRegister_LOSLAS", dynlib: gdalLib, raises: []
.}

proc GDALRegister_NTv2*() {.
  cdecl, importc: "GDALRegister_NTv2", dynlib: gdalLib, raises: []
.}

proc GDALRegister_JP2OpenJPEG*() {.
  cdecl, importc: "GDALRegister_JP2OpenJPEG", dynlib: gdalLib, raises: []
.}

proc DeclareDeferredOPENJPEGPlugin*() {.
  cdecl, importc: "DeclareDeferredOPENJPEGPlugin", dynlib: gdalLib, raises: []
.}

proc GDALRegister_XYZ*() {.
  cdecl, importc: "GDALRegister_XYZ", dynlib: gdalLib, raises: []
.}

proc GDALRegister_HF2*() {.
  cdecl, importc: "GDALRegister_HF2", dynlib: gdalLib, raises: []
.}

proc GDALRegister_PDF*() {.
  cdecl, importc: "GDALRegister_PDF", dynlib: gdalLib, raises: []
.}

proc DeclareDeferredPDFPlugin*() {.
  cdecl, importc: "DeclareDeferredPDFPlugin", dynlib: gdalLib, raises: []
.}

proc GDALRegister_MAP*() {.
  cdecl, importc: "GDALRegister_MAP", dynlib: gdalLib, raises: []
.}

proc GDALRegister_ACE2*() {.
  cdecl, importc: "GDALRegister_ACE2", dynlib: gdalLib, raises: []
.}

proc GDALRegister_CTG*() {.
  cdecl, importc: "GDALRegister_CTG", dynlib: gdalLib, raises: []
.}

proc GDALRegister_SNODAS*() {.
  cdecl, importc: "GDALRegister_SNODAS", dynlib: gdalLib, raises: []
.}

proc GDALRegister_WEBP*() {.
  cdecl, importc: "GDALRegister_WEBP", dynlib: gdalLib, raises: []
.}

proc DeclareDeferredWEBPPlugin*() {.
  cdecl, importc: "DeclareDeferredWEBPPlugin", dynlib: gdalLib, raises: []
.}

proc GDALRegister_ZMap*() {.
  cdecl, importc: "GDALRegister_ZMap", dynlib: gdalLib, raises: []
.}

proc GDALRegister_NGSGEOID*() {.
  cdecl, importc: "GDALRegister_NGSGEOID", dynlib: gdalLib, raises: []
.}

proc GDALRegister_MBTiles*() {.
  cdecl, importc: "GDALRegister_MBTiles", dynlib: gdalLib, raises: []
.}

proc GDALRegister_IRIS*() {.
  cdecl, importc: "GDALRegister_IRIS", dynlib: gdalLib, raises: []
.}

proc GDALRegister_KRO*() {.
  cdecl, importc: "GDALRegister_KRO", dynlib: gdalLib, raises: []
.}

proc GDALRegister_KEA*() {.
  cdecl, importc: "GDALRegister_KEA", dynlib: gdalLib, raises: []
.}

proc DeclareDeferredKEAPlugin*() {.
  cdecl, importc: "DeclareDeferredKEAPlugin", dynlib: gdalLib, raises: []
.}

proc GDALRegister_ROIPAC*() {.
  cdecl, importc: "GDALRegister_ROIPAC", dynlib: gdalLib, raises: []
.}

proc GDALRegister_PLMOSAIC*() {.
  cdecl, importc: "GDALRegister_PLMOSAIC", dynlib: gdalLib, raises: []
.}

proc GDALRegister_CALS*() {.
  cdecl, importc: "GDALRegister_CALS", dynlib: gdalLib, raises: []
.}

proc GDALRegister_ISCE*() {.
  cdecl, importc: "GDALRegister_ISCE", dynlib: gdalLib, raises: []
.}

proc GDALRegister_WMTS*() {.
  cdecl, importc: "GDALRegister_WMTS", dynlib: gdalLib, raises: []
.}

proc DeclareDeferredWMTSPlugin*() {.
  cdecl, importc: "DeclareDeferredWMTSPlugin", dynlib: gdalLib, raises: []
.}

proc GDALRegister_SAFE*() {.
  cdecl, importc: "GDALRegister_SAFE", dynlib: gdalLib, raises: []
.}

proc GDALRegister_SENTINEL2*() {.
  cdecl, importc: "GDALRegister_SENTINEL2", dynlib: gdalLib, raises: []
.}

proc GDALRegister_MRF*() {.
  cdecl, importc: "GDALRegister_MRF", dynlib: gdalLib, raises: []
.}

proc DeclareDeferredMRFPlugin*() {.
  cdecl, importc: "DeclareDeferredMRFPlugin", dynlib: gdalLib, raises: []
.}

proc GDALRegister_RRASTER*() {.
  cdecl, importc: "GDALRegister_RRASTER", dynlib: gdalLib, raises: []
.}

proc GDALRegister_Derived*() {.
  cdecl, importc: "GDALRegister_Derived", dynlib: gdalLib, raises: []
.}

proc GDALRegister_PRF*() {.
  cdecl, importc: "GDALRegister_PRF", dynlib: gdalLib, raises: []
.}

proc GDALRegister_NULL*() {.
  cdecl, importc: "GDALRegister_NULL", dynlib: gdalLib, raises: []
.}

proc GDALRegister_EEDAI*() {.
  cdecl, importc: "GDALRegister_EEDAI", dynlib: gdalLib, raises: []
.}

proc GDALRegister_EEDA*() {.
  cdecl, importc: "GDALRegister_EEDA", dynlib: gdalLib, raises: []
.}

proc GDALRegister_SIGDEM*() {.
  cdecl, importc: "GDALRegister_SIGDEM", dynlib: gdalLib, raises: []
.}

proc GDALRegister_BYN*() {.
  cdecl, importc: "GDALRegister_BYN", dynlib: gdalLib, raises: []
.}

proc GDALRegister_TileDB*() {.
  cdecl, importc: "GDALRegister_TileDB", dynlib: gdalLib, raises: []
.}

proc DeclareDeferredTileDBPlugin*() {.
  cdecl, importc: "DeclareDeferredTileDBPlugin", dynlib: gdalLib, raises: []
.}

proc GDALRegister_DAAS*() {.
  cdecl, importc: "GDALRegister_DAAS", dynlib: gdalLib, raises: []
.}

proc GDALRegister_COG*() {.
  cdecl, importc: "GDALRegister_COG", dynlib: gdalLib, raises: []
.}

proc GDALRegister_RDB*() {.
  cdecl, importc: "GDALRegister_RDB", dynlib: gdalLib, raises: []
.}

proc GDALRegister_EXR*() {.
  cdecl, importc: "GDALRegister_EXR", dynlib: gdalLib, raises: []
.}

proc DeclareDeferredEXRPlugin*() {.
  cdecl, importc: "DeclareDeferredEXRPlugin", dynlib: gdalLib, raises: []
.}

proc GDALRegister_AVIF*() {.
  cdecl, importc: "GDALRegister_AVIF", dynlib: gdalLib, raises: []
.}

proc DeclareDeferredAVIFPlugin*() {.
  cdecl, importc: "DeclareDeferredAVIFPlugin", dynlib: gdalLib, raises: []
.}

proc GDALRegister_HEIF*() {.
  cdecl, importc: "GDALRegister_HEIF", dynlib: gdalLib, raises: []
.}

proc DeclareDeferredHEIFPlugin*() {.
  cdecl, importc: "DeclareDeferredHEIFPlugin", dynlib: gdalLib, raises: []
.}

proc GDALRegister_TGA*() {.
  cdecl, importc: "GDALRegister_TGA", dynlib: gdalLib, raises: []
.}

proc GDALRegister_OGCAPI*() {.
  cdecl, importc: "GDALRegister_OGCAPI", dynlib: gdalLib, raises: []
.}

proc GDALRegister_STACTA*() {.
  cdecl, importc: "GDALRegister_STACTA", dynlib: gdalLib, raises: []
.}

proc GDALRegister_Zarr*() {.
  cdecl, importc: "GDALRegister_Zarr", dynlib: gdalLib, raises: []
.}

proc DeclareDeferredZarrPlugin*() {.
  cdecl, importc: "DeclareDeferredZarrPlugin", dynlib: gdalLib, raises: []
.}

proc GDALRegister_STACIT*() {.
  cdecl, importc: "GDALRegister_STACIT", dynlib: gdalLib, raises: []
.}

proc GDALRegister_JPEGXL*() {.
  cdecl, importc: "GDALRegister_JPEGXL", dynlib: gdalLib, raises: []
.}

proc DeclareDeferredJPEGXLPlugin*() {.
  cdecl, importc: "DeclareDeferredJPEGXLPlugin", dynlib: gdalLib, raises: []
.}

proc GDALRegister_BASISU*() {.
  cdecl, importc: "GDALRegister_BASISU", dynlib: gdalLib, raises: []
.}

proc GDALRegister_KTX2*() {.
  cdecl, importc: "GDALRegister_KTX2", dynlib: gdalLib, raises: []
.}

proc GDALRegister_BASISU_KTX2*() {.
  cdecl, importc: "GDALRegister_BASISU_KTX2", dynlib: gdalLib, raises: []
.}

proc DeclareDeferredBASISU_KTX2Plugin*() {.
  cdecl, importc: "DeclareDeferredBASISU_KTX2Plugin", dynlib: gdalLib, raises: []
.}

proc GDALRegister_NOAA_B*() {.
  cdecl, importc: "GDALRegister_NOAA_B", dynlib: gdalLib, raises: []
.}

proc GDALRegister_NSIDCbin*() {.
  cdecl, importc: "GDALRegister_NSIDCbin", dynlib: gdalLib, raises: []
.}

proc GDALRegister_SNAP_TIFF*() {.
  cdecl, importc: "GDALRegister_SNAP_TIFF", dynlib: gdalLib, raises: []
.}

proc GDALRegister_RCM*() {.
  cdecl, importc: "GDALRegister_RCM", dynlib: gdalLib, raises: []
.}

proc GDALRegister_MiraMon*() {.
  cdecl, importc: "GDALRegister_MiraMon", dynlib: gdalLib, raises: []
.}

proc GDALRegister_GDALG*() {.
  cdecl, importc: "GDALRegister_GDALG", dynlib: gdalLib, raises: []
.}

proc GDALRegister_E57*() {.
  cdecl, importc: "GDALRegister_E57", dynlib: gdalLib, raises: []
.}

proc GDALRegister_CPHD*() {.
  cdecl, importc: "GDALRegister_CPHD", dynlib: gdalLib, raises: []
.}

proc MEMCreate*(
  nXSize: cint,
  nYSize: cint,
  nBands: cint,
  eType: GDALDataType,
  papszOptions: CSLConstList,
): GDALDatasetH {.cdecl, importc: "MEMCreate", dynlib: gdalLib, raises: [].}

proc GDALInfoOptionsNew*(
  papszArgv: cstringArray, psOptionsForBinary: ptr GDALInfoOptionsForBinary
): ptr GDALInfoOptions {.
  cdecl, importc: "GDALInfoOptionsNew", dynlib: gdalLib, raises: []
.}

proc GDALInfoOptionsFree*(
  psOptions: ptr GDALInfoOptions
) {.cdecl, importc: "GDALInfoOptionsFree", dynlib: gdalLib, raises: [].}

proc GDALInfo*(
  hDataset: GDALDatasetH, psOptions: ptr GDALInfoOptions
): cstring {.cdecl, importc: "GDALInfo", dynlib: gdalLib, raises: [].}

proc GDALTranslateOptionsNew*(
  papszArgv: cstringArray, psOptionsForBinary: ptr GDALTranslateOptionsForBinary
): ptr GDALTranslateOptions {.
  cdecl, importc: "GDALTranslateOptionsNew", dynlib: gdalLib, raises: []
.}

proc GDALTranslateOptionsFree*(
  psOptions: ptr GDALTranslateOptions
) {.cdecl, importc: "GDALTranslateOptionsFree", dynlib: gdalLib, raises: [].}

proc GDALTranslateOptionsSetProgress*(
  psOptions: ptr GDALTranslateOptions,
  pfnProgress: GDALProgressFunc,
  pProgressData: pointer,
) {.cdecl, importc: "GDALTranslateOptionsSetProgress", dynlib: gdalLib, raises: [].}

proc GDALTranslate*(
  pszDestFilename: cstring,
  hSrcDataset: GDALDatasetH,
  psOptions: ptr GDALTranslateOptions,
  pbUsageError: ptr cint,
): GDALDatasetH {.cdecl, importc: "GDALTranslate", dynlib: gdalLib, raises: [].}

proc GDALWarpAppOptionsNew*(
  papszArgv: cstringArray, psOptionsForBinary: ptr GDALWarpAppOptionsForBinary
): ptr GDALWarpAppOptions {.
  cdecl, importc: "GDALWarpAppOptionsNew", dynlib: gdalLib, raises: []
.}

proc GDALWarpAppOptionsFree*(
  psOptions: ptr GDALWarpAppOptions
) {.cdecl, importc: "GDALWarpAppOptionsFree", dynlib: gdalLib, raises: [].}

proc GDALWarpAppOptionsSetProgress*(
  psOptions: ptr GDALWarpAppOptions,
  pfnProgress: GDALProgressFunc,
  pProgressData: pointer,
) {.cdecl, importc: "GDALWarpAppOptionsSetProgress", dynlib: gdalLib, raises: [].}

proc GDALWarpAppOptionsSetQuiet*(
  psOptions: ptr GDALWarpAppOptions, bQuiet: cint
) {.cdecl, importc: "GDALWarpAppOptionsSetQuiet", dynlib: gdalLib, raises: [].}

proc GDALWarpAppOptionsSetWarpOption*(
  psOptions: ptr GDALWarpAppOptions, pszKey: cstring, pszValue: cstring
) {.cdecl, importc: "GDALWarpAppOptionsSetWarpOption", dynlib: gdalLib, raises: [].}

proc GDALWarp*(
  pszDest: cstring,
  hDstDS: GDALDatasetH,
  nSrcCount: cint,
  pahSrcDS: ptr GDALDatasetH,
  psOptions: ptr GDALWarpAppOptions,
  pbUsageError: ptr cint,
): GDALDatasetH {.cdecl, importc: "GDALWarp", dynlib: gdalLib, raises: [].}

proc GDALVectorTranslateOptionsNew*(
  papszArgv: cstringArray, psOptionsForBinary: ptr GDALVectorTranslateOptionsForBinary
): ptr GDALVectorTranslateOptions {.
  cdecl, importc: "GDALVectorTranslateOptionsNew", dynlib: gdalLib, raises: []
.}

proc GDALVectorTranslateOptionsFree*(
  psOptions: ptr GDALVectorTranslateOptions
) {.cdecl, importc: "GDALVectorTranslateOptionsFree", dynlib: gdalLib, raises: [].}

proc GDALVectorTranslateOptionsSetProgress*(
  psOptions: ptr GDALVectorTranslateOptions,
  pfnProgress: GDALProgressFunc,
  pProgressData: pointer,
) {.
  cdecl, importc: "GDALVectorTranslateOptionsSetProgress", dynlib: gdalLib, raises: []
.}

proc GDALVectorTranslate*(
  pszDest: cstring,
  hDstDS: GDALDatasetH,
  nSrcCount: cint,
  pahSrcDS: ptr GDALDatasetH,
  psOptions: ptr GDALVectorTranslateOptions,
  pbUsageError: ptr cint,
): GDALDatasetH {.cdecl, importc: "GDALVectorTranslate", dynlib: gdalLib, raises: [].}

proc GDALDEMProcessingOptionsNew*(
  papszArgv: cstringArray, psOptionsForBinary: ptr GDALDEMProcessingOptionsForBinary
): ptr GDALDEMProcessingOptions {.
  cdecl, importc: "GDALDEMProcessingOptionsNew", dynlib: gdalLib, raises: []
.}

proc GDALDEMProcessingOptionsFree*(
  psOptions: ptr GDALDEMProcessingOptions
) {.cdecl, importc: "GDALDEMProcessingOptionsFree", dynlib: gdalLib, raises: [].}

proc GDALDEMProcessingOptionsSetProgress*(
  psOptions: ptr GDALDEMProcessingOptions,
  pfnProgress: GDALProgressFunc,
  pProgressData: pointer,
) {.cdecl, importc: "GDALDEMProcessingOptionsSetProgress", dynlib: gdalLib, raises: [].}

proc GDALDEMProcessing*(
  pszDestFilename: cstring,
  hSrcDataset: GDALDatasetH,
  pszProcessing: cstring,
  pszColorFilename: cstring,
  psOptions: ptr GDALDEMProcessingOptions,
  pbUsageError: ptr cint,
): GDALDatasetH {.cdecl, importc: "GDALDEMProcessing", dynlib: gdalLib, raises: [].}

proc GDALNearblackOptionsNew*(
  papszArgv: cstringArray, psOptionsForBinary: ptr GDALNearblackOptionsForBinary
): ptr GDALNearblackOptions {.
  cdecl, importc: "GDALNearblackOptionsNew", dynlib: gdalLib, raises: []
.}

proc GDALNearblackOptionsFree*(
  psOptions: ptr GDALNearblackOptions
) {.cdecl, importc: "GDALNearblackOptionsFree", dynlib: gdalLib, raises: [].}

proc GDALNearblackOptionsSetProgress*(
  psOptions: ptr GDALNearblackOptions,
  pfnProgress: GDALProgressFunc,
  pProgressData: pointer,
) {.cdecl, importc: "GDALNearblackOptionsSetProgress", dynlib: gdalLib, raises: [].}

proc GDALNearblack*(
  pszDest: cstring,
  hDstDS: GDALDatasetH,
  hSrcDS: GDALDatasetH,
  psOptions: ptr GDALNearblackOptions,
  pbUsageError: ptr cint,
): GDALDatasetH {.cdecl, importc: "GDALNearblack", dynlib: gdalLib, raises: [].}

proc GDALGridOptionsNew*(
  papszArgv: cstringArray, psOptionsForBinary: ptr GDALGridOptionsForBinary
): ptr GDALGridOptions {.
  cdecl, importc: "GDALGridOptionsNew", dynlib: gdalLib, raises: []
.}

proc GDALGridOptionsFree*(
  psOptions: ptr GDALGridOptions
) {.cdecl, importc: "GDALGridOptionsFree", dynlib: gdalLib, raises: [].}

proc GDALGridOptionsSetProgress*(
  psOptions: ptr GDALGridOptions, pfnProgress: GDALProgressFunc, pProgressData: pointer
) {.cdecl, importc: "GDALGridOptionsSetProgress", dynlib: gdalLib, raises: [].}

proc GDALGrid*(
  pszDest: cstring,
  hSrcDS: GDALDatasetH,
  psOptions: ptr GDALGridOptions,
  pbUsageError: ptr cint,
): GDALDatasetH {.cdecl, importc: "GDALGrid", dynlib: gdalLib, raises: [].}

proc GDALContourOptionsNew*(
  papszArgv: cstringArray, psOptionsForBinary: ptr GDALContourOptionsForBinary
): ptr GDALContourOptions {.
  cdecl, importc: "GDALContourOptionsNew", dynlib: gdalLib, raises: []
.}

proc GDALContourOptionsFree*(
  psOptions: ptr GDALContourOptions
) {.cdecl, importc: "GDALContourOptionsFree", dynlib: gdalLib, raises: [].}

proc GDALContourOptionsSetProgress*(
  psOptions: ptr GDALContourOptions,
  pfnProgress: GDALProgressFunc,
  pProgressData: pointer,
) {.cdecl, importc: "GDALContourOptionsSetProgress", dynlib: gdalLib, raises: [].}

proc GDALContourOptionsSetDestDataSource*(
  psOptions: ptr GDALContourOptions, pszDestDatasource: cstring
) {.cdecl, importc: "GDALContourOptionsSetDestDataSource", dynlib: gdalLib, raises: [].}

proc GDALContourProcessOptions*(
  psOptions: ptr GDALContourOptions,
  ppapszStringOptions: ptr cstringArray,
  hSrcDS: ptr GDALDatasetH,
  hBand: ptr GDALRasterBandH,
  hDstDS: ptr GDALDatasetH,
  hLayer: ptr OGRLayerH,
): CPLErr {.cdecl, importc: "GDALContourProcessOptions", dynlib: gdalLib, raises: [].}

proc GDALRasterizeOptionsNew*(
  papszArgv: cstringArray, psOptionsForBinary: ptr GDALRasterizeOptionsForBinary
): ptr GDALRasterizeOptions {.
  cdecl, importc: "GDALRasterizeOptionsNew", dynlib: gdalLib, raises: []
.}

proc GDALRasterizeOptionsFree*(
  psOptions: ptr GDALRasterizeOptions
) {.cdecl, importc: "GDALRasterizeOptionsFree", dynlib: gdalLib, raises: [].}

proc GDALRasterizeOptionsSetProgress*(
  psOptions: ptr GDALRasterizeOptions,
  pfnProgress: GDALProgressFunc,
  pProgressData: pointer,
) {.cdecl, importc: "GDALRasterizeOptionsSetProgress", dynlib: gdalLib, raises: [].}

proc GDALRasterize*(
  pszDest: cstring,
  hDstDS: GDALDatasetH,
  hSrcDS: GDALDatasetH,
  psOptions: ptr GDALRasterizeOptions,
  pbUsageError: ptr cint,
): GDALDatasetH {.cdecl, importc: "GDALRasterize", dynlib: gdalLib, raises: [].}

proc GDALFootprintOptionsNew*(
  papszArgv: cstringArray, psOptionsForBinary: ptr GDALFootprintOptionsForBinary
): ptr GDALFootprintOptions {.
  cdecl, importc: "GDALFootprintOptionsNew", dynlib: gdalLib, raises: []
.}

proc GDALFootprintOptionsFree*(
  psOptions: ptr GDALFootprintOptions
) {.cdecl, importc: "GDALFootprintOptionsFree", dynlib: gdalLib, raises: [].}

proc GDALFootprintOptionsSetProgress*(
  psOptions: ptr GDALFootprintOptions,
  pfnProgress: GDALProgressFunc,
  pProgressData: pointer,
) {.cdecl, importc: "GDALFootprintOptionsSetProgress", dynlib: gdalLib, raises: [].}

proc GDALFootprint*(
  pszDest: cstring,
  hDstDS: GDALDatasetH,
  hSrcDS: GDALDatasetH,
  psOptions: ptr GDALFootprintOptions,
  pbUsageError: ptr cint,
): GDALDatasetH {.cdecl, importc: "GDALFootprint", dynlib: gdalLib, raises: [].}

proc GDALBuildVRTOptionsNew*(
  papszArgv: cstringArray, psOptionsForBinary: ptr GDALBuildVRTOptionsForBinary
): ptr GDALBuildVRTOptions {.
  cdecl, importc: "GDALBuildVRTOptionsNew", dynlib: gdalLib, raises: []
.}

proc GDALBuildVRTOptionsFree*(
  psOptions: ptr GDALBuildVRTOptions
) {.cdecl, importc: "GDALBuildVRTOptionsFree", dynlib: gdalLib, raises: [].}

proc GDALBuildVRTOptionsSetProgress*(
  psOptions: ptr GDALBuildVRTOptions,
  pfnProgress: GDALProgressFunc,
  pProgressData: pointer,
) {.cdecl, importc: "GDALBuildVRTOptionsSetProgress", dynlib: gdalLib, raises: [].}

proc GDALBuildVRT*(
  pszDest: cstring,
  nSrcCount: cint,
  pahSrcDS: ptr GDALDatasetH,
  papszSrcDSNames: cstringArray,
  psOptions: ptr GDALBuildVRTOptions,
  pbUsageError: ptr cint,
): GDALDatasetH {.cdecl, importc: "GDALBuildVRT", dynlib: gdalLib, raises: [].}

proc GDALMultiDimInfoOptionsNew*(
  papszArgv: cstringArray, psOptionsForBinary: ptr GDALMultiDimInfoOptionsForBinary
): ptr GDALMultiDimInfoOptions {.
  cdecl, importc: "GDALMultiDimInfoOptionsNew", dynlib: gdalLib, raises: []
.}

proc GDALMultiDimInfoOptionsFree*(
  psOptions: ptr GDALMultiDimInfoOptions
) {.cdecl, importc: "GDALMultiDimInfoOptionsFree", dynlib: gdalLib, raises: [].}

proc GDALMultiDimInfo*(
  hDataset: GDALDatasetH, psOptions: ptr GDALMultiDimInfoOptions
): cstring {.cdecl, importc: "GDALMultiDimInfo", dynlib: gdalLib, raises: [].}

proc GDALMultiDimTranslateOptionsNew*(
  papszArgv: cstringArray, psOptionsForBinary: ptr GDALMultiDimTranslateOptionsForBinary
): ptr GDALMultiDimTranslateOptions {.
  cdecl, importc: "GDALMultiDimTranslateOptionsNew", dynlib: gdalLib, raises: []
.}

proc GDALMultiDimTranslateOptionsFree*(
  psOptions: ptr GDALMultiDimTranslateOptions
) {.cdecl, importc: "GDALMultiDimTranslateOptionsFree", dynlib: gdalLib, raises: [].}

proc GDALMultiDimTranslateOptionsSetProgress*(
  psOptions: ptr GDALMultiDimTranslateOptions,
  pfnProgress: GDALProgressFunc,
  pProgressData: pointer,
) {.
  cdecl, importc: "GDALMultiDimTranslateOptionsSetProgress", dynlib: gdalLib, raises: []
.}

proc GDALMultiDimTranslate*(
  pszDest: cstring,
  hDstDataset: GDALDatasetH,
  nSrcCount: cint,
  pahSrcDS: ptr GDALDatasetH,
  psOptions: ptr GDALMultiDimTranslateOptions,
  pbUsageError: ptr cint,
): GDALDatasetH {.cdecl, importc: "GDALMultiDimTranslate", dynlib: gdalLib, raises: [].}

proc GDALVectorInfoOptionsNew*(
  papszArgv: cstringArray, psOptionsForBinary: ptr GDALVectorInfoOptionsForBinary
): ptr GDALVectorInfoOptions {.
  cdecl, importc: "GDALVectorInfoOptionsNew", dynlib: gdalLib, raises: []
.}

proc GDALVectorInfoOptionsFree*(
  psOptions: ptr GDALVectorInfoOptions
) {.cdecl, importc: "GDALVectorInfoOptionsFree", dynlib: gdalLib, raises: [].}

proc GDALVectorInfo*(
  hDataset: GDALDatasetH, psOptions: ptr GDALVectorInfoOptions
): cstring {.cdecl, importc: "GDALVectorInfo", dynlib: gdalLib, raises: [].}

proc GDALTileIndexOptionsNew*(
  papszArgv: cstringArray, psOptionsForBinary: ptr GDALTileIndexOptionsForBinary
): ptr GDALTileIndexOptions {.
  cdecl, importc: "GDALTileIndexOptionsNew", dynlib: gdalLib, raises: []
.}

proc GDALTileIndexOptionsSetProgress*(
  psOptions: ptr GDALTileIndexOptions,
  pfnProgress: GDALProgressFunc,
  pProgressData: pointer,
) {.cdecl, importc: "GDALTileIndexOptionsSetProgress", dynlib: gdalLib, raises: [].}

proc GDALTileIndexOptionsFree*(
  psOptions: ptr GDALTileIndexOptions
) {.cdecl, importc: "GDALTileIndexOptionsFree", dynlib: gdalLib, raises: [].}

proc GDALTileIndex*(
  pszDest: cstring,
  nSrcCount: cint,
  papszSrcDSNames: cstringArray,
  psOptions: ptr GDALTileIndexOptions,
  pbUsageError: ptr cint,
): GDALDatasetH {.cdecl, importc: "GDALTileIndex", dynlib: gdalLib, raises: [].}

proc VRTCreate*(
  a0: cint, a1: cint
): VRTDatasetH {.gdalCall, importc: "VRTCreate", dynlib: gdalLib, raises: [].}

proc VRTFlushCache*(
  a0: VRTDatasetH
) {.gdalCall, importc: "VRTFlushCache", dynlib: gdalLib, raises: [].}

proc VRTSerializeToXML*(
  a0: VRTDatasetH, a1: cstring
): ptr CPLXMLNode {.
  gdalCall, importc: "VRTSerializeToXML", dynlib: gdalLib, raises: []
.}

proc VRTAddBand*(
  a0: VRTDatasetH, a1: GDALDataType, a2: CSLConstList
): cint {.gdalCall, importc: "VRTAddBand", dynlib: gdalLib, raises: [].}

proc VRTAddSource*(
  a0: VRTSourcedRasterBandH, a1: VRTSourceH
): CPLErr {.gdalCall, importc: "VRTAddSource", dynlib: gdalLib, raises: [].}

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
): CPLErr {.gdalCall, importc: "VRTAddSimpleSource", dynlib: gdalLib, raises: [].}

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
): CPLErr {.gdalCall, importc: "VRTAddComplexSource", dynlib: gdalLib, raises: [].}

proc VRTAddFuncSource*(
  a0: VRTSourcedRasterBandH, a1: VRTImageReadFunc, a2: pointer, a3: cdouble
): CPLErr {.gdalCall, importc: "VRTAddFuncSource", dynlib: gdalLib, raises: [].}

proc GDALAlgorithmArgTypeIsList*(
  `type`: GDALAlgorithmArgType
): bool {.cdecl, importc: "GDALAlgorithmArgTypeIsList", dynlib: gdalLib, raises: [].}

proc GDALAlgorithmArgTypeName*(
  `type`: GDALAlgorithmArgType
): cstring {.cdecl, importc: "GDALAlgorithmArgTypeName", dynlib: gdalLib, raises: [].}

proc GDALGetGlobalAlgorithmRegistry*(): GDALAlgorithmRegistryH {.
  cdecl, importc: "GDALGetGlobalAlgorithmRegistry", dynlib: gdalLib, raises: []
.}

proc GDALAlgorithmRegistryRelease*(
  a0: GDALAlgorithmRegistryH
) {.cdecl, importc: "GDALAlgorithmRegistryRelease", dynlib: gdalLib, raises: [].}

proc GDALAlgorithmRegistryGetAlgNames*(
  a0: GDALAlgorithmRegistryH
): cstringArray {.
  cdecl, importc: "GDALAlgorithmRegistryGetAlgNames", dynlib: gdalLib, raises: []
.}

proc GDALAlgorithmRegistryInstantiateAlg*(
  a0: GDALAlgorithmRegistryH, pszAlgName: cstring
): GDALAlgorithmH {.
  cdecl, importc: "GDALAlgorithmRegistryInstantiateAlg", dynlib: gdalLib, raises: []
.}

proc GDALAlgorithmRegistryInstantiateAlgFromPath*(
  a0: GDALAlgorithmRegistryH, papszAlgPath: cstringArray
): GDALAlgorithmH {.
  cdecl,
  importc: "GDALAlgorithmRegistryInstantiateAlgFromPath",
  dynlib: gdalLib,
  raises: []
.}

proc GDALAlgorithmRelease*(
  a0: GDALAlgorithmH
) {.cdecl, importc: "GDALAlgorithmRelease", dynlib: gdalLib, raises: [].}

proc GDALAlgorithmGetName*(
  a0: GDALAlgorithmH
): cstring {.cdecl, importc: "GDALAlgorithmGetName", dynlib: gdalLib, raises: [].}

proc GDALAlgorithmGetDescription*(
  a0: GDALAlgorithmH
): cstring {.
  cdecl, importc: "GDALAlgorithmGetDescription", dynlib: gdalLib, raises: []
.}

proc GDALAlgorithmGetLongDescription*(
  a0: GDALAlgorithmH
): cstring {.
  cdecl, importc: "GDALAlgorithmGetLongDescription", dynlib: gdalLib, raises: []
.}

proc GDALAlgorithmGetHelpFullURL*(
  a0: GDALAlgorithmH
): cstring {.
  cdecl, importc: "GDALAlgorithmGetHelpFullURL", dynlib: gdalLib, raises: []
.}

proc GDALAlgorithmHasSubAlgorithms*(
  a0: GDALAlgorithmH
): bool {.cdecl, importc: "GDALAlgorithmHasSubAlgorithms", dynlib: gdalLib, raises: [].}

proc GDALAlgorithmGetSubAlgorithmNames*(
  a0: GDALAlgorithmH
): cstringArray {.
  cdecl, importc: "GDALAlgorithmGetSubAlgorithmNames", dynlib: gdalLib, raises: []
.}

proc GDALAlgorithmInstantiateSubAlgorithm*(
  a0: GDALAlgorithmH, pszSubAlgName: cstring
): GDALAlgorithmH {.
  cdecl, importc: "GDALAlgorithmInstantiateSubAlgorithm", dynlib: gdalLib, raises: []
.}

proc GDALAlgorithmParseCommandLineArguments*(
  a0: GDALAlgorithmH, papszArgs: CSLConstList
): bool {.
  cdecl, importc: "GDALAlgorithmParseCommandLineArguments", dynlib: gdalLib, raises: []
.}

proc GDALAlgorithmGetArgDependencies*(
  a0: GDALAlgorithmH, pszArgumentName: cstring
): cstringArray {.
  cdecl, importc: "GDALAlgorithmGetArgDependencies", dynlib: gdalLib, raises: []
.}

proc GDALAlgorithmGetActualAlgorithm*(
  a0: GDALAlgorithmH
): GDALAlgorithmH {.
  cdecl, importc: "GDALAlgorithmGetActualAlgorithm", dynlib: gdalLib, raises: []
.}

proc GDALAlgorithmRun*(
  a0: GDALAlgorithmH, pfnProgress: GDALProgressFunc, pProgressData: pointer
): bool {.cdecl, importc: "GDALAlgorithmRun", dynlib: gdalLib, raises: [].}

proc GDALAlgorithmFinalize*(
  a0: GDALAlgorithmH
): bool {.cdecl, importc: "GDALAlgorithmFinalize", dynlib: gdalLib, raises: [].}

proc GDALAlgorithmGetUsageAsJSON*(
  a0: GDALAlgorithmH
): cstring {.
  cdecl, importc: "GDALAlgorithmGetUsageAsJSON", dynlib: gdalLib, raises: []
.}

proc GDALAlgorithmGetArgNames*(
  a0: GDALAlgorithmH
): cstringArray {.
  cdecl, importc: "GDALAlgorithmGetArgNames", dynlib: gdalLib, raises: []
.}

proc GDALAlgorithmGetArg*(
  a0: GDALAlgorithmH, pszArgName: cstring
): GDALAlgorithmArgH {.
  cdecl, importc: "GDALAlgorithmGetArg", dynlib: gdalLib, raises: []
.}

proc GDALAlgorithmGetArgNonConst*(
  a0: GDALAlgorithmH, pszArgName: cstring
): GDALAlgorithmArgH {.
  cdecl, importc: "GDALAlgorithmGetArgNonConst", dynlib: gdalLib, raises: []
.}

proc GDALAlgorithmArgRelease*(
  a0: GDALAlgorithmArgH
) {.cdecl, importc: "GDALAlgorithmArgRelease", dynlib: gdalLib, raises: [].}

proc GDALAlgorithmArgGetName*(
  a0: GDALAlgorithmArgH
): cstring {.cdecl, importc: "GDALAlgorithmArgGetName", dynlib: gdalLib, raises: [].}

proc GDALAlgorithmArgGetType*(
  a0: GDALAlgorithmArgH
): GDALAlgorithmArgType {.
  cdecl, importc: "GDALAlgorithmArgGetType", dynlib: gdalLib, raises: []
.}

proc GDALAlgorithmArgGetDescription*(
  a0: GDALAlgorithmArgH
): cstring {.
  cdecl, importc: "GDALAlgorithmArgGetDescription", dynlib: gdalLib, raises: []
.}

proc GDALAlgorithmArgGetShortName*(
  a0: GDALAlgorithmArgH
): cstring {.
  cdecl, importc: "GDALAlgorithmArgGetShortName", dynlib: gdalLib, raises: []
.}

proc GDALAlgorithmArgGetAliases*(
  a0: GDALAlgorithmArgH
): cstringArray {.
  cdecl, importc: "GDALAlgorithmArgGetAliases", dynlib: gdalLib, raises: []
.}

proc GDALAlgorithmArgGetMetaVar*(
  a0: GDALAlgorithmArgH
): cstring {.cdecl, importc: "GDALAlgorithmArgGetMetaVar", dynlib: gdalLib, raises: [].}

proc GDALAlgorithmArgGetCategory*(
  a0: GDALAlgorithmArgH
): cstring {.
  cdecl, importc: "GDALAlgorithmArgGetCategory", dynlib: gdalLib, raises: []
.}

proc GDALAlgorithmArgIsPositional*(
  a0: GDALAlgorithmArgH
): bool {.cdecl, importc: "GDALAlgorithmArgIsPositional", dynlib: gdalLib, raises: [].}

proc GDALAlgorithmArgIsRequired*(
  a0: GDALAlgorithmArgH
): bool {.cdecl, importc: "GDALAlgorithmArgIsRequired", dynlib: gdalLib, raises: [].}

proc GDALAlgorithmArgGetMinCount*(
  a0: GDALAlgorithmArgH
): cint {.cdecl, importc: "GDALAlgorithmArgGetMinCount", dynlib: gdalLib, raises: [].}

proc GDALAlgorithmArgGetMaxCount*(
  a0: GDALAlgorithmArgH
): cint {.cdecl, importc: "GDALAlgorithmArgGetMaxCount", dynlib: gdalLib, raises: [].}

proc GDALAlgorithmArgGetPackedValuesAllowed*(
  a0: GDALAlgorithmArgH
): bool {.
  cdecl, importc: "GDALAlgorithmArgGetPackedValuesAllowed", dynlib: gdalLib, raises: []
.}

proc GDALAlgorithmArgGetRepeatedArgAllowed*(
  a0: GDALAlgorithmArgH
): bool {.
  cdecl, importc: "GDALAlgorithmArgGetRepeatedArgAllowed", dynlib: gdalLib, raises: []
.}

proc GDALAlgorithmArgGetChoices*(
  a0: GDALAlgorithmArgH
): cstringArray {.
  cdecl, importc: "GDALAlgorithmArgGetChoices", dynlib: gdalLib, raises: []
.}

proc GDALAlgorithmArgGetMetadataItem*(
  a0: GDALAlgorithmArgH, a1: cstring
): cstringArray {.
  cdecl, importc: "GDALAlgorithmArgGetMetadataItem", dynlib: gdalLib, raises: []
.}

proc GDALAlgorithmArgIsExplicitlySet*(
  a0: GDALAlgorithmArgH
): bool {.
  cdecl, importc: "GDALAlgorithmArgIsExplicitlySet", dynlib: gdalLib, raises: []
.}

proc GDALAlgorithmArgHasDefaultValue*(
  a0: GDALAlgorithmArgH
): bool {.
  cdecl, importc: "GDALAlgorithmArgHasDefaultValue", dynlib: gdalLib, raises: []
.}

proc GDALAlgorithmArgGetDefaultAsBoolean*(
  a0: GDALAlgorithmArgH
): bool {.
  cdecl, importc: "GDALAlgorithmArgGetDefaultAsBoolean", dynlib: gdalLib, raises: []
.}

proc GDALAlgorithmArgGetDefaultAsString*(
  a0: GDALAlgorithmArgH
): cstring {.
  cdecl, importc: "GDALAlgorithmArgGetDefaultAsString", dynlib: gdalLib, raises: []
.}

proc GDALAlgorithmArgGetDefaultAsInteger*(
  a0: GDALAlgorithmArgH
): cint {.
  cdecl, importc: "GDALAlgorithmArgGetDefaultAsInteger", dynlib: gdalLib, raises: []
.}

proc GDALAlgorithmArgGetDefaultAsDouble*(
  a0: GDALAlgorithmArgH
): cdouble {.
  cdecl, importc: "GDALAlgorithmArgGetDefaultAsDouble", dynlib: gdalLib, raises: []
.}

proc GDALAlgorithmArgGetDefaultAsStringList*(
  a0: GDALAlgorithmArgH
): cstringArray {.
  cdecl, importc: "GDALAlgorithmArgGetDefaultAsStringList", dynlib: gdalLib, raises: []
.}

proc GDALAlgorithmArgGetDefaultAsIntegerList*(
  a0: GDALAlgorithmArgH, pnCount: ptr csize_t
): ptr cint {.
  cdecl, importc: "GDALAlgorithmArgGetDefaultAsIntegerList", dynlib: gdalLib, raises: []
.}

proc GDALAlgorithmArgGetDefaultAsDoubleList*(
  a0: GDALAlgorithmArgH, pnCount: ptr csize_t
): ptr cdouble {.
  cdecl, importc: "GDALAlgorithmArgGetDefaultAsDoubleList", dynlib: gdalLib, raises: []
.}

proc GDALAlgorithmArgIsHidden*(
  a0: GDALAlgorithmArgH
): bool {.cdecl, importc: "GDALAlgorithmArgIsHidden", dynlib: gdalLib, raises: [].}

proc GDALAlgorithmArgIsHiddenForCLI*(
  a0: GDALAlgorithmArgH
): bool {.
  cdecl, importc: "GDALAlgorithmArgIsHiddenForCLI", dynlib: gdalLib, raises: []
.}

proc GDALAlgorithmArgIsHiddenForAPI*(
  a0: GDALAlgorithmArgH
): bool {.
  cdecl, importc: "GDALAlgorithmArgIsHiddenForAPI", dynlib: gdalLib, raises: []
.}

proc GDALAlgorithmArgIsAvailableInPipelineStep*(
  a0: GDALAlgorithmArgH
): bool {.
  cdecl,
  importc: "GDALAlgorithmArgIsAvailableInPipelineStep",
  dynlib: gdalLib,
  raises: []
.}

proc GDALAlgorithmArgIsOnlyForCLI*(
  a0: GDALAlgorithmArgH
): bool {.cdecl, importc: "GDALAlgorithmArgIsOnlyForCLI", dynlib: gdalLib, raises: [].}

proc GDALAlgorithmArgIsInput*(
  a0: GDALAlgorithmArgH
): bool {.cdecl, importc: "GDALAlgorithmArgIsInput", dynlib: gdalLib, raises: [].}

proc GDALAlgorithmArgIsOutput*(
  a0: GDALAlgorithmArgH
): bool {.cdecl, importc: "GDALAlgorithmArgIsOutput", dynlib: gdalLib, raises: [].}

proc GDALAlgorithmArgGetMutualExclusionGroup*(
  a0: GDALAlgorithmArgH
): cstring {.
  cdecl, importc: "GDALAlgorithmArgGetMutualExclusionGroup", dynlib: gdalLib, raises: []
.}

proc GDALAlgorithmArgGetMutualDependencyGroup*(
  a0: GDALAlgorithmArgH
): cstring {.
  cdecl,
  importc: "GDALAlgorithmArgGetMutualDependencyGroup",
  dynlib: gdalLib,
  raises: []
.}

proc GDALAlgorithmArgGetAsBoolean*(
  a0: GDALAlgorithmArgH
): bool {.cdecl, importc: "GDALAlgorithmArgGetAsBoolean", dynlib: gdalLib, raises: [].}

proc GDALAlgorithmArgGetAsString*(
  a0: GDALAlgorithmArgH
): cstring {.
  cdecl, importc: "GDALAlgorithmArgGetAsString", dynlib: gdalLib, raises: []
.}

proc GDALAlgorithmArgGetAsDatasetValue*(
  a0: GDALAlgorithmArgH
): GDALArgDatasetValueH {.
  cdecl, importc: "GDALAlgorithmArgGetAsDatasetValue", dynlib: gdalLib, raises: []
.}

proc GDALAlgorithmArgGetAsInteger*(
  a0: GDALAlgorithmArgH
): cint {.cdecl, importc: "GDALAlgorithmArgGetAsInteger", dynlib: gdalLib, raises: [].}

proc GDALAlgorithmArgGetAsDouble*(
  a0: GDALAlgorithmArgH
): cdouble {.
  cdecl, importc: "GDALAlgorithmArgGetAsDouble", dynlib: gdalLib, raises: []
.}

proc GDALAlgorithmArgGetAsStringList*(
  a0: GDALAlgorithmArgH
): cstringArray {.
  cdecl, importc: "GDALAlgorithmArgGetAsStringList", dynlib: gdalLib, raises: []
.}

proc GDALAlgorithmArgGetDirectDependencies*(
  a0: GDALAlgorithmArgH
): cstringArray {.
  cdecl, importc: "GDALAlgorithmArgGetDirectDependencies", dynlib: gdalLib, raises: []
.}

proc GDALAlgorithmArgGetAsIntegerList*(
  a0: GDALAlgorithmArgH, pnCount: ptr csize_t
): ptr cint {.
  cdecl, importc: "GDALAlgorithmArgGetAsIntegerList", dynlib: gdalLib, raises: []
.}

proc GDALAlgorithmArgGetAsDoubleList*(
  a0: GDALAlgorithmArgH, pnCount: ptr csize_t
): ptr cdouble {.
  cdecl, importc: "GDALAlgorithmArgGetAsDoubleList", dynlib: gdalLib, raises: []
.}

proc GDALAlgorithmArgSetAsBoolean*(
  a0: GDALAlgorithmArgH, a1: bool
): bool {.cdecl, importc: "GDALAlgorithmArgSetAsBoolean", dynlib: gdalLib, raises: [].}

proc GDALAlgorithmArgSetAsString*(
  a0: GDALAlgorithmArgH, a1: cstring
): bool {.cdecl, importc: "GDALAlgorithmArgSetAsString", dynlib: gdalLib, raises: [].}

proc GDALAlgorithmArgSetAsDatasetValue*(
  hArg: GDALAlgorithmArgH, value: GDALArgDatasetValueH
): bool {.
  cdecl, importc: "GDALAlgorithmArgSetAsDatasetValue", dynlib: gdalLib, raises: []
.}

proc GDALAlgorithmArgSetDataset*(
  hArg: GDALAlgorithmArgH, a1: GDALDatasetH
): bool {.cdecl, importc: "GDALAlgorithmArgSetDataset", dynlib: gdalLib, raises: [].}

proc GDALAlgorithmArgSetDatasets*(
  hArg: GDALAlgorithmArgH, nCount: csize_t, a2: ptr GDALDatasetH
): bool {.cdecl, importc: "GDALAlgorithmArgSetDatasets", dynlib: gdalLib, raises: [].}

proc GDALAlgorithmArgSetDatasetNames*(
  hArg: GDALAlgorithmArgH, a1: CSLConstList
): bool {.
  cdecl, importc: "GDALAlgorithmArgSetDatasetNames", dynlib: gdalLib, raises: []
.}

proc GDALAlgorithmArgSetAsInteger*(
  a0: GDALAlgorithmArgH, a1: cint
): bool {.cdecl, importc: "GDALAlgorithmArgSetAsInteger", dynlib: gdalLib, raises: [].}

proc GDALAlgorithmArgSetAsDouble*(
  a0: GDALAlgorithmArgH, a1: cdouble
): bool {.cdecl, importc: "GDALAlgorithmArgSetAsDouble", dynlib: gdalLib, raises: [].}

proc GDALAlgorithmArgSetAsStringList*(
  a0: GDALAlgorithmArgH, a1: CSLConstList
): bool {.
  cdecl, importc: "GDALAlgorithmArgSetAsStringList", dynlib: gdalLib, raises: []
.}

proc GDALAlgorithmArgSetAsIntegerList*(
  a0: GDALAlgorithmArgH, nCount: csize_t, pnValues: ptr cint
): bool {.
  cdecl, importc: "GDALAlgorithmArgSetAsIntegerList", dynlib: gdalLib, raises: []
.}

proc GDALAlgorithmArgSetAsDoubleList*(
  a0: GDALAlgorithmArgH, nCount: csize_t, pnValues: ptr cdouble
): bool {.
  cdecl, importc: "GDALAlgorithmArgSetAsDoubleList", dynlib: gdalLib, raises: []
.}

proc GDALAlgorithmArgGetDatasetType*(
  a0: GDALAlgorithmArgH
): GDALArgDatasetType {.
  cdecl, importc: "GDALAlgorithmArgGetDatasetType", dynlib: gdalLib, raises: []
.}

proc GDALAlgorithmArgGetDatasetInputFlags*(
  a0: GDALAlgorithmArgH
): cint {.
  cdecl, importc: "GDALAlgorithmArgGetDatasetInputFlags", dynlib: gdalLib, raises: []
.}

proc GDALAlgorithmArgGetDatasetOutputFlags*(
  a0: GDALAlgorithmArgH
): cint {.
  cdecl, importc: "GDALAlgorithmArgGetDatasetOutputFlags", dynlib: gdalLib, raises: []
.}

proc GDALArgDatasetValueCreate*(): GDALArgDatasetValueH {.
  cdecl, importc: "GDALArgDatasetValueCreate", dynlib: gdalLib, raises: []
.}

proc GDALArgDatasetValueRelease*(
  a0: GDALArgDatasetValueH
) {.cdecl, importc: "GDALArgDatasetValueRelease", dynlib: gdalLib, raises: [].}

proc GDALArgDatasetValueGetName*(
  a0: GDALArgDatasetValueH
): cstring {.cdecl, importc: "GDALArgDatasetValueGetName", dynlib: gdalLib, raises: [].}

proc GDALArgDatasetValueGetDatasetRef*(
  a0: GDALArgDatasetValueH
): GDALDatasetH {.
  cdecl, importc: "GDALArgDatasetValueGetDatasetRef", dynlib: gdalLib, raises: []
.}

proc GDALArgDatasetValueGetDatasetIncreaseRefCount*(
  a0: GDALArgDatasetValueH
): GDALDatasetH {.
  cdecl,
  importc: "GDALArgDatasetValueGetDatasetIncreaseRefCount",
  dynlib: gdalLib,
  raises: []
.}

proc GDALArgDatasetValueSetName*(
  a0: GDALArgDatasetValueH, a1: cstring
) {.cdecl, importc: "GDALArgDatasetValueSetName", dynlib: gdalLib, raises: [].}

proc GDALArgDatasetValueSetDataset*(
  a0: GDALArgDatasetValueH, a1: GDALDatasetH
) {.cdecl, importc: "GDALArgDatasetValueSetDataset", dynlib: gdalLib, raises: [].}

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
): CPLErr {.
  cdecl, importc: "GDALGridInverseDistanceToAPower", dynlib: gdalLib, raises: []
.}

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
  cdecl,
  importc: "GDALGridInverseDistanceToAPowerNearestNeighbor",
  dynlib: gdalLib,
  raises: []
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
): CPLErr {.
  cdecl, importc: "GDALGridInverseDistanceToAPowerNoSearch", dynlib: gdalLib, raises: []
.}

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
): CPLErr {.cdecl, importc: "GDALGridMovingAverage", dynlib: gdalLib, raises: [].}

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
): CPLErr {.cdecl, importc: "GDALGridNearestNeighbor", dynlib: gdalLib, raises: [].}

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
): CPLErr {.cdecl, importc: "GDALGridDataMetricMinimum", dynlib: gdalLib, raises: [].}

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
): CPLErr {.cdecl, importc: "GDALGridDataMetricMaximum", dynlib: gdalLib, raises: [].}

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
): CPLErr {.cdecl, importc: "GDALGridDataMetricRange", dynlib: gdalLib, raises: [].}

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
): CPLErr {.cdecl, importc: "GDALGridDataMetricCount", dynlib: gdalLib, raises: [].}

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
): CPLErr {.
  cdecl, importc: "GDALGridDataMetricAverageDistance", dynlib: gdalLib, raises: []
.}

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
): CPLErr {.
  cdecl, importc: "GDALGridDataMetricAverageDistancePts", dynlib: gdalLib, raises: []
.}

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
): CPLErr {.cdecl, importc: "GDALGridLinear", dynlib: gdalLib, raises: [].}

proc GDALGridParseAlgorithmAndOptions*(
  a0: cstring, a1: ptr GDALGridAlgorithm, a2: ptr pointer
): CPLErr {.
  cdecl, importc: "GDALGridParseAlgorithmAndOptions", dynlib: gdalLib, raises: []
.}

proc GDALCreatePansharpenOptions*(): ptr GDALPansharpenOptions {.
  cdecl, importc: "GDALCreatePansharpenOptions", dynlib: gdalLib, raises: []
.}

proc GDALDestroyPansharpenOptions*(
  a0: ptr GDALPansharpenOptions
) {.cdecl, importc: "GDALDestroyPansharpenOptions", dynlib: gdalLib, raises: [].}

proc GDALClonePansharpenOptions*(
  psOptions: ptr GDALPansharpenOptions
): ptr GDALPansharpenOptions {.
  cdecl, importc: "GDALClonePansharpenOptions", dynlib: gdalLib, raises: []
.}

proc GDALCreatePansharpenOperation*(
  a0: ptr GDALPansharpenOptions
): GDALPansharpenOperationH {.
  cdecl, importc: "GDALCreatePansharpenOperation", dynlib: gdalLib, raises: []
.}

proc GDALDestroyPansharpenOperation*(
  a0: GDALPansharpenOperationH
) {.cdecl, importc: "GDALDestroyPansharpenOperation", dynlib: gdalLib, raises: [].}

proc GDALPansharpenProcessRegion*(
  hOperation: GDALPansharpenOperationH,
  nXOff: cint,
  nYOff: cint,
  nXSize: cint,
  nYSize: cint,
  pDataBuf: pointer,
  eBufDataType: GDALDataType,
): CPLErr {.cdecl, importc: "GDALPansharpenProcessRegion", dynlib: gdalLib, raises: [].}

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
): CPLErr {.cdecl, importc: "GDALWarpNoDataMasker", dynlib: gdalLib, raises: [].}

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
): CPLErr {.cdecl, importc: "GDALWarpDstAlphaMasker", dynlib: gdalLib, raises: [].}

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
): CPLErr {.cdecl, importc: "GDALWarpSrcAlphaMasker", dynlib: gdalLib, raises: [].}

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
): CPLErr {.cdecl, importc: "GDALWarpSrcMaskMasker", dynlib: gdalLib, raises: [].}

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
): CPLErr {.cdecl, importc: "GDALWarpCutlineMasker", dynlib: gdalLib, raises: [].}

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
): CPLErr {.cdecl, importc: "GDALWarpCutlineMaskerEx", dynlib: gdalLib, raises: [].}

proc GDALWarpGetOptionList*(): cstring {.
  cdecl, importc: "GDALWarpGetOptionList", dynlib: gdalLib, raises: []
.}

proc GDALCreateWarpOptions*(): ptr GDALWarpOptions {.
  gdalCall, importc: "GDALCreateWarpOptions", dynlib: gdalLib, raises: []
.}

proc GDALDestroyWarpOptions*(
  a0: ptr GDALWarpOptions
) {.gdalCall, importc: "GDALDestroyWarpOptions", dynlib: gdalLib, raises: [].}

proc GDALCloneWarpOptions*(
  a0: ptr GDALWarpOptions
): ptr GDALWarpOptions {.
  gdalCall, importc: "GDALCloneWarpOptions", dynlib: gdalLib, raises: []
.}

proc GDALWarpInitDstNoDataReal*(
  a0: ptr GDALWarpOptions, dNoDataReal: cdouble
) {.gdalCall, importc: "GDALWarpInitDstNoDataReal", dynlib: gdalLib, raises: [].}

proc GDALWarpInitSrcNoDataReal*(
  a0: ptr GDALWarpOptions, dNoDataReal: cdouble
) {.gdalCall, importc: "GDALWarpInitSrcNoDataReal", dynlib: gdalLib, raises: [].}

proc GDALWarpInitNoDataReal*(
  a0: ptr GDALWarpOptions, dNoDataReal: cdouble
) {.gdalCall, importc: "GDALWarpInitNoDataReal", dynlib: gdalLib, raises: [].}

proc GDALWarpInitDstNoDataImag*(
  a0: ptr GDALWarpOptions, dNoDataImag: cdouble
) {.gdalCall, importc: "GDALWarpInitDstNoDataImag", dynlib: gdalLib, raises: [].}

proc GDALWarpInitSrcNoDataImag*(
  a0: ptr GDALWarpOptions, dNoDataImag: cdouble
) {.gdalCall, importc: "GDALWarpInitSrcNoDataImag", dynlib: gdalLib, raises: [].}

proc GDALWarpResolveWorkingDataType*(
  a0: ptr GDALWarpOptions
) {.gdalCall, importc: "GDALWarpResolveWorkingDataType", dynlib: gdalLib, raises: [].}

proc GDALWarpInitDefaultBandMapping*(
  a0: ptr GDALWarpOptions, nBandCount: cint
) {.gdalCall, importc: "GDALWarpInitDefaultBandMapping", dynlib: gdalLib, raises: [].}

proc GDALSerializeWarpOptions*(
  a0: ptr GDALWarpOptions
): ptr CPLXMLNode {.
  gdalCall, importc: "GDALSerializeWarpOptions", dynlib: gdalLib, raises: []
.}

proc GDALDeserializeWarpOptions*(
  a0: ptr CPLXMLNode
): ptr GDALWarpOptions {.
  gdalCall, importc: "GDALDeserializeWarpOptions", dynlib: gdalLib, raises: []
.}

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
): CPLErr {.gdalCall, importc: "GDALReprojectImage", dynlib: gdalLib, raises: [].}

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
): CPLErr {.
  gdalCall, importc: "GDALCreateAndReprojectImage", dynlib: gdalLib, raises: []
.}

proc GDALAutoCreateWarpedVRT*(
  hSrcDS: GDALDatasetH,
  pszSrcWKT: cstring,
  pszDstWKT: cstring,
  eResampleAlg: GDALResampleAlg,
  dfMaxError: cdouble,
  psOptions: ptr GDALWarpOptions,
): GDALDatasetH {.
  gdalCall, importc: "GDALAutoCreateWarpedVRT", dynlib: gdalLib, raises: []
.}

proc GDALAutoCreateWarpedVRTEx*(
  hSrcDS: GDALDatasetH,
  pszSrcWKT: cstring,
  pszDstWKT: cstring,
  eResampleAlg: GDALResampleAlg,
  dfMaxError: cdouble,
  psOptions: ptr GDALWarpOptions,
  papszTransformerOptions: CSLConstList,
): GDALDatasetH {.
  gdalCall, importc: "GDALAutoCreateWarpedVRTEx", dynlib: gdalLib, raises: []
.}

proc GDALCreateWarpedVRT*(
  hSrcDS: GDALDatasetH,
  nPixels: cint,
  nLines: cint,
  padfGeoTransform: ptr cdouble,
  psOptions: ptr GDALWarpOptions,
): GDALDatasetH {.
  gdalCall, importc: "GDALCreateWarpedVRT", dynlib: gdalLib, raises: []
.}

proc GDALInitializeWarpedVRT*(
  hDS: GDALDatasetH, psWO: ptr GDALWarpOptions
): CPLErr {.gdalCall, importc: "GDALInitializeWarpedVRT", dynlib: gdalLib, raises: [].}

proc GDALCreateWarpOperation*(
  a0: ptr GDALWarpOptions
): GDALWarpOperationH {.
  cdecl, importc: "GDALCreateWarpOperation", dynlib: gdalLib, raises: []
.}

proc GDALDestroyWarpOperation*(
  a0: GDALWarpOperationH
) {.cdecl, importc: "GDALDestroyWarpOperation", dynlib: gdalLib, raises: [].}

proc GDALChunkAndWarpImage*(
  a0: GDALWarpOperationH, a1: cint, a2: cint, a3: cint, a4: cint
): CPLErr {.cdecl, importc: "GDALChunkAndWarpImage", dynlib: gdalLib, raises: [].}

proc GDALChunkAndWarpMulti*(
  a0: GDALWarpOperationH, a1: cint, a2: cint, a3: cint, a4: cint
): CPLErr {.cdecl, importc: "GDALChunkAndWarpMulti", dynlib: gdalLib, raises: [].}

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
): CPLErr {.cdecl, importc: "GDALWarpRegion", dynlib: gdalLib, raises: [].}

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
): CPLErr {.cdecl, importc: "GDALWarpRegionToBuffer", dynlib: gdalLib, raises: [].}

proc GWKGetFilterRadius*(
  eResampleAlg: GDALResampleAlg
): cint {.cdecl, importc: "GWKGetFilterRadius", dynlib: gdalLib, raises: [].}

proc GWKGetFilterFunc*(
  eResampleAlg: GDALResampleAlg
): FilterFuncType {.cdecl, importc: "GWKGetFilterFunc", dynlib: gdalLib, raises: [].}

proc GWKGetFilterFunc4Values*(
  eResampleAlg: GDALResampleAlg
): FilterFunc4ValuesType {.
  cdecl, importc: "GWKGetFilterFunc4Values", dynlib: gdalLib, raises: []
.}

proc GNMGetName*(
  hNet: GNMNetworkH
): cstring {.gdalCall, importc: "GNMGetName", dynlib: gdalLib, raises: [].}

proc GNMGetVersion*(
  hNet: GNMNetworkH
): cint {.gdalCall, importc: "GNMGetVersion", dynlib: gdalLib, raises: [].}

proc GNMDisconnectAll*(
  hNet: GNMNetworkH
): CPLErr {.gdalCall, importc: "GNMDisconnectAll", dynlib: gdalLib, raises: [].}

proc GNMGetFeatureByGlobalFID*(
  hNet: GNMNetworkH, nGFID: GIntBig
): OGRFeatureH {.
  gdalCall, importc: "GNMGetFeatureByGlobalFID", dynlib: gdalLib, raises: []
.}

proc GNMGetPath*(
  hNet: GNMNetworkH,
  nStartFID: GIntBig,
  nEndFID: GIntBig,
  eAlgorithm: GNMGraphAlgorithmType,
  papszOptions: CSLConstList,
): OGRLayerH {.gdalCall, importc: "GNMGetPath", dynlib: gdalLib, raises: [].}

proc GNMConnectFeatures*(
  hNet: GNMGenericNetworkH,
  nSrcFID: GIntBig,
  nTgtFID: GIntBig,
  nConFID: GIntBig,
  dfCost: cdouble,
  dfInvCost: cdouble,
  eDir: GNMDirection,
): CPLErr {.gdalCall, importc: "GNMConnectFeatures", dynlib: gdalLib, raises: [].}

proc GNMDisconnectFeatures*(
  hNet: GNMGenericNetworkH, nSrcFID: GIntBig, nTgtFID: GIntBig, nConFID: GIntBig
): CPLErr {.gdalCall, importc: "GNMDisconnectFeatures", dynlib: gdalLib, raises: [].}

proc GNMDisconnectFeaturesWithId*(
  hNet: GNMGenericNetworkH, nFID: GIntBig
): CPLErr {.
  gdalCall, importc: "GNMDisconnectFeaturesWithId", dynlib: gdalLib, raises: []
.}

proc GNMReconnectFeatures*(
  hNet: GNMGenericNetworkH,
  nSrcFID: GIntBig,
  nTgtFID: GIntBig,
  nConFID: GIntBig,
  dfCost: cdouble,
  dfInvCost: cdouble,
  eDir: GNMDirection,
): CPLErr {.gdalCall, importc: "GNMReconnectFeatures", dynlib: gdalLib, raises: [].}

proc GNMCreateRule*(
  hNet: GNMGenericNetworkH, pszRuleStr: cstring
): CPLErr {.gdalCall, importc: "GNMCreateRule", dynlib: gdalLib, raises: [].}

proc GNMDeleteAllRules*(
  hNet: GNMGenericNetworkH
): CPLErr {.gdalCall, importc: "GNMDeleteAllRules", dynlib: gdalLib, raises: [].}

proc GNMDeleteRule*(
  hNet: GNMGenericNetworkH, pszRuleStr: cstring
): CPLErr {.gdalCall, importc: "GNMDeleteRule", dynlib: gdalLib, raises: [].}

proc GNMGetRules*(
  hNet: GNMGenericNetworkH
): cstringArray {.gdalCall, importc: "GNMGetRules", dynlib: gdalLib, raises: [].}

proc GNMConnectPointsByLines*(
  hNet: GNMGenericNetworkH,
  papszLayerList: cstringArray,
  dfTolerance: cdouble,
  dfCost: cdouble,
  dfInvCost: cdouble,
  eDir: GNMDirection,
): CPLErr {.gdalCall, importc: "GNMConnectPointsByLines", dynlib: gdalLib, raises: [].}

proc GNMChangeBlockState*(
  hNet: GNMGenericNetworkH, nFID: GIntBig, bIsBlock: bool
): CPLErr {.gdalCall, importc: "GNMChangeBlockState", dynlib: gdalLib, raises: [].}

proc GNMChangeAllBlockState*(
  hNet: GNMGenericNetworkH, bIsBlock: cint
): CPLErr {.gdalCall, importc: "GNMChangeAllBlockState", dynlib: gdalLib, raises: [].}

proc GNMCastToNetwork*(
  hBase: GDALMajorObjectH
): GNMNetworkH {.gdalCall, importc: "GNMCastToNetwork", dynlib: gdalLib, raises: [].}

proc GNMCastToGenericNetwork*(
  hBase: GDALMajorObjectH
): GNMGenericNetworkH {.
  gdalCall, importc: "GNMCastToGenericNetwork", dynlib: gdalLib, raises: []
.}

proc OGRGeocodeCreateSession*(
  papszOptions: CSLConstList
): OGRGeocodingSessionH {.
  cdecl, importc: "OGRGeocodeCreateSession", dynlib: gdalLib, raises: []
.}

proc OGRGeocodeDestroySession*(
  hSession: OGRGeocodingSessionH
) {.cdecl, importc: "OGRGeocodeDestroySession", dynlib: gdalLib, raises: [].}

proc OGRGeocode*(
  hSession: OGRGeocodingSessionH,
  pszQuery: cstring,
  papszStructuredQuery: cstringArray,
  papszOptions: CSLConstList,
): OGRLayerH {.cdecl, importc: "OGRGeocode", dynlib: gdalLib, raises: [].}

proc OGRGeocodeReverse*(
  hSession: OGRGeocodingSessionH,
  dfLon: cdouble,
  dfLat: cdouble,
  papszOptions: CSLConstList,
): OGRLayerH {.cdecl, importc: "OGRGeocodeReverse", dynlib: gdalLib, raises: [].}

proc OGRGeocodeFreeResult*(
  hLayer: OGRLayerH
) {.cdecl, importc: "OGRGeocodeFreeResult", dynlib: gdalLib, raises: [].}

proc OSRAxisEnumToName*(
  eOrientation: OGRAxisOrientation
): cstring {.cdecl, importc: "OSRAxisEnumToName", dynlib: gdalLib, raises: [].}

proc OSRSetPROJSearchPaths*(
  papszPaths: cstringArray
) {.cdecl, importc: "OSRSetPROJSearchPaths", dynlib: gdalLib, raises: [].}

proc OSRGetPROJSearchPaths*(): cstringArray {.
  cdecl, importc: "OSRGetPROJSearchPaths", dynlib: gdalLib, raises: []
.}

proc OSRSetPROJAuxDbPaths*(
  papszPaths: cstringArray
) {.cdecl, importc: "OSRSetPROJAuxDbPaths", dynlib: gdalLib, raises: [].}

proc OSRGetPROJAuxDbPaths*(): cstringArray {.
  cdecl, importc: "OSRGetPROJAuxDbPaths", dynlib: gdalLib, raises: []
.}

proc OSRSetPROJEnableNetwork*(
  enabled: cint
) {.cdecl, importc: "OSRSetPROJEnableNetwork", dynlib: gdalLib, raises: [].}

proc OSRGetPROJEnableNetwork*(): cint {.
  cdecl, importc: "OSRGetPROJEnableNetwork", dynlib: gdalLib, raises: []
.}

proc OSRGetPROJVersion*(
  pnMajor: ptr cint, pnMinor: ptr cint, pnPatch: ptr cint
) {.cdecl, importc: "OSRGetPROJVersion", dynlib: gdalLib, raises: [].}

proc OSRNewSpatialReference*(
  a0: cstring
): OGRSpatialReferenceH {.
  gdalCall, importc: "OSRNewSpatialReference", dynlib: gdalLib, raises: []
.}

proc OSRCloneGeogCS*(
  a0: OGRSpatialReferenceH
): OGRSpatialReferenceH {.
  gdalCall, importc: "OSRCloneGeogCS", dynlib: gdalLib, raises: []
.}

proc OSRClone*(
  a0: OGRSpatialReferenceH
): OGRSpatialReferenceH {.gdalCall, importc: "OSRClone", dynlib: gdalLib, raises: [].}

proc OSRDestroySpatialReference*(
  a0: OGRSpatialReferenceH
) {.gdalCall, importc: "OSRDestroySpatialReference", dynlib: gdalLib, raises: [].}

proc OSRReference*(
  a0: OGRSpatialReferenceH
): cint {.cdecl, importc: "OSRReference", dynlib: gdalLib, raises: [].}

proc OSRDereference*(
  a0: OGRSpatialReferenceH
): cint {.cdecl, importc: "OSRDereference", dynlib: gdalLib, raises: [].}

proc OSRRelease*(
  a0: OGRSpatialReferenceH
) {.cdecl, importc: "OSRRelease", dynlib: gdalLib, raises: [].}

proc OSRValidate*(
  a0: OGRSpatialReferenceH
): OGRErr {.cdecl, importc: "OSRValidate", dynlib: gdalLib, raises: [].}

proc OSRImportFromEPSG*(
  a0: OGRSpatialReferenceH, a1: cint
): OGRErr {.gdalCall, importc: "OSRImportFromEPSG", dynlib: gdalLib, raises: [].}

proc OSRImportFromEPSGA*(
  a0: OGRSpatialReferenceH, a1: cint
): OGRErr {.gdalCall, importc: "OSRImportFromEPSGA", dynlib: gdalLib, raises: [].}

proc OSRImportFromWkt*(
  a0: OGRSpatialReferenceH, a1: cstringArray
): OGRErr {.cdecl, importc: "OSRImportFromWkt", dynlib: gdalLib, raises: [].}

proc OSRImportFromProj4*(
  a0: OGRSpatialReferenceH, a1: cstring
): OGRErr {.cdecl, importc: "OSRImportFromProj4", dynlib: gdalLib, raises: [].}

proc OSRImportFromESRI*(
  a0: OGRSpatialReferenceH, a1: cstringArray
): OGRErr {.cdecl, importc: "OSRImportFromESRI", dynlib: gdalLib, raises: [].}

proc OSRImportFromPCI*(
  hSRS: OGRSpatialReferenceH, a1: cstring, a2: cstring, a3: ptr cdouble
): OGRErr {.cdecl, importc: "OSRImportFromPCI", dynlib: gdalLib, raises: [].}

proc OSRImportFromUSGS*(
  a0: OGRSpatialReferenceH, a1: clong, a2: clong, a3: ptr cdouble, a4: clong
): OGRErr {.cdecl, importc: "OSRImportFromUSGS", dynlib: gdalLib, raises: [].}

proc OSRImportFromXML*(
  a0: OGRSpatialReferenceH, a1: cstring
): OGRErr {.cdecl, importc: "OSRImportFromXML", dynlib: gdalLib, raises: [].}

proc OSRImportFromDict*(
  a0: OGRSpatialReferenceH, a1: cstring, a2: cstring
): OGRErr {.cdecl, importc: "OSRImportFromDict", dynlib: gdalLib, raises: [].}

proc OSRImportFromPanorama*(
  a0: OGRSpatialReferenceH, a1: clong, a2: clong, a3: clong, a4: ptr cdouble
): OGRErr {.cdecl, importc: "OSRImportFromPanorama", dynlib: gdalLib, raises: [].}

proc OSRImportFromOzi*(
  a0: OGRSpatialReferenceH, a1: cstringArray
): OGRErr {.cdecl, importc: "OSRImportFromOzi", dynlib: gdalLib, raises: [].}

proc OSRImportFromMICoordSys*(
  a0: OGRSpatialReferenceH, a1: cstring
): OGRErr {.cdecl, importc: "OSRImportFromMICoordSys", dynlib: gdalLib, raises: [].}

proc OSRImportFromERM*(
  a0: OGRSpatialReferenceH, a1: cstring, a2: cstring, a3: cstring
): OGRErr {.cdecl, importc: "OSRImportFromERM", dynlib: gdalLib, raises: [].}

proc OSRImportFromUrl*(
  a0: OGRSpatialReferenceH, a1: cstring
): OGRErr {.cdecl, importc: "OSRImportFromUrl", dynlib: gdalLib, raises: [].}

proc OSRImportFromCF1*(
  a0: OGRSpatialReferenceH, papszKeyValues: CSLConstList, pszUnits: cstring
): OGRErr {.cdecl, importc: "OSRImportFromCF1", dynlib: gdalLib, raises: [].}

proc OSRExportToWkt*(
  a0: OGRSpatialReferenceH, a1: cstringArray
): OGRErr {.gdalCall, importc: "OSRExportToWkt", dynlib: gdalLib, raises: [].}

proc OSRExportToWktEx*(
  a0: OGRSpatialReferenceH, ppszResult: cstringArray, papszOptions: cstringArray
): OGRErr {.cdecl, importc: "OSRExportToWktEx", dynlib: gdalLib, raises: [].}

proc OSRExportToPrettyWkt*(
  a0: OGRSpatialReferenceH, a1: cstringArray, a2: cint
): OGRErr {.gdalCall, importc: "OSRExportToPrettyWkt", dynlib: gdalLib, raises: [].}

proc OSRExportToPROJJSON*(
  hSRS: OGRSpatialReferenceH, ppszReturn: cstringArray, papszOptions: cstringArray
): OGRErr {.cdecl, importc: "OSRExportToPROJJSON", dynlib: gdalLib, raises: [].}

proc OSRExportToProj4*(
  a0: OGRSpatialReferenceH, a1: cstringArray
): OGRErr {.gdalCall, importc: "OSRExportToProj4", dynlib: gdalLib, raises: [].}

proc OSRExportToPCI*(
  a0: OGRSpatialReferenceH, a1: cstringArray, a2: cstringArray, a3: ptr ptr cdouble
): OGRErr {.cdecl, importc: "OSRExportToPCI", dynlib: gdalLib, raises: [].}

proc OSRExportToUSGS*(
  a0: OGRSpatialReferenceH,
  a1: ptr clong,
  a2: ptr clong,
  a3: ptr ptr cdouble,
  a4: ptr clong,
): OGRErr {.cdecl, importc: "OSRExportToUSGS", dynlib: gdalLib, raises: [].}

proc OSRExportToXML*(
  a0: OGRSpatialReferenceH, a1: cstringArray, a2: cstring
): OGRErr {.cdecl, importc: "OSRExportToXML", dynlib: gdalLib, raises: [].}

proc OSRExportToPanorama*(
  a0: OGRSpatialReferenceH,
  a1: ptr clong,
  a2: ptr clong,
  a3: ptr clong,
  a4: ptr clong,
  a5: ptr cdouble,
): OGRErr {.cdecl, importc: "OSRExportToPanorama", dynlib: gdalLib, raises: [].}

proc OSRExportToMICoordSys*(
  a0: OGRSpatialReferenceH, a1: cstringArray
): OGRErr {.cdecl, importc: "OSRExportToMICoordSys", dynlib: gdalLib, raises: [].}

proc OSRExportToERM*(
  a0: OGRSpatialReferenceH, a1: cstring, a2: cstring, a3: cstring
): OGRErr {.cdecl, importc: "OSRExportToERM", dynlib: gdalLib, raises: [].}

proc OSRExportToCF1*(
  a0: OGRSpatialReferenceH,
  ppszGridMappingName: cstringArray,
  ppapszKeyValues: ptr cstringArray,
  ppszUnits: cstringArray,
  papszOptions: CSLConstList,
): OGRErr {.cdecl, importc: "OSRExportToCF1", dynlib: gdalLib, raises: [].}

proc OSRMorphToESRI*(
  a0: OGRSpatialReferenceH
): OGRErr {.cdecl, importc: "OSRMorphToESRI", dynlib: gdalLib, raises: [].}

proc OSRMorphFromESRI*(
  a0: OGRSpatialReferenceH
): OGRErr {.cdecl, importc: "OSRMorphFromESRI", dynlib: gdalLib, raises: [].}

proc OSRStripVertical*(
  a0: OGRSpatialReferenceH
): OGRErr {.cdecl, importc: "OSRStripVertical", dynlib: gdalLib, raises: [].}

proc OSRConvertToOtherProjection*(
  hSRS: OGRSpatialReferenceH, pszTargetProjection: cstring, papszOptions: cstringArray
): OGRSpatialReferenceH {.
  cdecl, importc: "OSRConvertToOtherProjection", dynlib: gdalLib, raises: []
.}

proc OSRGetName*(
  hSRS: OGRSpatialReferenceH
): cstring {.cdecl, importc: "OSRGetName", dynlib: gdalLib, raises: [].}

proc OSRGetCelestialBodyName*(
  hSRS: OGRSpatialReferenceH
): cstring {.cdecl, importc: "OSRGetCelestialBodyName", dynlib: gdalLib, raises: [].}

proc OSRSetAttrValue*(
  hSRS: OGRSpatialReferenceH, pszNodePath: cstring, pszNewNodeValue: cstring
): OGRErr {.gdalCall, importc: "OSRSetAttrValue", dynlib: gdalLib, raises: [].}

proc OSRGetAttrValue*(
  hSRS: OGRSpatialReferenceH, pszName: cstring, iChild: cint
): cstring {.gdalCall, importc: "OSRGetAttrValue", dynlib: gdalLib, raises: [].}

proc OSRSetAngularUnits*(
  a0: OGRSpatialReferenceH, a1: cstring, a2: cdouble
): OGRErr {.cdecl, importc: "OSRSetAngularUnits", dynlib: gdalLib, raises: [].}

proc OSRGetAngularUnits*(
  a0: OGRSpatialReferenceH, a1: cstringArray
): cdouble {.cdecl, importc: "OSRGetAngularUnits", dynlib: gdalLib, raises: [].}

proc OSRSetLinearUnits*(
  a0: OGRSpatialReferenceH, a1: cstring, a2: cdouble
): OGRErr {.cdecl, importc: "OSRSetLinearUnits", dynlib: gdalLib, raises: [].}

proc OSRSetTargetLinearUnits*(
  a0: OGRSpatialReferenceH, a1: cstring, a2: cstring, a3: cdouble
): OGRErr {.cdecl, importc: "OSRSetTargetLinearUnits", dynlib: gdalLib, raises: [].}

proc OSRSetLinearUnitsAndUpdateParameters*(
  a0: OGRSpatialReferenceH, a1: cstring, a2: cdouble
): OGRErr {.
  cdecl, importc: "OSRSetLinearUnitsAndUpdateParameters", dynlib: gdalLib, raises: []
.}

proc OSRGetLinearUnits*(
  a0: OGRSpatialReferenceH, a1: cstringArray
): cdouble {.cdecl, importc: "OSRGetLinearUnits", dynlib: gdalLib, raises: [].}

proc OSRGetTargetLinearUnits*(
  a0: OGRSpatialReferenceH, a1: cstring, a2: cstringArray
): cdouble {.cdecl, importc: "OSRGetTargetLinearUnits", dynlib: gdalLib, raises: [].}

proc OSRGetPrimeMeridian*(
  a0: OGRSpatialReferenceH, a1: cstringArray
): cdouble {.cdecl, importc: "OSRGetPrimeMeridian", dynlib: gdalLib, raises: [].}

proc OSRIsGeographic*(
  a0: OGRSpatialReferenceH
): cint {.cdecl, importc: "OSRIsGeographic", dynlib: gdalLib, raises: [].}

proc OSRIsDerivedGeographic*(
  a0: OGRSpatialReferenceH
): cint {.cdecl, importc: "OSRIsDerivedGeographic", dynlib: gdalLib, raises: [].}

proc OSRIsLocal*(
  a0: OGRSpatialReferenceH
): cint {.cdecl, importc: "OSRIsLocal", dynlib: gdalLib, raises: [].}

proc OSRIsProjected*(
  a0: OGRSpatialReferenceH
): cint {.cdecl, importc: "OSRIsProjected", dynlib: gdalLib, raises: [].}

proc OSRIsDerivedProjected*(
  a0: OGRSpatialReferenceH
): cint {.cdecl, importc: "OSRIsDerivedProjected", dynlib: gdalLib, raises: [].}

proc OSRIsCompound*(
  a0: OGRSpatialReferenceH
): cint {.cdecl, importc: "OSRIsCompound", dynlib: gdalLib, raises: [].}

proc OSRIsGeocentric*(
  a0: OGRSpatialReferenceH
): cint {.cdecl, importc: "OSRIsGeocentric", dynlib: gdalLib, raises: [].}

proc OSRIsVertical*(
  a0: OGRSpatialReferenceH
): cint {.cdecl, importc: "OSRIsVertical", dynlib: gdalLib, raises: [].}

proc OSRIsDynamic*(
  a0: OGRSpatialReferenceH
): cint {.cdecl, importc: "OSRIsDynamic", dynlib: gdalLib, raises: [].}

proc OSRHasPointMotionOperation*(
  a0: OGRSpatialReferenceH
): cint {.cdecl, importc: "OSRHasPointMotionOperation", dynlib: gdalLib, raises: [].}

proc OSRIsSameGeogCS*(
  a0: OGRSpatialReferenceH, a1: OGRSpatialReferenceH
): cint {.cdecl, importc: "OSRIsSameGeogCS", dynlib: gdalLib, raises: [].}

proc OSRIsSameVertCS*(
  a0: OGRSpatialReferenceH, a1: OGRSpatialReferenceH
): cint {.cdecl, importc: "OSRIsSameVertCS", dynlib: gdalLib, raises: [].}

proc OSRIsSame*(
  a0: OGRSpatialReferenceH, a1: OGRSpatialReferenceH
): cint {.cdecl, importc: "OSRIsSame", dynlib: gdalLib, raises: [].}

proc OSRIsSameEx*(
  a0: OGRSpatialReferenceH, a1: OGRSpatialReferenceH, papszOptions: cstringArray
): cint {.cdecl, importc: "OSRIsSameEx", dynlib: gdalLib, raises: [].}

proc OSRSetCoordinateEpoch*(
  hSRS: OGRSpatialReferenceH, dfCoordinateEpoch: cdouble
) {.cdecl, importc: "OSRSetCoordinateEpoch", dynlib: gdalLib, raises: [].}

proc OSRGetCoordinateEpoch*(
  hSRS: OGRSpatialReferenceH
): cdouble {.cdecl, importc: "OSRGetCoordinateEpoch", dynlib: gdalLib, raises: [].}

proc OSRSetLocalCS*(
  hSRS: OGRSpatialReferenceH, pszName: cstring
): OGRErr {.cdecl, importc: "OSRSetLocalCS", dynlib: gdalLib, raises: [].}

proc OSRSetProjCS*(
  hSRS: OGRSpatialReferenceH, pszName: cstring
): OGRErr {.cdecl, importc: "OSRSetProjCS", dynlib: gdalLib, raises: [].}

proc OSRSetGeocCS*(
  hSRS: OGRSpatialReferenceH, pszName: cstring
): OGRErr {.cdecl, importc: "OSRSetGeocCS", dynlib: gdalLib, raises: [].}

proc OSRSetWellKnownGeogCS*(
  hSRS: OGRSpatialReferenceH, pszName: cstring
): OGRErr {.cdecl, importc: "OSRSetWellKnownGeogCS", dynlib: gdalLib, raises: [].}

proc OSRSetFromUserInput*(
  hSRS: OGRSpatialReferenceH, a1: cstring
): OGRErr {.gdalCall, importc: "OSRSetFromUserInput", dynlib: gdalLib, raises: [].}

proc OSRSetFromUserInputEx*(
  hSRS: OGRSpatialReferenceH, a1: cstring, papszOptions: CSLConstList
): OGRErr {.cdecl, importc: "OSRSetFromUserInputEx", dynlib: gdalLib, raises: [].}

proc OSRCopyGeogCSFrom*(
  hSRS: OGRSpatialReferenceH, hSrcSRS: OGRSpatialReferenceH
): OGRErr {.cdecl, importc: "OSRCopyGeogCSFrom", dynlib: gdalLib, raises: [].}

proc OSRSetTOWGS84*(
  hSRS: OGRSpatialReferenceH,
  a1: cdouble,
  a2: cdouble,
  a3: cdouble,
  a4: cdouble,
  a5: cdouble,
  a6: cdouble,
  a7: cdouble,
): OGRErr {.cdecl, importc: "OSRSetTOWGS84", dynlib: gdalLib, raises: [].}

proc OSRGetTOWGS84*(
  hSRS: OGRSpatialReferenceH, a1: ptr cdouble, a2: cint
): OGRErr {.cdecl, importc: "OSRGetTOWGS84", dynlib: gdalLib, raises: [].}

proc OSRAddGuessedTOWGS84*(
  hSRS: OGRSpatialReferenceH
): OGRErr {.cdecl, importc: "OSRAddGuessedTOWGS84", dynlib: gdalLib, raises: [].}

proc OSRSetCompoundCS*(
  hSRS: OGRSpatialReferenceH,
  pszName: cstring,
  hHorizSRS: OGRSpatialReferenceH,
  hVertSRS: OGRSpatialReferenceH,
): OGRErr {.cdecl, importc: "OSRSetCompoundCS", dynlib: gdalLib, raises: [].}

proc OSRPromoteTo3D*(
  hSRS: OGRSpatialReferenceH, pszName: cstring
): OGRErr {.cdecl, importc: "OSRPromoteTo3D", dynlib: gdalLib, raises: [].}

proc OSRDemoteTo2D*(
  hSRS: OGRSpatialReferenceH, pszName: cstring
): OGRErr {.cdecl, importc: "OSRDemoteTo2D", dynlib: gdalLib, raises: [].}

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
): OGRErr {.cdecl, importc: "OSRSetGeogCS", dynlib: gdalLib, raises: [].}

proc OSRSetVertCS*(
  hSRS: OGRSpatialReferenceH,
  pszVertCSName: cstring,
  pszVertDatumName: cstring,
  nVertDatumType: cint,
): OGRErr {.cdecl, importc: "OSRSetVertCS", dynlib: gdalLib, raises: [].}

proc OSRGetSemiMajor*(
  a0: OGRSpatialReferenceH, a1: ptr OGRErr
): cdouble {.cdecl, importc: "OSRGetSemiMajor", dynlib: gdalLib, raises: [].}

proc OSRGetSemiMinor*(
  a0: OGRSpatialReferenceH, a1: ptr OGRErr
): cdouble {.cdecl, importc: "OSRGetSemiMinor", dynlib: gdalLib, raises: [].}

proc OSRGetInvFlattening*(
  a0: OGRSpatialReferenceH, a1: ptr OGRErr
): cdouble {.cdecl, importc: "OSRGetInvFlattening", dynlib: gdalLib, raises: [].}

proc OSRSetAuthority*(
  hSRS: OGRSpatialReferenceH, pszTargetKey: cstring, pszAuthority: cstring, nCode: cint
): OGRErr {.cdecl, importc: "OSRSetAuthority", dynlib: gdalLib, raises: [].}

proc OSRGetAuthorityCode*(
  hSRS: OGRSpatialReferenceH, pszTargetKey: cstring
): cstring {.cdecl, importc: "OSRGetAuthorityCode", dynlib: gdalLib, raises: [].}

proc OSRGetAuthorityName*(
  hSRS: OGRSpatialReferenceH, pszTargetKey: cstring
): cstring {.cdecl, importc: "OSRGetAuthorityName", dynlib: gdalLib, raises: [].}

proc OSRGetAreaOfUse*(
  hSRS: OGRSpatialReferenceH,
  pdfWestLongitudeDeg: ptr cdouble,
  pdfSouthLatitudeDeg: ptr cdouble,
  pdfEastLongitudeDeg: ptr cdouble,
  pdfNorthLatitudeDeg: ptr cdouble,
  ppszAreaName: cstringArray,
): cint {.cdecl, importc: "OSRGetAreaOfUse", dynlib: gdalLib, raises: [].}

proc OSRSetProjection*(
  a0: OGRSpatialReferenceH, a1: cstring
): OGRErr {.cdecl, importc: "OSRSetProjection", dynlib: gdalLib, raises: [].}

proc OSRSetProjParm*(
  a0: OGRSpatialReferenceH, a1: cstring, a2: cdouble
): OGRErr {.cdecl, importc: "OSRSetProjParm", dynlib: gdalLib, raises: [].}

proc OSRGetProjParm*(
  hSRS: OGRSpatialReferenceH, pszParamName: cstring, dfDefault: cdouble, a3: ptr OGRErr
): cdouble {.cdecl, importc: "OSRGetProjParm", dynlib: gdalLib, raises: [].}

proc OSRSetNormProjParm*(
  a0: OGRSpatialReferenceH, a1: cstring, a2: cdouble
): OGRErr {.cdecl, importc: "OSRSetNormProjParm", dynlib: gdalLib, raises: [].}

proc OSRGetNormProjParm*(
  hSRS: OGRSpatialReferenceH, pszParamName: cstring, dfDefault: cdouble, a3: ptr OGRErr
): cdouble {.cdecl, importc: "OSRGetNormProjParm", dynlib: gdalLib, raises: [].}

proc OSRSetUTM*(
  hSRS: OGRSpatialReferenceH, nZone: cint, bNorth: cint
): OGRErr {.cdecl, importc: "OSRSetUTM", dynlib: gdalLib, raises: [].}

proc OSRGetUTMZone*(
  hSRS: OGRSpatialReferenceH, pbNorth: ptr cint
): cint {.cdecl, importc: "OSRGetUTMZone", dynlib: gdalLib, raises: [].}

proc OSRSetStatePlane*(
  hSRS: OGRSpatialReferenceH, nZone: cint, bNAD83: cint
): OGRErr {.cdecl, importc: "OSRSetStatePlane", dynlib: gdalLib, raises: [].}

proc OSRSetStatePlaneWithUnits*(
  hSRS: OGRSpatialReferenceH,
  nZone: cint,
  bNAD83: cint,
  pszOverrideUnitName: cstring,
  dfOverrideUnit: cdouble,
): OGRErr {.cdecl, importc: "OSRSetStatePlaneWithUnits", dynlib: gdalLib, raises: [].}

proc OSRAutoIdentifyEPSG*(
  hSRS: OGRSpatialReferenceH
): OGRErr {.cdecl, importc: "OSRAutoIdentifyEPSG", dynlib: gdalLib, raises: [].}

proc OSRFindMatches*(
  hSRS: OGRSpatialReferenceH,
  papszOptions: CSLConstList,
  pnEntries: ptr cint,
  ppanMatchConfidence: ptr ptr cint,
): ptr OGRSpatialReferenceH {.
  cdecl, importc: "OSRFindMatches", dynlib: gdalLib, raises: []
.}

proc OSRFreeSRSArray*(
  pahSRS: ptr OGRSpatialReferenceH
) {.cdecl, importc: "OSRFreeSRSArray", dynlib: gdalLib, raises: [].}

proc OSREPSGTreatsAsLatLong*(
  hSRS: OGRSpatialReferenceH
): cint {.cdecl, importc: "OSREPSGTreatsAsLatLong", dynlib: gdalLib, raises: [].}

proc OSREPSGTreatsAsNorthingEasting*(
  hSRS: OGRSpatialReferenceH
): cint {.
  cdecl, importc: "OSREPSGTreatsAsNorthingEasting", dynlib: gdalLib, raises: []
.}

proc OSRGetAxis*(
  hSRS: OGRSpatialReferenceH,
  pszTargetKey: cstring,
  iAxis: cint,
  peOrientation: ptr OGRAxisOrientation,
): cstring {.cdecl, importc: "OSRGetAxis", dynlib: gdalLib, raises: [].}

proc OSRGetAxesCount*(
  hSRS: OGRSpatialReferenceH
): cint {.cdecl, importc: "OSRGetAxesCount", dynlib: gdalLib, raises: [].}

proc OSRSetAxes*(
  hSRS: OGRSpatialReferenceH,
  pszTargetKey: cstring,
  pszXAxisName: cstring,
  eXAxisOrientation: OGRAxisOrientation,
  pszYAxisName: cstring,
  eYAxisOrientation: OGRAxisOrientation,
): OGRErr {.cdecl, importc: "OSRSetAxes", dynlib: gdalLib, raises: [].}

proc OSRGetAxisMappingStrategy*(
  hSRS: OGRSpatialReferenceH
): OSRAxisMappingStrategy {.
  cdecl, importc: "OSRGetAxisMappingStrategy", dynlib: gdalLib, raises: []
.}

proc OSRSetAxisMappingStrategy*(
  hSRS: OGRSpatialReferenceH, strategy: OSRAxisMappingStrategy
) {.cdecl, importc: "OSRSetAxisMappingStrategy", dynlib: gdalLib, raises: [].}

proc OSRGetDataAxisToSRSAxisMapping*(
  hSRS: OGRSpatialReferenceH, pnCount: ptr cint
): ptr cint {.
  cdecl, importc: "OSRGetDataAxisToSRSAxisMapping", dynlib: gdalLib, raises: []
.}

proc OSRSetDataAxisToSRSAxisMapping*(
  hSRS: OGRSpatialReferenceH, nMappingSize: cint, panMapping: ptr cint
): OGRErr {.
  cdecl, importc: "OSRSetDataAxisToSRSAxisMapping", dynlib: gdalLib, raises: []
.}

proc OSRSetACEA*(
  hSRS: OGRSpatialReferenceH,
  dfStdP1: cdouble,
  dfStdP2: cdouble,
  dfCenterLat: cdouble,
  dfCenterLong: cdouble,
  dfFalseEasting: cdouble,
  dfFalseNorthing: cdouble,
): OGRErr {.cdecl, importc: "OSRSetACEA", dynlib: gdalLib, raises: [].}

proc OSRSetAE*(
  hSRS: OGRSpatialReferenceH,
  dfCenterLat: cdouble,
  dfCenterLong: cdouble,
  dfFalseEasting: cdouble,
  dfFalseNorthing: cdouble,
): OGRErr {.cdecl, importc: "OSRSetAE", dynlib: gdalLib, raises: [].}

proc OSRSetBonne*(
  hSRS: OGRSpatialReferenceH,
  dfStandardParallel: cdouble,
  dfCentralMeridian: cdouble,
  dfFalseEasting: cdouble,
  dfFalseNorthing: cdouble,
): OGRErr {.cdecl, importc: "OSRSetBonne", dynlib: gdalLib, raises: [].}

proc OSRSetCEA*(
  hSRS: OGRSpatialReferenceH,
  dfStdP1: cdouble,
  dfCentralMeridian: cdouble,
  dfFalseEasting: cdouble,
  dfFalseNorthing: cdouble,
): OGRErr {.cdecl, importc: "OSRSetCEA", dynlib: gdalLib, raises: [].}

proc OSRSetCS*(
  hSRS: OGRSpatialReferenceH,
  dfCenterLat: cdouble,
  dfCenterLong: cdouble,
  dfFalseEasting: cdouble,
  dfFalseNorthing: cdouble,
): OGRErr {.cdecl, importc: "OSRSetCS", dynlib: gdalLib, raises: [].}

proc OSRSetEC*(
  hSRS: OGRSpatialReferenceH,
  dfStdP1: cdouble,
  dfStdP2: cdouble,
  dfCenterLat: cdouble,
  dfCenterLong: cdouble,
  dfFalseEasting: cdouble,
  dfFalseNorthing: cdouble,
): OGRErr {.cdecl, importc: "OSRSetEC", dynlib: gdalLib, raises: [].}

proc OSRSetEckert*(
  hSRS: OGRSpatialReferenceH,
  nVariation: cint,
  dfCentralMeridian: cdouble,
  dfFalseEasting: cdouble,
  dfFalseNorthing: cdouble,
): OGRErr {.cdecl, importc: "OSRSetEckert", dynlib: gdalLib, raises: [].}

proc OSRSetEckertIV*(
  hSRS: OGRSpatialReferenceH,
  dfCentralMeridian: cdouble,
  dfFalseEasting: cdouble,
  dfFalseNorthing: cdouble,
): OGRErr {.cdecl, importc: "OSRSetEckertIV", dynlib: gdalLib, raises: [].}

proc OSRSetEckertVI*(
  hSRS: OGRSpatialReferenceH,
  dfCentralMeridian: cdouble,
  dfFalseEasting: cdouble,
  dfFalseNorthing: cdouble,
): OGRErr {.cdecl, importc: "OSRSetEckertVI", dynlib: gdalLib, raises: [].}

proc OSRSetEquirectangular*(
  hSRS: OGRSpatialReferenceH,
  dfCenterLat: cdouble,
  dfCenterLong: cdouble,
  dfFalseEasting: cdouble,
  dfFalseNorthing: cdouble,
): OGRErr {.cdecl, importc: "OSRSetEquirectangular", dynlib: gdalLib, raises: [].}

proc OSRSetEquirectangular2*(
  hSRS: OGRSpatialReferenceH,
  dfCenterLat: cdouble,
  dfCenterLong: cdouble,
  dfPseudoStdParallel1: cdouble,
  dfFalseEasting: cdouble,
  dfFalseNorthing: cdouble,
): OGRErr {.cdecl, importc: "OSRSetEquirectangular2", dynlib: gdalLib, raises: [].}

proc OSRSetGS*(
  hSRS: OGRSpatialReferenceH,
  dfCentralMeridian: cdouble,
  dfFalseEasting: cdouble,
  dfFalseNorthing: cdouble,
): OGRErr {.cdecl, importc: "OSRSetGS", dynlib: gdalLib, raises: [].}

proc OSRSetGH*(
  hSRS: OGRSpatialReferenceH,
  dfCentralMeridian: cdouble,
  dfFalseEasting: cdouble,
  dfFalseNorthing: cdouble,
): OGRErr {.cdecl, importc: "OSRSetGH", dynlib: gdalLib, raises: [].}

proc OSRSetIGH*(
  hSRS: OGRSpatialReferenceH
): OGRErr {.cdecl, importc: "OSRSetIGH", dynlib: gdalLib, raises: [].}

proc OSRSetGEOS*(
  hSRS: OGRSpatialReferenceH,
  dfCentralMeridian: cdouble,
  dfSatelliteHeight: cdouble,
  dfFalseEasting: cdouble,
  dfFalseNorthing: cdouble,
): OGRErr {.cdecl, importc: "OSRSetGEOS", dynlib: gdalLib, raises: [].}

proc OSRSetGaussSchreiberTMercator*(
  hSRS: OGRSpatialReferenceH,
  dfCenterLat: cdouble,
  dfCenterLong: cdouble,
  dfScale: cdouble,
  dfFalseEasting: cdouble,
  dfFalseNorthing: cdouble,
): OGRErr {.
  cdecl, importc: "OSRSetGaussSchreiberTMercator", dynlib: gdalLib, raises: []
.}

proc OSRSetGnomonic*(
  hSRS: OGRSpatialReferenceH,
  dfCenterLat: cdouble,
  dfCenterLong: cdouble,
  dfFalseEasting: cdouble,
  dfFalseNorthing: cdouble,
): OGRErr {.cdecl, importc: "OSRSetGnomonic", dynlib: gdalLib, raises: [].}

proc OSRSetHOM*(
  hSRS: OGRSpatialReferenceH,
  dfCenterLat: cdouble,
  dfCenterLong: cdouble,
  dfAzimuth: cdouble,
  dfRectToSkew: cdouble,
  dfScale: cdouble,
  dfFalseEasting: cdouble,
  dfFalseNorthing: cdouble,
): OGRErr {.cdecl, importc: "OSRSetHOM", dynlib: gdalLib, raises: [].}

proc OSRSetHOMAC*(
  hSRS: OGRSpatialReferenceH,
  dfCenterLat: cdouble,
  dfCenterLong: cdouble,
  dfAzimuth: cdouble,
  dfRectToSkew: cdouble,
  dfScale: cdouble,
  dfFalseEasting: cdouble,
  dfFalseNorthing: cdouble,
): OGRErr {.cdecl, importc: "OSRSetHOMAC", dynlib: gdalLib, raises: [].}

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
): OGRErr {.cdecl, importc: "OSRSetHOM2PNO", dynlib: gdalLib, raises: [].}

proc OSRSetIWMPolyconic*(
  hSRS: OGRSpatialReferenceH,
  dfLat1: cdouble,
  dfLat2: cdouble,
  dfCenterLong: cdouble,
  dfFalseEasting: cdouble,
  dfFalseNorthing: cdouble,
): OGRErr {.cdecl, importc: "OSRSetIWMPolyconic", dynlib: gdalLib, raises: [].}

proc OSRSetKrovak*(
  hSRS: OGRSpatialReferenceH,
  dfCenterLat: cdouble,
  dfCenterLong: cdouble,
  dfAzimuth: cdouble,
  dfPseudoStdParallelLat: cdouble,
  dfScale: cdouble,
  dfFalseEasting: cdouble,
  dfFalseNorthing: cdouble,
): OGRErr {.cdecl, importc: "OSRSetKrovak", dynlib: gdalLib, raises: [].}

proc OSRSetLAEA*(
  hSRS: OGRSpatialReferenceH,
  dfCenterLat: cdouble,
  dfCenterLong: cdouble,
  dfFalseEasting: cdouble,
  dfFalseNorthing: cdouble,
): OGRErr {.cdecl, importc: "OSRSetLAEA", dynlib: gdalLib, raises: [].}

proc OSRSetLCC*(
  hSRS: OGRSpatialReferenceH,
  dfStdP1: cdouble,
  dfStdP2: cdouble,
  dfCenterLat: cdouble,
  dfCenterLong: cdouble,
  dfFalseEasting: cdouble,
  dfFalseNorthing: cdouble,
): OGRErr {.cdecl, importc: "OSRSetLCC", dynlib: gdalLib, raises: [].}

proc OSRSetLCC1SP*(
  hSRS: OGRSpatialReferenceH,
  dfCenterLat: cdouble,
  dfCenterLong: cdouble,
  dfScale: cdouble,
  dfFalseEasting: cdouble,
  dfFalseNorthing: cdouble,
): OGRErr {.cdecl, importc: "OSRSetLCC1SP", dynlib: gdalLib, raises: [].}

proc OSRSetLCCB*(
  hSRS: OGRSpatialReferenceH,
  dfStdP1: cdouble,
  dfStdP2: cdouble,
  dfCenterLat: cdouble,
  dfCenterLong: cdouble,
  dfFalseEasting: cdouble,
  dfFalseNorthing: cdouble,
): OGRErr {.cdecl, importc: "OSRSetLCCB", dynlib: gdalLib, raises: [].}

proc OSRSetMC*(
  hSRS: OGRSpatialReferenceH,
  dfCenterLat: cdouble,
  dfCenterLong: cdouble,
  dfFalseEasting: cdouble,
  dfFalseNorthing: cdouble,
): OGRErr {.cdecl, importc: "OSRSetMC", dynlib: gdalLib, raises: [].}

proc OSRSetMercator*(
  hSRS: OGRSpatialReferenceH,
  dfCenterLat: cdouble,
  dfCenterLong: cdouble,
  dfScale: cdouble,
  dfFalseEasting: cdouble,
  dfFalseNorthing: cdouble,
): OGRErr {.cdecl, importc: "OSRSetMercator", dynlib: gdalLib, raises: [].}

proc OSRSetMercator2SP*(
  hSRS: OGRSpatialReferenceH,
  dfStdP1: cdouble,
  dfCenterLat: cdouble,
  dfCenterLong: cdouble,
  dfFalseEasting: cdouble,
  dfFalseNorthing: cdouble,
): OGRErr {.cdecl, importc: "OSRSetMercator2SP", dynlib: gdalLib, raises: [].}

proc OSRSetMollweide*(
  hSRS: OGRSpatialReferenceH,
  dfCentralMeridian: cdouble,
  dfFalseEasting: cdouble,
  dfFalseNorthing: cdouble,
): OGRErr {.cdecl, importc: "OSRSetMollweide", dynlib: gdalLib, raises: [].}

proc OSRSetNZMG*(
  hSRS: OGRSpatialReferenceH,
  dfCenterLat: cdouble,
  dfCenterLong: cdouble,
  dfFalseEasting: cdouble,
  dfFalseNorthing: cdouble,
): OGRErr {.cdecl, importc: "OSRSetNZMG", dynlib: gdalLib, raises: [].}

proc OSRSetOS*(
  hSRS: OGRSpatialReferenceH,
  dfOriginLat: cdouble,
  dfCMeridian: cdouble,
  dfScale: cdouble,
  dfFalseEasting: cdouble,
  dfFalseNorthing: cdouble,
): OGRErr {.cdecl, importc: "OSRSetOS", dynlib: gdalLib, raises: [].}

proc OSRSetOrthographic*(
  hSRS: OGRSpatialReferenceH,
  dfCenterLat: cdouble,
  dfCenterLong: cdouble,
  dfFalseEasting: cdouble,
  dfFalseNorthing: cdouble,
): OGRErr {.cdecl, importc: "OSRSetOrthographic", dynlib: gdalLib, raises: [].}

proc OSRSetPolyconic*(
  hSRS: OGRSpatialReferenceH,
  dfCenterLat: cdouble,
  dfCenterLong: cdouble,
  dfFalseEasting: cdouble,
  dfFalseNorthing: cdouble,
): OGRErr {.cdecl, importc: "OSRSetPolyconic", dynlib: gdalLib, raises: [].}

proc OSRSetPS*(
  hSRS: OGRSpatialReferenceH,
  dfCenterLat: cdouble,
  dfCenterLong: cdouble,
  dfScale: cdouble,
  dfFalseEasting: cdouble,
  dfFalseNorthing: cdouble,
): OGRErr {.cdecl, importc: "OSRSetPS", dynlib: gdalLib, raises: [].}

proc OSRSetRobinson*(
  hSRS: OGRSpatialReferenceH,
  dfCenterLong: cdouble,
  dfFalseEasting: cdouble,
  dfFalseNorthing: cdouble,
): OGRErr {.cdecl, importc: "OSRSetRobinson", dynlib: gdalLib, raises: [].}

proc OSRSetSinusoidal*(
  hSRS: OGRSpatialReferenceH,
  dfCenterLong: cdouble,
  dfFalseEasting: cdouble,
  dfFalseNorthing: cdouble,
): OGRErr {.cdecl, importc: "OSRSetSinusoidal", dynlib: gdalLib, raises: [].}

proc OSRSetStereographic*(
  hSRS: OGRSpatialReferenceH,
  dfCenterLat: cdouble,
  dfCenterLong: cdouble,
  dfScale: cdouble,
  dfFalseEasting: cdouble,
  dfFalseNorthing: cdouble,
): OGRErr {.cdecl, importc: "OSRSetStereographic", dynlib: gdalLib, raises: [].}

proc OSRSetSOC*(
  hSRS: OGRSpatialReferenceH,
  dfLatitudeOfOrigin: cdouble,
  dfCentralMeridian: cdouble,
  dfFalseEasting: cdouble,
  dfFalseNorthing: cdouble,
): OGRErr {.cdecl, importc: "OSRSetSOC", dynlib: gdalLib, raises: [].}

proc OSRSetTM*(
  hSRS: OGRSpatialReferenceH,
  dfCenterLat: cdouble,
  dfCenterLong: cdouble,
  dfScale: cdouble,
  dfFalseEasting: cdouble,
  dfFalseNorthing: cdouble,
): OGRErr {.cdecl, importc: "OSRSetTM", dynlib: gdalLib, raises: [].}

proc OSRSetTMVariant*(
  hSRS: OGRSpatialReferenceH,
  pszVariantName: cstring,
  dfCenterLat: cdouble,
  dfCenterLong: cdouble,
  dfScale: cdouble,
  dfFalseEasting: cdouble,
  dfFalseNorthing: cdouble,
): OGRErr {.cdecl, importc: "OSRSetTMVariant", dynlib: gdalLib, raises: [].}

proc OSRSetTMG*(
  hSRS: OGRSpatialReferenceH,
  dfCenterLat: cdouble,
  dfCenterLong: cdouble,
  dfFalseEasting: cdouble,
  dfFalseNorthing: cdouble,
): OGRErr {.cdecl, importc: "OSRSetTMG", dynlib: gdalLib, raises: [].}

proc OSRSetTMSO*(
  hSRS: OGRSpatialReferenceH,
  dfCenterLat: cdouble,
  dfCenterLong: cdouble,
  dfScale: cdouble,
  dfFalseEasting: cdouble,
  dfFalseNorthing: cdouble,
): OGRErr {.cdecl, importc: "OSRSetTMSO", dynlib: gdalLib, raises: [].}

proc OSRSetTPED*(
  hSRS: OGRSpatialReferenceH,
  dfLat1: cdouble,
  dfLong1: cdouble,
  dfLat2: cdouble,
  dfLong2: cdouble,
  dfFalseEasting: cdouble,
  dfFalseNorthing: cdouble,
): OGRErr {.cdecl, importc: "OSRSetTPED", dynlib: gdalLib, raises: [].}

proc OSRSetVDG*(
  hSRS: OGRSpatialReferenceH,
  dfCenterLong: cdouble,
  dfFalseEasting: cdouble,
  dfFalseNorthing: cdouble,
): OGRErr {.cdecl, importc: "OSRSetVDG", dynlib: gdalLib, raises: [].}

proc OSRSetWagner*(
  hSRS: OGRSpatialReferenceH,
  nVariation: cint,
  dfCenterLat: cdouble,
  dfFalseEasting: cdouble,
  dfFalseNorthing: cdouble,
): OGRErr {.cdecl, importc: "OSRSetWagner", dynlib: gdalLib, raises: [].}

proc OSRSetQSC*(
  hSRS: OGRSpatialReferenceH, dfCenterLat: cdouble, dfCenterLong: cdouble
): OGRErr {.cdecl, importc: "OSRSetQSC", dynlib: gdalLib, raises: [].}

proc OSRSetSCH*(
  hSRS: OGRSpatialReferenceH,
  dfPegLat: cdouble,
  dfPegLong: cdouble,
  dfPegHeading: cdouble,
  dfPegHgt: cdouble,
): OGRErr {.cdecl, importc: "OSRSetSCH", dynlib: gdalLib, raises: [].}

proc OSRSetVerticalPerspective*(
  hSRS: OGRSpatialReferenceH,
  dfTopoOriginLat: cdouble,
  dfTopoOriginLon: cdouble,
  dfTopoOriginHeight: cdouble,
  dfViewPointHeight: cdouble,
  dfFalseEasting: cdouble,
  dfFalseNorthing: cdouble,
): OGRErr {.cdecl, importc: "OSRSetVerticalPerspective", dynlib: gdalLib, raises: [].}

proc OSRCalcInvFlattening*(
  dfSemiMajor: cdouble, dfSemiMinor: cdouble
): cdouble {.cdecl, importc: "OSRCalcInvFlattening", dynlib: gdalLib, raises: [].}

proc OSRCalcSemiMinorFromInvFlattening*(
  dfSemiMajor: cdouble, dfInvFlattening: cdouble
): cdouble {.
  cdecl, importc: "OSRCalcSemiMinorFromInvFlattening", dynlib: gdalLib, raises: []
.}

proc OSRCleanup*() {.cdecl, importc: "OSRCleanup", dynlib: gdalLib, raises: [].}
proc OSRGetCRSInfoListFromDatabase*(
  pszAuthName: cstring, params: ptr OSRCRSListParameters, pnOutResultCount: ptr cint
): ptr ptr OSRCRSInfo {.
  cdecl, importc: "OSRGetCRSInfoListFromDatabase", dynlib: gdalLib, raises: []
.}

proc OSRDestroyCRSInfoList*(
  list: ptr ptr OSRCRSInfo
) {.cdecl, importc: "OSRDestroyCRSInfoList", dynlib: gdalLib, raises: [].}

proc OSRGetAuthorityListFromDatabase*(): cstringArray {.
  cdecl, importc: "OSRGetAuthorityListFromDatabase", dynlib: gdalLib, raises: []
.}

proc OCTNewCoordinateTransformation*(
  hSourceSRS: OGRSpatialReferenceH, hTargetSRS: OGRSpatialReferenceH
): OGRCoordinateTransformationH {.
  gdalCall, importc: "OCTNewCoordinateTransformation", dynlib: gdalLib, raises: []
.}

proc OCTNewCoordinateTransformationOptions*(): OGRCoordinateTransformationOptionsH {.
  cdecl, importc: "OCTNewCoordinateTransformationOptions", dynlib: gdalLib, raises: []
.}

proc OCTCoordinateTransformationOptionsSetOperation*(
  hOptions: OGRCoordinateTransformationOptionsH, pszCO: cstring, bReverseCO: cint
): cint {.
  cdecl,
  importc: "OCTCoordinateTransformationOptionsSetOperation",
  dynlib: gdalLib,
  raises: []
.}

proc OCTCoordinateTransformationOptionsSetAreaOfInterest*(
  hOptions: OGRCoordinateTransformationOptionsH,
  dfWestLongitudeDeg: cdouble,
  dfSouthLatitudeDeg: cdouble,
  dfEastLongitudeDeg: cdouble,
  dfNorthLatitudeDeg: cdouble,
): cint {.
  cdecl,
  importc: "OCTCoordinateTransformationOptionsSetAreaOfInterest",
  dynlib: gdalLib,
  raises: []
.}

proc OCTCoordinateTransformationOptionsSetDesiredAccuracy*(
  hOptions: OGRCoordinateTransformationOptionsH, dfAccuracy: cdouble
): cint {.
  cdecl,
  importc: "OCTCoordinateTransformationOptionsSetDesiredAccuracy",
  dynlib: gdalLib,
  raises: []
.}

proc OCTCoordinateTransformationOptionsSetBallparkAllowed*(
  hOptions: OGRCoordinateTransformationOptionsH, bAllowBallpark: cint
): cint {.
  cdecl,
  importc: "OCTCoordinateTransformationOptionsSetBallparkAllowed",
  dynlib: gdalLib,
  raises: []
.}

proc OCTCoordinateTransformationOptionsSetOnlyBest*(
  hOptions: OGRCoordinateTransformationOptionsH, bOnlyBest: bool
): cint {.
  cdecl,
  importc: "OCTCoordinateTransformationOptionsSetOnlyBest",
  dynlib: gdalLib,
  raises: []
.}

proc OCTDestroyCoordinateTransformationOptions*(
  a0: OGRCoordinateTransformationOptionsH
) {.
  cdecl,
  importc: "OCTDestroyCoordinateTransformationOptions",
  dynlib: gdalLib,
  raises: []
.}

proc OCTNewCoordinateTransformationEx*(
  hSourceSRS: OGRSpatialReferenceH,
  hTargetSRS: OGRSpatialReferenceH,
  hOptions: OGRCoordinateTransformationOptionsH,
): OGRCoordinateTransformationH {.
  cdecl, importc: "OCTNewCoordinateTransformationEx", dynlib: gdalLib, raises: []
.}

proc OCTClone*(
  hTransform: OGRCoordinateTransformationH
): OGRCoordinateTransformationH {.
  cdecl, importc: "OCTClone", dynlib: gdalLib, raises: []
.}

proc OCTGetSourceCS*(
  hTransform: OGRCoordinateTransformationH
): OGRSpatialReferenceH {.
  cdecl, importc: "OCTGetSourceCS", dynlib: gdalLib, raises: []
.}

proc OCTGetTargetCS*(
  hTransform: OGRCoordinateTransformationH
): OGRSpatialReferenceH {.
  cdecl, importc: "OCTGetTargetCS", dynlib: gdalLib, raises: []
.}

proc OCTGetInverse*(
  hTransform: OGRCoordinateTransformationH
): OGRCoordinateTransformationH {.
  cdecl, importc: "OCTGetInverse", dynlib: gdalLib, raises: []
.}

proc OCTDestroyCoordinateTransformation*(
  a0: OGRCoordinateTransformationH
) {.
  gdalCall, importc: "OCTDestroyCoordinateTransformation", dynlib: gdalLib, raises: []
.}

proc OCTTransform*(
  hCT: OGRCoordinateTransformationH,
  nCount: cint,
  x: ptr cdouble,
  y: ptr cdouble,
  z: ptr cdouble,
): cint {.gdalCall, importc: "OCTTransform", dynlib: gdalLib, raises: [].}

proc OCTTransformEx*(
  hCT: OGRCoordinateTransformationH,
  nCount: cint,
  x: ptr cdouble,
  y: ptr cdouble,
  z: ptr cdouble,
  pabSuccess: ptr cint,
): cint {.gdalCall, importc: "OCTTransformEx", dynlib: gdalLib, raises: [].}

proc OCTTransform4D*(
  hCT: OGRCoordinateTransformationH,
  nCount: cint,
  x: ptr cdouble,
  y: ptr cdouble,
  z: ptr cdouble,
  t: ptr cdouble,
  pabSuccess: ptr cint,
): cint {.cdecl, importc: "OCTTransform4D", dynlib: gdalLib, raises: [].}

proc OCTTransform4DWithErrorCodes*(
  hCT: OGRCoordinateTransformationH,
  nCount: cint,
  x: ptr cdouble,
  y: ptr cdouble,
  z: ptr cdouble,
  t: ptr cdouble,
  panErrorCodes: ptr cint,
): cint {.cdecl, importc: "OCTTransform4DWithErrorCodes", dynlib: gdalLib, raises: [].}

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
): cint {.gdalCall, importc: "OCTTransformBounds", dynlib: gdalLib, raises: [].}
