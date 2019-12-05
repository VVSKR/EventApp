//
//  AllEventsCell.swift
//  EventApp 1
//
//  Created by Vova SKR on 24/11/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import UIKit

class AllEventsCell: UITableViewCell {
    
    static let reuseId = "allEventsCell"
    
    // MARK: - Constants
    
    struct Constants {
         static fileprivate let cornerRadius: CGFloat = 20
    }

   
     // MARK: - Properties
    
    private let backgroundImage = UIImageView()
    private let placeHolderImageView = SkeletonView()
    private let eventView = UIView()
    private var stackView: UIStackView!
    
    private let headerLabel = UILabel.setupLabel(with: .boldSystemFont(ofSize: 20), tintColor: .white, line: 3)
    private let bodyLabel = UILabel.setupLabel(with: .systemFont(ofSize: 14), tintColor: .white, line: 2)
    private let dateLabel = UILabel.setupLabel(with: .systemFont(ofSize: 16), tintColor: .white, line: 2)
    private let categoryLabel = UILabel.setupLabel(with: .systemFont(ofSize: 16), tintColor: .white, line: 1)
    
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setEventView()
        setImageView()
        setStackView()
        setCategoryLabelConstaints()
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set
    
    public func set(value: EventModel) {
        let url = URL(string: (value.images[0].thumbnails?.the640X384!)!)!
        backgroundImage.loadImage(url: url, alpha: 0.55) { [weak self] in
            self?.placeHolderImageView.stopAnimating()
            self?.placeHolderImageView.isHidden = true
        }
       
        headerLabel.text = value.title
        bodyLabel.text = value.bodyText
        dateLabel.text = value.dates[0].startDate
    }
    
    public func setPlaceHolder() {
        placeHolderImageView.startAnimating()
    }
}
    
    // MARK: - Configure View
    
private extension AllEventsCell {
        
    private func setEventView() {
        self.addSubview(eventView)
        eventView.backgroundColor = .black
        setEventViewConstraints()
        addShadow()
        
    }
    
    
    private func addShadow() {
        eventView.layer.cornerRadius = Constants.cornerRadius
        eventView.layer.shadowColor = UIColor.black.cgColor
        eventView.layer.shadowOpacity = 0.4
        eventView.layer.shadowRadius = 10
        eventView.layer.shadowOffset = CGSize(width: 1, height: 2)
    }
    
    private func setImageView() {
        eventView.addSubview(backgroundImage)
        
        backgroundImage.layer.cornerRadius = Constants.cornerRadius
        backgroundImage.clipsToBounds = true
        backgroundImage.contentMode = .scaleAspectFill
        
       
//        skeletonView.setMaskingViews([placeHolderImageView])
        
      
        setImageViewConstraints()
        setPlaceHolderImage()
    }
    
    
    private func setPlaceHolderImage() {
        backgroundImage.addSubview(placeHolderImageView)
        placeHolderImageView.frame = CGRect(x: 0, y: 0, width: 400, height: 250)
        placeHolderImageView.layer.cornerRadius = Constants.cornerRadius
        placeHolderImageView.clipsToBounds = true
        placeHolderImageView.backgroundColor = .lightGray
    }
    
    
    
    
    private func setStackView() {
        stackView = UIStackView(arrangedSubviews: [headerLabel, bodyLabel, dateLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
//        stackView.alignment = .leading
//        stackView.distribution = .fill
        eventView.addSubview(stackView)
        setStackViewConstraints()
    }
    
    
    // MARK: - Set Constraints
    
    
    private func setEventViewConstraints() {
        eventView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            eventView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            eventView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            eventView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            eventView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
    
    
    private func setImageViewConstraints() {
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: eventView.topAnchor, constant: 0),
            backgroundImage.bottomAnchor.constraint(equalTo: eventView.bottomAnchor, constant: 0),
            backgroundImage.leadingAnchor.constraint(equalTo: eventView.leadingAnchor, constant: 0),
            backgroundImage.trailingAnchor.constraint(equalTo: eventView.trailingAnchor, constant: 0),
        ])
    }
    
    private func setStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor, constant: 10),
            stackView.widthAnchor.constraint(equalTo: backgroundImage.widthAnchor, multiplier: 5/6)
        ])
    }
    
    private func setCategoryLabelConstaints() {
        eventView.addSubview(categoryLabel)
        categoryLabel.text = "Category"
        categoryLabel.backgroundColor = .red
        
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: backgroundImage.topAnchor, constant: 15),
            categoryLabel.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor, constant: 15)
        ])
    }
}

