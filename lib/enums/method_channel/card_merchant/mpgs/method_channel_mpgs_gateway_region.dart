enum MethodChannelMpgsGatewayRegion {
  asiaPacific,
  europe,
  northAmerica,
  india,
  mtf,
  cn
}

extension KeyName on MethodChannelMpgsGatewayRegion {
  String getKeyName() {
    switch (this) {
      case MethodChannelMpgsGatewayRegion.asiaPacific:
        return "ap";
      case MethodChannelMpgsGatewayRegion.europe:
        return "eu";
      case MethodChannelMpgsGatewayRegion.northAmerica:
        return "na";
      case MethodChannelMpgsGatewayRegion.india:
        return "in";
      case MethodChannelMpgsGatewayRegion.mtf:
        return "test";
      case MethodChannelMpgsGatewayRegion.cn:
        return "cn";
    }
  }
}
