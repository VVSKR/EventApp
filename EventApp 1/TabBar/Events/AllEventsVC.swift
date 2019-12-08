//
//  AllEventsVC.swift
//  EventApp 1
//
//  Created by Vova SKR on 23/11/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import UIKit

class AllEventsVC: UIViewController, SelectCategoryVCDelegate {
    
    let tableView = UITableView()
    let networkManager: NetworkManager
    let transition = PopAnimator()
    var events: ResultEventsModel = ResultEventsModel()
    var selectCategoryVC = SelectCategoryVC()
    
    var fetchingMore = false
    var pageNumber = 1
    var currentCategory: Categories = .theater
    
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
        title = currentCategory.nameCategory
        print(UserDefaults.standard.returnUserId())
        print("==== UserDefaults ====")
        view.backgroundColor = .white
        configureTableView()
        setupTabBar()
        getEventsRequest()
        firebaseGetDataRequest()
        
        
    }
    
    // MARK: - Network Request
    
    func getEventsRequest() {
        networkManager.getEvents(categories: currentCategory, page: pageNumber) { (result) in
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
    }
    
    func firebaseGetDataRequest() {
        networkManager.firebaseGetData() { (result) in
            switch result {
            case .success(let value):
                UserSavedEvents.shared.savedEvents = value
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Right Button Pressed
    
    @objc
    func rightButtonPressed() {
        selectCategoryVC.delegate = self
        selectCategoryVC.setup(currentCategories: currentCategory, title: title)
        let selectCategory = UINavigationController(rootViewController: selectCategoryVC)
        present(selectCategory, animated: true, completion: nil)
    }
    
    // MARK: - Delegate Func
    func setCategory(data: Categories) {
        pageNumber = 1
        currentCategory = data
        title = currentCategory.nameCategory
        getEventsRequest()
        events.results = nil
        tableView.reloadData()
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
        
        detailEvent.transitioningDelegate = self
        detailEvent.hidesBottomBarWhenPushed = true
        detailEvent.event = event
        navigationController?.pushViewController(detailEvent, animated: true)
    }
}


// MARK: -  Load new element
extension AllEventsVC {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.height * 2 && contentHeight > 2000 {
            if !fetchingMore {
                beginBatchFetch()
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

extension AllEventsVC: UIViewControllerTransitioningDelegate {
    
    func animationController( forPresented presented: UIViewController,
                              presenting: UIViewController,
                              source: UIViewController)
        -> UIViewControllerAnimatedTransitioning? {
            return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController)
        -> UIViewControllerAnimatedTransitioning? {
      return nil
    }
}
