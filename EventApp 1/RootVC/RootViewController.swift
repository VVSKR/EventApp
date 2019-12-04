//
//  RootViewController.swift
//  EventApp 1
//
//  Created by Vova SKR on 23/11/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    var current: UIViewController
    
    init(){
        if UserDefaults.standard.returnNoFirstTime() {
            current = LoginVC()
        } else {
            current = WelcomeVC()
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(current)
        current.view.frame = view.bounds
        view.addSubview(current.view)
        current.didMove(toParent: self)
        
    }
    
    func switchToLoginScreen() {
        let newVC = UINavigationController(rootViewController: LoginVC())

        animateFadeTransition(to: newVC)
    }
    
    public func showMainScreen() {
        let newVC = MainTabBarController()
        animateFadeTransition(to: newVC)
    }
    
    private func animateFadeTransition(to newVC: UIViewController, completion: (() -> Void)? = nil) {
        current.willMove(toParent: nil)
        addChild(newVC)
        
        transition(from: current, to: newVC, duration: 0.3, options: [.transitionCrossDissolve, .curveEaseOut], animations: {
        }) { _ in
            self.current.removeFromParent()
            newVC.didMove(toParent: self)
            self.current = newVC
            completion?()
        }
    }
    
    private func animateDismissTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
        current.willMove(toParent: nil)
        addChild(new)
        transition(from: current, to: new, duration: 0.5, options: [.transitionFlipFromLeft, .curveEaseOut], animations: {
            new.view.frame = self.view.bounds
        }) { completed in
            self.current.removeFromParent()
            new.didMove(toParent: self)
            self.current = new
            completion?()
        }
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
