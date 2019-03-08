//
//  TableViewCell.swift
//  FlightTracker
//
//  Created by Candace Chiang on 3/7/19.
//  Copyright © 2019 Candace Chiang. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var arrowImage: UIImageView!
    
    var departLabel: UILabel!
    var arriveLabel: UILabel!
    
    var timeLabel: UILabel!
    var flightLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func initCellFrom(size: CGSize) {
        timeLabel = UILabel(frame: CGRect(x: size.width/6, y: size.height/6, width: size.width/2, height: size.height/5))
        timeLabel.font = UIFont(name: "SourceSansPro-Regular", size: 11)
        contentView.addSubview(timeLabel)
        
        departLabel = UILabel(frame: CGRect(x: 0, y: 0, width: size.width/10, height: size.height * 2/3))
        departLabel.center = CGPoint(x: size.width/4, y: size.height * 2/3)
        departLabel.font = UIFont(name: "SourceSansPro-Bold", size: 20)
        contentView.addSubview(departLabel)
        
        arrowImage = UIImageView(frame: CGRect(x: 0, y: 0, width: size.width/8, height: size.height/5))
        arrowImage.center = CGPoint(x: departLabel.frame.maxX + size.width/16, y: departLabel.frame.midY)
        arrowImage.image = UIImage(named: "arrow")
        arrowImage.contentMode = .scaleAspectFit
        contentView.addSubview(arrowImage)
        
        arriveLabel = UILabel(frame: CGRect(x: 0, y: 0, width: size.width/8, height: size.height * 2/3))
        arriveLabel.center = CGPoint(x: arrowImage.frame.maxX + size.width/16, y: departLabel.frame.midY)
        arriveLabel.font = UIFont(name: "SourceSansPro-Bold", size: 20)
        contentView.addSubview(arriveLabel)
        
        flightLabel = UILabel(frame: CGRect(x: 0, y: 0, width: size.width/3, height: size.height))
        flightLabel.center = CGPoint(x: size.width * 4/5, y: size.height/2)
        flightLabel.font = UIFont(name: "SourceSansPro-Bold", size: 25)
        contentView.addSubview(flightLabel)
    }
}
