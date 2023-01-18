//
//  HomeView.swift
//  UberClone
//
//  Created by Rebi.boy on 18/01/2023.
//

import SwiftUI

struct HomeView: View {
    @State private var showLocationSeachView = false
    
    var body: some View {
        ZStack(alignment: .top) {
            UberMapViewRepresentable()
                .ignoresSafeArea()
            
            if showLocationSeachView {
                LocationSearchView()
            }
            else {
                LocationSearchActivationView()
                    .padding(.top, 72)
                    .onTapGesture {
                        withAnimation(.spring()){
                            showLocationSeachView.toggle()
                        }
                    }
            }
            
            MapViewActionButton(showLocationSearchView: $showLocationSeachView)
                .padding(.leading)
                .padding(.top,4)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
