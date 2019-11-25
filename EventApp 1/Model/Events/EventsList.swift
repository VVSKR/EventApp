//
//  EventsList.swift
//  EventApp 1
//
//  Created by Vova SKR on 25/11/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import Foundation

struct EventsList {
    var count: Int
    var next: String
    var previous: String
    var results: [Result]
    
    var dto: EventsListDTO {
        var dto = EventsListDTO()
//        dto.results =
        return dto
    }
    
    init(dto: EventsListDTO) {
        count = dto.count ?? 0
        next = dto.next ?? ""
        previous = dto.previous ?? ""
        results = dto.results ?? ""
    }
}
