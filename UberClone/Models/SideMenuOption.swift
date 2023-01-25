//
//  SideMenuOption.swift
//  UberClone
//
//  Created by Rebi.boy on 25/01/2023.
//

import Foundation

enum SideMenuOption {
    case payments
    case promotions
    case myRides
    case support
    case about
    
    var image: String {
        switch self{
        case .payments: return "briefcase"
        case .promotions: return "UberBlack"
        case .myRides: return "UberXL"
        case .support: return ""
        case .about: return ""
        }
    }
}
