//
//  LocationSearchViewModel.swift
//  UberClone
//
//  Created by Rebi.boy on 18/01/2023.
//

import Foundation
import MapKit

/// This is a  location search view momdel.
///
/// ```
/// This is the view model that controls the functionality of the location search view.
/// It updates the scroll view of the location search view with updated search results
/// ```
class LocationSearchViewModel: NSObject, ObservableObject {
    
    //MARK: - Properties
    
    @Published var results = [MKLocalSearchCompletion]()
    private let searchCompleter = MKLocalSearchCompleter()
    var queryFragment: String = "" {
        didSet {
            searchCompleter.queryFragment = queryFragment
        }
    }
    
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
    }
    
}

//MARK: - MKLocalSearchCompletionDelegate

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}



