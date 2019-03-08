//
//  RequestVC - UISetup.swift
//  FlightTracker
//
//  Created by Candace Chiang on 3/5/19.
//  Copyright © 2019 Candace Chiang. All rights reserved.
//

import UIKit

extension RequestViewController {
    func setUpBackground() {
        backgroundImage = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        backgroundImage.image = UIImage(named: "blue_sky")
        backgroundImage.alpha = 0.8
        backgroundImage.contentMode = .scaleAspectFill
        view.addSubview(backgroundImage)
        
        logoImage = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width * 2/3, height: view.frame.height/6))
        logoImage.center = CGPoint(x: view.frame.width/2, y: view.frame.height/5)
        logoImage.image = UIImage(named: "plane_2")
        logoImage.contentMode = .scaleAspectFit
        view.addSubview(logoImage)
        
        nameLabel = UILabel(frame:CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height/6))
        nameLabel.center = CGPoint(x: view.frame.width/2, y: logoImage.frame.maxY + view.frame.height/15)
        nameLabel.text = "Lufthansa"
        nameLabel.textColor = .black
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont(name: "VT323-Regular", size: 80)
        view.addSubview(nameLabel)
        
        titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height/8))
        titleLabel.center = CGPoint(x: view.frame.width/2, y: nameLabel.frame.maxY)
        titleLabel.text = "Flight Tracker"
        titleLabel.font = UIFont(name: "SourceCodePro-Regular", size: 35)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        view.addSubview(titleLabel)
    }
    
    func setUpFields() {
        flightField = UITextField(frame: CGRect(x: 0, y: 0, width: view.frame.width * 4/5, height: view.frame.height/15))
        flightField.center = CGPoint(x: view.frame.width/2, y: view.frame.height * 2/3)
        flightField.font = UIFont(name: "SourceSansPro-Regular", size: 25)
        flightField.textColor = .black
        flightField.textAlignment = .center
        flightField.attributedText = NSAttributedString(string: "Flight Number",
                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        flightField.borderStyle = .none
        flightField.addTarget(self, action: #selector(flightEntered), for: .allEditingEvents)
        view.addSubview(flightField)
        
        datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: view.frame.width * 4/5, height: view.frame.height/15))
        datePicker.center = CGPoint(x: view.frame.width/2, y: flightField.frame.maxY + view.frame.height/25)
        datePicker.setValue(UIColor.black, forKeyPath: "textColor")
        datePicker.datePickerMode = .date
        view.addSubview(datePicker)
    }
    
    func setUpButton() {
        button = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.width/2, height: view.frame.height/20))
        button.center = CGPoint(x: view.frame.width/2, y: datePicker.frame.maxY + view.frame.height/12)
        button.titleLabel!.font = UIFont(name: "VT323-Regular", size: 40)
        button.setTitle("Find Flight!", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 10.0
        button.addTarget(self, action: #selector(search), for: .touchUpInside)
        view.addSubview(button)
    }
    
    
}
