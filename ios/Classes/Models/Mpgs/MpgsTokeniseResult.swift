//
//  MpgsTokeniseResult.swift
//  Runner
//
//  Created by Ray Chow on 27/4/2022.
//

import Foundation

struct MpgsTokeniseResult: MethodChannelResultConvertible {
    let sessionId: String
    
    func convertToDict() -> Dictionary<String, Any> {
        return [MethodChannelMpgsResultKey.mpgsTokeniseResult.rawValue: [MethodChannelMpgsTokniseResultKey.sessionId.rawValue: sessionId]]
    }
}
