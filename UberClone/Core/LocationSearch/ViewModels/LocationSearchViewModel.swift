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
    @Published var selectedUberLocation : UberLocation?
    @Published var pickupTime: String?
    @Published var dropoffTime: String?
    
    private let searchCompleter = MKLocalSearchCompleter()
    
    var queryFragment: String = "" {
        didSet {
            searchCompleter.queryFragment = queryFragment
        }
    }
    
    var userLocation: CLLocationCoordinate2D?
    
    //MARK: - LifeCycle
    
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
            self.selectedUberLocation = UberLocation(title: localSearch.title, coordinate: coordinate)
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
    
    func computeRidePrice(forType type: RideType) -> Double {
        guard let coordinate = selectedUberLocation?.coordinate else {return 0.0}
        guard let userLocation = self.userLocation else {return 0.0}
        
        let locationOfUser = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
        let destination = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        let tripDistanceInMeters = locationOfUser.distance(from: destination)
        return type.computePrice(for: tripDistanceInMeters)
        
    }
    
    /// This function fetches the directions from the users location to the destination
    ///
    /// ```
    /// It utilises a MKPlaceMark object to fetch a route from the users location and their destination. Upon completion, it executes a completion handler.
    /// ```
    /// - Parameters:
    ///     -from: An CLLocationCoordinate2D object, the user's location
    ///     -to: A CLLocationCoordinate2D, the user's destination
    ///
    /// - Returns: A result (route) and an error
    ///
    func getDestinationRoute(from userLocation: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D, completion: @escaping(MKRoute) -> Void ) {
        let destinationPlacemark = MKPlacemark(coordinate: destination)
        let userPlacemark = MKPlacemark(coordinate: userLocation)
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: userPlacemark)
        request.destination = MKMapItem(placemark: destinationPlacemark)
        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            //handle error
            if let error = error {
                print("DEBUG failed to get directions with errorr \(error.localizedDescription)")
                return
            }
            
            guard let route = response?.routes.first else {return}
            self.configurePckUpAndDropOffTimes(with: route.expectedTravelTime)
            completion(route)
        }
    }
    
    func configurePckUpAndDropOffTimes(with expectedTravelTime: Double) {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        
        pickupTime = formatter.string(from: Date())
        dropoffTime = formatter.string(from: Date() + expectedTravelTime)
    }
    
}

//MARK: - MKLocalSearchCompletionDelegate

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}



