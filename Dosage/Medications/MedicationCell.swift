//
//  MedicationCell.swift
//  Dosage
//
//  Created by Mark Mansur on 2019-12-05.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import UIKit

class MedicationCell: UICollectionViewCell {
    var medication: Medication? {
        didSet {
            nameLabel.text = medication?.name
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor(r: 50, g: 160, b: 96, alpha: 0.98)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let timesLeftLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor.lightGray
        label.text = "3 more times today"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        setupLayer()
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        backgroundColor = .white
        layer.cornerRadius = 12
    }
    
    private func setupLayer() {
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 9
        layer.shadowOpacity = 0.15
        layer.masksToBounds = false
    }
    
    private func setupSubviews() {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, timesLeftLabel])
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    func highlight() {
        backgroundColor = UIColor(r: 63, g: 186, b: 115, alpha: 1)
        nameLabel.textColor = .white
    }
    
    func unHighlight() {
        backgroundColor = .white
        nameLabel.textColor = UIColor(r: 50, g: 160, b: 96, alpha: 0.98)   
    }
    
    
}
