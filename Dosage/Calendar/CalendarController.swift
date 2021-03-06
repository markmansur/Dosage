//
//  CalendarController.swift
//  Dosage
//
//  Created by Mark Mansur on 2020-01-17.
//  Copyright © 2020 Mark Mansur. All rights reserved.
//

import UIKit
import SwiftDate

class CalendarController: UICollectionViewController {
    var medications: [Medication]?
    let month: Month
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        
        medications = CoreDataManager.shared.getAllMedications()
    }
    
    init(month: Month) {
        self.month = month
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        let layout = collectionViewLayout as? UICollectionViewFlowLayout
        layout?.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionView.backgroundColor = UIColor(r: 246, g: 248, b: 252, alpha: 1)
        collectionView.register(CalendarCell.self, forCellWithReuseIdentifier: "cellId")
    }
}

extension CalendarController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as? CalendarCell else { return UICollectionViewCell() }
        
        let now = Date()
        if month.rawValue == now.month {
            cell.date = now + indexPath.row.days
        }
        
        return cell
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let now = Date()
        return now.monthDays - now.day + 1 // calculate number of days remaining in the current month
    }
}

extension CalendarController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.95, height: 140)
    }
}
