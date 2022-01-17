//
//  UserDefaults.swift
//  EventApp 1
//
//  Created by Vova SKR on 23/11/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    func setNoFirstTime(value: Bool = true) {
        set(value, forKey: "isFirstTime")
        synchronize()
    }
    
    func returnNoFirstTime() -> Bool {
        return bool(forKey: "isFirstTime")
    }
    
    
    // MARK: - UserID
    
    func setUserId(id: String, userName: String) {
        set(id, forKey: "UserId")
        set(userName, forKey: "UserName")
        synchronize()
    }
    
    func returnUserId() -> String {
        return string(forKey: "UserId") ?? ""
    }
    
    func returmUserEmail() -> String {
        return string(forKey: "UserName") ?? "userName"
    }
    
    func deleteUserId() {
        setUserId(id: "", userName: "")
    }
}
