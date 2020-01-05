//
//  StartEndDatePickerController.swift
//  Dosage
//
//  Created by Mark Mansur on 2020-01-03.
//  Copyright © 2020 Mark Mansur. All rights reserved.
//

import UIKit

class StartEndDatePickerController: UIViewController {
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.isHidden = true
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.heightAnchor.constraint(equalToConstant: 90).isActive = true
        picker.addTarget(self, action: #selector(handleDateChange(sender:)), for: .valueChanged)
        return picker
    }()
    
    lazy var datePickerHeaderView = DatePickerHeaderView(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        let mainStackView = UIStackView(arrangedSubviews: [datePickerHeaderView, datePicker], spacing: 7, axis: .vertical)
        
        view.addSubview(mainStackView)
        mainStackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mainStackView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mainStackView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    func startDate() -> Date? {
        return datePickerHeaderView.leftDate
    }
    
    func endDate() -> Date? {
        return datePickerHeaderView.rightDate
    }
    
}

extension StartEndDatePickerController: DatePickerHeaderViewDelegate {
    func headerStateDidChange(state: SelectedState) {
        switch state {
        case .left, .right:
            showDatePicker()
        case .none:
            hideDatePicker()
        }
    }
}

extension StartEndDatePickerController {
    private func showDatePicker() {
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
    
    private func hideDatePicker() {
        // hide picker animation
        UIView.animate(withDuration: 0.5) {
            self.datePicker.isHidden = true
        }
    }
    
    @objc private func handleDateChange(sender: UIDatePicker) {
        let date = datePicker.date
        
        switch datePickerHeaderView.selectedState {
            case .left:
                datePickerHeaderView.leftDate = date
            case .right:
                datePickerHeaderView.rightDate = date
            case .none:
                break
        }
    }
}
