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
        
        setUpBackground()
        setUpFields()
        setUpButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController!.isNavigationBarHidden = true
        self.flightField.delegate = self
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
        
        //Gets new auth token and then gets flight status once that is successful
        LufthansaAPI.getAuthToken() {
            LufthansaAPI.getFlightStatus(flightNum: self.flightNum, date: Utils.getRepr(date: self.datePicker.date)) { flt in
                if flt == JSON.null {
                    self.displayAlert(title: "Invalid", message: "Sorry: couldn't find the flight.")
                    return
                }
                self.flight = Flight(id: self.flightNum, data: flt)
                //self.animateImage()
                
                self.performSegue(withIdentifier: "toFlight", sender: self)
            }
        }
    }
    //fix
    func animateImage(){
        UIView.animate(withDuration: 4, animations: {
            self.logoImage.frame = CGRect(x: self.view.frame.maxX + 300, y: 400, width: 300, height: 200)
        }) { (done) in
            self.logoImage.frame = CGRect(x: -300, y: 500, width: 300, height: 200)
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
