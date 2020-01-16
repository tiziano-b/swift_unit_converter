//
//  WeightConversionImplementation.swift
//  UnityConverterApp
//
//  Created by Tiziano on 16/03/2019.
//  Copyright © 2019 Tiziano Bissola. All rights reserved.
//


import Foundation
import UIKit

/*
 class with the behaviour of convert and produce the string of the measure.
 it inherits the MeasureRoundHelper class and define the protocol WeightConversion to ensure decoupling to the solution from the Conversion and the ViewController.
 
*/

class WeightMeasureImplementation: MeasuresRoundHelper, WeightConversion{
    
     // the function creates the arrey of string that has to be saved. the function is decleared on the parent . Usage of polymorphism for manage the situation.
    // just for accademic purpose (:
    func conversionForSaving(inputValue: Double) -> Measure {
        let finalPack : WeightMeasure = WeightMeasure()
        
        finalPack.grams = stringRoundedMeasureAllHistory(inputValue: inputValue, outputDimension: UnitMass.grams)
        finalPack.kg = stringRoundedMeasureAllHistory(inputValue: inputValue, outputDimension: UnitMass.kilograms)
        finalPack.ounces = stringRoundedMeasureAllHistory(inputValue: inputValue, outputDimension: UnitMass.ounces)
        finalPack.pounds = stringRoundedMeasureAllHistory(inputValue: inputValue, outputDimension: UnitMass.pounds)
        finalPack.stone = stringRoundedMeasureAllHistory(inputValue: inputValue, outputDimension: UnitMass.stones)
        
        let packreturn : Measure =  finalPack
        
        
        return packreturn
            
    }

    
    // the function creates the arrey of string to be used during the interaction with the conversion view.
    
    func conversionForEditingWeight(value: String, inputValueType: String) -> WeightMeasure {
        let packreturn : WeightMeasure = WeightMeasure()
        
          // delete this IF - ELSE. it doesn't make sense. a string empty can't become a Double!!!
        if let valueDigit = Double(value){
            if (value == ""){
                packreturn.grams = ""
                packreturn.kg = ""
                packreturn.ounces = ""
                packreturn.pounds = ""
                packreturn.stone = ""
            }
            else
            {
                var inputValue : Measurement<UnitMass>?
                
                if (inputValueType == UnitMass.grams.symbol){
                    inputValue = Measurement(value: valueDigit, unit: UnitMass.grams)
                }
                else if (inputValueType == UnitMass.kilograms.symbol){
                    inputValue = Measurement(value: valueDigit, unit: UnitMass.kilograms)
                }
                else if (inputValueType == UnitMass.ounces.symbol){
                    inputValue = Measurement(value: valueDigit, unit: UnitMass.ounces)
                }
                else if (inputValueType == UnitMass.pounds.symbol){
                    inputValue = Measurement(value: valueDigit, unit: UnitMass.pounds)
                }
                else if (inputValueType == UnitMass.stones.symbol){
                    inputValue = Measurement(value: valueDigit, unit: UnitMass.stones)
                }
                else {
                    print("WHAT IS GOING ON HERE??")
                }
                
                if let inputVal = inputValue{
                    packreturn.grams = stringRoundedMassConversion(inputValue: inputVal, outputDimension: UnitMass.grams)
                    packreturn.kg = stringRoundedMassConversion(inputValue: inputVal, outputDimension: UnitMass.kilograms)
                    packreturn.ounces = stringRoundedMassConversion(inputValue: inputVal, outputDimension: UnitMass.ounces)
                    packreturn.pounds = stringRoundedMassConversion(inputValue: inputVal, outputDimension: UnitMass.pounds)
                    packreturn.stone = stringRoundedMassConversion(inputValue: inputVal, outputDimension: UnitMass.stones)
                   
                   
                }
            }
        }
        else{
//            print("WHAT IS GOING ON HERE??")
            
        }
        
        return packreturn
        
        
    }
    
    
}


