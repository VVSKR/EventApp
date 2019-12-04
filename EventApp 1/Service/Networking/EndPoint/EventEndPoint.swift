//
//  EventEndPoint.swift
//  EventApp 1
//
//  Created by Vova SKR on 02/12/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import Foundation

indirect enum NetworkEnvironment {
    case kudaGoAPI(KudaGoApi)
    case fireBaseAuth(Auth)
    
}

public enum KudaGoApi {
    case recommended(id:Int)
    case popular(page:Int)
    case newMovies(page:Int)
    case video(id:Int)
    case events(categories: Categories)
}

public enum Auth {
    case signUp(email: String, password: String)
    case signIn(email: String, password: String)
}


public enum Categories: String {
    case all = ""
    case concert = "concert"
    case festival = "festival"
    case theater = "theater"
    case standUp = "stand-up"
}


extension NetworkEnvironment: EndPointType {
    
    var httpMethod: HTTPMethod {
        switch self {
        case .fireBaseAuth:
            return .post
        case .kudaGoAPI:
            return .get
        }
    }
    
    var task: HTTPTask {
        
        switch self {
            
        case .kudaGoAPI(let events):
            switch events {
                
            case .newMovies(let page):
                return .requestParameters(bodyParameters: nil,
                                          bodyEncoding: .urlEncoding,
                                          urlParameters: ["page": page, "api_key": "k"])
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
            
        case .fireBaseAuth(let auth):
            switch auth {
            case .signIn(let email, let password):
                return .requestParametersAndHeaders(bodyParameters: ["email": email, "password": password], bodyEncoding: .urlAndJsonEncoding, urlParameters: ["key": "AIzaSyBapSaUwsJ77F0-JqjfcfN7r7RrTx10uMU"], additionHeaders: ["Content-Type":"application/json"])
            case .signUp(let email, let password):
                return .requestParametersAndHeaders(bodyParameters: ["email": email, "password": password], bodyEncoding: .urlAndJsonEncoding, urlParameters: ["key": "AIzaSyBapSaUwsJ77F0-JqjfcfN7r7RrTx10uMU"], additionHeaders: ["Content-Type":"application/json"])
                
            }
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var environmentBaseURL : String {
        switch self {
        case .kudaGoAPI: return "https://kudago.com/public-api/v1.4/"
        case .fireBaseAuth: return "https://identitytoolkit.googleapis.com/v1/"
            
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.") }
        return url
    }
    
    var path: String {
        switch self {
            
        case .kudaGoAPI(let events):
            switch events {
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
            
        case .fireBaseAuth(let auth):
            switch auth {
            case .signIn:
                return "accounts:signInWithPassword"
            case .signUp:
                return "accounts:signUp"
            }
        }
    }
}
