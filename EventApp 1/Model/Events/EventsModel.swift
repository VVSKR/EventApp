//
//  PlacesModel.swift
//  EventApp 1
//
//  Created by Vova SKR on 25/11/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct EventsModel {
    let count: Int
    let next: String
    let previous: String
    let results: [Result]
}

// MARK: - Result
public struct Result {
    let title: String
    let bodyText, price: String
    let dates: [DateElement]
    let place: Place?
    let images: [Image]
    let shortTitle: String
}

// MARK: - DateElement
struct DateElement {
    let startDate: String?
    let startTime: String?
}

// MARK: - Image
struct Image1 {
    let image: String
   
}

// MARK: - Place
struct Place1 {
   
    let title: String
    let address: String
    let subway: String
}


