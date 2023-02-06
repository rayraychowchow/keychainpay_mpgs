package com.keychainpay.keychainpay_mpgs.models.mpgs

import com.keychainpay.keychainpay_mpgs.enums.method_channel.card_merchant.mpgs.MethodChannelMpgs3dsResultKey
import com.keychainpay.keychainpay_mpgs.enums.method_channel.card_merchant.mpgs.MethodChannelMpgsResultKey
import com.keychainpay.keychainpay_mpgs.models.base.MethodChannelResultConvertible

class Mpgs3dsResult constructor(private val result: String, private val isLast3ds: Boolean):
    MethodChannelResultConvertible {
    override fun convertToHashMap(): HashMap<String, Any> {
        val hashMap = HashMap<String, Any>()
        val dataHashMap = HashMap<String, Any>()

        dataHashMap[MethodChannelMpgs3dsResultKey.RESULT.key] = result
        dataHashMap[MethodChannelMpgs3dsResultKey.IS_LAST_3DS.key] = isLast3ds
        hashMap[MethodChannelMpgsResultKey.MPGS_3DS_RESULT.key] = dataHashMap
        return hashMap
    }

}