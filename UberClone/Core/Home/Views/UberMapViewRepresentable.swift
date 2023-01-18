//
//  UberMapViewRepresentable.swift
//  UberClone
//
//  Created by Rebi.boy on 18/01/2023.
//

import Foundation
import SwiftUI
import MapKit

/// Produce a custom map view that includes `coordinators and paths`.
///
/// ```
/// UberMapViewRepresentable()
/// ```
///
/// - Parameters:
///     -None
///
/// - Returns: An  `UberMapViewRepresentable Object`.
struct UberMapViewRepresentable: UIViewRepresentable {
    let mapView = MKMapView()
    let locationManager = LocationManager()
    @EnvironmentObject var locationViewModel : LocationSearchViewModel
    
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let coordinate = locationViewModel.selectedLocationCoordinate {
            context.coordinator.addAndSelectAnnotation(withCoordinate: coordinate)
            context.coordinator.configurePolyline(withDestination: coordinate)
        }
    }
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
    
}

extension UberMapViewRepresentable {
    
    
    /// Produce a custom map coordinator that represents a  `coordinate` on the mapview.
    ///
    /// ```
    /// MapCoordinator(parent:)
    /// It sets the user's location at the center of the map view and starts updating the users location.
    /// ```
    ///
    /// - Parameters:
    ///     -parent: The parent UberMapViewRepresentable.
    ///
    /// - Returns: An  `MapCoordinator Object`.
    
    
    
    class MapCoordinator : NSObject, MKMapViewDelegate {
        
        //MARK: - Properties
        
        let parent : UberMapViewRepresentable
        var userLocationCoordinate: CLLocationCoordinate2D?
        
        //MARK: - Lifecycle
        
        init(parent:UberMapViewRepresentable){
            self.parent = parent
            super.init()
        }
        
        //MARK: - MKMapViewDelegate
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            self.userLocationCoordinate = userLocation.coordinate
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            
            parent.mapView.setRegion(region, animated: true)
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let polyline = MKPolylineRenderer(overlay: overlay)
            polyline.strokeColor = .systemBlue
            polyline.lineWidth = 6
            return polyline
        }
        
        //MARK: - Helpers
        
        func addAndSelectAnnotation(withCoordinate coordinate: CLLocationCoordinate2D) {
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            let anno = MKPointAnnotation()
            anno.coordinate = coordinate
            parent.mapView.addAnnotation(anno)
            parent.mapView.selectAnnotation(anno, animated: true)
            parent.mapView.showAnnotations(parent.mapView.annotations, animated: true)
        }
        
        func configurePolyline(withDestination coordinate: CLLocationCoordinate2D) {
            guard let userLocationCoordinate = self.userLocationCoordinate else {return}
            getDestinationRoute(from: userLocationCoordinate, to: coordinate) { route in
                self.parent.mapView.addOverlay(route.polyline)
                
            }
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
                completion(route)
            }
        }
        
    }
    
}


