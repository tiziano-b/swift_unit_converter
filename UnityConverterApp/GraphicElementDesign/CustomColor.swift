//
//  CustomColor.swift
//  UnityConverterApp
//
//  Created by Tiziano on 14/03/2019.
//  Copyright © 2019 Tiziano Bissola. All rights reserved.
//

import Foundation
import UIKit

/*
 Extension of UIColor Class to have a better way to define a color based on its value (:
 */

extension UIColor{
    convenience init(rgb: UInt, alphaVal: CGFloat) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: alphaVal
        )
    }
}
