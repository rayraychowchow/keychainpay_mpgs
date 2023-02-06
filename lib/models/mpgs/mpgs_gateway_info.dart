import 'package:keychainpay_mpgs/enums/method_channel/card_merchant/mpgs/method_channel_mpgs_gateway_info_key.dart';
import 'package:keychainpay_mpgs/enums/method_channel/card_merchant/mpgs/method_channel_mpgs_gateway_region.dart';
import 'package:keychainpay_mpgs/models/base/method_channel_result/method_channel_request.dart';

class MpgsGatewayInfo implements MethodChannelRequest {
  MethodChannelMpgsGatewayRegion region;
  String merchantId;
  String sessionId;
  String version;

  MpgsGatewayInfo(this.region, this.merchantId, this.sessionId, this.version);

  @override
  Map<String, dynamic> toJson() {
    return {
      MethodChannelMpgsGatewayInfoKey.gatewayRegion.getKeyName():
          region.getKeyName(),
      MethodChannelMpgsGatewayInfoKey.merchantId.getKeyName(): merchantId,
      MethodChannelMpgsGatewayInfoKey.sessionId.getKeyName(): sessionId,
      MethodChannelMpgsGatewayInfoKey.apiVerions.getKeyName(): version
    };
  }
}
