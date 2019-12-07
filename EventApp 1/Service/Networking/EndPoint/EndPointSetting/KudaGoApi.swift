//
//  KudaGoApi.swift
//  EventApp 1
//
//  Created by Vova SKR on 05/12/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import Foundation

public enum KudaGoApi {
    case events(categories: Categories, page: Int)
}

public enum Categories: String {
    case all = ""
    case concert = "concert"
    case festival = "festival"
    case theater = "theater"
    case standUp = "stand-up"
}
