//
//  DatePickerHeaderView.swift
//  Dosage
//
//  Created by Mark Mansur on 2019-12-11.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import UIKit

enum SelectedState {
    case left
    case right
    case none
}

protocol DatePickerHeaderViewDelegate {
    func headerStateDidChange(state: SelectedState)
}

class DatePickerHeaderView: UIView {
    // MARK: Properties
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd yyyy"
        return formatter
    }()
    
    var leftDate: Date? {
        didSet {
            guard let leftDate = leftDate else { return }
            leftDateLabel.text = dateFormatter.string(from: leftDate)
        }
    }
    var rightDate: Date?  {
        didSet {
            guard let rightDate = rightDate else { return }
            rightDateLabel.text = dateFormatter.string(from: rightDate)
        }
    }
    
    var selectedState: SelectedState = .none
    var delegate: DatePickerHeaderViewDelegate?
    
    private let leftDateLabel = UILabel(text: "", textColor: UIColor(named: "darkGreen"), font: .boldSystemFont(ofSize: 14), textAlignment: .center)
    private let rightDateLabel = UILabel(text: "End Date", textColor: UIColor(named: "darkGreen"), font: .boldSystemFont(ofSize: 14), textAlignment: .center)
    
    private var clockSymbol: UIImageView = {
        if #available(iOS 13.0, *) {
            let config = UIImage.SymbolConfiguration(pointSize: 15, weight: .light, scale: .medium)
            let symbolImage = UIImage(systemName: "clock", withConfiguration: config)
            let imageView = UIImageView(image: symbolImage)
            imageView.tintColor = .lightGray
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        } else {
            return UIImageView()
        }
    }()
    
    init(delegate: DatePickerHeaderViewDelegate? = nil) {
        self.delegate = delegate
        super.init(frame: .zero)
        setupView()
        setupBorder()
        setupDateLabels()
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        defer { // called after self is available, didSet on leftDate is called this way.
            leftDate = Date()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .clear
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
    }
    
    private func setupBorder() {
        layer.cornerRadius = 5
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.5
        clipsToBounds = true
    }
    
    private func setupDateLabels() {
        addSubview(clockSymbol)
        clockSymbol.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        clockSymbol.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        clockSymbol.heightAnchor.constraint(equalToConstant: 25).isActive = true
        clockSymbol.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        addSubview(leftDateLabel)
        leftDateLabel.leftAnchor.constraint(equalTo: clockSymbol.rightAnchor, constant: -4).isActive = true
        leftDateLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        leftDateLabel.rightAnchor.constraint(equalTo: centerXAnchor, constant: -5).isActive = true
        leftDateLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        addSubview(rightDateLabel)
        rightDateLabel.leftAnchor.constraint(equalTo: centerXAnchor, constant: 5).isActive = true
        rightDateLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        rightDateLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true
        rightDateLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    override func draw(_ rect: CGRect) {
        // reset colors
        leftDateLabel.textColor = UIColor(named: "darkGreen")
        rightDateLabel.textColor = UIColor(named: "darkGreen")
        clockSymbol.tintColor = .lightGray
        
        // draw gray divider
        let path = UIBezierPath()
        path.lineWidth = 0.25
        UIColor.lightGray.setFill()
        path.move(to: CGPoint(x: rect.width / 2, y: 0))
        path.addLine(to: CGPoint(x: rect.width * 0.53, y: rect.height / 2))
        path.addLine(to: CGPoint(x: rect.width / 2, y: rect.height))
        path.stroke()

        UIColor(named: "darkGreen")?.setFill()
        switch selectedState {
        case .left:
            fillLeft()
        case .right:
            fillRight()
        default:
            break
        }
    }
    
    private func fillLeft() {
        leftDateLabel.textColor = .white
        clockSymbol.tintColor = .white

        let path = UIBezierPath()
        path.lineCapStyle = .round
        path.lineWidth = 9
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: bounds.height))
        path.addLine(to: CGPoint(x: bounds.width / 2, y: bounds.height))
        path.addLine(to: CGPoint(x: bounds.width * 0.53, y: bounds.height / 2))
        path.addLine(to: CGPoint(x: bounds.width / 2, y: 0))
        path.close()
        path.fill()
    }

    private func fillRight() {
        rightDateLabel.textColor = .white

        let path = UIBezierPath()
        path.move(to: CGPoint(x: bounds.width / 2, y: 0))
        path.addLine(to: CGPoint(x: bounds.width * 0.53, y: bounds.height / 2))
        path.addLine(to: CGPoint(x: bounds.width / 2, y: bounds.height))
        path.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
        path.addLine(to: CGPoint(x: bounds.width, y: 0))
        path.close()
        path.fill()
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        if sender.location(in: self).x < self.bounds.width * 0.53 {
            if selectedState == .left {
                selectedState = .none
            } else {
                selectedState = .left
            }
        } else {
            if selectedState == .right {
                selectedState = .none
            } else {
                selectedState = .right
            }
        }
        setNeedsDisplay()
        delegate?.headerStateDidChange(state: selectedState)
    }
}
