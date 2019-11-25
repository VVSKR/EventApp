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
    }
    
    func returnNoFirstTime() -> Bool {
        return bool(forKey: "isFirstTime")
    }
}
