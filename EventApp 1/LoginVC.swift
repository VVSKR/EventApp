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
    private lazy var imageView = UIImageView()
    private lazy var loginTF = UITextField.logIn(with: "Почта")
    private lazy var passwordTF = UITextField.logIn(with: "Пароль")
    
    private lazy var loginButton = UIButton(type: .system)
    private lazy var registrationButton = UIButton(type: .system)
    
    private lazy var mainStackView = UIStackView()
    
    
    var networkManager = NetworkManager()
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Вход"
        
        setupImageVIew()
        setupStackView()
        setupButton()
        setupConstraint()
    }
    
    
   
    
    
    @objc
    func loginButtonPTap() {
//         AppDelegate.shared.rootViewController.showMainScreen()
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
                    self.loginButton.shake()
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    @objc
    func textFieldDidChange(_ textField: UITextField) {
        if !loginTF.text!.isEmpty && passwordTF.text!.count >= 6 {
            UIView.animate(withDuration: 0.5) {
                self.loginButton.backgroundColor = .mainRed
                self.loginButton.isEnabled = true
            }
            return
        }
        UIView.animate(withDuration: 0.5) {
            self.loginButton.backgroundColor = .gray
            self.loginButton.isEnabled = false
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
    
    func setupImageVIew() {
          view.addSubview(imageView)
          imageView.translatesAutoresizingMaskIntoConstraints = false
          imageView.contentMode = .scaleAspectFill
          imageView.clipsToBounds = true
          imageView.image = UIImage(named: "three")
          imageView.backgroundColor = .green
      }
    
    func setupButton() {
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
//        buttonLogin.isEnabled = false
        loginButton.frame = .zero
        loginButton.layer.cornerRadius = 27
        loginButton.setTitle("Войти", for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonPTap), for: .touchUpInside)
        loginButton.backgroundColor = .gray
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        loginButton.tintColor = .white
        
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
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 40),
            mainStackView.heightAnchor.constraint(equalToConstant: 140)
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            imageView.bottomAnchor.constraint(equalTo: mainStackView.topAnchor, constant: -40),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            loginButton.heightAnchor.constraint(equalToConstant: 55)
        ])
        
        NSLayoutConstraint.activate([
            registrationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            registrationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            registrationButton.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -10),
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


// @objc
//    func login() {
//        UIView.animate(withDuration: 0.5, animations: {
//            self.buttonLogin.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
//        }, completion: { _ in
//            UIView.animate(withDuration: 1, animations: {
//                print(self.view.frame.width)
//                self.buttonLogin.frame.size = CGSize(width: 1000, height: 1000)
////                self.buttonLogin.center = self.view.center
//            }, completion: { _ in })
//        })
//    }
