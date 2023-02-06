import 'package:keychainpay_mpgs/enums/method_channel/card_merchant/mpgs/method_channel_mpgs_3d_secure_info_key.dart';
import 'package:keychainpay_mpgs/enums/method_channel/card_merchant/mpgs/method_channel_mpgs_request_key.dart';
import 'package:keychainpay_mpgs/models/base/method_channel_result/method_channel_request.dart';

class Mpgs3DSecureInfo implements MethodChannelRequest {
  String htmlContent;
  String title;

  Mpgs3DSecureInfo(this.htmlContent, this.title);

  @override
  Map<String, dynamic> toJson() {
    return {
      MethodChannelMpgsRequestKey.mpgs3dsInfo.getKeyName(): {
        MethodChannelMpgs3DSecureInfoKey.htmlContent.getKeyName(): htmlContent,
        MethodChannelMpgs3DSecureInfoKey.title.getKeyName(): title
      }
    };
  }
}
