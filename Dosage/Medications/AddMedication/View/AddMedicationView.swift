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
    var addHandler: ((_ name: String, _ shapeIndexPath: IndexPath) -> Void)?
    var cancelHandler: (() -> Void)?
    
    let addNewMedicationLabel = UILabel(text: "Add New medication", font: .boldSystemFont(ofSize: 19))
    
    var cancelButton: UIButton = {
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
    
    let nameLabel = UILabel(text: "Name", textColor: .lightGray, font: .systemFont(ofSize: 14))
    
    let nameTextField =  AddMedicationTextField()
    
    let shapesLabel = UILabel(text: "Shape", textColor: .lightGray, font: .systemFont(ofSize: 14))
    
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
    
    init(addHandler: @escaping(_ name: String, _ shapeIndexPath: IndexPath) -> Void, cancelHandler: @escaping() -> Void) {
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
        let headerStackView = UIStackView(arrangedSubviews: [addNewMedicationLabel, cancelButton])
        let nameStackView = UIStackView(arrangedSubviews: [nameLabel, nameTextField], spacing: 7, axis: .vertical)
        let shapesStackView = UIStackView(arrangedSubviews: [shapesLabel, shapesCollectionView], spacing: 7, axis: .vertical)

        // main stack view that holds all other  stack views views
        let mainStackView = UIStackView(arrangedSubviews: [headerStackView, nameStackView, shapesStackView], spacing: 40, axis: .vertical)
        
        addSubview(mainStackView)
        mainStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 40).isActive = true
        mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 40).isActive = true
        mainStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -40).isActive = true
        
        addSubview(addButton)
        addButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 48).isActive = true
        addButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -48).isActive = true
        addButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    @objc private func handleAdd() {
        guard let name = nameTextField.text else { return }
        guard let selectedShapeIndexPath = shapesCollectionView.indexPathsForSelectedItems?[0] else { return }
        
        addHandler?(name, selectedShapeIndexPath)
    }
    
    @objc private func handleCancel() {
        cancelHandler?()
    }
}
