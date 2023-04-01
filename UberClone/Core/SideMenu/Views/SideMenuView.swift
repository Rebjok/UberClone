//
//  SideMenuView.swift
//  UberClone
//
//  Created by Rebi.boy on 24/01/2023.
//

import SwiftUI

struct SideMenuView: View {
    @Binding var mapState : MapViewState
    var viewModel: SideMenuViewModel = SideMenuViewModel()
    
    var body: some View {
        ZStack {
            //Dimming view
            GeometryReader { _ in
                        EmptyView()
                    }
                    .background(.black.opacity(0.6))
                    .opacity(mapState == .sideMenuOpened ? 1 : 0)
                    .animation(.easeInOut.delay(0.5), value: mapState == .sideMenuOpened)
                    .onTapGesture {
                        mapState = .noInput
                    }
            
            //SideMenu Contents
            HStack {
                ZStack{
                    
                    LinearGradient(gradient: Gradient(colors: [Color(UIColor.lightGray),Color(UIColor.lightGray)]), startPoint: .top, endPoint: .bottom)

                    VStack {
                        //Header
                        SideMenuHeaderView()

                        //Option Cells
                        VStack{
                            ForEach( SideMenuOption.allCases, id: \.self) {type in
                                Button {
                                    switch type{
                                    case .payments: viewModel.payments()
                                    case .promotions: viewModel.promotions()
                                    case .myRides: viewModel.myRides()
                                    case .support: viewModel.support()
                                    case .about: viewModel.about()
                                    }
                                } label: {
                                    SideMenuOptionView(sideMenuOptionType: type)
                                }
                            }
                        }
                        .padding(.vertical)
                        .background(.white)
                        .cornerRadius(10)
                        
                        
                        VStack {
                            Spacer()
                            
                            
                            HStack {
                                Spacer()
                                
                                Button {
                                    viewModel.becomeADriver() 
                                } label: {
                                    VStack(alignment: .leading){
                                        Text("Become a Driver")
                                        
                                        Text("Earn money on your schedule")
                                            .font(.system(size: 16, weight: .light))
                                    }
                                    
                                }
                                .padding()
                                .foregroundColor(.white)
                                .background(.green)
                                .cornerRadius(10)
                                .padding(.bottom, 32)
                                .padding(.horizontal)
                                
                                Spacer()
                            }
                            
                            
                        }
                        .padding(.vertical)
                        .background(.white)
                        .cornerRadius(10)
                        
                    }
                    
                }
                .ignoresSafeArea()
                .frame(width: UIScreen.main.bounds.width * 0.7)
                .offset(x: mapState == .sideMenuOpened ? 0 : -(UIScreen.main.bounds.width * 0.7))
                .animation(.default, value: mapState == .sideMenuOpened)
                
                Spacer()
                
            }
            
            
        }
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(mapState: .constant(.sideMenuOpened))
    }
}
