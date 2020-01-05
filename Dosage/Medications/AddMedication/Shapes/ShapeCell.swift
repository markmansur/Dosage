//
//  ShapeCell.swift
//  Dosage
//
//  Created by Mark Mansur on 2019-12-08.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import UIKit

class ShapeCell: UICollectionViewCell {
    
    var shapeImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayer()
        setupImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayer() {
        layer.cornerRadius = 13
    }
    
    private func setupImageView() {
        shapeImageView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(shapeImageView)
        
        shapeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3).isActive = true
        shapeImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3).isActive = true
        shapeImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 3).isActive = true
        shapeImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -3).isActive = true
        
    }
    
    func highlight() {
        backgroundColor = UIColor(named: "darkGreen")
        shapeImageView.image = shapeImageView.image?.withTintColor(.white)
    }
    
    func unHighlight() {
        backgroundColor = .white
        shapeImageView.image = shapeImageView.image?.withTintColor(UIColor(named: "darkGreen")!)
    }
}
