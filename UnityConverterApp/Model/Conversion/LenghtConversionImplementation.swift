//
//  LenghtConversionImplementation.swift
//  UnityConverterApp
//
//  Created by Tiziano on 16/03/2019.
//  Copyright © 2019 Tiziano Bissola. All rights reserved.
//

import Foundation


import UIKit


class LenghtConversionImplementation : MeasuresRoundHelper, LenghtConversion {
    
    func conversionForSaving(inputValue: Double) -> Measure {
        
        let finalPack : LenghtMeasure = LenghtMeasure()
        
        finalPack.cm = stringRoundedMeasureAllHistory(inputValue: inputValue, outputDimension: UnitLength.centimeters)
        finalPack.inch = stringRoundedMeasureAllHistory(inputValue: inputValue, outputDimension: UnitLength.inches)
        finalPack.metre = stringRoundedMeasureAllHistory(inputValue: inputValue, outputDimension: UnitLength.meters)
        finalPack.mile = stringRoundedMeasureAllHistory(inputValue: inputValue, outputDimension: UnitLength.betterImplementationMiles)
        finalPack.mm = stringRoundedMeasureAllHistory(inputValue: inputValue, outputDimension: UnitLength.millimeters)
        finalPack.yard = stringRoundedMeasureAllHistory(inputValue: inputValue, outputDimension: UnitLength.yards)
        
        
        let packreturn : Measure =  finalPack
        return packreturn
    }

    
    func conversionForEditingLenght(value: String, inputValueType: String) -> LenghtMeasure {
        
        
        let finalpack : LenghtMeasure = LenghtMeasure()
          // delete this IF - ELSE. it doesn't make sense. a string empty can't become a Double!!!
        if let valueDigit = Double(value){
            if (value == ""){
                finalpack.cm = ""
                finalpack.inch = ""
                finalpack.metre = ""
                finalpack.mile = ""
                finalpack.mm = ""
                finalpack.yard = ""
            }
            else{
                var inputValue : Measurement<UnitLength>?
                if (inputValueType == UnitLength.centimeters.symbol){
                    inputValue = Measurement(value: valueDigit, unit: UnitLength.centimeters)
                }
                else if (inputValueType == UnitLength.inches.symbol){
                    inputValue = Measurement(value: valueDigit, unit: UnitLength.inches)
                }
                else if (inputValueType == UnitLength.meters.symbol){
                    inputValue = Measurement(value: valueDigit, unit: UnitLength.meters)
                }
                else if (inputValueType == UnitLength.betterImplementationMiles.symbol){
                    inputValue = Measurement(value: valueDigit, unit: UnitLength.betterImplementationMiles)
                }
                else if (inputValueType == UnitLength.millimeters.symbol){
                    inputValue = Measurement(value: valueDigit, unit: UnitLength.millimeters)
                }
                else if (inputValueType == UnitLength.yards.symbol){
                    inputValue = Measurement(value: valueDigit, unit: UnitLength.yards)
                }
                else {
                    print("WHAT IS GOING ON HERE??")
                }
                
                if let inputVal = inputValue{
                    finalpack.cm = stringRoundedMeasurelenghtConversion(inputValue: inputVal, outputDimension: UnitLength.centimeters)
                    
                    finalpack.inch = stringRoundedMeasurelenghtConversion(inputValue: inputVal, outputDimension: UnitLength.inches)
                    finalpack.metre = stringRoundedMeasurelenghtConversion(inputValue: inputVal, outputDimension: UnitLength.meters)
                    
                    finalpack.mile = stringRoundedMeasurelenghtConversion(inputValue: inputVal, outputDimension: UnitLength.betterImplementationMiles)
                    
                    finalpack.mm = stringRoundedMeasurelenghtConversion(inputValue: inputVal, outputDimension: UnitLength.millimeters)
                    finalpack.yard = stringRoundedMeasurelenghtConversion(inputValue: inputVal, outputDimension: UnitLength.yards)

                }
            }
        }
        else{
//            print("WHAT IS GOING ON HERE??")
        }
        
        return finalpack
  
    }
    
    
}

