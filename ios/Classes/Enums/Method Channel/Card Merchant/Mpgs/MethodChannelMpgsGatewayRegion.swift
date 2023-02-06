//
//  MethodChannelMpgsGatewayRegion.swift
//  Runner
//
//  Created by Ray Chow on 29/4/2022.
//

import Foundation

enum MethodChannelMpgsGatewayRegion: String {
    case asiaPacific = "ap",
    europe = "eu",
    northAmerica = "na",
    india = "in",
    mtf = "test",
    cn = "cn"
    
    func convertToMpgsGatewayRegion() -> GatewayRegion {
        switch (self) {
        case .asiaPacific:
            return GatewayRegion.asiaPacific
        case .europe:
            return GatewayRegion.europe
        case .northAmerica:
            return GatewayRegion.northAmerica
        case .india:
            return GatewayRegion.india
        case .mtf:
            return GatewayRegion.mtf
        case .cn:
            return GatewayRegion.china
        }
    }
}
