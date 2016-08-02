//
//  UIColor+PPColor.swift
//  PitchPerfect
//
//  Created by David Gibbs on 31/07/2016.
//  Copyright © 2016 SixtySticks. All rights reserved.
//

import UIKit

public extension UIColor {
    public static func pitchPerfectPrimaryColor() -> UIColor {
        let ppColor = UIColor(red: 6.0/255, green: 99/255, blue: 140/255, alpha: 1.0)
        return ppColor
    }
    
    public static func pitchPerfectSecondaryColor() -> UIColor {
        let ppSecondaryColor = UIColor(red: 130/255.0, green: 177/255.0, blue: 197/255.0, alpha: 1.0)
        return ppSecondaryColor
    }
}