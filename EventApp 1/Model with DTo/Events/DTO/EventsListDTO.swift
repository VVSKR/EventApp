//
//  EventsListDTO.swift
//  EventApp 1
//
//  Created by Vova SKR on 25/11/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import Foundation

public struct EventsListDTO: Codable {
    
   public var count: Int?
   public var next: String?
   public var previous: String?
   public var results: [ResultDTO]?
    
}
