enum MethodChannelMpgsResultKey { mpgsTokeniseResult, mpgs3dsResult }

extension KeyName on MethodChannelMpgsResultKey {
  String getKeyName() {
    switch (this) {
      case MethodChannelMpgsResultKey.mpgsTokeniseResult:
        return "mpgs_tokenise_result";
      case MethodChannelMpgsResultKey.mpgs3dsResult:
        return "mpgs_3ds_result";
    }
  }
}
