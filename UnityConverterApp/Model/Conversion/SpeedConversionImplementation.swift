//
//  SpeedConversionImplementation.swift
//  UnityConverterApp
//
//  Created by Tiziano on 16/03/2019.
//  Copyright © 2019 Tiziano Bissola. All rights reserved.
//

import Foundation


import UIKit

class SpeedConversionImplementation: MeasuresRoundHelper, SpeedConversion {
    func conversionForSaving(inputValue: Double) -> Measure {
        
        let finalPack : SpeedMeasure = SpeedMeasure()
        
        finalPack.km_h = stringRoundedMeasureAllHistory(inputValue: inputValue, outputDimension: UnitSpeed.kilometersPerHour)
        
        
        finalPack.metres_sec = stringRoundedMeasureAllHistory(inputValue: inputValue, outputDimension: UnitSpeed.metersPerSecond)
        
        finalPack.miles_h = stringRoundedMeasureAllHistory(inputValue: inputValue, outputDimension: UnitSpeed.milesPerHour)
        
        finalPack.nauticalMiles_h = stringRoundedMeasureAllHistory(inputValue: inputValue, outputDimension: UnitSpeed.knots)
        
        let packreturn : Measure =  finalPack
        return packreturn
    }

    
    func conversionForEditingSpeed(value: String, inputValueType: String) -> SpeedMeasure {
        let finalpack : SpeedMeasure = SpeedMeasure()
          // delete this IF - ELSE. it doesn't make sense. a string empty can't become a Double!!!
        if let valueDigit = Double(value){
            if (value == ""){
                finalpack.km_h = ""
                finalpack.metres_sec = ""
                finalpack.miles_h = ""
                finalpack.nauticalMiles_h = ""
            }
            else{
                var inputValue : Measurement<UnitSpeed>?
                
                if (inputValueType == UnitSpeed.metersPerSecond.symbol){
                    inputValue = Measurement(value: valueDigit, unit: UnitSpeed.metersPerSecond)
                }
                else if (inputValueType == UnitSpeed.kilometersPerHour.symbol){
                    inputValue = Measurement(value: valueDigit, unit: UnitSpeed.kilometersPerHour)
                }
                else if (inputValueType == UnitSpeed.milesPerHour.symbol){
                    inputValue = Measurement(value: valueDigit, unit: UnitSpeed.milesPerHour)
                }
                else if (inputValueType == UnitSpeed.knots.symbol){
                    inputValue = Measurement(value: valueDigit, unit: UnitSpeed.knots)
                }
                else {
                    print("WHAT IS GOING ON HERE??")
                }
                
                if let inputVal = inputValue{
                    finalpack.km_h = stringRoundedMeasureSpeedConversion(inputValue: inputVal, outputDimension: UnitSpeed.kilometersPerHour)
                    finalpack.metres_sec = stringRoundedMeasureSpeedConversion(inputValue: inputVal, outputDimension: UnitSpeed.metersPerSecond)
                    finalpack.miles_h = stringRoundedMeasureSpeedConversion(inputValue: inputVal, outputDimension: UnitSpeed.milesPerHour)
                    finalpack.nauticalMiles_h = stringRoundedMeasureSpeedConversion(inputValue: inputVal, outputDimension: UnitSpeed.knots)
                }
            }
        }
        else{
//            print("WHAT IS GOING ON HERE??")
        }
        
        return finalpack
        
    }
}
    
    
  
