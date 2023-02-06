enum MethodChannelMpgs3DSecureResult { result, isLast3DS }

extension KeyName on MethodChannelMpgs3DSecureResult {
  String getKeyName() {
    switch (this) {
      case MethodChannelMpgs3DSecureResult.result:
        return "result";
      case MethodChannelMpgs3DSecureResult.isLast3DS:
        return "is_last_3ds";
    }
  }
}
