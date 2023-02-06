package com.keychainpay.keychainpay_mpgs.models.base

interface MethodChannelResultConvertible {
    fun convertToHashMap(): HashMap<String, Any>
}