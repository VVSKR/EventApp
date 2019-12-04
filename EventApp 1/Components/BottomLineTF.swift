//
//  BottomLineTF.swift
//  EventApp 1
//
//  Created by Vova SKR on 03/12/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import UIKit

class Utilities {
    
    static func styleTextField(_ textfield: UITextField) {
        
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        
        bottomLine.backgroundColor = UIColor.mainRed.cgColor
        
        textfield.borderStyle = .none
        textfield.layer.addSublayer(bottomLine)
        
    }
}
