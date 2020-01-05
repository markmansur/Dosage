//
//  DayOfWeekCell.swift
//  Dosage
//
//  Created by Mark Mansur on 2020-01-01.
//  Copyright © 2020 Mark Mansur. All rights reserved.
//

import UIKit

class DayOfWeekCell: UICollectionViewCell {
    var dayOfWeek: DayOfWeek? {
        didSet {
            switch dayOfWeek {
            case .sunday:
                dayOfWeekLabel.text = "S"
            case .monday:
                dayOfWeekLabel.text = "M"
            case .tuesday:
                dayOfWeekLabel.text = "T"
            case .wednesday:
                dayOfWeekLabel.text = "W"
            case .thursday:
                dayOfWeekLabel.text = "T"
            case .friday:
                dayOfWeekLabel.text = "F"
            case .saturday:
                dayOfWeekLabel.text = "S"
            default:
                break
            }
        }
    }
    let dayOfWeekLabel = UILabel(textColor: UIColor(named: "darkGreen"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupLabel()
        setupShadow()
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.5
        layer.cornerRadius = 12
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLabel() {
        addSubview(dayOfWeekLabel)
        dayOfWeekLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        dayOfWeekLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    private func setupShadow() {
        layer.shadowColor = UIColor(named: "darkGreen")?.cgColor
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.08
        layer.shadowOffset = CGSize(width: -10, height: -5)
        layer.masksToBounds = false
    }
    
    func highlight() {
        backgroundColor = UIColor(named: "darkGreen")
        dayOfWeekLabel.textColor = .white
    }
    
    func unHighlight() {
        backgroundColor = .white
        dayOfWeekLabel.textColor = UIColor(named: "darkGreen")
    }
}
