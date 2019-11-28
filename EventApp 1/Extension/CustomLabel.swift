//
//  CustomLabel.swift
//  EventApp 1
//
//  Created by Vova SKR on 24/11/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import UIKit

extension UILabel {
    
    public static func tableViewLabel(with font: UIFont, tintColor: UIColor) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.tintColor = tintColor
        label.numberOfLines = 3
        label.textColor = .white
        label.font = font
        label.sizeToFit()
        return label
    }
}
