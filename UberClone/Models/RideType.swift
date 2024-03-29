//
//  RideType.swift
//  UberClone
//
//  Created by Rebi.boy on 19/01/2023.
//

import Foundation

enum RideType: Int, CaseIterable, Identifiable {
    case uberX
    case uberBlack
    case uberXL
    
    var id: Int {return rawValue}
    
    var description: String {
        switch self{
        case .uberX: return "DashX"
        case .uberBlack: return "DashBlack"
        case .uberXL: return "DashXL"
        }
    }
    
    var imageName: String {
        switch self{
        case .uberX: return "uber-x"
        case .uberBlack: return "uber-black"
        case .uberXL: return "uber-x"
        }
    }
    
    var baseFare: Double {
        switch self{
        case .uberX: return 5
        case .uberBlack: return 20
        case .uberXL: return 10
        }
    }
    
    func computePrice(for distanceInMetres: Double) -> Double {
        let distanceInMiles = distanceInMetres / 1600
        switch self{
        case .uberX: return distanceInMiles * 1.5 + baseFare
        case .uberBlack: return distanceInMiles * 2.0 + baseFare
        case .uberXL: return distanceInMiles * 1.75 + baseFare
        }
    }
    
}
