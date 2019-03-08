//
//  SelectedViewController.swift
//  FlightTracker
//
//  Created by Candace Chiang on 3/7/19.
//  Copyright © 2019 Candace Chiang. All rights reserved.
//

import UIKit
import MapKit

class SelectedViewController: UIViewController {
    
    var backgroundImage: UIImageView!
    
    var airport: Airport!
    var departures: [Flight] = []
    var arrivals: [Flight] = []
    var flights: [Flight]!

    var mapView: MKMapView!
    var toggleButton: UISegmentedControl!
    var tableView: UITableView!
    
    var noneLabel: UILabel?
    
    var selected: Flight!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getFlights()
        setUpBackground()
        setUpMap()
        setUpToggle()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController!.isNavigationBarHidden = false
        self.navigationItem.title = "\(airport.title!)"
        self.mapView.delegate = self
    }
    
    func getFlights() {
        let current = Date.init(timeIntervalSinceNow: 0)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.string(from: current) + "T12:00"
        LufthansaAPI.getFlightsFrom(type: "departures", code: "\(self.airport.subtitle!)", date: "\(date)") { deps in
            //self.label.text = flt.timeStatus
            self.departures = deps
            LufthansaAPI.getFlightsFrom(type: "arrivals", code: "\(self.airport.subtitle!)", date: "\(date)") { arrs in
                self.arrivals = arrs
                self.flights = deps
                self.setUpTable()
            }
        }
    }
    
    @objc func toggle(_ segmentedControl: UISegmentedControl) {
        if tableView == nil {
            return
        }
        switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            flights = departures
            tableView.reloadData()
            break
        case 1:
            flights = arrivals
            tableView.reloadData()
            break
        default:
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let flightVC = segue.destination as? FlightViewController {
            flightVC.flight = selected
        }
    }
}
