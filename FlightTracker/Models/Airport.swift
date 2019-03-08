//
//  Airport.swift
//  FlightTracker
//
//  Created by Candace Chiang on 3/6/19.
//  Copyright © 2019 Candace Chiang. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class Airport: NSObject, MKAnnotation {
    var title: String!
    var subtitle: String!
    var coordinate: CLLocationCoordinate2D
    
    init(code: String) {
        self.subtitle = code
        self.coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    }
    
    init(lat: Float, lon: Float, code: String, name: String) {
        self.title = name
        self.subtitle = code
        self.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(exactly: lat)!, longitude: CLLocationDegrees(exactly: lon)!)
    }
}
