//
//  MethodChannelMerchantManager.swift
//  Runner
//
//  Created by Ray Chow on 26/4/2022.
//

import Foundation
import Flutter
import RxSwift

class MethodChannelCardMerchantManager: BaseMethodChannelManager {
    static let shared = MethodChannelCardMerchantManager()
    let disposeBag = DisposeBag()
    
    func handleMethod(call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let method = MethodChannelCardMerchantMethodKey(rawValue:  call.method) else {
            result(FlutterMethodNotImplemented)
            return
        }
        
        guard let arguments = call.arguments as? Dictionary<String, Any>,
                let data = arguments[MethodChannelRequestKey.data.rawValue] as? Dictionary<String, Any>
         else {
            result(FlutterError(code: "-1", message: "Cannot find object with key - data", details: nil))
            return
        }
        
        switch method {
            //MPGS
        case .tokeniseWithMpgs:
            MpgsMerchantManager.shared.tokeniseWithMpgs(data: data).subscribe(with: self) { this, mpgsTokeniseResult in
                result(this.mapToMethodChannelResultDataDictionary(
                    data: mpgsTokeniseResult.convertToDict()))
            } onFailure: { this, error in
                result(FlutterError(code: "-1", message: error.localizedDescription, details: nil))
            }.disposed(by: disposeBag)
            break
        case .showMpgs3ds:
            MpgsMerchantManager.shared.showMpgs3ds(data: data).take(1).subscribe(with: self) { this, mpgs3dsResult in
                result(this.mapToMethodChannelResultDataDictionary(data: mpgs3dsResult.convertToDict()))
            } onError: { this, error in
                result(FlutterError(code: "-1", message: error.localizedDescription, details: nil))
            }.disposed(by: disposeBag)
            break
        default:
            result(FlutterMethodNotImplemented)
            break
        }
    }
}
