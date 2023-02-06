//
//  Mappable.swift
//  Runner
//
//  Created by Ray Chow on 27/4/2022.
//

import Foundation

protocol Mappable {
    static func mapFromDict(dict: [String: Any]) -> Self?
}
