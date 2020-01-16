//
//  DosageViewController.swift
//  Dosage
//
//  Created by Mark Mansur on 2020-01-03.
//  Copyright © 2020 Mark Mansur. All rights reserved.
//

import UIKit

class DosageViewController: UIViewController {
    private let daysOfWeek = DayOfWeek.allCases
    
    private let dosageLabel = UILabel(text: "Dosage", textColor: .lightGray, font: .systemFont(ofSize: 14))
    private let dosageSubtextLabel = UILabel(text: "You'll have a dosage every day.", textColor: .lightGray, font: .systemFont(ofSize: 12))
    
    private var daysSelectorCollectionView: UICollectionView?
    
    lazy var dosageSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl()
        sc.insertSegment(withTitle: "Daily", at: 0, animated: true)
        sc.insertSegment(withTitle: "Custom", at: 1, animated: true)
        sc.selectedSegmentTintColor = UIColor(named: "darkGreen")
        sc.selectedSegmentIndex = 0
        sc.setTitleTextAttributes([.font: UIFont.boldSystemFont(ofSize: 14),
                                   .foregroundColor: UIColor.white], for: .selected)
        sc.setTitleTextAttributes([.font: UIFont.boldSystemFont(ofSize: 14),
                                   .foregroundColor: UIColor(named: "darkGreen") ?? .green], for: .normal)
        sc.addTarget(self, action: #selector(handleSegementControlChange(sender:)), for: .valueChanged)
        return sc
    }()
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupView()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        
        daysSelectorCollectionView = UICollectionView(frame: .null, collectionViewLayout: layout)
        daysSelectorCollectionView?.dataSource = self
        daysSelectorCollectionView?.delegate = self
        
        daysSelectorCollectionView?.isHidden = true
        daysSelectorCollectionView?.allowsMultipleSelection = true
        daysSelectorCollectionView?.backgroundColor = .clear
        daysSelectorCollectionView?.layer.masksToBounds = false
        
        daysSelectorCollectionView?.register(DayOfWeekCell.self, forCellWithReuseIdentifier: "cellId")
        
        daysSelectorCollectionView?.translatesAutoresizingMaskIntoConstraints = false
        daysSelectorCollectionView?.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupView() {
        guard let daysSelectorCollectionView = daysSelectorCollectionView else { return }
        let mainStackView = UIStackView(arrangedSubviews: [dosageLabel, dosageSegmentedControl, daysSelectorCollectionView, dosageSubtextLabel], spacing: 10, axis: .vertical)
        mainStackView.setCustomSpacing(3, after: daysSelectorCollectionView)
        
        view.addSubview(mainStackView)
        mainStackView.anchorToSuperview()
    }
    
    @objc private func handleSegementControlChange(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            dosageSubtextLabel.text = "You'll have a dosage every day."
            UIView.animate(withDuration: 0.3) {
                self.daysSelectorCollectionView?.isHidden = true
            }
            
        default:
            dosageSubtextLabel.text = "You'll have a dosage on select days."
            UIView.animate(withDuration: 0.3) {
                self.daysSelectorCollectionView?.isHidden = false
            }
        }
    }
    
    func selectedDosageDays() -> [DayOfWeek] {
        var dosageDays: [DayOfWeek]
        
        // determine dosage days. if daily get all cases. if custom get only selected cases.
        switch dosageSegmentedControl.selectedSegmentIndex {
        case 0:
            dosageDays = DayOfWeek.allCases
        default:
            dosageDays = [DayOfWeek]()
            daysSelectorCollectionView?.indexPathsForSelectedItems?.forEach({ (selectedIndexPath) in
                guard let cell = daysSelectorCollectionView?.cellForItem(at: selectedIndexPath) as? DayOfWeekCell else { return }
                guard let dayOfWeek = cell.dayOfWeek else { return }
                dosageDays.append(dayOfWeek)
            })
        }

        return dosageDays
    }
}


extension DosageViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return daysOfWeek.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as? DayOfWeekCell else { return UICollectionViewCell() }
        cell.dayOfWeek = daysOfWeek[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? DayOfWeekCell else { return }
        cell.highlight()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? DayOfWeekCell else { return }
        cell.unHighlight()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize(width: 0, height: 0) }
        let numberOfItemsPerRow:CGFloat = CGFloat(daysOfWeek.count)
        let spacingBetweenCells:CGFloat = flowLayout.minimumLineSpacing
        let totalSpacing = (numberOfItemsPerRow - 1) * spacingBetweenCells
        
        let collectionViewWidth = collectionView.bounds.width
        let cellWidth = (collectionViewWidth - totalSpacing) / numberOfItemsPerRow
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
}
