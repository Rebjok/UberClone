//
//  UberCloneApp.swift
//  UberClone
//
//  Created by Rebi.boy on 18/01/2023.
//

import SwiftUI

@main
struct UberCloneApp: App {
    @StateObject var locationViewModel = LocationSearchViewModel()
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(locationViewModel)
        }
    }
}
