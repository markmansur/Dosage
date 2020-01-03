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
    private let addNewMedicationLabel = UILabel(text: "Add New medication", font: .boldSystemFont(ofSize: 19))
    
    let nameTextField =  AddMedicationTextField(placeholder: "Name")
    
    var cancelButton: UIButton = {
        if #available(iOS 13.0, *) {
            let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .large)
            let symbolImage = UIImage(systemName: "xmark.circle", withConfiguration: config)
            let button = UIButton()
            button.setImage(symbolImage, for: .normal)
            button.tintColor = .lightGray
            return button
        } else {
            return UIButton()
        }
    }()
    
    let startEndDatePickerView: UIView
    let shapesView: UIView
    let dosageView: UIView
    
    let addButton: UIButton = {
        let button = UIButton()
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add Medication", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 12
        button.backgroundColor = UIColor(named: "darkGreen")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(startEndDatePickerView: UIView, shapesView: UIView, dosageView: UIView) {
        self.startEndDatePickerView = startEndDatePickerView
        self.shapesView = shapesView
        self.dosageView = dosageView
        super.init(frame: .zero)
        setupView()
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
    
    func setupSubViews() {
        let headerStackView = UIStackView(arrangedSubviews: [addNewMedicationLabel, cancelButton])

        // main stack view that holds all other  stack views views
        let mainStackView = UIStackView(arrangedSubviews: [headerStackView, nameTextField, startEndDatePickerView, shapesView, dosageView], spacing: 30, axis: .vertical)
        
        addSubview(mainStackView)
        mainStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 40).isActive = true
        mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 40).isActive = true
        mainStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -40).isActive = true
        
        addSubview(addButton)
        addButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 48).isActive = true
        addButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -48).isActive = true
        addButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
