//
//  AirportsViewController.swift
//  FlightTracker
//
//  Created by Candace Chiang on 3/6/19.
//  Copyright © 2019 Candace Chiang. All rights reserved.
//

import UIKit
import MapKit

class AirportsViewController: UIViewController {
    
    var mapView: MKMapView!
    var airports: [Airport]!
    var selected: Airport!

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpMap()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController!.isNavigationBarHidden = true
        self.mapView.delegate = self
    }
    
    func mapView(_ mapView: MKMapView, annotationView: MKAnnotationView, calloutAccessoryControlTapped: UIControl) {
        selected = annotationView.annotation as? Airport
        performSegue(withIdentifier: "toAirport", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectedVC = segue.destination as? SelectedViewController {
            selectedVC.airport = selected
        }
        
    }
}
