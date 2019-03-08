//
//  FavoritesVC - UISetup.swift
//  FlightTracker
//
//  Created by Candace Chiang on 3/8/19.
//  Copyright © 2019 Candace Chiang. All rights reserved.
//

import UIKit

extension FavoritesViewController {
    func setUpBackground() {
        backgroundImage = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        backgroundImage.image = UIImage(named: "pixel_sky")
        backgroundImage.alpha = 0.25
        backgroundImage.contentMode = .scaleAspectFill
        view.addSubview(backgroundImage)
    }
    
    func setUpTable() {
        flights.sort(by: { $0.date + $0.departScheduled > $1.date + $1.departScheduled })
        
        if tableView != nil {
            tableView.reloadData()
        } else {
            tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
            tableView.register(TableViewCell.self, forCellReuseIdentifier: "tableCell")
            tableView.delegate = self
            tableView.dataSource = self
            tableView.rowHeight = view.frame.height/16
            tableView.backgroundColor = UIColor.clear
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: view.frame.height/10, right: 0)
            view.addSubview(tableView)
        }
    }
}
