//
//  PlaceModel.swift
//  EventApp 1
//
//  Created by Vova SKR on 25/11/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import Foundation

public struct Place {
    
    public var title: String
    public var address: String
    public var subway: String
    
    var dto: PlaceDTO {
        let dto = PlaceDTO(title: title, address: address, subway: subway)
        return dto
    }
    
    init(dto: PlaceDTO) {
        title = dto.title ?? ""
        address = dto.address ?? "Москва"
        subway = dto.subway ?? ""
    }
}
