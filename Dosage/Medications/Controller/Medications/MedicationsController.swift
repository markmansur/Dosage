//
//  MedicationController.swift
//  Dosage
//
//  Created by Mark Mansur on 2019-12-05.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import UIKit

class MedicationsController: UICollectionViewController {
    let spacing:CGFloat = 24
    
    lazy var slideInTransitioningDelegate = SlideInPresentationManager()
    
    var medications = [Medication]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupNavigationController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        medications = CoreDataManager.shared.getAllMedications()
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = UIColor(r: 246, g: 248, b: 252, alpha: 1)
        
        collectionView.register(MedicationCell.self, forCellWithReuseIdentifier: "cellId")
    }
    
    private func setupNavigationController() {
        navigationItem.title = "Medications"
        
        // right plus bar button
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .large)
        let plusSymbolImage = UIImage(systemName: "plus.circle", withConfiguration: config)
        let barButtonItem = UIBarButtonItem(image: plusSymbolImage, style: .plain, target: self, action: #selector(handleAddMedication))
        barButtonItem.tintColor = .white
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc private func handleAddMedication() {
        let addController = AddMedicationViewController()
        addController.addMedicationControllerDelegate = self
        addController.transitioningDelegate = slideInTransitioningDelegate
        addController.modalPresentationStyle = .custom
        
        let navController = UINavigationController(rootViewController: addController)
        navController.navigationBar.isHidden = true
        navController.transitioningDelegate = slideInTransitioningDelegate
        navController.modalPresentationStyle = .custom
        
        present(navController, animated: true, completion: nil)
    }
}
