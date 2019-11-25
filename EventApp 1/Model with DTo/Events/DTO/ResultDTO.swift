//
//  ResultModel.swift
//  EventApp 1
//
//  Created by Vova SKR on 25/11/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import Foundation

public struct ResultDTO: Codable {
    
    public var title: String?
    public var bodyText: String?
    public var price: String?
    public var dates: [DateDTO]?
    public var place: PlaceDTO?
    public var images: [ImageDTO]?
    public var shortTitle: String?
}
