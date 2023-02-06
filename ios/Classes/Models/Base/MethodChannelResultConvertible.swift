//
//  Serializable.swift
//  Runner
//
//  Created by Ray Chow on 27/4/2022.
//

import Foundation

protocol MethodChannelResultConvertible {
    func convertToDict() -> Dictionary<String, Any>
}
