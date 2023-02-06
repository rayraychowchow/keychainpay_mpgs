//
//  MethodChannelCardMerchantMethodKey.swift
//  Runner
//
//  Created by Ray Chow on 22/4/2022.
//

import Foundation

enum MethodChannelCardMerchantMethodKey: String {
    case tokeniseWithMpgs = "tokenise_with_mpgs",
         createPaymentMethodWithStripe = "create_payment_method_with_stripe",
         tokeniseWithStripe = "tokenise_with_stripe",
         tokeniseApplePayWithStripe = "tokenise_apple_pay_with_stripe",
         tokeniseGooglePayWithStripe = "tokenise_google_pay_with_stripe",
         setupApplePay = "setup_apple_pay",
         showMpgs3ds = "show_mpgs_3ds",
         showStripe3ds = "show_stripe_3d_secure"
}
