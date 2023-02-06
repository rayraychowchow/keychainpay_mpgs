enum MethodChannelResultKey { data, isSuccess, errorMessage, errorCode }

extension KeyName on MethodChannelResultKey {
  String getKeyName() {
    switch (this) {
      case MethodChannelResultKey.data:
        return "data";
      case MethodChannelResultKey.isSuccess:
        return "is_success";
      case MethodChannelResultKey.errorMessage:
        return "error_message";
      case MethodChannelResultKey.errorCode:
        return "error_code";
    }
  }
}
