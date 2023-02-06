package com.keychainpay.keychainpay_mpgs.extension

fun String?.isNotNullOrEmpty(): Boolean {
    return this != null && this.isNotEmpty()
}