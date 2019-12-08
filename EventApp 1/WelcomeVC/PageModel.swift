//
//  Page.swift
//  EventApp 1
//
//  Created by Vova SKR on 22/11/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import Foundation

struct WelcomePageModel {
    let imageName: String? = nil
    let headerText: String
    let bodyText: String
    
    static func all() -> [WelcomePageModel] {
        return [WelcomePageModel(headerText:"firstPage", bodyText: "firstPagefirstPagefirstPagefirstPager"), WelcomePageModel(headerText: "secondPage", bodyText: "secondPagesecondPagesecondPage"), WelcomePageModel(headerText: "thirdPage", bodyText: "thirdPagethirdPagethirdPage")]
    }
}
