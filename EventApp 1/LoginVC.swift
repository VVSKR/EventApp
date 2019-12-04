//
//  LoginVC.swift
//  EventApp 1
//
//  Created by Vova SKR on 23/11/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    
    // MARK: - UI
    private var loginTF = UITextField.logIn(with: "Login")
    private var passwordTF = UITextField.logIn(with: " Password")
    private var buttonLogin = UIButton(type: .system)
    private var mainStackView = UIStackView()
    
    
    var networkManager = NetworkManager()
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupStackView()
        setupButton()
        
        setupConstraint()
    }
    
    
    @objc
    func login() {
        UIView.animate(withDuration: 0.5, animations: {
            self.buttonLogin.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }, completion: { _ in
            UIView.animate(withDuration: 1, animations: {
                
                print(self.view.frame.width)
                self.buttonLogin.frame.size = CGSize(width: self.view.frame.width * 10, height: self.view.frame.height * 10)
//                self.buttonLogin.center = self.view.center
            }, completion: { _ in
                 AppDelegate.shared.rootViewController.showMainScreen() })
        })
       
    }
    
    @objc
    func login2() {
        networkManager.postSingUp(email: loginTF.text!, password: passwordTF.text!) { (_) in
            print("----!!!!!!!!!!----")
        }
        AppDelegate.shared.rootViewController.showMainScreen()
    }
}



private extension LoginVC {
    
    func setupStackView() {
        mainStackView = UIStackView(arrangedSubviews: [loginTF, passwordTF])
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.spacing = 60
        mainStackView.distribution = .fillEqually
        view.addSubview(mainStackView)
        
    }
    
    func setupButton() {
        view.addSubview(buttonLogin)
        buttonLogin.translatesAutoresizingMaskIntoConstraints = false
        buttonLogin.frame = .zero
        buttonLogin.layer.cornerRadius = 27
        buttonLogin.setTitle("Login", for: .normal)
        buttonLogin.addTarget(self, action: #selector(login2), for: .touchUpInside)
        buttonLogin.backgroundColor = UIColor.systemGray
        buttonLogin.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        buttonLogin.tintColor = .white
    }
    
    
    func setupConstraint() {
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainStackView.heightAnchor.constraint(equalToConstant: 140)
        ])
        
        NSLayoutConstraint.activate([
            buttonLogin.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            buttonLogin.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            buttonLogin.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120),
            buttonLogin.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}
