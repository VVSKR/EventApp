//
//  RegistrationVC.swift
//  EventApp 1
//
//  Created by Vova SKR on 06/12/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import UIKit

class RegistrationVC: UIViewController {
    
    
    // MARK: - UI
    private var loginTF = UITextField.logIn(with: "Почта")
    private var passwordTF = UITextField.logIn(with: "Пароль (не менее 6 символов)")
    private var repeatPasswordTF = UITextField.logIn(with: "Повторите пароль")
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
        networkManager.postSingUp(email: loginTF.text!, password: passwordTF.text!) { result in
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
        if !loginTF.text!.isEmpty
            && passwordTF.text!.count >= 6
            && passwordTF.text! == repeatPasswordTF.text! {
            
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
    
    
}



private extension RegistrationVC {
    
    func setupStackView() {
        loginTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        repeatPasswordTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        mainStackView = UIStackView(arrangedSubviews: [loginTF, passwordTF, repeatPasswordTF])
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
        buttonLogin.setTitle("Зарегестрироваться", for: .normal)
        buttonLogin.addTarget(self, action: #selector(login), for: .touchUpInside)
        buttonLogin.backgroundColor = .gray
        buttonLogin.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        buttonLogin.tintColor = .white
    }
    
    
    func setupConstraint() {
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainStackView.heightAnchor.constraint(equalToConstant: 210)
        ])
        
        NSLayoutConstraint.activate([
            buttonLogin.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            buttonLogin.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
            buttonLogin.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            buttonLogin.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}

// MARK: - TextField Delegate
extension RegistrationVC : UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

