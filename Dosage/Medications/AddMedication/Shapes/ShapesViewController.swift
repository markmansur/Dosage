//
//  ShapesViewController.swift
//  Dosage
//
//  Created by Mark Mansur on 2020-01-03.
//  Copyright © 2020 Mark Mansur. All rights reserved.
//

import UIKit

class ShapesViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let shapes = Shape.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        collectionView.register(ShapeCell.self, forCellWithReuseIdentifier: "cellId")
    }
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func selectedShape() -> Shape {
        guard let selectedIndexPath = collectionView.indexPathsForSelectedItems?[0] else { return Shape.shape1 }
        return shapes[selectedIndexPath.row]
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shapes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ShapeCell else { return }
        cell.highlight()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ShapeCell else { return }
        cell.unHighlight()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as? ShapeCell else { return UICollectionViewCell() }
        cell.shapeImageView.image = shapes[indexPath.row].image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 45, height: 45)
    }
}
