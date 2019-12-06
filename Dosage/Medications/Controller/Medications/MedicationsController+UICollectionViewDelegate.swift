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
    
    override func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? MedicationCell else { return }
        cell.highlight()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? MedicationCell else { return }
        cell.unHighlight()
    }
}
