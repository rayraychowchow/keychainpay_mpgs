//
//  MpgsGatewayInfo.swift
//  trywithmpgs
//
//  Created by Ray Chow on 21/4/2022.
//

import Foundation

struct MpgsGatewayInfo: Mappable {
    let region: MethodChannelMpgsGatewayRegion
    let merchantId: String
    let sessionId: String
    let apiVersion: String
    
    
    static func mapFromDict(dict: [String: Any]) -> MpgsGatewayInfo? {
        guard let region = dict[MethodChannelMpgsGatewayInfoKey.gatewayRegion.rawValue] as? String,
              let merchantId = dict[MethodChannelMpgsGatewayInfoKey.merchantId.rawValue] as? String,
              let sessionId = dict[MethodChannelMpgsGatewayInfoKey.sessionId.rawValue] as? String,
              let apiVersion = dict[MethodChannelMpgsGatewayInfoKey.apiVerions.rawValue] as? String
        else { return nil }
        //TODO: the default value may need to change
        return MpgsGatewayInfo(region: MethodChannelMpgsGatewayRegion(rawValue: region) ?? MethodChannelMpgsGatewayRegion.asiaPacific, merchantId: merchantId, sessionId: sessionId, apiVersion: apiVersion)
    }
}
