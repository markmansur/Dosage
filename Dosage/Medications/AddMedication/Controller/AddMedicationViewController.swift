//
//  AddMedicationViewController.swift
//  Dosage
//
//  Created by Mark Mansur on 2019-12-07.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import UIKit

protocol AddMedicationControllerDelegate {
    func didAddMedication(medication: Medication)
}

class AddMedicationViewController: UIViewController {
    
    // MARK: Properties
    var delegate: AddMedicationControllerDelegate?
    let shapes = Shape.allCases
    
    override func loadView() {
        let addMedicationView = AddMedicationView(addHandler: handleAdd, cancelHandler: handleCancel)
        addMedicationView.shapesCollectionView.delegate = self
        addMedicationView.shapesCollectionView.dataSource = self
        addMedicationView.datePickerHeaderView.delegate = self
        addMedicationView.datePicker.addTarget(self, action: #selector(handleDateChange(sender:)), for: .valueChanged)
        view = addMedicationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Handlers
    @objc private func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    private func handleAdd(name: String, shapeIndexPath: IndexPath, startDate: Date, endDate: Date) {
        let shape = shapes[shapeIndexPath.row]
        let medication = CoreDataManager.shared.addMedication(name: name, shape: shape, startDate: startDate, endDate: endDate)
        dismiss(animated: true) {
            self.delegate?.didAddMedication(medication: medication)
        }
    }
    
    private func handleCancel() {
        dismiss(animated: true)
    }
    
    @objc private func handleDateChange(sender: UIDatePicker) {
        guard let addMedicationView = view as? AddMedicationView else { return }
        let date = addMedicationView.datePicker.date
        
        switch addMedicationView.datePickerHeaderView.selectedState {
            case .left:
                addMedicationView.datePickerHeaderView.leftDate = date
            case .right:
                addMedicationView.datePickerHeaderView.rightDate = date
            case .none:
                break
        }
    }
}

extension AddMedicationViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shapes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as? ShapeCell else { return UICollectionViewCell()}
        cell.shapeImageView.image = shapes[indexPath.row].image
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = 50
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ShapeCell else { return }
        cell.highlight()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ShapeCell else { return }
        cell.unHighlight()
    }
}

extension AddMedicationViewController: DatePickerHeaderViewDelegate {
    
    func headerStateDidChange(state: SelectedState) {
        guard let addMedicationView = view as? AddMedicationView else { return }
        
        switch state {
            case .left:
                addMedicationView.showDatePicker()
            case .right:
                addMedicationView.showDatePicker()
            case .none:
                addMedicationView.hideDatePicker()
        }
    }
}
