//
//  Airport.swift
//  FlightTracker
//
//  Created by Candace Chiang on 3/6/19.
//  Copyright © 2019 Candace Chiang. All rights reserved.
//

import Foundation
import CoreLocation

class Airport {
    var code: String!
    var location: CLLocation!
    var name: String!
    
    init(code: String) {
        self.code = code
    }
    
    init(lat: Float, lon: Float, code: String, name: String) {
        self.code = code
        self.location = CLLocation(latitude: CLLocationDegrees(exactly: lat)!, longitude: CLLocationDegrees(exactly: lon)!)
        self.name = name
    }
}
