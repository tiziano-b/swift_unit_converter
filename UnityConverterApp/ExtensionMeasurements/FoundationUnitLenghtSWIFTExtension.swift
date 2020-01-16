//
//  ExtensionFoundationSWIFT.swift
//  UnityConverterApp
//
//  Created by Tiziano on 16/03/2019.
//  Copyright © 2019 Tiziano Bissola. All rights reserved.
//

import Foundation


// FOUNDATION HAVE a wrong defintion of Mile !!
/*
 
 print(UnitLength.preciseMiles.converter.baseUnitValue(fromValue: 1.0))
 // 1609.34
 
the correct value is --> 1.609344
 
 
 WORKAROUND to define a better value ...
 
 
 
 NB --> I NOTICED THE SAME PROBLEM WITH fahrenheit and KM/H
 
 1.0 m/s --> 3.5999971200023038 km/h due to the formula = km/h = m_s / coefficent km_h
 
 // ------ ///
 
 input celsius --> 1.0
 output fahrenheit --> 33.79999999999598

 
 
 */

extension UnitLength{
    static var betterImplementationMiles: UnitLength {
        return UnitLength(symbol: "mi",
                          converter: UnitConverterLinear(coefficient: 1609.344))
    }
}



