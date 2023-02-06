enum MethodChannelMpgsTokeniseResultKey { sessionId }

extension KeyName on MethodChannelMpgsTokeniseResultKey {
  String getKeyName() {
    switch (this) {
      case MethodChannelMpgsTokeniseResultKey.sessionId:
        return "session_id";
    }
  }
}
