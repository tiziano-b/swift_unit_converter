//
//  LiquidConversionImplementation.swift
//  UnityConverterApp
//
//  Created by Tiziano on 16/03/2019.
//  Copyright © 2019 Tiziano Bissola. All rights reserved.
//

import Foundation


import UIKit

class LiquidConversionImplementation: MeasuresRoundHelper, LiquidConversion {
    func conversionForSaving(inputValue: Double) -> Measure {
        
        let finalPack : LiquidMeasure = LiquidMeasure()
        
        finalPack.litre = stringRoundedMeasureAllHistory(inputValue: inputValue, outputDimension: UnitVolume.liters)
        
        
        finalPack.fluid_ounce = stringRoundedMeasureAllHistory(inputValue: inputValue, outputDimension: UnitVolume.fluidOunces)
        
        finalPack.gallon = stringRoundedMeasureAllHistory(inputValue: inputValue, outputDimension: UnitVolume.gallons)
        
        finalPack.millilitre = stringRoundedMeasureAllHistory(inputValue: inputValue, outputDimension: UnitVolume.milliliters)
        
        finalPack.pint_uk = stringRoundedMeasureAllHistory(inputValue: inputValue, outputDimension: UnitVolume.imperialPints)
        
        let packreturn : Measure =  finalPack
        return packreturn
    }

    
    func conversionForEditingLiquid(value: String, inputValueType: String) -> LiquidMeasure {
        let finalpack : LiquidMeasure = LiquidMeasure()
          // delete this IF - ELSE. it doesn't make sense. a string empty can't become a Double!!!
        if let valueDigit = Double(value){
            if (value == ""){
                finalpack.fluid_ounce = ""
                finalpack.gallon = ""
                finalpack.litre = ""
                finalpack.millilitre = ""
                finalpack.pint_uk = ""
            }
            else{
                var inputValue : Measurement<UnitVolume>?
                if (inputValueType == UnitVolume.liters.symbol){
                    inputValue = Measurement(value: valueDigit, unit: UnitVolume.liters)
                }
                else if (inputValueType == UnitVolume.milliliters.symbol){
                    inputValue = Measurement(value: valueDigit, unit: UnitVolume.milliliters)
                }
                else if (inputValueType == UnitVolume.imperialPints.symbol){
                    inputValue = Measurement(value: valueDigit, unit: UnitVolume.imperialPints)
                }
                else if (inputValueType == UnitVolume.gallons.symbol){
                    inputValue = Measurement(value: valueDigit, unit: UnitVolume.gallons)
                }
                else if (inputValueType == UnitVolume.fluidOunces.symbol){
                    inputValue = Measurement(value: valueDigit, unit: UnitVolume.fluidOunces)
                }
                else {
                    print("WHAT IS GOING ON HERE??")
                }
                
                if let inputVal = inputValue{
                    finalpack.fluid_ounce = stringRoundedMeasureLiquidConversion(inputValue: inputVal, outputDimension: UnitVolume.fluidOunces)
                    
                    finalpack.gallon = stringRoundedMeasureLiquidConversion(inputValue: inputVal, outputDimension: UnitVolume.gallons)
                    finalpack.litre = stringRoundedMeasureLiquidConversion(inputValue: inputVal, outputDimension: UnitVolume.liters)
                    finalpack.millilitre = stringRoundedMeasureLiquidConversion(inputValue: inputVal, outputDimension: UnitVolume.milliliters)
                    finalpack.pint_uk = stringRoundedMeasureLiquidConversion(inputValue: inputVal, outputDimension: UnitVolume.imperialPints)
                }
            }
        }
        else{
//            print("WHAT IS GOING ON HERE??")
        }
        
        return finalpack
        
    }

}
