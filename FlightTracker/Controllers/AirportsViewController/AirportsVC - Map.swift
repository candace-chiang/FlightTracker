//
//  AirportsVC - Map.swift
//  FlightTracker
//
//  Created by Candace Chiang on 3/6/19.
//  Copyright © 2019 Candace Chiang. All rights reserved.
//

import UIKit
import MapKit
import JGProgressHUD

extension AirportsViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Airport else {
            return nil
        }
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
    func setUpMap() {
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Loading"
        hud.show(in: view)
        hud.dismiss(afterDelay: 5.0)
        
        mapView = MKMapView(frame: view.frame)
        mapView.centerCoordinate = CLLocationCoordinate2D(latitude: 48.8566, longitude: 2.349014)
        mapView.mapType = .standard
        mapView.setUserTrackingMode(.follow, animated: true)
        
        LufthansaAPI.getAuthToken() {
            LufthansaAPI.getAllAirports() { airports in
                self.airports = airports
                self.updateMapView()
            }
        }
        view.addSubview(mapView)
    }
    
    func updateMapView() {
        for airport in airports {
            mapView.addAnnotation(airport)
        }
    }
}
