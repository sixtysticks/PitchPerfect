//
//  UIColor+PPColor.swift
//  PitchPerfect
//
//  Created by David Gibbs on 31/07/2016.
//  Copyright © 2016 SixtySticks. All rights reserved.
//

import UIKit

public extension UIColor {
    
    public static func pitchPerfectColour(red r: CGFloat, green g: CGFloat, blue b: CGFloat) -> UIColor {
        let color = UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1.0)
        return color
    }

}
