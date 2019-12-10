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
            guard let medication = medication else { return }
            nameLabel.text = medication.name
            guard let shape = Shape(rawValue: medication.shape) else { return }
            shapeImageView.image = shape.image
        }
    }
    
    let shapeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
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
        let stackView = UIStackView(arrangedSubviews: [shapeImageView, nameLabel, timesLeftLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    func highlight() {
        backgroundColor = UIColor(named: "darkGreen")
        nameLabel.textColor = .white
        timesLeftLabel.textColor = .white
        shapeImageView.image = shapeImageView.image?.withTintColor(.white)
    }
    
    func unHighlight() {
        backgroundColor = .white
        nameLabel.textColor = UIColor(r: 50, g: 160, b: 96, alpha: 0.98)
        timesLeftLabel.textColor = .lightGray
        shapeImageView.image = shapeImageView.image?.withTintColor(UIColor(named: "darkGreen") ?? UIColor.green)
    }
    
    
}
