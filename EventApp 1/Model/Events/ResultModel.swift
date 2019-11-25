//
//  ResultModel.swift
//  EventApp 1
//
//  Created by Vova SKR on 25/11/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import Foundation

public struct ResultModel {
    
    public var title: String
    public var shortTitle: String
    public var bodyText: String
    public var price: String
    public var dates: [Date]
    public var place: Place
    public var images: [Image]
    
    
    var dto: ResultDTO {
        var dto = ResultDTO()
        dto.title = title
        dto.shortTitle = shortTitle
        dto.bodyText = bodyText
        dto.price = price
//        dto.dates = dates
        dto.place = place.dto
//        dto.images = images
        return dto
    }
    
    init(dto: ResultDTO) {
        title = dto.title ?? "Без названия"
        shortTitle = dto.shortTitle ?? "Без описания"
        bodyText = dto.bodyText ?? ""
        price = dto.price ?? "0000"
//        dates = dto.d
        place = dto.place
    }

}
