enum MethodChannelMpgs3DSecureInfoKey { htmlContent, title }

extension KeyName on MethodChannelMpgs3DSecureInfoKey {
  String getKeyName() {
    switch (this) {
      case MethodChannelMpgs3DSecureInfoKey.htmlContent:
        return "html_content";
      case MethodChannelMpgs3DSecureInfoKey.title:
        return "title";
    }
  }
}
