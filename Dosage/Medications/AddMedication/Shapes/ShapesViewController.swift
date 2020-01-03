//
//  ShapesViewController.swift
//  Dosage
//
//  Created by Mark Mansur on 2020-01-03.
//  Copyright © 2020 Mark Mansur. All rights reserved.
//

import UIKit

class ShapesViewController: UIViewController {
    private let shapes = Shape.allCases
    private let shapesLabel = UILabel(text: "Shape", textColor: .lightGray, font: .systemFont(ofSize: 14))
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .null, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        collectionView.register(ShapeCell.self, forCellWithReuseIdentifier: "cellId")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        let mainStackView = UIStackView(arrangedSubviews: [shapesLabel, collectionView], spacing: 7, axis: .vertical)
        
        view.addSubview(mainStackView)
        mainStackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mainStackView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mainStackView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    func selectedShape() -> Shape {
        guard let selectedIndexPath = collectionView.indexPathsForSelectedItems?[0] else { return Shape.shape1 }
        return shapes[selectedIndexPath.row]
    }
}

extension ShapesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shapes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ShapeCell else { return }
        cell.highlight()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ShapeCell else { return }
        cell.unHighlight()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as? ShapeCell else { return UICollectionViewCell() }
        cell.shapeImageView.image = shapes[indexPath.row].image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 45, height: 45)
    }
}
