//
//  CalendarCell.swift
//  Dosage
//
//  Created by Mark Mansur on 2020-01-17.
//  Copyright © 2020 Mark Mansur. All rights reserved.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    var date: Date? {
        didSet {
            dateLabel.text = "\(date?.day ?? 0)"
            monthLabel.text = date?.monthName(.short)
        }
    }
    var medications: [Medication]?
    
    var isToday: Bool? {
        didSet {
            guard let isToday = isToday else { return }
            switch isToday {
            case true:
                dateLabel.textColor = UIColor(named: "darkGreen")
                monthLabel.textColor = UIColor(named: "darkGreen")
            default:
                dateLabel.textColor = .black
                monthLabel.textColor = .black
            }
            
            
        }
    }
    
    let dateLabel = UILabel(text: "04", font: .systemFont(ofSize: 56, weight: .thin), textAlignment: .center)
    let monthLabel = UILabel(text: "JAN", font: .systemFont(ofSize: 22, weight: .thin), textAlignment: .center)
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CalendarTimeCell.self, forCellReuseIdentifier: "cellId")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        setupLayer()
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        backgroundColor = .white
        layer.cornerRadius = 12
    }
    
    private func setupLayer() {
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 9
        layer.shadowOpacity = 0.15
        layer.masksToBounds = false
    }
    
    private func setupSubviews() {
        let dateStackView = UIStackView(arrangedSubviews: [dateLabel, monthLabel], spacing: 7, axis: .vertical)
        dateStackView.distribution = .equalCentering
        
        addSubview(dateStackView)
        dateStackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        dateStackView.widthAnchor.constraint(equalToConstant: frame.width * 0.2).isActive = true
        dateStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        
        addSubview(tableView)
        tableView.leftAnchor.constraint(equalTo: dateStackView.rightAnchor, constant: 12).isActive = true
        tableView.topAnchor.constraint(equalTo: dateStackView.topAnchor, constant: 12).isActive = true
        tableView.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

extension CalendarCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as? CalendarTimeCell else { return UITableViewCell() }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
