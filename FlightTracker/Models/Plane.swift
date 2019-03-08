//
//  Plane.swift
//  FlightTracker
//
//  Created by Candace Chiang on 3/6/19.
//  Copyright © 2019 Candace Chiang. All rights reserved.
//

import UIKit
class Plane {
    var id: String!
    var image: UIImage!
    var name: String!
    
    init(id: String) {
        self.id = id
    }
    
    init(id: String, img: UIImage) {
        self.id = id
        self.image = img
    }
}
