//
//  RideRequestView.swift
//  UberClone
//
//  Created by Rebi.boy on 19/01/2023.
//

import SwiftUI

struct RideRequestView: View {
    @State private var selectedRideType: RideType = .uberX
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    private var viewModel: RideRequestViewModel = RideRequestViewModel()
    
    var body: some View {
        VStack {
            Capsule()
                .foregroundColor(Color(.systemGray5))
                .frame(width:48,height:6)
                .padding(.top, 8)
            
            //trip info view
            HStack {
                VStack {
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width:8,height:8)
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width:1,height:32)
                    Rectangle()
                        .fill(.black)
                        .frame(width:8,height:8)
                }
                
                VStack (alignment: .leading, spacing: 24){
                    HStack {
                        Text("Current Location")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.gray)
                        
                        Spacer()
                        
                        Text(locationViewModel.pickupTime ?? "")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.gray)
                            
                    }
                    .padding(.bottom, 10)
                    
                    HStack {
                        if let location = locationViewModel.selectedUberLocation {
                            Text(location.title)
                                .font(.system(size: 16, weight: .semibold))
                        }
                        
                        Spacer()
                        
                        Text(locationViewModel.dropoffTime ?? "")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.gray)
                            
                    }
                }
                .padding(.leading, 8)
            }
            .padding()
            
            Divider()
            
            //ride type selection view
            Text("SUGGESTED RIDES")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding()
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(.horizontal) {
                HStack(spacing: 12) {
                    ForEach ( RideType.allCases, id: \.self) { type in
                        VStack(alignment: .leading) {
                            Image(type.imageName)
                                .resizable()
                                .scaledToFit()
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(type.description)
                                    .font(.system(size: 14, weight: .semibold))
                                
                                Text(locationViewModel.computeRidePrice(forType: type).toCurrency())
                                    .font(.system(size: 14, weight: .semibold))
                            }
                            .padding(12)
                            
                        }
                        .frame(width:112, height: 140)
                        .foregroundColor(type == selectedRideType ? .white : Color.theme.primaryTextColor)
                        .background(type == selectedRideType ? Color.theme.DashPrimary : Color.theme.secondaryBackgroundColor)
//                        "#65F6A1"
                        .scaleEffect(type == selectedRideType ? 1.2 : 1.0)
                        .cornerRadius(10)
                        .onTapGesture{
                            withAnimation(.spring()) {
                                selectedRideType = type
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
            
            Divider()
                .padding(.vertical, 8)
            
            //payment option view
            Button {
                viewModel.paymentClicked()
            } label: {
                HStack(spacing: 12){
                    Text("Visa")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(6)
                        .background(.blue)
                        .cornerRadius(4)
                        .foregroundColor(.white)
                        .padding(.leading)
                    
                    Text("**** 1234")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .imageScale(.medium)
                        .padding()
                }
                .background(Color.theme.secondaryBackgroundColor)
                .cornerRadius(10)
                .padding(.horizontal)
            }
            
            //request ride button
            Button {
                viewModel.requestRide()
            } label: {
                Text("CONFIRM RIDE")
                    .fontWeight(.bold)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                    .background(Color.theme.DashPrimary)
                    .cornerRadius(10)
                    .foregroundColor(.white)
            }

        }
        .padding(.bottom, 24)
        .background(Color.theme.backgroundColor)
        .cornerRadius(16)
    }
}

struct RideRequestView_Previews: PreviewProvider {
    static var previews: some View {
        RideRequestView()
    }
}
