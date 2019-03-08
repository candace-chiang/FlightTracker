//
//  FavoritesViewController.swift
//  FlightTracker
//
//  Created by Candace Chiang on 3/8/19.
//  Copyright © 2019 Candace Chiang. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    var backgroundImage: UIImageView!
    var tableView: UITableView!
    var flights: [Flight]! = []
    
    var selected: Flight!

    override func viewDidLoad() {
        super.viewDidLoad()

        loadFavorites()
        setUpBackground()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController!.isNavigationBarHidden = true
        loadFavorites()
    }
    
    func loadFavorites() {
        flights = []
        var num = UserDefaults.standard.integer(forKey: "favoritesCount")
        while num > 0 {
            let num1 = num - 1
            let num2 = num - 2
            let flightNumber = UserDefaults.standard.string(forKey: "\(num2)")
            let date = UserDefaults.standard.string(forKey: "\(num1)")
            LufthansaAPI.getAuthToken {
                LufthansaAPI.getFlightStatus(flightNum: flightNumber!, date: date!) { flt in
                    let json = flt["FlightStatusResource"]["Flights"]["Flight"]
                    let flight = Flight(id: flightNumber!, data: json)
                    self.flights.append(flight)
                    if num - 2 < 0 {
                        self.setUpTable()
                    }
                }
            }
            num = num - 2
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let flightVC = segue.destination as? FlightViewController {
            flightVC.flight = selected
        }
    }
}
