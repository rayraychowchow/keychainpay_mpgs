enum CardInfomationKey {
  nameOnCard,
  cardNumber,
  cvc,
  expirationMonth,
  expirationYear
}

extension KeyName on CardInfomationKey {
  String getKeyName() {
    switch (this) {
      case CardInfomationKey.nameOnCard:
        return "name_on_card";
      case CardInfomationKey.cardNumber:
        return "card_number";
      case CardInfomationKey.cvc:
        return "cvc";
      case CardInfomationKey.expirationMonth:
        return "expiration_month";
      case CardInfomationKey.expirationYear:
        return "expiration_year";
    }
  }
}
