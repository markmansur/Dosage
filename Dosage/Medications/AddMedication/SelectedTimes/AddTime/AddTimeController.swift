//
//  AddTimeController.swift
//  Dosage
//
//  Created by Mark Mansur on 2020-01-04.
//  Copyright © 2020 Mark Mansur. All rights reserved.
//

import UIKit

protocol AddTimeControllerDelegate {
    func didAddTime(time: Time)
}

class AddTimeController: UIViewController {
    var delegate: AddTimeControllerDelegate?
    
    let backButton: UIButton = {
        if #available(iOS 13.0, *) {
            let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .large)
            let symbolImage = UIImage(systemName: "chevron.left", withConfiguration: config)
            let button = UIButton()
            button.setImage(symbolImage, for: .normal)
            button.tintColor = .lightGray
            button.addTarget(self, action: #selector(handleBack), for: .touchDown)
            return button
        } else {
            return UIButton()
        }
    }()
    
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.heightAnchor.constraint(equalToConstant: 90).isActive = true
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add Time", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 12
        button.backgroundColor = UIColor(named: "darkGreen")
        button.addTarget(self, action: #selector(handleAdd), for: .touchDown)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let addNewMedicationLabel = UILabel(text: "Add Time", font: .boldSystemFont(ofSize: 19))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSubViews()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.layer.cornerRadius = 40
        view.clipsToBounds = true
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func setupSubViews() {
        let headerStackView = UIStackView(arrangedSubviews: [backButton, addNewMedicationLabel, UIView()], spacing: 30)
        headerStackView.distribution = .equalCentering
        
        let mainStackView = UIStackView(arrangedSubviews: [headerStackView, datePicker, addButton], spacing: 20, axis: .vertical)
        
        view.addSubview(mainStackView)
        mainStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        mainStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        mainStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        
        
        
    }
    
    @objc private func handleBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func handleAdd() {
        let date = datePicker.date
        let components = Calendar.current.dateComponents([.hour, .minute], from: date)
        
        guard let hour = components.hour else { return }
        guard let minute = components.minute else { return }
        
        let time: Time
        if hour >= 12 {
            time = Time(hour: hour - 12, min: minute, isPM: true)
        } else {
            time = Time(hour: hour, min: minute, isPM: false)
        }
        
        delegate?.didAddTime(time: time)
        navigationController?.popViewController(animated: true)
    }
}
