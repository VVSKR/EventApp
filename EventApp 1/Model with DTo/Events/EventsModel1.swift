//
//  PlacesModel.swift
//  EventApp 1
//
//  Created by Vova SKR on 25/11/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct EventsModel1 {
    let count: Int
    let next: String
    let previous: String
    let results: [Result1]
}

// MARK: - Result
public struct Result1 {
    let title: String
    let bodyText, price: String
    let dates: [DateElement1]
    let place: Place1?
    let images: [Image1]
    let shortTitle: String
}

// MARK: - DateElement
struct DateElement1 {
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


