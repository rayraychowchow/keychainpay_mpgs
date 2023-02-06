package com.keychainpay.keychainpay_mpgs.models.base

interface Mappable<T> {
    fun mapFromHashMap(hashMap: HashMap<String, Any>): T?
}