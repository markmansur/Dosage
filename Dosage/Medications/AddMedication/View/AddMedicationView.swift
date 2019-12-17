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
    private var addHandler: ((_ name: String, _ shapeIndexPath: IndexPath, _ startDate: Date, _ endDate: Date) -> Void)?
    private var cancelHandler: (() -> Void)?
    
    private let addNewMedicationLabel = UILabel(text: "Add New medication", font: .boldSystemFont(ofSize: 19))
    private let shapesLabel = UILabel(text: "Shape", textColor: .lightGray, font: .systemFont(ofSize: 14))
    private let repeatLabel = UILabel(text: "Repeat", textColor: .lightGray, font: .systemFont(ofSize: 14))
    
    private let nameTextField =  AddMedicationTextField(placeholder: "Name")
    private let datePickerHeaderView = DatePickerHeaderView()
    
    private var cancelButton: UIButton = {
        if #available(iOS 13.0, *) {
            let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .large)
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
    
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.isHidden = true
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.heightAnchor.constraint(equalToConstant: 90).isActive = true
        return picker
    }()
    
    let shapesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        let collectionView = UICollectionView(frame: CGRect.null, collectionViewLayout: layout)
        collectionView.register(ShapeCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.heightAnchor.constraint(equalToConstant: 55).isActive = true
        return collectionView
    }()
    
    init(addHandler: @escaping(_ name: String, _ shapeIndexPath: IndexPath, _ startDate: Date, _ endDate: Date) -> Void, cancelHandler: @escaping() -> Void) {
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
        datePickerHeaderView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let headerStackView = UIStackView(arrangedSubviews: [addNewMedicationLabel, cancelButton])
        let shapesStackView = UIStackView(arrangedSubviews: [shapesLabel, shapesCollectionView], spacing: 7, axis: .vertical)

        // main stack view that holds all other  stack views views
        let mainStackView = UIStackView(arrangedSubviews: [headerStackView, nameTextField, datePickerHeaderView, datePicker, shapesStackView], spacing: 40, axis: .vertical)
        
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
    
    @objc private func handleAdd() {
        guard let name = nameTextField.text else { return }
        guard let selectedShapeIndexPath = shapesCollectionView.indexPathsForSelectedItems?[0] else { return }
        guard let startDate = datePickerHeaderView.leftDate else { return }
        guard let endDate = datePickerHeaderView.rightDate else { return }
        
        addHandler?(name, selectedShapeIndexPath, startDate, endDate)
    }
    
    @objc private func handleCancel() {
        cancelHandler?()
    }
}
