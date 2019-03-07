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
    
    init(id: String, data: JSON) {
        let info = data["FlightStatusResource"]["Flights"]["Flight"]
        
        self.id = id
        flightStatus = info["FlightStatus"]["Definition"].stringValue
        plane = Plane(id: info["Equipment"]["AircraftCode"].stringValue)
        
        depart = Airport(code: info["Departure"]["AirportCode"].stringValue)
        arrive = Airport(code: info["Arrival"]["AirportCode"].stringValue)
        
        departTerm = info["Departure"]["Terminal"]["Name"].stringValue
        if departTerm == nil {
            departTerm = "--"
        }
        
        departGate = info["Departure"]["Terminal"]["Gate"].stringValue
        if departGate == nil {
            departGate = "--"
        }
        
        arriveTerm = info["Arrival"]["Terminal"]["Name"].stringValue
        if arriveTerm == nil {
            arriveTerm = "--"
        }
        
        arriveGate = info["Arrival"]["Terminal"]["Gate"].stringValue
        if arriveGate == nil {
            arriveGate = "--"
        }
        
        departScheduled = Utils.cleanDate(info["Departure"]["ScheduledTimeLocal"]["DateTime"].stringValue)
        
        departActual = info["Departure"]["ActualTimeLocal"]["DateTime"].stringValue
        if departActual != nil {
            departActual = Utils.cleanDate(departActual)
        }
        
        arriveScheduled = Utils.cleanDate(info["Arrival"]["ScheduledTimeLocal"]["DateTime"].stringValue)
        
        arriveActual = info["Arrival"]["ActualTimeLocal"]["DateTime"].stringValue
        if arriveActual != nil {
            arriveActual = Utils.cleanDate(arriveActual)
        }

    }
}
