//
//  UserEvents.swift
//  EventApp 1
//
//  Created by Vova SKR on 07/12/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import Foundation

class UserSavedEvents {
    
    static var shared = UserSavedEvents()
    
    var savedEvents:[EventModel] = []
    
    private init() { }
}



extension UserSavedEvents: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
