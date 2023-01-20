//
//  locationManager.swift
//  UberClone
//
//  Created by Rebi.boy on 18/01/2023.
//

import CoreLocation

/// Manages the location information of the user
///
/// ```
/// LocationManger()
/// It extends the CLLocationMangerDelegate class.
/// ```
///
/// - Parameters:
///     -None
///
/// - Returns: An  `LocationManger Object`.
class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    static let shared = LocationManager()
    @Published var userLocation: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
}

extension LocationManager : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {return}
        self.userLocation = location.coordinate
        locationManager.stopUpdatingLocation()
    }
}

