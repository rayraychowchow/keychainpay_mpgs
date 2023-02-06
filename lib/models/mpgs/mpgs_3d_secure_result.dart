import 'package:keychainpay_mpgs/enums/method_channel/card_merchant/mpgs/method_channel_mpgs_3d_secure_result_key.dart';
import 'package:keychainpay_mpgs/enums/method_channel/card_merchant/mpgs/method_channel_mpgs_result_key.dart';
import 'package:keychainpay_mpgs/models/base/method_channel_result/method_channel_result.dart';

class Mpgs3DSecureResult implements MethodChannelResult {
  String result;
  bool isLast3DS;

  Mpgs3DSecureResult(this.result, this.isLast3DS);

  @override
  bool checkDataIsCompleted() {
    return result.isNotEmpty;
  }

  static Mpgs3DSecureResult fromMap(Map<dynamic, dynamic>? data) {
    var resultMap =
        data?[MethodChannelMpgsResultKey.mpgs3dsResult.getKeyName()] ?? {};
    String result =
        resultMap?[MethodChannelMpgs3DSecureResult.result.getKeyName()] ?? "";
    bool isLast3DS =
        resultMap?[MethodChannelMpgs3DSecureResult.isLast3DS.getKeyName()] ??
            false;
    return Mpgs3DSecureResult(result, isLast3DS);
  }
}
