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
    let daysOfWeek = DayOfWeek.allCases
    var addMedicationView: AddMedicationView?
    
    let shapesViewController = ShapesViewController()
    
    override func loadView() {
        let addMedicationView = AddMedicationView(shapesCollectionView: shapesViewController.collectionView)
        addMedicationView.cancelButton.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        addMedicationView.addButton.addTarget(self, action: #selector(handleAdd), for: .touchUpInside)
        addMedicationView.shapesCollectionView.delegate = self
        addMedicationView.shapesCollectionView.dataSource = self
        addMedicationView.daysSelectorCollectionView.delegate = self
        addMedicationView.daysSelectorCollectionView.dataSource = self
        addMedicationView.datePickerHeaderView.delegate = self
        addMedicationView.datePicker.addTarget(self, action: #selector(handleDateChange(sender:)), for: .valueChanged)
        addMedicationView.dosageSegmentedControl.addTarget(self, action: #selector(handleSegementControlChange(sender:)), for: .valueChanged)
        addMedicationView.setupSubViews()
        view = addMedicationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addMedicationView = view as? AddMedicationView
        addChild(shapesViewController)
    }
    
    // MARK: Handlers
    @objc private func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func handleAdd() {
        guard let name = addMedicationView?.nameTextField.text else { return }
        guard let selectedShapeIndexPath = addMedicationView?.shapesCollectionView.indexPathsForSelectedItems?[0] else { return }
        guard let startDate = addMedicationView?.datePickerHeaderView.leftDate else { return }
        guard let endDate = addMedicationView?.datePickerHeaderView.rightDate else { return }
        
        let shape = shapes[selectedShapeIndexPath.row]
        var dosageDays: [DayOfWeek]
        
        // determine dosage days. if daily get all cases. if custom get only selected cases.
        switch addMedicationView?.dosageSegmentedControl.selectedSegmentIndex {
        case 0:
            dosageDays = DayOfWeek.allCases
        default:
            dosageDays = [DayOfWeek]()
            addMedicationView?.daysSelectorCollectionView.indexPathsForSelectedItems?.forEach({ (selectedIndexPath) in
                guard let cell = addMedicationView?.daysSelectorCollectionView.cellForItem(at: selectedIndexPath) as? DayOfWeekCell else { return }
                guard let dayOfWeek = cell.dayOfWeek else { return }
                dosageDays.append(dayOfWeek)
            })
        }
        
        let medication = CoreDataManager.shared.addMedication(name: name, shape: shape, startDate: startDate, endDate: endDate, dosageDays: dosageDays)
        dismiss(animated: true) {
            self.delegate?.didAddMedication(medication: medication)
        }
    }
    
    @objc private func handleCancel() {
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
    
    @objc private func handleSegementControlChange(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            addMedicationView?.dosageSubtextLabel.text = "You'll have a dosage every day."
            UIView.animate(withDuration: 0.3) {
                self.addMedicationView?.daysSelectorCollectionView.isHidden = true
            }
            
        default:
            addMedicationView?.dosageSubtextLabel.text = "You'll have a dosage on select days."
            UIView.animate(withDuration: 0.3) {
                self.addMedicationView?.daysSelectorCollectionView.isHidden = false
            }
        }
        
    }
}

extension AddMedicationViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case addMedicationView?.shapesCollectionView:
            return shapes.count
        default:
            return daysOfWeek.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case addMedicationView?.shapesCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as? ShapeCell else { return UICollectionViewCell() }
            cell.shapeImageView.image = shapes[indexPath.row].image
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as? DayOfWeekCell else { return UICollectionViewCell() }
            cell.dayOfWeek = daysOfWeek[indexPath.row]
            return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case addMedicationView?.shapesCollectionView:
            return CGSize(width: 45, height: 45)
        case addMedicationView?.daysSelectorCollectionView:
            guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize(width: 0, height: 0) }
            let numberOfItemsPerRow:CGFloat = CGFloat(daysOfWeek.count)
            let spacingBetweenCells:CGFloat = flowLayout.minimumLineSpacing
            let totalSpacing = (numberOfItemsPerRow - 1) * spacingBetweenCells
            
            let collectionViewWidth = collectionView.bounds.width
            let cellWidth = (collectionViewWidth - totalSpacing) / numberOfItemsPerRow
            return CGSize(width: cellWidth, height: cellWidth)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ShapeCell {
            cell.highlight()
        }
        if let cell = collectionView.cellForItem(at: indexPath) as? DayOfWeekCell {
            cell.highlight()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ShapeCell {
            cell.unHighlight()
        }
        if let cell = collectionView.cellForItem(at: indexPath) as? DayOfWeekCell {
            cell.unHighlight()
        }
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
