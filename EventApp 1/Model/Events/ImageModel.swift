//
//  ImageModel.swift
//  EventApp 1
//
//  Created by Vova SKR on 25/11/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import Foundation

public struct Image {
    
    public var image: String
    
    var dto: ImageDTO {
        var dto = ImageDTO()
        dto.image = image
        return dto
    }
    
    init(dto: ImageDTO) {
        image = dto.image ?? ""
    }
}
