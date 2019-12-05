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
    case firebaseDataBase(Request)
    
}

extension NetworkEnvironment: EndPointType {
    
    
    // MARK: - HTTPMethod
    
    var httpMethod: HTTPMethod {
        switch self {
        case .fireBaseAuth:
            return .post
        case .kudaGoAPI:
            return .get
        case .firebaseDataBase(let request):
            switch request {
            case .getUserData:
                return .get
            case .putNewData:
                return .put
            }
        }
    }
    
    // MARK: - HTTPTask
    
    var task: HTTPTask {
        
        switch self {
        // KudaGoAPi
        case .kudaGoAPI(let events):
            switch events {
                
            case .events(let categories):
                return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding,
                                          urlParameters: ["categories": categories.rawValue,])
            }
        // FireBaseAuth
        case .fireBaseAuth(let auth):
            switch auth {
            case .signIn(let email, let password):
                return .requestParametersAndHeaders(bodyParameters: ["email": email, "password": password], bodyEncoding: .urlAndJsonEncoding, urlParameters: ["key": "AIzaSyBapSaUwsJ77F0-JqjfcfN7r7RrTx10uMU"], additionHeaders: ["Content-Type":"application/json"])
            case .signUp(let email, let password):
                return .requestParametersAndHeaders(bodyParameters: ["email": email, "password": password], bodyEncoding: .urlAndJsonEncoding, urlParameters: ["key": "AIzaSyBapSaUwsJ77F0-JqjfcfN7r7RrTx10uMU"], additionHeaders: ["Content-Type":"application/json"])
            }
        // FirebaseDataBase
        case .firebaseDataBase(let request):
            switch request {
            case .getUserData:
                return .request
            case .putNewData:
                return .request
                
            }
        }
    }
    
    // MARK: -  HTTTPHEaders
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    // MARK: - URL
    
    var environmentBaseURL : String {
        switch self {
        case .kudaGoAPI: return "https://kudago.com/public-api/v1.4/"
        case .fireBaseAuth: return "https://identitytoolkit.googleapis.com/v1/"
        case .firebaseDataBase: return "https://eventsbd-7d841.firebaseio.com/\(UserDefaults.standard.returnUserId())"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.") }
        return url
    }
    
    // MARK: - URL path
    
    var path: String {
        switch self {
        // KudaGoAPi
        case .kudaGoAPI(let events):
            switch events {
            case .events:
                return "events"
            }
        // FireBaseAuth
        case .fireBaseAuth(let auth):
            switch auth {
            case .signIn:
                return "accounts:signInWithPassword"
            case .signUp:
                return "accounts:signUp"
            }
        // FirebaseDataBase
        case .firebaseDataBase(let request):
            switch request {
            case .getUserData:
                return ".json"
            case .putNewData:
                return ".json"
                
            }
        }
    }
    
    
    //    private var defaultParamForKudaGoApi: [String: String] {
    //        return ["fields": "title,short_title,body_text,price,images,dates,place,categories",
    //                "expand": "location,dates,participants,images,place",
    //                "order_by": "-rank",
    //                "text_format": "text",
    //                "location": "msk",
    //                "actual_since": "1575075200"]
    //    }
}
