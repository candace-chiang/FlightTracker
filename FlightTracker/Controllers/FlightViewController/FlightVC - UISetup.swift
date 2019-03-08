//
//  FlightVC - UISetup.swift
//  FlightTracker
//
//  Created by Candace Chiang on 3/6/19.
//  Copyright © 2019 Candace Chiang. All rights reserved.
//

import UIKit

extension FlightViewController {
    func setUpBackground() {
        backgroundImage = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        backgroundImage.image = UIImage(named: "pixel_sky")
        backgroundImage.alpha = 0.25
        backgroundImage.contentMode = .scaleAspectFill
        view.addSubview(backgroundImage)
    }
    
    func setUpFavorites() {
        favoriteButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(favoriteFlight))
        self.navigationItem.setRightBarButton(favoriteButton, animated: true)
    }
    
    func setUpStatus() {
        statusLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width * 3/4, height: view.frame.height/14))
        statusLabel.center = CGPoint(x: view.frame.width/2, y: mapView.frame.maxY + view.frame.height/30)
        statusLabel.text = "✈    " + flight.flightStatus
        statusLabel.font = UIFont(name: "SourceSansPro-Bold", size: 30)
        statusLabel.textAlignment = .center
        view.addSubview(statusLabel)
        
        planeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height/20))
        planeLabel.center = CGPoint(x: view.frame.width/2, y: statusLabel.frame.maxY)
        LufthansaAPI.getAircraft(code: self.flight.plane.id) { plane in
            self.flight.plane = plane
            if plane.name == "" {
                self.planeLabel.text = "Not Available"
            } else {
                self.planeLabel.text = plane.name
            }
        }
        planeLabel.font = UIFont(name: "SourceSansPro-Regular", size: 18)
        planeLabel.textAlignment = .center
        view.addSubview(planeLabel)
    }
    
    func setUpImage() {
        arrowImage = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width/4, height: view.frame.height/12))
        arrowImage.center = CGPoint(x: view.frame.width/2, y: planeLabel.frame.maxY + view.frame.height/12)
        arrowImage.image = UIImage(named: "arrow")
        arrowImage.contentMode = .scaleAspectFit
        view.addSubview(arrowImage)
    }
    
    func setUpInfo() {
        let leftCenter = arrowImage.frame.minX/2 + view.frame.width/30
        let rightCenter = (arrowImage.frame.maxX + view.frame.width)/2 - view.frame.width/30
        let width = view.frame.width/3
        
        departLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: view.frame.height/25))
        departLabel.center = CGPoint(x: leftCenter, y: arrowImage.frame.minY)
        departLabel.text = flight.depart.subtitle
        departLabel.font = UIFont(name: "SourceSansPro-Bold", size: 28)
        departLabel.textAlignment = .center
        view.addSubview(departLabel)
        
        arriveLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: view.frame.height/25))
        arriveLabel.center = CGPoint(x: rightCenter, y: arrowImage.frame.minY)
        arriveLabel.text = flight.arrive.subtitle
        arriveLabel.font = UIFont(name: "SourceSansPro-Bold", size: 28)
        arriveLabel.textAlignment = .center
        view.addSubview(arriveLabel)
        
        departTermGate = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: view.frame.height/30))
        departTermGate.center = CGPoint(x: leftCenter, y: departLabel.frame.maxY + view.frame.height/60)
        departTermGate.text = "Term. " + flight.departTerm + " / " + "Gate " + flight.departGate
        departTermGate.font = UIFont(name: "SourceSansPro-Regular", size: 17)
        departTermGate.textAlignment = .center
        view.addSubview(departTermGate)
        
        arriveTermGate = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: view.frame.height/30))
        arriveTermGate.center = CGPoint(x: rightCenter, y: departLabel.frame.maxY + view.frame.height/60)
        arriveTermGate.text = "Term. " + flight.arriveTerm + " / " + "Gate " + flight.arriveGate
        arriveTermGate.font = UIFont(name: "SourceSansPro-Regular", size: 17)
        arriveTermGate.textAlignment = .center
        view.addSubview(arriveTermGate)
        
        bigDepart = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: view.frame.height/25))
        bigDepart.center = CGPoint(x: leftCenter, y: departTermGate.frame.maxY + view.frame.height/30)
        bigDepart.font = UIFont(name: "SourceSansPro-Bold", size: 24)
        bigDepart.textColor = UIColor(hexString: "#0B2161")
        bigDepart.textAlignment = .center
        
        smallDepart = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: view.frame.height/25))
        smallDepart.center = CGPoint(x: leftCenter, y: bigDepart.frame.maxY + view.frame.height/80)
        smallDepart.font = UIFont(name: "SourceSansPro-Regular", size: 15)
        smallDepart.textAlignment = .center
        
        if flight.departActual != "N/A" {
            bigDepart.text = flight.departActual
            smallDepart.text = "Scheduled: " + flight.departScheduled
        } else {
            bigDepart.text = flight.departScheduled
            smallDepart.text = "Scheduled"
        }
        
        view.addSubview(bigDepart)
        view.addSubview(smallDepart)
        
        bigArrive = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: view.frame.height/25))
        bigArrive.center = CGPoint(x: rightCenter, y: departTermGate.frame.maxY + view.frame.height/30)
        bigArrive.font = UIFont(name: "SourceSansPro-Bold", size: 24)
        bigArrive.textColor = UIColor(hexString: "#0B2161")
        bigArrive.textAlignment = .center
        
        smallArrive = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: view.frame.height/25))
        smallArrive.center = CGPoint(x: rightCenter, y: bigDepart.frame.maxY + view.frame.height/80)
        smallArrive.font = UIFont(name: "SourceSansPro-Regular", size: 15)
        smallArrive.textAlignment = .center
        
        if flight.arriveActual != "N/A" {
            bigArrive.text = flight.arriveActual
            smallArrive.text = "Scheduled: " + flight.arriveScheduled
        } else {
            bigArrive.text = flight.arriveScheduled
            smallArrive.text = "Scheduled"
        }
        
        view.addSubview(bigArrive)
        view.addSubview(smallArrive)
    }
}
