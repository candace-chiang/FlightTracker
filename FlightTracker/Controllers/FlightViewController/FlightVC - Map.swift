//
//  FlightVC - Map.swift
//  FlightTracker
//
//  Created by Candace Chiang on 3/6/19.
//  Copyright © 2019 Candace Chiang. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

extension FlightViewController: MKMapViewDelegate {
    func setUpMap() {
        mapView = MKMapView(frame: CGRect(x: 0, y: UIApplication.shared.statusBarFrame.maxY, width: view.frame.width, height: view.frame.height-UIApplication.shared.statusBarFrame.maxY))
        mapView.mapType = .standard
        mapView.setUserTrackingMode(.follow, animated: true)
        
        LufthansaAPI.getAirportCoordinates(code: self.flight.arrive.code) {
            arrive in
            LufthansaAPI.getAirportCoordinates(code: self.flight.depart.code) {
                depart in
                self.flight.arrive = arrive
                self.flight.depart = depart
            }
        }
        
        let depart = MKPointAnnotation()
        depart.coordinate = (flight.depart.location?.coordinate)!
        depart.title = flight.depart.code
        mapView.addAnnotation(depart)
        
        let arrive = MKPointAnnotation()
        arrive.coordinate = (flight.arrive.location?.coordinate)!
        arrive.title = flight.arrive.code
        mapView.addAnnotation(arrive)
        
        view.addSubview(mapView)
        
        mapView.showAnnotations([depart, arrive], animated: true)
        let coordinates = [depart.coordinate, arrive.coordinate]
        mapView.addOverlay(MKGeodesicPolyline(coordinates: coordinates, count: coordinates.count))
        
    }
    
}
