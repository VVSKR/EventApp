//
//  AllEventsVC.swift
//  EventApp 1
//
//  Created by Vova SKR on 23/11/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import UIKit

class AllEventsVC: UIViewController {
    
    let tableView = UITableView()
    var fetchingMore = false
    var pageNumber = 1
    let networkManager: NetworkManager
    
    var events: ResultEventsModel = ResultEventsModel()
    
    // MARK: Init
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init() {
        fatalError("use 'init networkService:' instead")
    }
    
    
    // MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureTableView()
        setupTabBar()
        
        networkManager.getEvents(categories: .theater, page: pageNumber) { (result) in
            switch result {
            case .success(let value):
                DispatchQueue.main.async {
                    self.events = value
                    print(self.events.results?.count as Any)
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        networkManager.firebaseGetData() { (result) in
            switch result {
            case .success(let value):
                UserSavedEvents.shared.savedEvents = value
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: SetupTableView
    
private extension AllEventsVC {
    
    func setupTabBar() {
        let rightBarItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(rightButtonPressed))
        navigationItem.rightBarButtonItem = rightBarItem
    }
    
    private func configureTableView() {
        setupTableView()
        setTableViewDelegates()
        
        tableView.register(AllEventsCell.self, forCellReuseIdentifier: AllEventsCell.reuseId)
        tableView.rowHeight = 250
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 10
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
    private func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc
    func rightButtonPressed() {
        
    }
    
    
    
    
}

// MARK: - Delegate, DataSourse

extension AllEventsVC: UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.results?.count ?? 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AllEventsCell.reuseId, for: indexPath) as! AllEventsCell
        
        cell.setPlaceHolder()
        guard let event = events.results?[indexPath.row] else { return cell }
        cell.set(value: event)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let event = events.results?[indexPath.row] else { return }
        let detailEvent = DetailEventVC()
        detailEvent.event = event
        navigationController?.pushViewController(detailEvent, animated: true)
    }
}


// MARK: - ScrollView
extension AllEventsVC {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.height * 2 && contentHeight > 2000 {
            if !fetchingMore {
//                beginBatchFetch()
            }
        }
    }
    
    func beginBatchFetch() {
        fetchingMore = true
        pageNumber += 1
        networkManager.getEvents(categories: .theater, page: pageNumber) { (result) in
            switch result {
            case .success(let value):
                DispatchQueue.main.async {
                    self.events.results? += value.results!
                    print(self.events.results?.count as Any)
                    self.tableView.reloadData()
                    self.fetchingMore = false
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
