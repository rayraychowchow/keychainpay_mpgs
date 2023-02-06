//
//  MpgsMerchantManager.swift
//  Runner
//
//  Created by Ray Chow on 25/4/2022.
//

import Foundation
import RxSwift

class MpgsMerchantManager {
    static let shared = MpgsMerchantManager()
    
    /// Returns an observable of MpgsTokeniseResult when tokenise credit card with mpgs success
    ///
    /// - Parameters:
    ///   - data: The data Dictionary should include a MpgsGatewayInfo and a Mpgs Card(Card Info)
    /// - Returns: Returns an observable of MpgsTokeniseResult
    /// - Error: Return an observable error
    func tokeniseWithMpgs(data: [String: Any]) -> Single<MpgsTokeniseResult> {
        MpgsService.shared.tokeniseCreditCardWithMpgs(data: data).asSingle()
    }
    
    /// Returns an observable of Mpgs3dsResult when 3ds Result from Mpgs
    ///
    /// - Parameters:
    ///   - data: The data Dictionary should include a Mpgs3dsInfo
    /// - Returns: Returns an observable of Mpgs3dsResult
    /// - Error: Return an observable error
    func showMpgs3ds(data: [String: Any]) -> PublishSubject<Mpgs3DSecureResult> {
        MpgsService.shared.showMpgs3DSecure(data: data)
    }
    
}
