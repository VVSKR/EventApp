//
//  PresentVC.swift
//  EventApp 1
//
//  Created by Vova SKR on 10/12/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import UIKit

class PresentVC: UIViewController {
    
    let defaults = UserDefaults.standard
    
    let imageView = UIImageView()
    let label = UILabel.setupLabel(with: .boldSystemFont(ofSize: 30), tintColor: .black, line: 1)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupImageView()
        setupLabel()
        animation()
    }
    
    
    func animation() {
        UIView.animate(withDuration: 2, delay: 1, options: [], animations: {
            self.imageView.alpha = 1
            self.label.alpha = 1
        }) { (_) in
            if !self.defaults.returnNoFirstTime() {
                AppDelegate.shared.rootViewController.showWelcomeVC()
            } else if self.defaults.returnUserId() == "" {
                AppDelegate.shared.rootViewController.switchToLoginScreen()
            } else {
                AppDelegate.shared.rootViewController.showMainScreenFadeTransition()
            }
        }
    }
    
    
    func setupImageView() {
        view.addSubview(imageView)
        imageView.alpha = 0
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        imageView.image = UIImage(named: "kremlin")
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
            
        ])
        
    }
    
    func setupLabel() {
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.alpha = 0
        label.text = "Афиша Москвы"
        label.textAlignment = .center
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            label.widthAnchor.constraint(equalTo: imageView.widthAnchor),
            label.centerXAnchor.constraint(equalTo: imageView.centerXAnchor)
        ])
        
    }
    
    
    
}
