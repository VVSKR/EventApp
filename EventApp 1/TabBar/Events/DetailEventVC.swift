//
//  DetailEvent.swift
//  EventApp 1
//
//  Created by Vova SKR on 27/11/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import UIKit

class DetailEventVC: UIViewController {
    // MARK: - Constants
    var event: ResultModel!
    struct Constants {
        static fileprivate let headerHeight: CGFloat = 210
    }
    
    // MARK: - Properties
    
    private var scrollView: UIScrollView!
    private var detailView: UIView!
    private var headerContainerView: UIView!
    private var headerImageView: UIImageView!
    
    private var headerLabel: UILabel!
    private var bodyLabel: UILabel!
    private var dateLabel: UILabel!
    private var priceLabel: UILabel!
    private var addressLabel: UILabel!
    
    private var mainStackView: UIStackView!
    
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        createDetailView()
        
        createScrollView()
        createHeaderContainerView()
        createHeaderImageView()
        createLabels()
        addStackView()
        
        view.addSubview(scrollView)
        scrollView.addSubview(headerContainerView)
        scrollView.addSubview(detailView)
        headerContainerView.addSubview(headerImageView)
        detailView.addSubview(mainStackView)
        
        arrangeConstraints()
        set(value: event)
        
    }
    
    func set(value: ResultModel) {
        let url = URL(string: value.images[0].image)!
        headerImageView.loadImage(url: url, alpha: 1)
        headerLabel.text = value.title
        bodyLabel.text = value.bodyText
        dateLabel.text = "Событие пройдет - \(String(describing: value.dates[0].startDate)) в \(String(describing: value.dates[0].startTime))"
        priceLabel.text = "Цена - \(value.price)"
        addressLabel.text = "Адресс - \(String(describing: value.place?.address))"
    }
}


// MARK: - CreateViews

private extension DetailEventVC {
    
    func createScrollView()  {
        scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInsetAdjustmentBehavior = .automatic
    }
    
    func createHeaderContainerView(){
        headerContainerView = UIView()
        headerContainerView.clipsToBounds = true
        headerContainerView.backgroundColor = .green
        headerContainerView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func createHeaderImageView() {
        headerImageView = UIImageView()
        headerImageView.translatesAutoresizingMaskIntoConstraints = false
        headerImageView.contentMode = .scaleAspectFill
        headerImageView.clipsToBounds = true
        if let image = UIImage(named: "three") {
            headerImageView.image = image
        }
        headerImageView.clipsToBounds = true
        
    }
    
    func createDetailView()  {
        detailView = UIView()
        detailView.translatesAutoresizingMaskIntoConstraints = false
        detailView.backgroundColor = .white
        //        let titleFont = UIFont.preferredFont(forTextStyle: .title1)
        //        if let boldDescriptor = titleFont.fontDescriptor.withSymbolicTraits(.traitBold) {
        //            label.font = UIFont(descriptor: boldDescriptor, size: 0)
        //        } else {
        //            label.font = titleFont
        //        }
        //        label.textAlignment = .center
        //        label.adjustsFontForContentSizeCategory = true
        //        label.numberOfLines = 0
        
    }
    
    func createLabels() {
        headerLabel = UILabel.customLabel(with: .largeTitle, tintColor: .white)
        headerLabel.textAlignment = .center
        bodyLabel = UILabel.customLabel(with: .body, tintColor: .white)
        dateLabel = UILabel.customLabel(with: .title1, tintColor: .white)
        priceLabel = UILabel.customLabel(with: .title2, tintColor: .white)
        addressLabel = UILabel.customLabel(with: .title3, tintColor: .white)
    
        
        
    }
    
    func addStackView() {
        
        mainStackView = UIStackView(arrangedSubviews: [headerLabel, bodyLabel, dateLabel, priceLabel, addressLabel])
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.spacing = 10
        
    }
    
    
    // MARK: - setupConstraints
    
    func arrangeConstraints() {
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        
        NSLayoutConstraint.activate([
            headerContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            headerContainerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1.0),
            headerContainerView.heightAnchor.constraint(equalToConstant: 210),
//            headerContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/4),
            headerContainerView.bottomAnchor.constraint(equalTo: detailView.topAnchor, constant: 0)
            
        ])
        
        NSLayoutConstraint.activate([
            headerImageView.topAnchor.constraint(equalTo: headerContainerView.topAnchor),
            headerImageView.leadingAnchor.constraint(equalTo: headerContainerView.leadingAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: headerContainerView.trailingAnchor),
            headerImageView.bottomAnchor.constraint(equalTo: headerContainerView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
//            detailView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: view.bounds.size.height / 4),
            detailView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 210),
            detailView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1.0),
            detailView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: detailView.topAnchor, constant: 20),
            mainStackView.leadingAnchor.constraint(equalTo: detailView.leadingAnchor, constant: 15),
            mainStackView.trailingAnchor.constraint(equalTo: detailView.trailingAnchor, constant: -15),
            mainStackView.bottomAnchor.constraint(equalTo: detailView.bottomAnchor, constant: -20)
        
        ])
        
        
        
    }
}

extension DetailEventVC: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //        //            headerHeightConstraint.constant = max(headerContainerView.bounds.height, headerContainerView.bounds.height - scrollView.contentOffset.y )
        //        print(headerHeightConstraint.constant)
        //        if scrollView.contentOffset.y < 0.0 {
        //
        //            //            headerHeightConstraint?.constant = -scrollView.contentOffset.y + 100
        //            //                Constants.headerHeight - scrollView.contentOffset.y
        //            //            headerContainerView.layoutIfNeeded()
        //            print(headerHeightConstraint.constant)
        //        }
        //        else {
        //            let parallaxFactor: CGFloat = 0.25
        //            let offsetY = scrollView.contentOffset.y * parallaxFactor
        //            let minOffsetY: CGFloat = 30
        //            let availableOffset = min(offsetY, minOffsetY)
        //            let contentRectOffsetY = availableOffset / Constants.headerHeight
        //            headerTopConstraint?.constant = view.frame.origin.y
        //            headerHeightConstraint?.constant = Constants.headerHeight - scrollView.contentOffset.y
        //            headerImageView.layer.contentsRect = CGRect(x: 0, y: -contentRectOffsetY, width: 0, height: 0)
        //        }
    }
}
