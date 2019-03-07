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
        /*
        
        mapView.showAnnotations([source, destination], animated: true)
        
        var coordinates = [source.coordinate, destination.coordinate]
        
        let geodesicPolyline = MKGeodesicPolyline(coordinates: &coordinates, count: 2)
        mapView.addOverlay(geodesicPolyline)
        
        
        let paddingOfMap = 1.5
        debugPrint(UIApplication.shared.statusBarFrame.maxY)
        var latDelta = abs(destination.coordinate.latitude - source.coordinate.latitude) * paddingOfMap
        let lonDelta = abs(destination.coordinate.longitude - source.coordinate.longitude) * paddingOfMap
        
        let percentToUse = (mapView.frame.height - heightOfPane)/mapView.frame.height
        latDelta = Double(CGFloat(latDelta)/(percentToUse))
        
        if latDelta > 180 {
            latDelta = 180
        }
        
        let centerY = max(destination.coordinate.latitude,source.coordinate.latitude) - latDelta/2.8
        let centerX = (destination.coordinate.longitude + source.coordinate.longitude)/2
        
        let spanny = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        
        let centerman = CLLocationCoordinate2D(latitude: centerY, longitude: centerX)
        
        mapView.setRegion(MKCoordinateRegion(center: centerman, span: spanny), animated: true)
        
        
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let polylineRenderer = MKPolylineRenderer(overlay: overlay)
        polylineRenderer.strokeColor = Constants.DEEP_BLUE
        polylineRenderer.alpha = 0.9
        polylineRenderer.lineWidth = 5
        return polylineRenderer
    }*/
    }
    
}
