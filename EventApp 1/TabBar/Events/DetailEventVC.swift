//
//  DetailEvent.swift
//  EventApp 1
//
//  Created by Vova SKR on 27/11/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import UIKit

enum SaveHelper {
    case delete
    case save
    case noAction
}


class DetailEventVC: UIViewController {
    // MARK: - Constants
    var event: EventModel!
    struct Constants {
        static fileprivate let headerHeight: CGFloat = 210
    }
    
    // MARK: - Properties
    private var networkManager = NetworkManager()
    
    private var isSaved: Bool!
    private var saveHelper: SaveHelper = .noAction
    
    private var navTitle: String?
    private var scrollView: UIScrollView!
    private var detailView: UIView!
    private var headerContainerView: UIView!
    private var headerImageView: UIImageView!
    private var placeHolderImageView: LoadingAnimationView!
    private var rightNavBarButton: UIButton!
    
    
    private var headerLabel: UILabel!
    private var bodyLabel: UILabel!
    private var dateLabel: UILabel!
    private var priceLabel: UILabel!
    private var addressLabel: UILabel!
    
    private var mainStackView: UIStackView!
    
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isSavedEvent()
        setupView()
        print(isSaved)
        navigationController?.navigationBar.barStyle = .black
        view.backgroundColor = .white
        navigationController?.navigationBar.barStyle = .blackOpaque
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
        
        setupConstraints()
        guard let event = event else { return }
        
        
        set(value: event)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        saveOrDeleteInFavoriteEvents()
    }
    
    func isSavedEvent() {
        guard let event = event else { return }
        guard let savedEvent = UserSavedEvents.shared.savedEvents.first(where: { $0.id == event.id }) else { isSaved = false; return }
        self.event = savedEvent
        isSaved = true
    }
    
    
    // MARK: - Set Data
    func set(value: EventModel) {
        placeHolderImageView.startAnimating()
        guard let url = URL(string: value.images[0].image) else { return }
        title = value.title
        headerImageView.loadImage(url: url, alpha: 1) { [weak self] in
            self?.placeHolderImageView.stopAnimating()
            self?.placeHolderImageView.isHidden = true
        }
        headerLabel.text = value.title
        bodyLabel.text = value.bodyText
        dateLabel.text = "Событие состоится - \(String(describing: value.dates[0].startDate)) в \(String(describing: value.dates[0].startTime))"
        priceLabel.text = "Цена - \(value.price)"
        addressLabel.text = "Адрес - \(String(describing: value.place.address))"
        
    }
    
    
    @objc
    func rightButtonPressed() {
        let nameImage = isSaved ? "heart" : "heartRed"
        saveHelper = isSaved ? .delete : .save
        navigationItem.rightBarButtonItem?.image = UIImage(named: nameImage)?.withRenderingMode(.alwaysOriginal)
        isSaved = !isSaved
    }
    
    
    func saveOrDeleteInFavoriteEvents() {
        switch saveHelper {
        case .noAction: break
        case .save:
            guard event.date == nil else { return }
            saveEvent()
        case .delete:
            guard event.date != nil else { return }
            deleteEvent()
        }
    }
    
    func saveEvent() {
        let date = Int(Date().string())!
        event.date = date
        networkManager.firebasePutData(event: event,currentDate: date) { (_) in }
        UserSavedEvents.shared.savedEvents.append(event)
    }
    
    func deleteEvent() {
        // написать удаление по дате
    }
}



// MARK: - Setup UI

private extension DetailEventVC {
    
    func addBarItem() {
        let nameImage = isSaved ? "heartRed" : "heart"
        let image = UIImage(named: nameImage)?.withRenderingMode(.alwaysOriginal)
        let rightButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(rightButtonPressed))
        navigationItem.rightBarButtonItem = rightButtonItem
    }
    
    func setupView() {
        createDetailView()
        createScrollView()
        createHeaderContainerView()
        createHeaderImageView()
        createLabels()
        addStackView()
        addBarItem()
        
        
        view.addSubview(scrollView)
        scrollView.addSubview(headerContainerView)
        scrollView.addSubview(detailView)
        headerContainerView.addSubview(headerImageView)
        detailView.addSubview(mainStackView)
        createPlaceHolderImage()
    }
    
    
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
    }
    
    func createPlaceHolderImage() {
        placeHolderImageView = LoadingAnimationView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height / 2))
        placeHolderImageView.translatesAutoresizingMaskIntoConstraints = false
        headerImageView.addSubview(placeHolderImageView)
    }
    
    
    func createDetailView()  {
        detailView = UIView()
        detailView.translatesAutoresizingMaskIntoConstraints = false
        detailView.backgroundColor = .white
        
    }
    
    func createLabels() {
        headerLabel = UILabel.setupLabel(with: .boldSystemFont(ofSize: 24), tintColor: .black, line: 0)
        headerLabel.textAlignment = .center
        
        bodyLabel = UILabel.setupLabel(with: .systemFont(ofSize: 16), tintColor: .darkGray, line: 0)
        dateLabel = UILabel.setupLabel(with: .monospacedDigitSystemFont(ofSize: 16, weight: UIFont.Weight(rawValue: 2)), tintColor: .black, line: 0)
        priceLabel = UILabel.setupLabel(with: .systemFont(ofSize: 18), tintColor: .black, line: 0)
        addressLabel = UILabel.setupLabel(with: .systemFont(ofSize: 18), tintColor: .black, line: 0)
    }
    
    
    func addStackView() {
        
        mainStackView = UIStackView(arrangedSubviews: [headerLabel, bodyLabel, dateLabel, priceLabel, addressLabel])
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.spacing = 20
    }
    
    
    // MARK: - Setup Constraints
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let headerViewTopConstraint = headerContainerView.topAnchor.constraint(equalTo: view.topAnchor)
        headerViewTopConstraint.priority = UILayoutPriority(900)
        
        NSLayoutConstraint.activate([
            headerViewTopConstraint,
            headerContainerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1.0),
            headerContainerView.bottomAnchor.constraint(equalTo: detailView.topAnchor, constant: 0)
            
        ])
        
        NSLayoutConstraint.activate([
            headerImageView.topAnchor.constraint(equalTo: headerContainerView.topAnchor),
            headerImageView.leadingAnchor.constraint(equalTo: headerContainerView.leadingAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: headerContainerView.trailingAnchor),
            headerImageView.bottomAnchor.constraint(equalTo: headerContainerView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 210),
            detailView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1.0),
            detailView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: detailView.topAnchor, constant: 25),
            mainStackView.leadingAnchor.constraint(equalTo: detailView.leadingAnchor, constant: 25),
            mainStackView.trailingAnchor.constraint(equalTo: detailView.trailingAnchor, constant: -25),
            mainStackView.bottomAnchor.constraint(equalTo: detailView.bottomAnchor, constant: -25)
            
        ])
    }
}

// MARK: - ScrollView Delegate

extension DetailEventVC: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset.y / 210
        
        if offset > 0.9 { // исчкезает
            UIView.animate(withDuration: 0.4) {
                self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
                self.navigationController?.navigationBar.shadowImage = nil
                self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
                
            }
            
            
        } else { // появляется
            UIView.animate(withDuration: 0.4) {
                self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
                self.navigationController?.navigationBar.shadowImage = UIImage()
                self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
                
            }
        }
    }
}
