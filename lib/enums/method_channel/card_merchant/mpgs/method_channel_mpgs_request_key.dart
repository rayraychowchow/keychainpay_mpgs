enum MethodChannelMpgsRequestKey { cardInfo, mpgsGatewayInfo, mpgs3dsInfo }

extension KeyName on MethodChannelMpgsRequestKey {
  String getKeyName() {
    switch (this) {
      case MethodChannelMpgsRequestKey.cardInfo:
        return "card_info";
      case MethodChannelMpgsRequestKey.mpgsGatewayInfo:
        return "mpgs_gateway_info";
      case MethodChannelMpgsRequestKey.mpgs3dsInfo:
        return "mpgs_3ds_info";
    }
  }
}
