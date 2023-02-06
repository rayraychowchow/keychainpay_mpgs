package com.keychainpay.keychainpay_mpgs.manager.method_channel.base

import com.keychainpay.keychainpay_mpgs.enums.method_channel.common.MethodChannelResultKey

open class BaseMethodChannelManager {
    fun mapToMethodChannelDataMap(data: HashMap<String, Any> = HashMap()): HashMap<String, Any> {
        val hashMap: HashMap<String, Any> = HashMap()
        hashMap[MethodChannelResultKey.DATA.key] = data
        return hashMap
    }
}