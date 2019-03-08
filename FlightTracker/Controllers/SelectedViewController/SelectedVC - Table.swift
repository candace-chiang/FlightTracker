//
//  SelectedVC - Table.swift
//  FlightTracker
//
//  Created by Candace Chiang on 3/7/19.
//  Copyright © 2019 Candace Chiang. All rights reserved.
//

import UIKit

extension SelectedViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flights.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height/16
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell") as! TableViewCell
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        cell.awakeFromNib()
        cell.contentView.backgroundColor = UIColor.clear
        let size = CGSize(width: tableView.frame.width, height: view.frame.height/16)
        cell.initCellFrom(size: size)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if flights.count == 0 {
            showLabel()
        } else {
            noneLabel = nil
        }
        
        let tableCell = cell as! TableViewCell
        let flight = flights[indexPath.row]
        
        tableCell.backgroundColor = UIColor.clear
        tableCell.arriveLabel.text = flight.arrive.subtitle
        tableCell.departLabel.text = flight.depart.subtitle
        tableCell.flightLabel.text = flight.id
        if toggleButton.selectedSegmentIndex == 0 {
            tableCell.timeLabel.text = "Departs: " + flight.departScheduled
        } else {
            tableCell.timeLabel.text = "Arrives: " + flight.arriveScheduled
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected = flights[indexPath.row]
        performSegue(withIdentifier: "toFlight", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

