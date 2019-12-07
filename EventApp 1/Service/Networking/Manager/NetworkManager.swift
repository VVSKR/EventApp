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
    
    private let router = Router<NetworkEnvironment>()
    
    // MARK: - KudaGO API
    public func getEvents(categories: Categories, completion: @escaping (Result<ResultEventsModel, Error>) -> ()) {
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
    
    // MARK: - Firebase Auth
    public func postSingUp(email: String, password: String, completion: @escaping (Result<UserModel, Error>) -> ()) {
        router.request(.fireBaseAuth(.signUp(email: email, password: password))) { (data, responce, error) in
            
            guard error == nil, let responseData = data else { completion(.failure(APIError.noData)); return }
            guard let responce = responce as? HTTPURLResponse, responce.statusCode == 200 else {
                completion(.failure(APIError.requestFailed))
                return
            }
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
    
    public func postSingIn(email: String, password: String, completion: @escaping (Result<UserModel, Error>) -> ()) {
        router.request(.fireBaseAuth(.signIn(email: email, password: password))) { (data, responce, error) in
            
            guard error == nil, let responseData = data else { completion(.failure(APIError.noData)); return }
            guard let responce = responce as? HTTPURLResponse, responce.statusCode == 200 else {
                completion(.failure(APIError.requestFailed))
                return
            }
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
    
    
    // MARK: - Firebase DB
    public func firebaseGetData(completion: @escaping (Result<[EventModel], Error>) -> ()) {
        router.request(.firebaseDataBase(.getUserData)) { (data, responce, error) in
            guard error == nil else { completion(.failure(APIError.noData)); return }
            guard let responseData = data else {
                completion(.failure(APIError.requestFailed ))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let apiResponse = try decoder.decode([String: EventModel].self, from: responseData)
                let data = Array(apiResponse.values)
                completion(.success(data))
            } catch {
                print(error)
                completion(.failure(APIError.jsonParsingFailure))
            }
        }
    }
    
    
    public func firebasePutData(event: EventModel,currentDate: Int, completion: @escaping (Result<String, Error>) -> ()) {
        router.request(.firebaseDataBase(.putNewData(data: event, currentDate: currentDate))) { (data, responce, error) in
            guard let data = data else { print("No data from FIREBASE"); return }
            print(data)
            completion(.success("Yess"))
            
        }
    }
    
    
    public func firebaseDeleteData(at index: Int,
                                   completion: @escaping (Result<String, Error>) -> ())  {
        router.request(.firebaseDataBase(.deleteData(index: index))) { (_, responce, _) in
            let httpResponce = responce as! HTTPURLResponse
            guard httpResponce.statusCode == 200 else {
                completion(.failure(APIError.requestFailed)); return
            }
            completion(.success("Event removed"))
        }
        
    }
    // new func
}

