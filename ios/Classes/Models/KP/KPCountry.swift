//
//  KPCountry.swift
//  Runner
//
//  Created by Ray Chow on 28/4/2022.
//

import Foundation

struct KPCountry {
    
    var name: String?
    var countryCode: String?
    var currencyCode: String?
    var currencySign: String?
 
    static var HKG: KPCountry {
        var hkg = KPCountry()
        
        hkg.name = "hong_kong"
        hkg.countryCode = "HK"
        hkg.currencyCode = "HKD"
        hkg.currencySign = "$"
        
        return hkg
    }
}
