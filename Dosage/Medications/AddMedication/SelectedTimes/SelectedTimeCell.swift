//
//  SelectedTimeCell.swift
//  Dosage
//
//  Created by Mark Mansur on 2020-01-03.
//  Copyright © 2020 Mark Mansur. All rights reserved.
//

import UIKit

class SelectedTimeCell: UICollectionViewCell {
    var time: Time? {
        didSet {
            guard let hour = time?.hour else { return }
            guard let min = time?.min else { return }
            guard let isPM = time?.isPM else { return }
            
            timeLabel.text = "\(hour):\(min)\(isPM ? "PM" : "AM")"
        }
    }
    let deleteButton: UIButton = {
        if #available(iOS 13.0, *) {
            let config = UIImage.SymbolConfiguration(pointSize: 6, weight: .regular, scale: .large)
            let symbolImage = UIImage(systemName: "xmark", withConfiguration: config)
            let button = UIButton()
            button.setImage(symbolImage, for: .normal)
            button.tintColor = .white
            return button
        } else {
            return UIButton()
        }
    }()
    private let timeLabel = UILabel(textColor: .white, font: .systemFont(ofSize: 14), textAlignment: .center)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        backgroundColor = UIColor(named: "darkGreen")
        addSubview(deleteButton)
        addSubview(timeLabel)
        deleteButton.frame = CGRect(x: 4, y: frame.height/2 - 4, width: 8, height: 8)
        timeLabel.frame = CGRect(x: 13, y: frame.height/2 - 10, width: 55, height: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
