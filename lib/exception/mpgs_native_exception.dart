class MpgsNativeException implements Exception {
  String reason;
  int errorCode;
  MpgsNativeException(this.errorCode, this.reason);
}
