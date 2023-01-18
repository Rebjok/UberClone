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
    @Published var selectedLocationCoordinate : CLLocationCoordinate2D?
    
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
    
    //MARK: - Helpers
    func selectedLocation(_ localSearch: MKLocalSearchCompletion){
        locationSearch(forLocalSeachCompletion: localSearch) { response, error in
            //handle error
            if let error = error {
                print("DEBUG: Location search failed with \(error)")
                return
            }
            
            //get coordinate
            guard let item = response?.mapItems.first else {return}
            let coordinate = item.placemark.coordinate
            self.selectedLocationCoordinate = coordinate
            print("DEBUG location coordinates \(coordinate)")
        }
    }
    
    /// This function fetches the coordinate of a location given a string address
    ///
    /// ```
    /// This function performs a call to Apple's MKLocalSearch framework to fetch the coordinates of a location
    /// It performs a naturlay language query on an MKLocalSearch object and executes a completion handler upon fnish
    /// ```
    /// - Parameters:
    ///     -forLocalSeachCompletion: An MKLocalSearchCompletion object
    ///     -completion: A completion handler which is executed after the MKLocalSearch finishes executnig
    ///
    /// - Returns: A result (CLLocationCoordinate2D) and an error
    func locationSearch(forLocalSeachCompletion localSearch: MKLocalSearchCompletion, completion: @escaping MKLocalSearch.CompletionHandler ){
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.title)
        let search = MKLocalSearch(request: searchRequest)
        search.start(completionHandler: completion)
    }
    
}

//MARK: - MKLocalSearchCompletionDelegate

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}



