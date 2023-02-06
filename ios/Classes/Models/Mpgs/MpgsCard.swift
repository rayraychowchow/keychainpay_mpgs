//
//  MpgsCard.swift
//  trywithmpgs
//
//  Created by Ray Chow on 21/4/2022.
//

import Foundation

struct MpgsCard: Mappable {
    let name: String
    let number: String
    let cvc: String
    let expirationMonth: Int
    let expirationYear: Int
    
    static func mapFromDict(dict: [String : Any]) -> MpgsCard? {
        guard let name = dict[MethodChannelCardInformationKey.nameOnCard.rawValue] as? String,
              let number = dict[MethodChannelCardInformationKey.cardNumber.rawValue] as? String,
              let cvc = dict[MethodChannelCardInformationKey.cvc.rawValue] as? String,
              let expirationMonth = dict[MethodChannelCardInformationKey.expirationMonth.rawValue] as? Int,
              let expirationYear = dict[MethodChannelCardInformationKey.expirationYear.rawValue] as? Int
        else { return nil }
        
        return MpgsCard(name: name,
                        number: number,
                        cvc: cvc,
                        expirationMonth: expirationMonth,
                        expirationYear: expirationYear)
    }
}
