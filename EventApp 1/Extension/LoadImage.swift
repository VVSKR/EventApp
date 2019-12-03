//
//  LoadImage.swift
//  EventApp 1
//
//  Created by Vova SKR on 26/11/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func loadImage(url: URL, alpha: CGFloat) {
        ImageService.getImage(withURL: url) { (result) in
            switch result {
            case .success(let image):
                self.image = image.alpha(alpha)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
