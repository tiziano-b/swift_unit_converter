//
//  TemperatureConversionImplementation.swift
//  UnityConverterApp
//
//  Created by Tiziano on 16/03/2019.
//  Copyright © 2019 Tiziano Bissola. All rights reserved.
//

import Foundation
import UIKit

class TemperatureConversionImplementation: MeasuresRoundHelper, TemperatureConversion {
    func conversionForSaving(inputValue: Double) -> Measure {
        
        let finalPackTemperatures : TemperatureMeasure = TemperatureMeasure()
        
        finalPackTemperatures.cel = stringRoundedMeasureAllHistory(inputValue: inputValue, outputDimension: UnitTemperature.celsius)
        finalPackTemperatures.fara = stringRoundedMeasureAllHistory(inputValue: inputValue, outputDimension: UnitTemperature.fahrenheit)
        finalPackTemperatures.kelvin = stringRoundedMeasureAllHistory(inputValue: inputValue, outputDimension: UnitTemperature.kelvin)
        
        
        let packreturn : Measure =  finalPackTemperatures
        return packreturn
    }
    

    
    func conversionForEditingTemperature(value: String, inputValueType: String) -> TemperatureMeasure{
        
        let packreturn : TemperatureMeasure = TemperatureMeasure()
        
        
        if let valueDigit = Double(value){
            // delete this IF - ELSE. it doesn't make sense. a string empty can't become a Double!!!
            if (value == ""){
                packreturn.cel = ""
                packreturn.fara = ""
                packreturn.kelvin = ""
            }
            else
            {
                var inputValue : Measurement<UnitTemperature>?
                
                if (inputValueType == UnitTemperature.celsius.symbol){
                    inputValue = Measurement(value: valueDigit, unit: UnitTemperature.celsius)
                }
                else if (inputValueType == UnitTemperature.kelvin.symbol){
                    inputValue = Measurement(value: valueDigit, unit: UnitTemperature.kelvin)
                }
                else if (inputValueType == UnitTemperature.fahrenheit.symbol){
                    inputValue = Measurement(value: valueDigit, unit: UnitTemperature.fahrenheit)
                }
                else {
                    print("WHAT IS GOING ON HERE?? unit not found")
                }
                
//                
//                print("ELEMENT TEMPERATURE AFTER CONVERSION -->")
//                print("initial value --> \(value)")
//                print(inputValue?.value)
//                print("ELEMENT TEMPERATURE AFTER CONVERSION -->")
//                
                
                if let inputVal = inputValue{
                    packreturn.cel = stringRoundedMeasureTemperatureConversion(inputValue: inputVal, outputDimension: UnitTemperature.celsius)
                    packreturn.fara = stringRoundedMeasureTemperatureConversion(inputValue: inputVal, outputDimension: UnitTemperature.fahrenheit)
                    packreturn.kelvin = stringRoundedMeasureTemperatureConversion(inputValue: inputVal, outputDimension: UnitTemperature.kelvin)
                }
            }
        }
        else{
//            print("WHAT IS GOING ON HERE?? v1 - element can't be converted")
            
        }
        
        return packreturn
    }
    
    
}
