enum MethodChannelRequestKey { data }

extension KeyName on MethodChannelRequestKey {
  String getKeyName() {
    switch (this) {
      case MethodChannelRequestKey.data:
        return "data";
    }
  }
}
