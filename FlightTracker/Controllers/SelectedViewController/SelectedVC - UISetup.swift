//
//  SelectedVC - UISetup.swift
//  FlightTracker
//
//  Created by Candace Chiang on 3/7/19.
//  Copyright © 2019 Candace Chiang. All rights reserved.
//

import UIKit

extension SelectedViewController {
    func setUpBackground() {
        backgroundImage = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        backgroundImage.image = UIImage(named: "pixel_sky")
        backgroundImage.alpha = 0.25
        backgroundImage.contentMode = .scaleAspectFill
        view.addSubview(backgroundImage)
    }
    
    func setUpToggle() {
        let items = ["Departures", "Arrivals"]
        toggleButton = UISegmentedControl(items: items)
        toggleButton.frame = CGRect(x: 0, y: 0, width: 200, height: 25)
        toggleButton.center = CGPoint(x: view.frame.width/2, y: mapView.frame.maxY + view.frame.height/50)
        toggleButton.addTarget(self, action: #selector(toggle), for: .valueChanged)
        toggleButton.selectedSegmentIndex = 0
        view.addSubview(toggleButton)
        view.bringSubviewToFront(toggleButton)
    }
    
    func setUpTable() {
        tableView = UITableView(frame: CGRect(x: 0, y: toggleButton.frame.maxY, width: view.frame.width, height: view.frame.height * 2/3 - self.navigationController!.navigationBar.frame.height))
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "tableCell")
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.rowHeight = view.frame.height/16
        tableView.backgroundColor = UIColor.clear
        //tableView.backgroundColor = UIColor(hexString: "#2ECCFA")
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: view.frame.height/10, right: 0)
        view.addSubview(tableView)
    }
    
    func showLabel() {
        noneLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height/2))
        noneLabel!.center = CGPoint(x: view.frame.width/2, y: view.frame.height * 2/3)
        noneLabel!.text = "No flights!"
        noneLabel!.font = UIFont(name: "VT323-Regular", size: 30)
        noneLabel!.textAlignment = .center
        view.addSubview(noneLabel!)
    }
}
