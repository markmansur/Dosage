//
//  MedicationsController+UICollectionViewDelegateFlowLayout.swift
//  Dosage
//
//  Created by Mark Mansur on 2019-12-06.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import UIKit

extension MedicationsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow:CGFloat = 2
        let spacingBetweenCells:CGFloat = 14
        
        let totalSpacing = (2 * spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells) //Amount of total spacing in a row
        
        if let collection = self.collectionView{
            let width = (collection.bounds.width - totalSpacing)/numberOfItemsPerRow
            return CGSize(width: width, height: width * 0.85)
        }else{
            return CGSize(width: 0, height: 0)
        }
    }
}
