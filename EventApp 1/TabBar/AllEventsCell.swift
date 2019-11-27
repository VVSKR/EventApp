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
    
    public let eventView = UIView()
    let backgroundImage = UIImageView()
    var mainImage = String()
    private let headerLabel = UILabel.tableViewLabel(with: .boldSystemFont(ofSize: 20))
    private let bodyLabel = UILabel.tableViewLabel(with: .systemFont(ofSize: 18))
    private let dateLabel = UILabel.tableViewLabel(with: .systemFont(ofSize: 18))
    private let categoryLabel = UILabel.tableViewLabel(with: .systemFont(ofSize: 16))
    
    
    private let cornerRadius: CGFloat = 20
    private var stackView: UIStackView!
    
    
    //MARK: Init
    
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
    
    func set(value: ResultModel) {
        let url = URL(string: value.images[0].thumbnails.the640X384!)!
        ImageService.getImage(withURL: url) { [weak self] (image) in
            self?.backgroundImage.image = image
        }
//        backgroundImage.load(url: url)
//        let image = backgroundImage.image
        headerLabel.text = value.title
        bodyLabel.text = value.body_text
        dateLabel.text = value.dates[0].start_date
//        categoryLabel.text = value.
        
    }
    
    
    // MARK: Configure View
    
    private func setEventView() {
        self.addSubview(eventView)
        eventView.backgroundColor = .white
        
        setEventViewConstraints()
        addShadow()
        
    }
    
    
    private func addShadow() {
        eventView.layer.cornerRadius = cornerRadius
        eventView.layer.shadowColor = UIColor.black.cgColor
        eventView.layer.shadowOpacity = 0.4
        eventView.layer.shadowRadius = 10
        eventView.layer.shadowOffset = CGSize(width: -1, height: 1)
    }
    
    private func setImageView() {
        eventView.addSubview(backgroundImage)
        
        backgroundImage.layer.cornerRadius = cornerRadius
        backgroundImage.clipsToBounds = true
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.alpha = 0.6
        setImageViewConstraints()
    }
    
    private func setLabel() {
        
        headerLabel.text = "Header "
        bodyLabel.text = "BodyLabel "
        dateLabel.text = "addss Labeladdss Labeladdss Labeladdss Labeladdss Labeladdss Labeladdss Label"
    }
    
    
    
    private func setStackView() {
        setLabel()
        stackView = UIStackView(arrangedSubviews: [headerLabel, bodyLabel, dateLabel])
        
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .leading
        stackView.distribution = .fill
        eventView.addSubview(stackView)
        setStackViewConstraints()
    }
    
    
    // MARK: Set Constraints
    
    
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
            stackView.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: -5),
            stackView.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor, constant: 10),
            stackView.widthAnchor.constraint(equalTo: backgroundImage.widthAnchor, multiplier: 3/4),
            stackView.heightAnchor.constraint(equalTo: backgroundImage.heightAnchor, multiplier: 1/2)
        ])
    }
    
    private func setCategoryLabelConstaints() {
        eventView.addSubview(categoryLabel)
        categoryLabel.text = "Category"
        categoryLabel.backgroundColor = .red
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: backgroundImage.topAnchor, constant: 15),
            categoryLabel.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor, constant: 15)
//            stackView.widthAnchor.constraint(equalTo: backgroundImage.widthAnchor, multiplier: 3/4),
//            stackView.heightAnchor.constraint(equalTo: backgroundImage.heightAnchor, multiplier: 1/2)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        backgroundImage.image = UIImage(named: "three")
        
    }

}

