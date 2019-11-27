//
//  EventsModel.swift
//  EventApp 1
//
//  Created by Vova SKR on 26/11/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct EventsModel: Decodable {
    var count: Int
    var next: String
    var results: [ResultModel]
}

// MARK: - Result
struct ResultModel: Decodable {
    var title: String
    var body_text, price: String
    var dates: [DateModel]
    var place: PlaceModel?
    var images: [ImageModel]
    var short_title: String
}

// MARK: - DateElement
struct DateModel: Decodable {
    var start_date: String?
    var start_time: String?
}

// MARK: - Image
struct ImageModel: Decodable {
    var image: String
    var thumbnails: Thumbnails
}

struct Thumbnails: Decodable {
    var the640X384: String?
    var the144X96: String?
    
    enum CodingKeys: String, CodingKey {
        case the640X384 = "640x384"
        case the144X96 = "144x96"
    }
    
    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.the640X384 = try? container.decode(String.self, forKey: .the640X384)
            self.the144X96 = try? container.decode(String.self, forKey: .the144X96)
        } catch {
            assertionFailure("Error")
        }
    }
    
    
}

// MARK: - Place
struct PlaceModel: Decodable {
   
    let title: String
    let address: String
    let subway: String
}

