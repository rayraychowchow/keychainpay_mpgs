//
//  Mpgs3dsInfo.swift
//  Runner
//
//  Created by Ray Chow on 3/5/2022.
//

import Foundation

struct Mpgs3DSecureInfo: Mappable {
    let htmlContent: String
    let title: String
    
    static func mapFromDict(dict: [String: Any]) -> Mpgs3DSecureInfo? {
        guard let htmlContent = dict[MethodChannelMpgs3DSecureInfoKey.htmlContent.rawValue] as? String,
              let title = dict[MethodChannelMpgs3DSecureInfoKey.title.rawValue] as? String
        else { return nil }
        return Mpgs3DSecureInfo(htmlContent: htmlContent, title: title)
    }
}
