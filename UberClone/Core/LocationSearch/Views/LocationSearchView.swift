//
//  LocationSearchView.swift
//  UberClone
//
//  Created by Rebi.boy on 18/01/2023.
//

import SwiftUI

/// This is the location view.
///
/// ```
/// LocationSearchView()
/// It manages two things, the search functionality and the list of popular destinations.
/// The Search functionality enables the user to search and select for a pickup location and a destination location
/// The list of popular destination locations is a scroll view of LocationSearchViewCells.
/// ```
struct LocationSearchView: View {
    @State private var startLocationText = ""
    @Binding var mapState : MapViewState
    @EnvironmentObject var viewModel : LocationSearchViewModel
    
    var body: some View {
        VStack {
            //header view
            HStack {
                VStack {
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width:6,height:6)
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width:1,height:24)
                    Rectangle()
                        .fill(.black)
                        .frame(width:6,height:6)
                }
                
                VStack {
                    TextField("Current Location", text: $startLocationText)
                        .frame(height: 32)
                        .background(Color(.systemGroupedBackground))
                        .padding(.trailing)
                    
                    TextField("Where to?", text: $viewModel.queryFragment)
                        .frame(height: 32)
                        .background(Color(.systemGray4))
                        .padding(.trailing)
                }
                
            }
            .padding(.horizontal)
            .padding(.top, 64)
            
            Divider()
                .padding(.vertical)
            
            //list view
            ScrollView  {
                VStack(alignment:.leading) {
                    ForEach(viewModel.results, id: \.self){ result in
                        LocationSearchResultCell(title: result.title, subtitle: result.subtitle)
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    viewModel.selectedLocation(result)
                                    mapState = .locationSelected
                                }
                            }
                    }
                    
                }
            }
            
        }
        .background(.white)
    }
}

struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView(mapState: .constant(.searchingForLocation))
    }
}
