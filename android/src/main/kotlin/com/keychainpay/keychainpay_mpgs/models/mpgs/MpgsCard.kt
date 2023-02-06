package com.keychainpay.keychainpay_mpgs.models.mpgs

import com.keychainpay.keychainpay_mpgs.enums.method_channel.card_merchant.common.card_info.MethodChannelCardInformationKey
import com.keychainpay.keychainpay_mpgs.models.base.Mappable
import com.keychainpay.keychainpay_mpgs.utils.safeLet

class MpgsCard(val name: String,
               val number: String,
               val cvc: String,
               val expirationMonth: Int,
               val expirationYear: Int) {

    companion object: Mappable<MpgsCard> {
        override fun mapFromHashMap(hashMap: HashMap<String, Any>): MpgsCard? {
            return safeLet(hashMap[MethodChannelCardInformationKey.NAME_ON_CARD.key] as? String,
                hashMap[MethodChannelCardInformationKey.CARD_NUMBER.key] as? String,
                hashMap[MethodChannelCardInformationKey.CVC.key] as? String,
                hashMap[MethodChannelCardInformationKey.EXPIRATION_MONTH.key] as? Int,
                hashMap[MethodChannelCardInformationKey.EXPIRATION_YEAR.key] as? Int) {
                name, number, cvc, expirationMonth, expirationYear ->
                MpgsCard(name, number, cvc, expirationMonth, expirationYear)
            }
        }
    }
}