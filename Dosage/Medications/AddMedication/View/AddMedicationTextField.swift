//
//  AddMedicationTextField.swift
//  Dosage
//
//  Created by Mark Mansur on 2019-12-08.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import UIKit

class AddMedicationTextField: UITextField {
    
    // MARK: Properties
    private let underlineLayer = CALayer()
    var borderColor: UIColor = UIColor.lightGray {
        didSet { setupUnderline() }
    }
    var borderWidth: CGFloat = 0.5 {
        didSet { setupUnderline() }
    }

    // MARK: Init
    override init(frame : CGRect) {
        super.init(frame : frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupUnderline()
    }

    convenience init(placeholder: String? = nil) {
        self.init(frame:CGRect.zero)
        self.placeholder = placeholder
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Coder not implemented")
    }

    func setupUnderline() {
        underlineLayer.borderColor = self.borderColor.cgColor
        underlineLayer.borderWidth = borderWidth
        self.layer.addSublayer(underlineLayer)
        self.layer.masksToBounds = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        underlineLayer.frame = CGRect(x: 0, y: self.frame.size.height - borderWidth, width:  self.frame.size.width, height: borderWidth)
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 0, dy: 7)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 0, dy: 7)
    }
}
