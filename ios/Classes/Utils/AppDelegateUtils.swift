//
//  AppDelegateUtils.swift
//  Runner
//
//  Created by Ray Chow on 3/5/2022.
//

import Foundation
import UIKit

class AppDelegateUtils {
    static func getRootViewController() -> UIViewController? {
        return UIApplication.shared.delegate?.window??.rootViewController
    }
}
