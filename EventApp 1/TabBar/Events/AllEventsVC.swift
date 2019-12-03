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
    
    let networkManager: NetworkManager
    
    var events: EventsModel = EventsModel()
    
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
        
        view.backgroundColor = .yellow
        configureTableView()
        networkManager.getEvents(categories: .all) { (result) in
            switch result {
            case .success(let value):
                DispatchQueue.main.async {
                    self.events = value
                    print(self.events.results?.count)
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
        }
//        networkService.getEvents { (result) in
//            switch result {
//            case .success(let value):
//                DispatchQueue.main.async {
//                    self.events = value
//                    print(self.events.results?.count)
//                    self.tableView.reloadData()
//                }
//
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }

    
    
    // MARK: SetupTableView
    
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
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
    private func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    
    
}

// MARK: - Delegate, DataSourse

extension AllEventsVC: UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.results?.count ?? 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AllEventsCell.reuseId, for: indexPath) as! AllEventsCell
        cell.backgroundImage.image = UIImage(named: "three")
        guard let event = events.results?[indexPath.row] else { return cell }
        cell.set(value: event)
//        cell.accessoryType = .detailDisclosureButton
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let event = events.results?[indexPath.row] else { return }
        let detailEvent = DetailEventVC()
        detailEvent.event = event
        navigationController?.pushViewController(detailEvent, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.25) {
            if let cell = tableView.cellForRow(at: indexPath) as? AllEventsCell {
//                cell.eventView.transform = .init(scaleX: 0.95, y: 0.95)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
                UIView.animate(withDuration: 0.25) {
            if let cell = tableView.cellForRow(at: indexPath) as? AllEventsCell {
//                cell.eventView.transform = .identity
            }
        }

    }
    
        
}
