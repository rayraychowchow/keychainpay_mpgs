//
//  Mpgs3dsResult.swift
//  Runner
//
//  Created by Ray Chow on 3/5/2022.
//

import Foundation

struct Mpgs3DSecureResult: MethodChannelResultConvertible {
    let result: String
    let isLast3DS: Bool
    
    func convertToDict() -> Dictionary<String, Any> {
        return [MethodChannelMpgsResultKey.mpgs3dsResult.rawValue:[MethodChannelMpgs3dsResultKey.result.rawValue: result,
            MethodChannelMpgs3dsResultKey.isLast3DS.rawValue: isLast3DS]
        ]
    }
}
