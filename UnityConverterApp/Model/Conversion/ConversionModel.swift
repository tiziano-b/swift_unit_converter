//
//  ConversionModel.swift
//  UnityConverterApp
//
//  Created by Tiziano on 16/03/2019.
//  Copyright © 2019 Tiziano Bissola. All rights reserved.
//

import Foundation

import Foundation
import UIKit

// definition of the interface for the conversion.


protocol ConversionMeasures {
     func conversionForSaving(inputValue: Double) -> Measure
}

protocol TemperatureConversion : ConversionMeasures{
  //  func conversionForSavingTemperature(inputType : String, inputValue: Double, outPutType: String) -> Measure
    func conversionForEditingTemperature(value: String, inputValueType: String) -> TemperatureMeasure
}

protocol WeightConversion : ConversionMeasures{
   // func conversionForSavingWeight(inputType : String, inputValue: Double, outPutType: String) -> Measure
    func conversionForEditingWeight(value: String, inputValueType: String) -> WeightMeasure
}

protocol SpeedConversion : ConversionMeasures{
 //   func conversionForSavingSpeed(inputType : String, inputValue: Double, outPutType: String) -> Measure
    func conversionForEditingSpeed(value: String, inputValueType: String) -> SpeedMeasure
}

protocol LiquidConversion : ConversionMeasures{
 //   func conversionForSavingLiquid(inputType : String, inputValue: Double, outPutType: String) -> Measure
    func conversionForEditingLiquid(value: String, inputValueType: String) -> LiquidMeasure
}

protocol LenghtConversion : ConversionMeasures{
  //  func conversionForSavingLenght(inputType : String, inputValue: Double, outPutType: String) -> Measure
    func conversionForEditingLenght(value: String, inputValueType: String) -> LenghtMeasure
}


