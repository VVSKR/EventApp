//
//  EventEndPoint.swift
//  EventApp 1
//
//  Created by Vova SKR on 02/12/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import Foundation

indirect enum NetworkEnvironment {
    case events(KudaGoApi)
    case fireBase
    
}

public enum KudaGoApi {
    case recommended(id:Int)
    case popular(page:Int)
    case newMovies(page:Int)
    case video(id:Int)
    case events(categories: Categories)
}


public enum Categories: String {
    case all = ""
    case concert = "concert,"
    case festival = "festival,"
    case theater = "theater,"
    case standUp = "stand-up"
}


extension KudaGoApi: EndPointType {
    
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .events: return "https://kudago.com/public-api/v1.4/"
        case .fireBase: return "firebase"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.") }
        return url
    }
    
    var path: String {
        switch self {
        case .recommended(let id):
            return "\(id)/recommendations"
        case .popular:
            return "popular"
        case .newMovies:
            return "now_playing"
        case .video(let id):
            return "\(id)/videos"
        case .events:
            return "events"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .newMovies(let page):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["page": page,
                                                      "api_key": "k"])
        case .events(let categories):
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding,
                                      urlParameters: ["categories": categories.rawValue,
                                                      "fields": "title,short_title,body_text,price,images,dates,place,categories",
                                                      "expand": "location,dates,participants,images,place",
                                                      "order_by": "-rank",
                                                      "text_format": "text",
                                                      "location": "msk",
                                                      "actual_since": "1575075200"])
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}

