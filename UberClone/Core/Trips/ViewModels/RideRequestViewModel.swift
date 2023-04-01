//
//  RideRequestViewModel.swift
//  UberClone
//
//  Created by Rebi.boy on 26/01/2023.
//

import Foundation

class RideRequestViewModel {
    //MARK: - Properties
    
    //MARK: - LifeCycle
    
    //MARK: - Payment Details
    //We are only going to accept Apple pay and credit card
    func paymentClicked() {
        print("DEBUG: select payment method")
    }
    
    //MARK: - Server Interactions
    func requestRide() {
        print("DEBUG: Interact with the server to get the closest driver")
    }
    
}

