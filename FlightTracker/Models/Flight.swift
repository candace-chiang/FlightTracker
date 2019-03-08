//
//  Flight.swift
//  FlightTracker
//
//  Created by Candace Chiang on 3/5/19.
//  Copyright © 2019 Candace Chiang. All rights reserved.
//

import Foundation
import SwiftyJSON

class Flight {
    
    var id: String!
    var flightStatus: String!
    var plane: Plane!
    
    var depart: Airport!
    var arrive: Airport!
    
    var departGate: String!
    var departTerm: String!
    var arriveGate: String!
    var arriveTerm: String!
    
    var departScheduled: String!
    var departActual: String!
    var arriveScheduled: String!
    var arriveActual: String!
    
    var date: String!
    
    init(id: String, data: JSON) {
        self.id = id
        flightStatus = data["FlightStatus"]["Definition"].stringValue
        plane = Plane(id: data["Equipment"]["AircraftCode"].stringValue)
        
        depart = Airport(code: data["Departure"]["AirportCode"].stringValue)
        arrive = Airport(code: data["Arrival"]["AirportCode"].stringValue)
        
        departTerm = data["Departure"]["Terminal"]["Name"].stringValue
        if departTerm == "" {
            departTerm = "--"
        }
        
        departGate = data["Departure"]["Terminal"]["Gate"].stringValue
        if departGate == "" {
            departGate = "--"
        }
        
        arriveTerm = data["Arrival"]["Terminal"]["Name"].stringValue
        if arriveTerm == "" {
            arriveTerm = "--"
        }
        
        arriveGate = data["Arrival"]["Terminal"]["Gate"].stringValue
        if arriveGate == "" {
            arriveGate = "--"
        }
        
        departScheduled = Utils.cleanDate(data["Departure"]["ScheduledTimeLocal"]["DateTime"].stringValue)
        
        departActual = data["Departure"]["ActualTimeLocal"]["DateTime"].stringValue
        if departActual != "" {
            departActual = Utils.cleanDate(departActual)
        } else {
            departActual = "N/A"
        }
        
        arriveScheduled = Utils.cleanDate(data["Arrival"]["ScheduledTimeLocal"]["DateTime"].stringValue)
        
        arriveActual = data["Arrival"]["ActualTimeLocal"]["DateTime"].stringValue
        if arriveActual != "" {
            arriveActual = Utils.cleanDate(arriveActual)
        } else {
            arriveActual = "N/A"
        }
        
        let dateString = data["Departure"]["ScheduledTimeLocal"]["DateTime"].stringValue
        let index = dateString.index(dateString.startIndex, offsetBy: 10)
        date = String(dateString[..<index])
    }
}
