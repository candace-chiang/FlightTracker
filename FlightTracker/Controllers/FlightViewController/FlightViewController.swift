//
//  FlightViewController.swift
//  FlightTracker
//
//  Created by Candace Chiang on 3/6/19.
//  Copyright © 2019 Candace Chiang. All rights reserved.
//

import UIKit
import MapKit

class FlightViewController: UIViewController {
    
    var flight: Flight!
    var mapView: MKMapView!
    
    var flightStatus: UILabel!
    var flightNumber: UILabel!
    
    var bigDepart: UILabel!
    var smallDepart: UILabel?
    var bigArrive: UILabel!
    var smallArrive: UILabel?
    
    var departAirport: UILabel!
    var arriveAirport: UILabel!
    var airportArrow: UIImageView!
    
    var plane: UIImageView!
    var planeName: UILabel!
    
    var departTermGate: UILabel!
    var arriveTermGate: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpMap()
        //setUpInfo()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.mapView.delegate = self
    }

}
