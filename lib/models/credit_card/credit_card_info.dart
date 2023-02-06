import 'package:keychainpay_mpgs/enums/method_channel/card_merchant/common/method_channel_credit_card_infomation.dart';
import 'package:keychainpay_mpgs/models/base/method_channel_result/method_channel_request.dart';

class MpgsCreditCardInfo implements MethodChannelRequest {
  final String name;
  final String number;
  final String cvc;
  final int expirationMonth;
  final int expirationYear;

  MpgsCreditCardInfo(this.name, this.number, this.cvc, this.expirationMonth,
      this.expirationYear);

  MpgsCreditCardInfo.fromJson(Map<String, dynamic> json)
      : name = json[CardInfomationKey.nameOnCard.getKeyName()],
        number = json[CardInfomationKey.cardNumber.getKeyName()],
        cvc = json[CardInfomationKey.cvc.getKeyName()],
        expirationMonth = json[CardInfomationKey.expirationMonth.getKeyName()],
        expirationYear = json[CardInfomationKey.expirationYear.getKeyName()];

  @override
  Map<String, dynamic> toJson() => {
        CardInfomationKey.nameOnCard.getKeyName(): name,
        CardInfomationKey.cardNumber.getKeyName(): number,
        CardInfomationKey.cvc.getKeyName(): cvc,
        CardInfomationKey.expirationMonth.getKeyName(): expirationMonth,
        CardInfomationKey.expirationYear.getKeyName(): expirationYear
      };
}
