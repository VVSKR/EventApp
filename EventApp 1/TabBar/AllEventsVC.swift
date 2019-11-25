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
    
    let networkService: NetworkService
    
    
    // MARK: Init
    
    init(networkService: NetworkService) {
        self.networkService = networkService
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
    }
    
    
    // MARK: SetupTableView
    
    private func configureTableView() {
        setupTableView()
        setTableViewDelegates()
        
        tableView.register(AllEventsCell.self, forCellReuseIdentifier: AllEventsCell.reuseId)
        tableView.rowHeight = 300
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

extension AllEventsVC: UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AllEventsCell.reuseId, for: indexPath) as! AllEventsCell
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.25) {
            if let cell = tableView.cellForRow(at: indexPath) as? AllEventsCell {
                cell.eventView.transform = .init(scaleX: 0.95, y: 0.95)
//                cell.contentView.backgroundColor = .lightGray
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
                UIView.animate(withDuration: 0.25) {
            if let cell = tableView.cellForRow(at: indexPath) as? AllEventsCell {
                cell.eventView.transform = .identity
//                cell.contentView.backgroundColor = .white
            }
        }

    }
    
    
}

//override func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
//    UIView.animate(withDuration: 0.5) {
//        if let cell = collectionView.cellForItem(at: indexPath) as? CustomCell {
//            cell.imageView.transform = .init(scaleX: 0.95, y: 0.95)
//            cell.contentView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
//        }
//    }
//}
//
//override func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
//    UIView.animate(withDuration: 0.5) {
//        if let cell = collectionView.cellForItem(at: indexPath) as? CustomCell {
//            cell.imageView.transform = .identity
//            cell.contentView.backgroundColor = .clear
//        }
//    }
//}
