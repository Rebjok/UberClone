//
//  SideMenuHeaderView.swift
//  UberClone
//
//  Created by Rebi.boy on 24/01/2023.
//

import SwiftUI

struct SideMenuHeaderView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .scaledToFit()
                    .clipped()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .font(.system(size:14,weight:.ultraLight))
                    .foregroundColor(.primary)
                    .padding()
                    .padding(.top, 40)
                    .padding(.bottom)
                
                VStack(alignment: .leading, spacing: 8){
                    Text("John Doe")
                        .font(.system(size: 18, weight: .semibold))
                        
                    
                    Button {
                        
                    } label: {
                        Text("Edit Profile")
                            .foregroundColor(.green)
                    }
                }
                Spacer()
            }
            .background(.white)
            .cornerRadius(10)
            
            
        }
    }
}

struct SideMenuHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuHeaderView()
    }
}
