//
//  Utils.swift
//  FlightTracker
//
//  Created by Candace Chiang on 3/6/19.
//  Copyright © 2019 Candace Chiang. All rights reserved.
//

import Foundation

class Utils {
    static func cleanDate(_ dateString: String) -> String {
        let index = dateString.index(dateString.startIndex, offsetBy: 10)
        let next = dateString.index(dateString.startIndex, offsetBy: 11)
        return String(dateString[..<index] + " " + dateString[next...])
    }
    
    static func getRepr(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: date)
    }
}
