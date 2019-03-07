//
//  FlightVC - UISetup.swift
//  FlightTracker
//
//  Created by Candace Chiang on 3/6/19.
//  Copyright © 2019 Candace Chiang. All rights reserved.
//
/*
 var flightStatus: UILabel!
 var flightNumber: UILabel!
 
 var timingPane: UIView!
 
 var bigDepart: UILabel!
 var smallDepart: UILabel?
 var bigArrive: UILabel!
 var smallArrive: UILabel?
 
 var srcAirportCode: UILabel!
 var desAirportCode: UILabel!
 var airportArrow: UIImageView!
 
 var plane: UIImageView!
 var planeName: UILabel!
 
 var departTermGate: UILabel!
 var arriveTermGate: UILabel!
 */

import UIKit

extension FlightViewController {
    func setUpInfo() {
        flightStatus = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width * 3/4, height: view.frame.height/14))
        flightStatus.center = CGPoint(x: view.frame.width/2, y: view.frame.height * 0.55)
        flightStatus.text = flight.flightStatus
        flightStatus.font = UIFont(name: "SourceSansPro", size: 16)
        flightStatus.textAlignment = .center
        view.addSubview(flightStatus)
    }
}
