//
//  SideMenuOptionView.swift
//  UberClone
//
//  Created by Rebi.boy on 24/01/2023.
//

import SwiftUI

struct SideMenuOptionView: View {
    var sideMenuOptionType : SideMenuOption
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: sideMenuOptionType.image)
                .resizable()
                .scaledToFit()
                .clipped()
                .frame(width: 30, height: 30)
                .font(.system(size:14,weight:.ultraLight))
                .foregroundColor(.primary)
            
            Text(sideMenuOptionType.name)
                .font(.system(size:16,weight:.light))
            
            Spacer()
                
        }
        .padding()
    }
}

struct SideMenuOptionView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuOptionView(sideMenuOptionType: .payments)
    }
}
