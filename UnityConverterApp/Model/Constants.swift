//
//  Constants.swift
//  UnityConverterApp
//
//  Created by Tiziano on 09/03/2019.
//  Copyright © 2019 Tiziano Bissola. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    struct PhoneKeyboardSize {
        static let iPhone_5_5S_SE = 200
        static let iPhone_6_6S_7_8 = 220
        static let iPhone_6p_6Sp_7p_8p = 220
        static let iPhone_X_XS = 260
        static let iPhone_XS_Max = 260
        static let iPhone_XR = 260
    }
    
    struct PhoneHeaderSize {
        static let iPhone_5_5S_SE = 77
        static let iPhone_6_6S_7_8 = 80
        static let iPhone_6p_6Sp_7p_8p = 80
        
        static let iPhone_X_XS = 105
        static let iPhone_XS_Max = 105
        static let iPhone_XR = 105
    }
    
    
    struct Conversion {
        static let weights = "Weights"
        static let temperature = "Temperature"
        static let liquid_volumes = "Liquid_Volumes"
        static let lenght = "Lenght"
        static let speed = "Speed"
        static let volumes = "Volumes"
    }
    
   
    struct GeneralValues {
         // --------- TO MANAGE THE SCROLLVIEW WITH THE CUSTOM KEYBOARD ... INCREASE THE VALUE AND GO BIG !!
        static let increaseSizeVerificationKeyboardOffset : CGFloat = 45
         // ---------
        
        // -------- ATTRIBUTES NAVIGATION BAR TITLE --------/
        
        static let weightNavigationBarLight = UIFont.Weight.light
        static let sizeNavigationBar : CGFloat = 17.0
        static let weightNavigationBarMedium = UIFont.Weight.bold
    }
   
    
}

struct NumberToBeConvertedFormat{
    var numberofZero : Int =  0
    var floatingPoint : Bool = false
    var numberofDigitAfterThePoint : Int = 0
    var extraDeciamlNumerOtherZero : Bool = false
    var exp : Bool = false
    
}




/// --- NW --- //

// polymorphism on the measure if it is necessary some new methods / attributes

class Measure{
    
}

class WeightMeasure : Measure{
    public var kg = ""
    public var grams = ""
    public var ounces = ""
    public var pounds = ""
    public var stone = ""
}

class TemperatureMeasure : Measure {
    public var cel = ""
    public var fara = ""
    public var kelvin = ""
}

class LenghtMeasure : Measure{
    public var metre = ""
    public var mile = ""
    public var cm = ""
    public var mm = ""
    public var yard = ""
    public var inch = ""
}

class SpeedMeasure : Measure {
    public var km_h = ""
    public var metres_sec = ""
    public var miles_h = ""
    public var nauticalMiles_h = ""
}

class LiquidMeasure : Measure{
    public var gallon = ""
    public var litre = ""
    public var pint_uk = ""
    public var fluid_ounce = ""
    public var millilitre = ""
    
}



let attrs = [
    NSAttributedString.Key.foregroundColor: UIColor.red,
    NSAttributedString.Key.font: UIFont(name: "Georgia-Bold", size: 24)!
]


// changing color Navigation Bar
struct System {
    static func clearNavigationBar(forBar navBar: UINavigationBar) {
        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.shadowImage = UIImage()
        navBar.isTranslucent = true
      
        
        // text
      //  navBar.titleTextAttributes = attrs
        
        // ICON
      ///  navBar.tintColor = UIColor.red
    }
}



