//
//  ResultModel.swift
//  EventApp 1
//
//  Created by Vova SKR on 25/11/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import Foundation

public struct Result {
    
    public var title: String
    public var shortTitle: String
    public var bodyText: String
    public var price: String
    public var dates: Date
    public var place: Place
    public var image: Image
    
    
    var dto: ResultDTO {
        var dto = ResultDTO()
        dto.title = title
        dto.shortTitle = shortTitle
        dto.bodyText = bodyText
        dto.price = price
        dto.dates = [dates.dto]
        dto.place = place.dto
        dto.images = [image.dto]
        return dto
    }
    
    init(dto: ResultDTO) {
        title = dto.title ?? "Без названия"
        shortTitle = dto.shortTitle ?? "Без описания"
        bodyText = dto.bodyText ?? ""
        price = dto.price ?? "0000"
        dates = Date(dto:(dto.dates![0]))
        place = Place(dto: dto.place!)
        image = Image(dto: dto.images![0])
    }
}
