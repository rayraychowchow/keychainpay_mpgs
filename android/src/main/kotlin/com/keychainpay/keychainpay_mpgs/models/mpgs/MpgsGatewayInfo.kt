package com.keychainpay.keychainpay_mpgs.models.mpgs

import com.keychainpay.keychainpay_mpgs.enums.method_channel.card_merchant.mpgs.MethodChannelMpgsGatewayInfoKey
import com.keychainpay.keychainpay_mpgs.enums.method_channel.card_merchant.mpgs.MethodChannelMpgsGatewayRegion
import com.keychainpay.keychainpay_mpgs.models.base.Mappable
import com.keychainpay.keychainpay_mpgs.utils.safeLet

class MpgsGatewayInfo constructor(regionString: String,
                                  val merchantId: String,
                                  val sessionId: String,
                                  val apiVersion: String) {
    val region: MethodChannelMpgsGatewayRegion = MethodChannelMpgsGatewayRegion.values().first { it.key == regionString }
    companion object: Mappable<MpgsGatewayInfo> {
        override fun mapFromHashMap(hashMap: HashMap<String, Any>): MpgsGatewayInfo? {
            return safeLet(
                hashMap[MethodChannelMpgsGatewayInfoKey.GATEWAY_REGION.key] as? String,
                hashMap[MethodChannelMpgsGatewayInfoKey.MERCHANT_ID.key] as? String,
                hashMap[MethodChannelMpgsGatewayInfoKey.SESSION_ID.key] as? String,
                hashMap[MethodChannelMpgsGatewayInfoKey.API_VERSION.key] as? String
            ) { regionString, merchantId, sessionId, apiVersion ->
                MpgsGatewayInfo(regionString, merchantId, sessionId, apiVersion)
            }
        }
    }
}