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
    
    func getEvents(categories: Categories, completion: @escaping (Result<ResultEventsModel, Error>) -> ()) {
        router.request(.kudaGoAPI(.events(categories: categories))) { data, response, error in
            guard error == nil else { completion(.failure(error!)); return }
            guard let responseData = data else {
                completion(.failure(APIError.requestFailed ))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let apiResponse = try decoder.decode(ResultEventsModel.self, from: responseData)
                completion(.success(apiResponse))
            } catch {
                print(error)
                completion(.failure(APIError.jsonParsingFailure))
            }
        }
    }
    
    
    func postSingUp(email: String, password: String, completion: @escaping (Result<UserModel, Error>) -> ()) {
        router.request(.fireBaseAuth(.signUp(email: email, password: password))) { (data, responce, error) in
            
            guard error == nil, let responseData = data else { completion(.failure(APIError.requestFailed)); return }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let apiResponse = try decoder.decode(UserModel.self, from: responseData)
                completion(.success(apiResponse))
            } catch {
                 completion(.failure(APIError.jsonParsingFailure))
            }
        }
    }
    
    
    func firebaseGetData(completion: @escaping (Result<ResultEventsModel, Error>) -> ()) {
        router.request(.firebaseDataBase(.getUserData)) { (data, responce, error) in
            guard let data = data else { print("No data from FIREBASE"); return }
            print(data)
        
        }
    }
    
    func firebasePutData(event: EventModel, completion: @escaping (Result<ResultEventsModel, Error>) -> ()) {
        router.request(.firebaseDataBase(.putNewData(data: event))) { (data, responce, error) in
            guard let data = data else { print("No data from FIREBASE"); return }
            print(data)
        
        }
    }
    
    
    
    // new func
}

