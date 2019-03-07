//
//  LufthansaAPI.swift
//  FlightTracker
//
//  Created by Candace Chiang on 3/5/19.
//  Copyright © 2019 Candace Chiang. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class LufthansaAPI {
    //These are where we will store all of the authentication information. Get these from your account at developer.lufthansa.com.
    static let clientSecret = "CqwFd4QMJX"
    static let clientID = "cemmea24ebxpjuhb3akrvwry"
    
    //This variable will store the session's auth token that we will get from getAuthToken()
    static var authToken: String?
    
    //This function will request an auth token from the lufthansa servers
    static func getAuthToken(completion: @escaping () -> ()){
        
        //This is the information that will be sent to the server to authenticate our device
        let requestURL = "https://api.lufthansa.com/v1/oauth/token"
        let parameters = ["client_id": "\(clientID)", "client_secret": "\(clientSecret)", "grant_type": "client_credentials"]
        
        //This is the POST request made to the lufthansa servers to get the authToken for this session.
        Alamofire.request(requestURL, method: .post, parameters: parameters, encoding: URLEncoding()).responseJSON { response in
            
            //Converts response to JSON object and sets authToken variable to appropriate value
            let json = JSON(response.result.value)
            self.authToken = json["access_token"].stringValue
            
            print("Auth token: " + self.authToken!)
            print("This key expires in " + json["expires_in"].stringValue + " seconds\n")
            
            //Runs completion closure
            completion()
        }
    }
    
    //This function will get the status for a flight. FlightNum format "LHXXX" Date format "YYYY-MM-DD"
    static func getFlightStatus(flightNum: String, date: String, completion: @escaping (JSON) -> ()){
        
        //Request URL and authentication parameters
        let requestURL = "https://api.lufthansa.com/v1/operations/flightstatus/\(flightNum)/\(date)"
        let parameters: HTTPHeaders = ["Accept":"application/json", "Authorization":"Bearer \(self.authToken!)"]
        
        //print("PARAMETERS FOR REQUEST:")
        //print(parameters)
        //print("\n")
        
        Alamofire.request(requestURL, headers: parameters).responseJSON { response in
            //Makes sure that response is valid
            guard response.result.isSuccess else {
                print(response.result.error.debugDescription)
                return
            }
            //Creates JSON object
            let json = JSON(response.result.value) //FIXME
            print(json)
            //Create new flight model and populate data
            
            completion(json)
        }
    }
    
    static func getAirportCoordinates(code: String, completion: @escaping (Airport) -> ()) {
        let requestURL = "https://api.lufthansa.com/v1/references/airports/\(code)?limit=20&offset=0&LHoperated=0"
        let parameters: HTTPHeaders = ["Accept":"application/json", "Authorization":"Bearer \(self.authToken!)"]
        
        Alamofire.request(requestURL, headers: parameters).responseJSON { response in
            //Makes sure thhat response is valid
            guard response.result.isSuccess else {
                print(response.result.error.debugDescription)
                return
            }
            //Creates JSON object
            let json = JSON(response.result.value)
            print(json)
            
            let lat = json["AirportResource"]["Airports"]["Airport"]["Position"]["Coordinate"]["Latitude"].floatValue
            let lon = json["AirportResource"]["Airports"]["Airport"]["Position"]["Coordinate"]["Longitude"].floatValue
            let name = json["AirportResource"]["Airports"]["Airport"]["Names"]["Name"].arrayValue[1]["$"].stringValue
            let airport = Airport(lat: lat, lon: lon, code: code, name: name)
            completion(airport)
        }
    }
    
    static func getAllAirports(completion: @escaping ([Airport]) -> ()){
        let requestURL = "https://api.lufthansa.com/v1/references/airports/?limit=20&offset=0&LHoperated=0"
        let parameters: HTTPHeaders = ["Authorization": "Bearer \(authToken!)", "Accept": "application/json"]
        
        Alamofire.request(requestURL, headers: parameters).responseJSON { response in
            //Makes sure thhat response is valid
            guard response.result.isSuccess else {
                print(response.result.error.debugDescription)
                return
            }
            //Creates JSON object
            let json = JSON(response.result.value)
            print(json)
            //Create new flight model and populate data
            var airports : [Airport] = []
            for i in 0...19 {
                let code = json["AirportResource"]["Airports"]["Airport"][i]["AirportCode"].stringValue
                let name = json["AirportResource"]["Airports"]["Airport"][i]["Names"]["Name"][0]["$"].stringValue
                let lat = json["AirportResource"]["Airports"]["Airport"][i]["Position"]["Coordinate"]["Latitude"].floatValue
                
                let lon = json["AirportResource"]["Airports"]["Airport"][i]["Position"]["Coordinate"]["Longitude"].floatValue
                airports.append(Airport(lat: lat, lon: lon, code: code, name: name))
            }
            completion(airports)
        }
    }
}
