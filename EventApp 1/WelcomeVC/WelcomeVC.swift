//
//  WelcomeVC.swift
//  EventApp
//
//  Created by Vova SKR on 22/11/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {
    
    private var collectionView: UICollectionView!
    
    private var nextButton = UIButton(type: .system)
    private var skipButton = UIButton(type: .system)
    private var pageControl = UIPageControl()
    
    let pages = [Page(headerText:"firstPage", bodyText: "firstPagefirstPagefirstPagefirstPager"), Page(headerText: "secondPage", bodyText: "secondPagesecondPagesecondPage"), Page(headerText: "thirdPage", bodyText: "thirdPagethirdPagethirdPage")]
    
    // MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCollectionView()
        setupButton()
        
    }
    
    // MARK: Setup Button
    
    private func setupButton() {
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.backgroundColor = .mainRed
        nextButton.tintColor = .white
        nextButton.titleLabel?.font = .systemFont(ofSize: 19)
        nextButton.layer.cornerRadius = 10
        nextButton.setTitle("Дальше", for: .normal)
        nextButton.addTarget(self, action: #selector(nextButtonTap), for: .touchUpInside)
        view.addSubview(nextButton)
        
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        skipButton.setTitle("Пропустить", for: .normal)
        skipButton.tintColor = .gray
        skipButton.addTarget(self, action: #selector(skipButtonTap), for: .touchUpInside)
        view.addSubview(skipButton)
        
        setUpPageControll()
        setupLayout()
    }
    
    // MARK: PageControll
    
    private func setUpPageControll() {
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .systemGray
        pageControl.currentPageIndicatorTintColor = .mainRed
        view.addSubview(pageControl)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPos = scrollView.contentOffset.x / view.frame.width
        pageControl.currentPage = Int(scrollPos + 0.5)
        nextButton.alpha = CGFloat(pages.count - 1) - scrollPos
    }
    
    // MARK: SetupLayout
    
    private func setupLayout() {
        let safeArea = self.view.safeAreaLayoutGuide
        let heightButton: CGFloat = 55
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            skipButton.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -15),
            skipButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 40),
            skipButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -40),
            skipButton.heightAnchor.constraint(equalToConstant: heightButton)
        ])
        
        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: skipButton.topAnchor, constant: -10),
            nextButton.leadingAnchor.constraint(equalTo: skipButton.leadingAnchor, constant: 0),
            nextButton.trailingAnchor.constraint(equalTo: skipButton.trailingAnchor, constant: 0),
            nextButton.heightAnchor.constraint(equalToConstant: heightButton)
        ])
        
        
    }
    
    // MARK: Setup CollectionView
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.size.width,
                                 height: view.frame.size.height)
        
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        collectionView = UICollectionView(frame: view.frame,
                                          collectionViewLayout: layout)
        collectionView.register(WelcomeCell.self, forCellWithReuseIdentifier: WelcomeCell.reuseId)
        
        collectionView.backgroundColor = .red
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        //        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        
    }
    
    @objc
    private func skipButtonTap() {
//        UserDefaults.standard.setNoFirstTime()  // раскоментить на релизе
        AppDelegate.shared.rootViewController.switchToLoginScreen()
    }
    
    @objc
    private func nextButtonTap() {
        let indexPath = IndexPath(item: pageControl.currentPage + 1, section: 0)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
    
}

// MARK: Delegate, DataSourse

extension WelcomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WelcomeCell.reuseId, for: indexPath) as! WelcomeCell
      
        cell.set(page: pages[indexPath.item])

        return cell
    }
    
    
}
