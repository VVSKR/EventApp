//
//  LoadImage.swift
//  EventApp 1
//
//  Created by Vova SKR on 26/11/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    ImageService.shared.cashe.setObject(image, forKey: url.absoluteString as NSString)
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}


