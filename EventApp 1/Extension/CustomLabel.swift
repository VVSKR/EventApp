//
//  CustomLabel.swift
//  EventApp 1
//
//  Created by Vova SKR on 24/11/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import UIKit

extension UILabel {
    
    public static func tableViewLabel(with font: UIFont) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.backgroundColor = .red
        label.numberOfLines = 2
        label.textColor = .white
        label.font = font
        label.sizeToFit()
        return label
    }
}
