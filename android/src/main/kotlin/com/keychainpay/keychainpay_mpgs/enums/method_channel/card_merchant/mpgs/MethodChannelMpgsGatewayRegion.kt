package com.keychainpay.keychainpay_mpgs.enums.method_channel.card_merchant.mpgs

import com.mastercard.gateway.android.sdk.Gateway

enum class MethodChannelMpgsGatewayRegion(val key: String) {
    ASIA_PACIFIC("ap"),
    EUROPE("eu"),
    NORTH_AMERICA("na"),
    INDIA("in"),
    MTF("test"),
    CN("cn")
}

fun MethodChannelMpgsGatewayRegion.convertToMpgsGateInfo(): Gateway.Region {
    return when (this) {
        MethodChannelMpgsGatewayRegion.ASIA_PACIFIC -> Gateway.Region.ASIA_PACIFIC
        MethodChannelMpgsGatewayRegion.EUROPE -> Gateway.Region.EUROPE
        MethodChannelMpgsGatewayRegion.NORTH_AMERICA -> Gateway.Region.NORTH_AMERICA
        MethodChannelMpgsGatewayRegion.INDIA -> Gateway.Region.INDIA
        MethodChannelMpgsGatewayRegion.MTF -> Gateway.Region.MTF
        MethodChannelMpgsGatewayRegion.CN -> Gateway.Region.CHINA
    }
}