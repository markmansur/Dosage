//
//  AddMedicationView.swift
//  Dosage
//
//  Created by Mark Mansur on 2019-12-07.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import UIKit

protocol AddMedicationViewDelegate {
    func didAddMedication(name: String)
}

class AddMedicationView: UIView {
    var addHandler: ((_ name: String) -> Void)?
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add Dosage", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 12
        button.backgroundColor = .green
        button.addTarget(self, action: #selector(handleAdd), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(addHandler: @escaping(_ name: String) -> Void) {
        super.init(frame: .zero)
        self.addHandler = addHandler
        setupView()
        setupSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        
        layer.cornerRadius = 65
        clipsToBounds = true
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func setupSubViews() {
        addSubview(addButton)

        addButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        addButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32).isActive = true
        addButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
    }
    
    @objc private func handleAdd() {
        self.addHandler?("Ibuprofen")
    }
    
    
    
}
