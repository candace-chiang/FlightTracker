//
//  airportAnnotation.swift
//  FlightTracker
//
//  Created by Candace Chiang on 3/7/19.
//  Copyright © 2019 Candace Chiang. All rights reserved.
//

import MapKit

class airportAnnotation: MKPointAnnotation {
    var airport: Airport!
    
    init(airport: Airport) {
        self.airport = airport
    }
}
