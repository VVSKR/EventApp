//
//  NetworkService.swift
//  EventApp 1
//
//  Created by Vova SKR on 24/11/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import UIKit

class NetworkService {
    
    let session: URLSession
    
    private var queue = DispatchQueue(label: "loadEvents", qos: .default, attributes: .concurrent)
    
    
    init() {
        session = URLSession(configuration: .default)
    }
    
    enum Result<Value> {
        case success(Value)
        case failure(Error)
    }
    
    let url = URL(string: "https://kudago.com/public-api/v1.4/events/?fields=title,short_title,body_text,price,images,dates,place&expand=location,dates,participants,images,place&order_by=%20-rank&text_format=text&location=msk&actual_since=1574575200&categories")!
    
    public func getBoards(completion: ((Result<EventsModel>) -> Void)?) {
        mainSession(request: getBoardsUrl(), completion: completion)
    }

    
    private func getBoardsUrl() -> URLRequest {
//        let url = URL(string: "https://api.trello.com/1/members/me/boards?key=\(apiKey)" + "&token=\(UserDefaults.standard.returnToken())")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
    
    
    
    private func mainSession<T: Decodable> (request: URLRequest, completion: ((Result<T>) -> Void)?) {
        
        session.dataTask(with: request) { (data, responce, error) in
            guard let jsonData = data, error == nil else { completion?(.failure(error!)); return }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let decodedData = try decoder.decode(T.self, from: jsonData)
                completion?(.success(decodedData))
            } catch {
                completion?(.failure(error))
            }
        }.resume()
    }
}
