//
//  NetworkManager.swift
//  EventApp 1
//
//  Created by Vova SKR on 02/12/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import Foundation

//enum NetworkResponse:String {
//    case success
//    case authenticationError = "You need to be authenticated first."
//    case badRequest = "Bad request"
//    case outdated = "The url you requested is outdated."
//    case failed = "Network request failed."
//    case noData = "Response returned with no data to decode."
//    case unableToDecode = "We could not decode the response."
//}


struct NetworkManager {
    
    let router = Router<NetworkEnvironment>()
    
    func getEvents(categories: Categories, completion: @escaping (Result<EventsModel, Error>) -> ()) {
        router.request(.kudaGoAPI(.events(categories: categories))) { data, response, error in
            guard error == nil else { completion(.failure(error!)); return }
            guard let responseData = data else {
                completion(.failure(APIError.requestFailed ))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let apiResponse = try decoder.decode(EventsModel.self, from: responseData)
                completion(.success(apiResponse))
            } catch {
                print(error)
                completion(.failure(APIError.jsonParsingFailure))
            }
        }
    }
    
    
    // new func
}

