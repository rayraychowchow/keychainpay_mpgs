enum MethodChannelMethodKey {
  tokeniseWithMpgs,
  showMpgs3DSecure,
}

extension KeyName on MethodChannelMethodKey {
  String getKeyName() {
    switch (this) {
      case MethodChannelMethodKey.tokeniseWithMpgs:
        return "tokenise_with_mpgs";
      case MethodChannelMethodKey.showMpgs3DSecure:
        return "show_mpgs_3ds";
    }
  }
}
