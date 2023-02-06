package com.keychainpay.keychainpay_mpgs.models.mpgs

import android.util.Log
import com.keychainpay.keychainpay_mpgs.enums.method_channel.card_merchant.mpgs.MethodChannelMpgs3dsInfoKey
import com.keychainpay.keychainpay_mpgs.models.base.Mappable
import com.keychainpay.keychainpay_mpgs.utils.safeLet

class Mpgs3dsInfo constructor(val htmlContent: String, val title: String) {
    companion object: Mappable<Mpgs3dsInfo> {
        override fun mapFromHashMap(hashMap: HashMap<String, Any>): Mpgs3dsInfo? {
            return safeLet(
                hashMap[MethodChannelMpgs3dsInfoKey.HTML_CONTENT.key] as? String,
                hashMap[MethodChannelMpgs3dsInfoKey.TITLE.key] as? String
            ) { htmlContent, title ->
                Mpgs3dsInfo(htmlContent, title)
            }
        }
    }
}