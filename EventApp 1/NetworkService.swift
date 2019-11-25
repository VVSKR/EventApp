//
//  NetworkService.swift
//  EventApp 1
//
//  Created by Vova SKR on 24/11/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import UIKit

class NetworkService {
    
    let session: URLSession
    
    private var queue = DispatchQueue(label: "loadEvents", qos: .default, attributes: .concurrent)
    
    
    init() {
        session = URLSession(configuration: .default)
    }
}
