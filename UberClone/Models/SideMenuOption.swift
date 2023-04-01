//
//  SideMenuOption.swift
//  UberClone
//
//  Created by Rebi.boy on 25/01/2023.
//

import Foundation

enum SideMenuOption: Int, CaseIterable, Identifiable {
    case payments
    case promotions
    case myRides
    case support
    case about
    
    var id: Int {return rawValue}
    
    var name: String {
        switch self{
        case .payments: return "Payments"
        case .promotions: return "Promotions"
        case .myRides: return "My Rides"
        case .support: return "Support"
        case .about: return "About"
        }
    }
    
    var image: String {
        switch self{
        case .payments: return "wallet.pass"
        case .promotions: return "tag"
        case .myRides: return "clock"
        case .support: return "questionmark.circle"
        case .about: return "info.circle"
        }
    }
}
