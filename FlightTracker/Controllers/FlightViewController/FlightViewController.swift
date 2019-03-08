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
    
    var backgroundImage: UIImageView!
    
    var statusLabel: UILabel!
    var planeImage: UIImageView!
    var planeLabel: UILabel!
    
    var arrowImage: UIImageView!
    
    var bigDepart: UILabel!
    var smallDepart: UILabel!
    var bigArrive: UILabel!
    var smallArrive: UILabel!
    
    var departLabel: UILabel!
    var arriveLabel: UILabel!
    
    var departTermGate: UILabel!
    var arriveTermGate: UILabel!
    
    var favorite = false
    var favoriteButton: UIBarButtonItem!
    
    var selected: Airport!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpBackground()
        setUpFavorites()
        setUpMap()
        setUpStatus()
        setUpImage()
        setUpInfo()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController!.isNavigationBarHidden = false
        self.title = flight.id
        self.mapView.delegate = self
    }
    
    @objc func favoriteFlight() {
        favorite = true
        let count = UserDefaults.standard.integer(forKey: "favoritesCount")
        let newCount = count + 1
        UserDefaults.standard.set(flight.id, forKey: "\(count)")
        UserDefaults.standard.set(flight.date, forKey: "\(newCount)")
        UserDefaults.standard.set(newCount + 1, forKey: "favoritesCount")
        favoriteButton = UIBarButtonItem(title: "Saved", style: .plain, target: self, action: nil)
        self.navigationItem.setRightBarButton(favoriteButton, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectedVC = segue.destination as? SelectedViewController {
            selectedVC.airport = selected
        }
        
    }
}
