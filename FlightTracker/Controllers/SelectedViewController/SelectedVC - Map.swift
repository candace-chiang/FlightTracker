//
//  SelectedVC - Map.swift
//  FlightTracker
//
//  Created by Candace Chiang on 3/7/19.
//  Copyright © 2019 Candace Chiang. All rights reserved.
//

import UIKit
import MapKit

extension SelectedViewController: MKMapViewDelegate {
    func setUpMap() {
        mapView = MKMapView(frame: CGRect(x: 0, y: self.navigationController!.navigationBar.frame.height, width: view.frame.width, height: view.frame.height/3))
        mapView.mapType = .standard
        mapView.setUserTrackingMode(.follow, animated: true)
        mapView.addAnnotation(airport)
        
        let region = MKCoordinateRegion(center: airport.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        self.mapView.setRegion(region, animated : true)
        view.addSubview(mapView)
    }
    
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
}
