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
    private var loginTF = UITextField.logIn(with: "Почта")
    private var passwordTF = UITextField.logIn(with: "Пароль")
    
    private var buttonLogin = UIButton(type: .system)
    private var registrationButton = UIButton(type: .system)
    
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
                self.buttonLogin.center = self.view.center
            }, completion: { _ in })
        })
    }
    
    
    @objc
    func login2() {
//        AppDelegate.shared.rootViewController.showMainScreen()
        networkManager.postSingIn(email: loginTF.text!, password: passwordTF.text!) { result in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    guard let userId = user.localId else { return }
                    UserDefaults.standard.setUserId(id: userId)
                    print(userId)
                    AppDelegate.shared.rootViewController.showMainScreen()
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self.buttonLogin.shake()
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    @objc
    func textFieldDidChange(_ textField: UITextField) {
        if !loginTF.text!.isEmpty && passwordTF.text!.count >= 6 {
            UIView.animate(withDuration: 0.5) {
                self.buttonLogin.backgroundColor = .mainRed
                self.buttonLogin.isEnabled = true
            }
            return
        }
        UIView.animate(withDuration: 0.5) {
            self.buttonLogin.backgroundColor = .gray
            self.buttonLogin.isEnabled = false
        }
    }
    
    @objc
    func registrationButtonTap() {
        navigationController?.pushViewController(RegistrationVC(), animated: true)
    }
    
    
}


// MARK: - Setup UI
private extension LoginVC {
    
    func setupStackView() {
        loginTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
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
        buttonLogin.isEnabled = false
        buttonLogin.frame = .zero
        buttonLogin.layer.cornerRadius = 27
        buttonLogin.setTitle("Войти", for: .normal)
        buttonLogin.addTarget(self, action: #selector(login2), for: .touchUpInside)
        buttonLogin.backgroundColor = .gray
        buttonLogin.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        buttonLogin.tintColor = .white
        
        view.addSubview(registrationButton)
        registrationButton.translatesAutoresizingMaskIntoConstraints = false
        registrationButton.frame = .zero
        registrationButton.setTitle("Еще не заренистрированы? Нажмите сюда", for: .normal)
        registrationButton.titleLabel?.numberOfLines = 0
        registrationButton.titleLabel?.textAlignment = .center
        registrationButton.addTarget(self, action: #selector(registrationButtonTap), for: .touchUpInside)
        registrationButton.backgroundColor = .clear
        registrationButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        registrationButton.tintColor = .lightBlue
        
        
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
            buttonLogin.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            buttonLogin.heightAnchor.constraint(equalToConstant: 55)
        ])
        
        NSLayoutConstraint.activate([
            registrationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            registrationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            registrationButton.bottomAnchor.constraint(equalTo: buttonLogin.topAnchor, constant: -10),
            registrationButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}

// MARK: - TextField Delegate
extension LoginVC : UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}








//@objc
//func login2() {
//    networkManager.postSingUp(email: loginTF.text!, password: passwordTF.text!) { result in
//        DispatchQueue.main.async {
//            UIView.animate(withDuration: 0.4, animations: {
//                self.buttonLogin.transform = CGAffineTransform(scaleX: 0.90, y: 0.90)
//            }, completion: { _ in
//
//                switch result {
//                case .success(let user):
//                    guard let userId = user.localId else { return }
//                    UserDefaults.standard.setUserId(id: userId)
//                    print(UserDefaults.standard.returnUserId())
//                    AppDelegate.shared.rootViewController.showMainScreen()
//                case .failure(let error):
//                    UIView.animate(withDuration: 0.4, animations: {
//                        self.buttonLogin.transform = CGAffineTransform.identity
//                    }, completion: { _ in
//                        self.buttonLogin.shake()
//                        print(error.localizedDescription)
//                    })
//                }
//            })
//        }
//    }
