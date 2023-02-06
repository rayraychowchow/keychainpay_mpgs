package com.keychainpay.keychainpay_mpgs.models.mpgs

import com.keychainpay.keychainpay_mpgs.enums.method_channel.card_merchant.mpgs.MethodChannelMpgsResultKey
import com.keychainpay.keychainpay_mpgs.enums.method_channel.card_merchant.mpgs.MethodChannelMpgsTokniseResultKey
import com.keychainpay.keychainpay_mpgs.models.base.MethodChannelResultConvertible

class MpgsTokeniseResult(val sessionId: String): MethodChannelResultConvertible {
    override fun convertToHashMap(): HashMap<String, Any> {
        val hashMap = HashMap<String, Any>()
        val dataHashMap = HashMap<String, Any>()

        dataHashMap[MethodChannelMpgsTokniseResultKey.SESSION_ID.key] = sessionId
        hashMap[MethodChannelMpgsResultKey.MPGS_TOKENISE_RESULT.key] = dataHashMap
        return hashMap
    }
}