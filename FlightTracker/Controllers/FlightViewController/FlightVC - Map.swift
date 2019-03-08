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
        mapView = MKMapView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 3/5))
        mapView.mapType = .standard
        mapView.setUserTrackingMode(.follow, animated: true)
        
        LufthansaAPI.getAirportCoordinates(code: self.flight.arrive.subtitle) { arrive in
            LufthansaAPI.getAirportCoordinates(code: self.flight.depart.subtitle) { depart in
                self.flight.arrive = arrive
                self.flight.depart = depart
                self.updateMapView()
            }
        }
        view.addSubview(mapView)
    }
    
    func updateMapView() {
        let depart = airportAnnotation(airport: flight.depart)
        depart.coordinate = (flight.depart.coordinate)
        depart.title = flight.depart.title
        mapView.addAnnotation(depart)
        
        let arrive = airportAnnotation(airport: flight.arrive)
        arrive.coordinate = (flight.arrive.coordinate)
        arrive.title = flight.arrive.title
        mapView.addAnnotation(arrive)
        
        mapView.showAnnotations([depart, arrive], animated: true)
        let coordinates = [depart.coordinate, arrive.coordinate]
        mapView.addOverlay(MKGeodesicPolyline(coordinates: coordinates, count: coordinates.count), level: .aboveRoads)
    }
    
    func mapView(_ mapView: MKMapView!, rendererFor overlay: MKOverlay!) -> MKOverlayRenderer! {
        let polylineRenderer = MKPolylineRenderer(overlay: overlay)
        polylineRenderer.strokeColor = UIColor(hexString: "#00BFFF")
        polylineRenderer.lineWidth = 5
        return polylineRenderer
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let annotation = view.annotation as! airportAnnotation
        selected = annotation.airport
        performSegue(withIdentifier: "toAirport", sender: self)
    }
}
