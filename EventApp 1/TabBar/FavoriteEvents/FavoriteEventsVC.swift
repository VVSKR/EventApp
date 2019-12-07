//
//  FavoriteEventsVC.swift
//  EventApp 1
//
//  Created by Vova SKR on 23/11/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import UIKit

class FavoriteEventsVC: UIViewController {
    
    var tableView = UITableView()
    var event: [EventModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        event = UserSavedEvents.shared.savedEvents
        tableView.reloadData()
//        print(UserSavedEvents.shared.savedEvents.count)
    }

    
    private func configureTableView() {
        setupTableView()
        setTableViewDelegates()
        
        tableView.register(FavoriteEventsCell.self, forCellReuseIdentifier: FavoriteEventsCell.reuseId)
        tableView.rowHeight = 170
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.estimatedRowHeight = 10
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    
    
}

extension FavoriteEventsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return event.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteEventsCell.reuseId, for: indexPath) as! FavoriteEventsCell
        let event = self.event[indexPath.row]
        cell.set(event: event)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        let detailEvent = DetailEventVC()
        detailEvent.event = event[indexPath.row]
        navigationController?.pushViewController(detailEvent, animated: true)
    }

    
    
}
