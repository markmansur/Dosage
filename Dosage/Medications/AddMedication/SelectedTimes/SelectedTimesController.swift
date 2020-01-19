//
//  TimeSelectorController.swift
//  Dosage
//
//  Created by Mark Mansur on 2020-01-03.
//  Copyright © 2020 Mark Mansur. All rights reserved.
//

import UIKit

protocol SelectedTimesControllerDelegate {
    func didTapAddTime()
}

class SelectedTimesController: UIViewController {
    var delegate: SelectedTimesControllerDelegate?
    
    var selectedTimes = [Time]()
    
    private let timesLabel = UILabel(text: "Times", textColor: .lightGray, font: .systemFont(ofSize: 14))
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .null, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        collectionView.register(SelectedTimeCell.self, forCellWithReuseIdentifier: "selectedTimeCell")
        collectionView.register(AddTimeCell.self, forCellWithReuseIdentifier: "addTimeCell")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        let mainStackView = UIStackView(arrangedSubviews: [timesLabel, collectionView], spacing: 7, axis: .vertical)
        
        view.addSubview(mainStackView)
        mainStackView.anchorToSuperview()
    }
    
    @objc private func handleDeleteTimeTap(sender: UIButton) {
        let row = sender.tag
        selectedTimes.remove(at: row)
        collectionView.deleteItems(at: [IndexPath(row: row, section: 0)])
        collectionView.reloadItems(at: collectionView.indexPathsForVisibleItems)
    }
    
    func addTime(time: Time) {
        var foundDuplicate = false
        selectedTimes.forEach { (selectedTime) in
            if selectedTime.hour == time.hour && selectedTime.min == time.min && selectedTime.isPM == time.isPM {
                foundDuplicate = true
            }
        }
        
        if !foundDuplicate {
            selectedTimes.append(time)
            collectionView.insertItems(at: [IndexPath(row: selectedTimes.count - 1, section: 0)])
        }
    }
}

extension SelectedTimesController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedTimes.count + 1 // extra for add button
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = indexPath.row
        if (row == selectedTimes.count) { // last cell (need to return add button)
            return collectionView.dequeueReusableCell(withReuseIdentifier: "addTimeCell", for: indexPath)
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "selectedTimeCell", for: indexPath) as? SelectedTimeCell else { return UICollectionViewCell() }
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(handleDeleteTimeTap(sender:)), for: .touchDown)
        cell.time = selectedTimes[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 75, height: 25)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = indexPath.row
        if (row == selectedTimes.count) { // add cell tapped
            delegate?.didTapAddTime()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
    }
    
    
}
