//
//  BaseMethodChannelManager.swift
//  Runner
//
//  Created by Ray Chow on 27/4/2022.
//

import Foundation

class BaseMethodChannelManager: NSObject {
    func mapToMethodChannelResultDataDictionary(data: Dictionary<String, Any> = [:]) -> Dictionary<String, Any?> {
        return [MethodChannelResultKey.data.rawValue: data]
    }
}
