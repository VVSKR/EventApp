//
//  WelcomeCell.swift
//  EventApp
//
//  Created by Vova SKR on 22/11/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import UIKit

class WelcomeCell: UICollectionViewCell {
    
    static public let reuseId = "welcomeCell"
    
    public var page: Page? {
        didSet {
            headerLabel.text = page?.headerText
            bodyLabel.text = page?.bodyText
        }
    }
    
    private var headerLabel = UILabel()
    private var bodyLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.backgroundColor = .clear
        headerLabel.textColor = .black
        headerLabel.textAlignment = .center
        headerLabel.font = .boldSystemFont(ofSize: 22)
        addSubview(headerLabel)
        
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        bodyLabel.backgroundColor = .clear
        bodyLabel.textColor = .darkGray
        bodyLabel.textAlignment = .center
        bodyLabel.font = .systemFont(ofSize: 18)
        addSubview(bodyLabel)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupLayout() {
        
        NSLayoutConstraint.activate([
            headerLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -80),
            headerLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            headerLabel.heightAnchor.constraint(equalToConstant: 40),
            headerLabel.widthAnchor.constraint(equalToConstant: 250)
        ])
        
        NSLayoutConstraint.activate([
            bodyLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: -20),
            bodyLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            bodyLabel.heightAnchor.constraint(equalToConstant: 100),
            bodyLabel.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    
    
    
}
