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
    var cancelHandler: (() -> Void)?
    
    let addNewMedicationLabel: UILabel = {
        let label = UILabel()
        label.text = "Add New Medication"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var cancelButton: UIButton = {
        if #available(iOS 13.0, *) {
            let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .medium)
            let symbolImage = UIImage(systemName: "xmark.circle", withConfiguration: config)
            let button = UIButton()
            button.setImage(symbolImage, for: .normal)
            button.tintColor = .lightGray
            button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
            return button
        } else {
            return UIButton()
        }
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = label.font.withSize(14)
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
    
    init(addHandler: @escaping(_ name: String) -> Void, cancelHandler: @escaping() -> Void) {
        super.init(frame: .zero)
        self.addHandler = addHandler
        self.cancelHandler = cancelHandler
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
        
        // addNewMedicationLabel
        let headerStackView = UIStackView(arrangedSubviews: [addNewMedicationLabel, cancelButton])
        
        // nameLabel & nameTextField
        let nameStackView = UIStackView(arrangedSubviews: [nameLabel, nameTextField])
        nameStackView.spacing = 7
        nameStackView.translatesAutoresizingMaskIntoConstraints = false
        nameStackView.axis = .vertical

        // main stack view that holds all other views
        let mainStackView = UIStackView(arrangedSubviews: [headerStackView ,nameStackView])
        mainStackView.spacing = 40
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        
        addSubview(mainStackView)
        mainStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 48).isActive = true
        mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 50).isActive = true
        mainStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -48).isActive = true
        
        
        addSubview(addButton)
        addButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 48).isActive = true
        addButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -48).isActive = true
        addButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    @objc private func handleAdd() {
        guard let name = nameTextField.text else { return }
        
        addHandler?(name)
    }
    
    @objc private func handleCancel() {
        cancelHandler?()
    }
}
