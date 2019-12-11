//
//  MedicationsController+AddMedicationControllerDelegate.swift
//  Dosage
//
//  Created by Mark Mansur on 2019-12-08.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//


extension MedicationsController: AddMedicationControllerDelegate {
    func didAddMedication(medication: Medication) {
        medications.append(medication)
    }
}
