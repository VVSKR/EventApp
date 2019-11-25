//
//  DateModel.swift
//  EventApp 1
//
//  Created by Vova SKR on 25/11/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import Foundation

public struct Date {
    
    public var startDate: String
    public var startTime: String
    
    public var dto: DateDTO {
        var dto = DateDTO()
        dto.startDate = startDate
        dto.startTime = startTime
        return dto
    }
    
    init(dto: DateDTO) {
        startTime = dto.startTime ?? "00-00-00"
        startDate = dto.startDate ?? "2019"
    }
}
