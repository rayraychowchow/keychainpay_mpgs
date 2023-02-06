package com.keychainpay.keychainpay_mpgs.enums.method_channel.card_merchant.common.method_key

enum class MethodChannelCardMerchantMethodKey(val key: String) {
    TOKENISE_WITH_MPGS("tokenise_with_mpgs"),
    CREATE_PAYMENT_METHOD_WITH_STRIPE("create_payment_method_with_stripe"),
    TOKENISE_WITH_STRIPE("tokenise_with_stripe"),
    SHOW_MPGS_3DS("show_mpgs_3ds"),
    SHOW_STRIPE_3D_SECURE("show_stripe_3d_secure")
}