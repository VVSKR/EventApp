//
//  FavotiteEventsCell.swift
//  EventApp 1
//
//  Created by Vova SKR on 07/12/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import UIKit

class FavoriteEventsCell: UITableViewCell {
    
    static let reuseId = "favoriteEventsCell"
    
    var customView = UIView()
    
    private let headerLabel = UILabel.setupLabel(with: .boldSystemFont(ofSize: 19), tintColor: .black, line: 2)
    private let bodyLabel = UILabel.setupLabel(with: .systemFont(ofSize: 15), tintColor: .gray, line: 3)
    private let dataLabel = UILabel.setupLabel(with: .systemFont(ofSize: 17), tintColor: .darkGray, line: 1)
    private var stackView: UIStackView!
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupStackView()
        setupCustomView()
        setupLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(event: EventModel) {
        headerLabel.text = event.title
        bodyLabel.text = event.bodyText
        dataLabel.text = event.dates[0].startDate
    }
    
}

private extension FavoriteEventsCell {
    
    func setupStackView() {
        stackView = UIStackView(arrangedSubviews: [headerLabel, bodyLabel, dataLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        customView.addSubview(stackView)
        headerLabel.text = "header header header header header header header header header"
        bodyLabel.text = "bodyLabel bodyLabel bodyLabel bodyLabel bodyLabel bodyLabel bodyLabel bodyLabel bodyLabel"
        dataLabel.text = "dataLabel dataLabel dataLabel dataLabel dataLabel dataLabel"
        
    }
    
    func setupCustomView() {
        customView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(customView)
    }
    
    func setupLayoutConstraints() {
        
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: contentView.topAnchor),
            customView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            customView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3)
        ])
        
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: customView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -50),
            stackView.bottomAnchor.constraint(equalTo: customView.bottomAnchor, constant: -10)
        ])
    }
    
    
}
