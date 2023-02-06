enum MethodChannelMpgsGatewayInfoKey {
  gatewayRegion,
  apiVerions,
  merchantId,
  sessionId,
}

extension KeyName on MethodChannelMpgsGatewayInfoKey {
  String getKeyName() {
    switch (this) {
      case MethodChannelMpgsGatewayInfoKey.gatewayRegion:
        return "mpgs_gateway_region";
      case MethodChannelMpgsGatewayInfoKey.apiVerions:
        return "mpgs_api_version";
      case MethodChannelMpgsGatewayInfoKey.merchantId:
        return "mpgs_merchant_id";
      case MethodChannelMpgsGatewayInfoKey.sessionId:
        return "mpgs_session_id";
    }
  }
}
