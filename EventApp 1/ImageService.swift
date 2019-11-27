//
//  ImageService.swift
//  EventApp 1
//
//  Created by Vova SKR on 27/11/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import UIKit

class ImageService {
    
    static var shared = ImageService()
    
    let cashe = NSCache<NSString, UIImage>()
    
    static func downloadImage(withURL url: URL, comlection: @escaping (_ image: UIImage?) -> ()) {
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            var downloadedImage: UIImage?
            if let data = data {
                downloadedImage = UIImage(data: data)
            }
            
            if downloadedImage != nil {
//                cashe.setObject(downloadedImage!, forKey: url.absoluteString as NSString)
            }
           
            DispatchQueue.main.async {
                comlection(downloadedImage)
            }
        }.resume()
        
    }
    
    private init() { }
    
//    static func getImage(withURL url: URL, comlection: @escaping (_ image: UIImage?) -> ()) {
//        if let image = cashe.object(forKey: url.absoluteString as NSString) {
//            comlection(image)
//        } else {
//            downloadImage(withURL: url, comlection: comlection)
//        }
//    }
}
