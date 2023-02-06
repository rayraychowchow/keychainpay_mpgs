import 'package:keychainpay_mpgs/enums/method_channel/card_merchant/mpgs/method_channel_mpgs_result_key.dart';
import 'package:keychainpay_mpgs/enums/method_channel/card_merchant/mpgs/method_channel_mpgs_tokenise_result_key.dart';
import 'package:keychainpay_mpgs/models/base/method_channel_result/method_channel_result.dart';

class TokeniseWithMpgsResult implements MethodChannelResult {
  String sessionId;

  TokeniseWithMpgsResult(this.sessionId);

  static TokeniseWithMpgsResult fromMap(Map data) {
    var result =
        data[MethodChannelMpgsResultKey.mpgsTokeniseResult.getKeyName()] ?? {};
    String sessionId =
        result[MethodChannelMpgsTokeniseResultKey.sessionId.getKeyName()] ?? "";
    return TokeniseWithMpgsResult(sessionId);
  }

  @override
  bool checkDataIsCompleted() {
    return sessionId.isNotEmpty;
  }
}
