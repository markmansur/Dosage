//
//  MedicationsController+UICollectionViewDelegate.swift
//  Dosage
//
//  Created by Mark Mansur on 2019-12-06.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import UIKit

extension MedicationsController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let medicationController = MedicationController()
        let medication = medications[indexPath.row]
        medicationController.medication = medication
        
        navigationController?.pushViewController(medicationController, animated: true)
    }
}
