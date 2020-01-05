//
//  AddTimeCell.swift
//  Dosage
//
//  Created by Mark Mansur on 2020-01-03.
//  Copyright © 2020 Mark Mansur. All rights reserved.
//

import UIKit

class AddTimeCell: UICollectionViewCell {
    let plusImageView: UIImageView = {
        if #available(iOS 13.0, *) {
            let config = UIImage.SymbolConfiguration(pointSize: 6, weight: .regular, scale: .large)
            let symbolImage = UIImage(systemName: "plus.circle", withConfiguration: config)
            let imageView = UIImageView(image: symbolImage)
            imageView.tintColor = .white
            return imageView
        } else {
            return UIImageView()
        }
    }()
    private let addLabel = UILabel(text: "Add", textColor: .white, font: .systemFont(ofSize: 14), textAlignment: .center)

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        backgroundColor = UIColor(named: "darkGreen")
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(plusImageView)
        addSubview(addLabel)
        plusImageView.frame = CGRect(x: 6, y: 2, width: 20, height: 20)
        addLabel.frame = CGRect(x: 26, y: 2, width: 40, height: 20)
        
        
    }
}
