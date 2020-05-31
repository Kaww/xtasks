//
//  UIColor+colors.swift
//  XTasks
//
//  Created by kaww on 09/05/2020.
//  Copyright © 2020 kaww. All rights reserved.
//

import UIKit


struct Colors {
    
    /// Used for backgrounds
    static let appTintColor = UIColor.init(white: 50 / 255, alpha: 1)
    static let appTintColor1 = UIColor.init(white: 60 / 255, alpha: 1)
    static let appTintColor2 = UIColor.init(white: 45 / 255, alpha: 1)
    
    /// Used for backgorunds that need to be lighten
    static let appTintLightColor = UIColor.init(white: 80 / 255, alpha: 1)
    
    
    /// Used for texts
    static let appTextColor = UIColor.white
    
    /// Used for tasks colors: checked / unchecked
    static let appNegativeColor = UIColor(red: 255 / 255, green: 210 / 255, blue: 0 / 255, alpha: 1)
    static let appNegativeColor_darker = UIColor(red: 247 / 255, green: 151 / 255, blue: 30 / 255, alpha: 1)
    
    static let appPositiveColor = UIColor(red: 113 / 255, green: 199 / 255, blue: 52 / 255, alpha: 1)
    static let appPositiveColor_darker = UIColor(red: 39 / 255, green: 186 / 255, blue: 76 / 255, alpha: 1)
    
    /// Used for descructive actions
    static let appDescructiveColor = UIColor.systemRed
    
    static let appShadowsColor = UIColor.init(white: 20 / 255, alpha: 1)
    
}
