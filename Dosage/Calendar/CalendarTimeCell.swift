//
//  CalendarTimeCell.swift
//  Dosage
//
//  Created by Mark Mansur on 2020-01-17.
//  Copyright © 2020 Mark Mansur. All rights reserved.
//

import UIKit

class CalendarTimeCell: UITableViewCell {
    
    var time: Date? {
        didSet {
            
        }
    }
    
    var medication: Medication? {
        didSet {
            
        }
    }
    
    let timeLabel = UILabel(text: "9:00AM", font: .boldSystemFont(ofSize: 14))
    let medicationLabel = UILabel(text: "Advil - back pain")
    
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLabels() {
        addSubview(timeLabel)
        timeLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        timeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
        
        addSubview(medicationLabel)
        medicationLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 8).isActive = true
        medicationLabel.leftAnchor.constraint(equalTo: timeLabel.leftAnchor).isActive = true
    }
}
