//
//  LoginVC.swift
//  EventApp 1
//
//  Created by Vova SKR on 23/11/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    
    private var button = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        
        button.frame.size = CGSize(width: 200, height: 40)
        button.center = view.center
        button.center.y += 300
        button.layer.cornerRadius = 20
        button.backgroundColor = .purple
        button.alpha = 1
        button.setTitle("Login", for: .normal)
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        view.addSubview(button)
        
    }
    
    @objc
       func login() {
        AppDelegate.shared.rootViewController.showMainScreen()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
