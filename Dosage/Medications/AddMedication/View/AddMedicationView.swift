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
    // MARK: Properties
    var addHandler: ((_ name: String) -> Void)?
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextField =  AddMedicationTextField()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add Medication", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 12
        button.backgroundColor = UIColor(named: "darkGreen")
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
        
        layer.cornerRadius = 40
        clipsToBounds = true
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func setupSubViews() {
        
        // nameLabel & nameTextField
        let nameStackView = UIStackView(arrangedSubviews: [nameLabel, nameTextField])
        nameStackView.spacing = 7
        nameStackView.translatesAutoresizingMaskIntoConstraints = false
        nameStackView.axis = .vertical

        // main stack view that holds all other views
        let mainStackView = UIStackView(arrangedSubviews: [nameStackView, addButton])
        mainStackView.distribution = .equalSpacing
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        
        addSubview(mainStackView)
        mainStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 48).isActive = true
        mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 64).isActive = true
        mainStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -48).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    @objc private func handleAdd() {
        guard let name = nameTextField.text else { return }
        
        self.addHandler?(name)
    }
    
    
    
}
