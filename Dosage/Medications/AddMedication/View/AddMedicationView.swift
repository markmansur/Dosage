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
    private let shapesLabel = UILabel(text: "Shape", textColor: .lightGray, font: .systemFont(ofSize: 14))
    
    let nameTextField =  AddMedicationTextField(placeholder: "Name")
    let datePickerHeaderView = DatePickerHeaderView()
    
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
    
    let shapesCollectionView: UICollectionView
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
    
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.isHidden = true
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.heightAnchor.constraint(equalToConstant: 90).isActive = true
        return picker
    }()
    
    init(shapesCollectionView: UICollectionView, dosageView: UIView) {
        self.shapesCollectionView = shapesCollectionView
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
        datePickerHeaderView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let headerStackView = UIStackView(arrangedSubviews: [addNewMedicationLabel, cancelButton])
        let shapesStackView = UIStackView(arrangedSubviews: [shapesLabel, shapesCollectionView], spacing: 7, axis: .vertical)

        // main stack view that holds all other  stack views views
        let mainStackView = UIStackView(arrangedSubviews: [headerStackView, nameTextField, datePickerHeaderView, datePicker, shapesStackView, dosageView], spacing: 30, axis: .vertical)
        
        addSubview(mainStackView)
        mainStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 40).isActive = true
        mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 40).isActive = true
        mainStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -40).isActive = true
        
        addSubview(addButton)
        addButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 48).isActive = true
        addButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -48).isActive = true
        addButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func showDatePicker() {
        switch datePickerHeaderView.selectedState {
        case .left:
            guard let leftDate = datePickerHeaderView.leftDate else { break }
            datePicker.date = leftDate
        case .right:
            guard let rightDate = datePickerHeaderView.rightDate else { break }
            datePicker.date = rightDate
        case .none:
            break
        }
        
        // show picker animation
        UIView.animate(withDuration: 0.5) {
            self.datePicker.isHidden = false
        }
    }
    
    func hideDatePicker() {
        // hide picker animation
        UIView.animate(withDuration: 0.5) {
            self.datePicker.isHidden = true
        }
    }
}
