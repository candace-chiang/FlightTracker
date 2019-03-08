//
//  RequestViewController.swift
//  FlightTracker
//
//  Created by Candace Chiang on 3/5/19.
//  Copyright © 2019 Candace Chiang. All rights reserved.
//

import UIKit
import SwiftyJSON

class RequestViewController: UIViewController, UITextFieldDelegate {
    
    var backgroundImage: UIImageView!
    var logoImage: UIImageView!
    var nameLabel: UILabel!
    var titleLabel: UILabel!
    
    var flightField: UITextField!
    var datePicker: UIDatePicker!
    var button: UIButton!
    
    var flightNum = ""
    var flight: Flight!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
        
        setUpBackground()
        setUpFields()
        setUpButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController!.isNavigationBarHidden = true
        self.flightField.delegate = self
        self.button.isUserInteractionEnabled = true
        
        if flightNum != "" {
            self.flightField.text = flightNum
        }
    }
    
    //dismiss keyboard when you press somewhere else
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //dismiss keyboard when you press return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //text stuff
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = nil
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if flightNum == "" {
            textField.text = "Flight Number"
        }
    }
    
    @objc func flightEntered(_ sender: UITextField) {
        flightNum = sender.text!
    }
    
    
    @objc func search(_ sender: Any) {
        if flightNum == "" {
            displayAlert(title: "Incomplete", message: "Enter a flight number.")
        }
        
        button.isUserInteractionEnabled = false
        
        //Gets new auth token and then gets flight status once that is successful
        LufthansaAPI.getAuthToken() {
            LufthansaAPI.getFlightStatus(flightNum: self.flightNum, date: Utils.getRepr(date: self.datePicker.date)) { flt in
                let json = flt["FlightStatusResource"]["Flights"]["Flight"]
                if json == JSON.null {
                    self.displayAlert(title: "Invalid", message: "No such flight.")
                    return
                }
                self.flight = Flight(id: self.flightNum, data: json)
                
                self.performSegue(withIdentifier: "toFlight", sender: self)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let flightVC = segue.destination as! FlightViewController
        flightVC.flight = flight
    }
    
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
