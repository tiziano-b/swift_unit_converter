//
//  RoundValue.swift
//  UnityConverterApp
//
//  Created by Tiziano on 16/03/2019.
//  Copyright © 2019 Tiziano Bissola. All rights reserved.
//

import Foundation

/*
 
the behavior of this class is to return the string of the measure rounded at the most significan
 value after the . with a maximum of 4 digit after the .
 */

class MeasuresRoundHelper{
    

    
    // ----------  SAVING for HISTORY  ------------ //
    
    
    func stringRoundedMeasureAllHistory(inputValue: Double, outputDimension: Dimension) -> String{
        
        var resultString : String = ""
        
        
        /*
        Based on the type of conversion ..
        */
        
        if (outputDimension == UnitTemperature.celsius || outputDimension == UnitTemperature.kelvin || outputDimension == UnitTemperature.fahrenheit)
            
        {
            /*
             Define the base measure of the conversion, in this case celsius
             */
            let inputValue = Measurement(value: inputValue, unit: UnitTemperature.celsius)
            
            /*
             Convert the measure into a string of the output dimension -> in this case kelvin, fahrenite or celsius
             */
            let inputR : String = String(inputValue.converted(to: outputDimension as! UnitTemperature).value)
            
            
            /*
             Verify the number of 0 after the . to ensure that the conversion is made properly
             */
            let numberRounded = verifyNumberOfZero(inputElement: inputR)
            
            /*
             Population of the history string for the converted measure.
            1. manage the case if the string has the exponent
            2  manage the case if the string doens't have an exponent. print to max 4 decimals or at the most signfiicant digit after the 0
             */
            
            var outputvalue : String = ""
            if(numberRounded.exp == true){
                outputvalue = cutTheExponential(expNumber: inputValue.converted(to: outputDimension as! UnitTemperature).value)
                
            }
            else{
                let roundedDecimal = typeOfRoundedMethod(number: numberRounded)
                outputvalue = String(format: "%.\(roundedDecimal)f", inputValue.converted(to: outputDimension as! UnitTemperature).value)
            }
            let outputFull = outputvalue+" \(outputDimension.symbol)"
            
            resultString = outputFull
            
        }
            
            /*
             REPEAT the logic for all the measures
             */
            
            
        else if (outputDimension == UnitMass.kilograms || outputDimension == UnitMass.grams || outputDimension == UnitMass.ounces || outputDimension == UnitMass.pounds || outputDimension == UnitMass.stones)
            
        {
            let inputValue = Measurement(value: inputValue, unit: UnitMass.kilograms)
            
            let inputR : String = String(inputValue.converted(to: outputDimension as! UnitMass).value)
            
            
            let numberRounded = verifyNumberOfZero(inputElement: inputR)
            var outputvalue : String = ""
            
            if(numberRounded.exp == true){
                outputvalue = cutTheExponential(expNumber: inputValue.converted(to: outputDimension as! UnitMass).value)
                
            }
            else{
                let roundedDecimal = typeOfRoundedMethod(number: numberRounded)
                outputvalue = String(format: "%.\(roundedDecimal)f", inputValue.converted(to: outputDimension as! UnitMass).value)
            }
            let outputFull = outputvalue+" \(outputDimension.symbol)"
            
            resultString = outputFull
            
        }
            
            
        else if (outputDimension == UnitVolume.liters || outputDimension == UnitVolume.gallons || outputDimension == UnitVolume.fluidOunces || outputDimension == UnitVolume.milliliters || outputDimension == UnitVolume.imperialPints)
            
        {
            let inputValue = Measurement(value: inputValue, unit: UnitVolume.liters)
            
            let inputR : String = String(inputValue.converted(to: outputDimension as! UnitVolume).value)
            
            
            let numberRounded = verifyNumberOfZero(inputElement: inputR)
            var outputvalue : String = ""
            
            if(numberRounded.exp == true){
                outputvalue = cutTheExponential(expNumber: inputValue.converted(to: outputDimension as! UnitVolume).value)
                
            }
            else{
                let roundedDecimal = typeOfRoundedMethod(number: numberRounded)
                outputvalue = String(format: "%.\(roundedDecimal)f", inputValue.converted(to: outputDimension as! UnitVolume).value)
            }
            let outputFull = outputvalue+" \(outputDimension.symbol)"
            
            resultString = outputFull
            
        }
            
            
        else if (outputDimension == UnitLength.centimeters || outputDimension == UnitLength.millimeters || outputDimension == UnitLength.meters || outputDimension == UnitLength.betterImplementationMiles || outputDimension == UnitLength.yards || outputDimension == UnitLength.inches)
            
        {
            let inputValue = Measurement(value: inputValue, unit: UnitLength.meters)
            
            let inputR : String = String(inputValue.converted(to: outputDimension as! UnitLength).value)
            
            
            let numberRounded = verifyNumberOfZero(inputElement: inputR)
            var outputvalue : String = ""
            
            if(numberRounded.exp == true){
                outputvalue = cutTheExponential(expNumber: inputValue.converted(to: outputDimension as! UnitLength).value)
                
            }
            else{
                let roundedDecimal = typeOfRoundedMethod(number: numberRounded)
                outputvalue = String(format: "%.\(roundedDecimal)f", inputValue.converted(to: outputDimension as! UnitLength).value)
            }
            let outputFull = outputvalue+" \(outputDimension.symbol)"
            
            resultString = outputFull
            
        }
            
        else if (outputDimension == UnitSpeed.kilometersPerHour || outputDimension == UnitSpeed.metersPerSecond || outputDimension == UnitSpeed.milesPerHour || outputDimension == UnitSpeed.knots)
            
        {
            let inputValue = Measurement(value: inputValue, unit: UnitSpeed.metersPerSecond)
            
            let inputR : String = String(inputValue.converted(to: outputDimension as! UnitSpeed).value)
            
            
            let numberRounded = verifyNumberOfZero(inputElement: inputR)
            var outputvalue : String = ""
            
            if(numberRounded.exp == true){
                outputvalue = cutTheExponential(expNumber: inputValue.converted(to: outputDimension as! UnitSpeed).value)
                
            }
            else{
                let roundedDecimal = typeOfRoundedMethod(number: numberRounded)
                outputvalue = String(format: "%.\(roundedDecimal)f", inputValue.converted(to: outputDimension as! UnitSpeed).value)
            }
            let outputFull = outputvalue+" \(outputDimension.symbol)"
            
            resultString = outputFull
            
        }
        
        return resultString
    }
    
    
    
    // ---------- DURING EDITING ------------ //
    
    /*
     I have defined a function for each conversion.
     It can be
     */
    
    func stringRoundedMeasureTemperatureConversion (inputValue: Measurement<UnitTemperature>, outputDimension: UnitTemperature) -> String{
        
        
        /*
         the logic is the same as described above with the exception of
         - no add the symbol to the string
         
         */
        
        let inputR : String = String(inputValue.converted(to: outputDimension).value)
        let numberRounded = verifyNumberOfZero(inputElement: inputR)
        var outputvalue : String = ""
        
        if(numberRounded.exp == true){
            outputvalue = cutTheExponential(expNumber: inputValue.converted(to: outputDimension).value)
        }
        else{
            let roundedDecimal = typeOfRoundedMethod(number: numberRounded)
            outputvalue = String(format: "%.\(roundedDecimal)f", inputValue.converted(to: outputDimension).value)
        }
        
        return outputvalue
        
    }
    
    
    // round function for Liquid String
    
    func stringRoundedMeasureLiquidConversion (inputValue: Measurement<UnitVolume>, outputDimension: UnitVolume) -> String{
        
        let inputR : String = String(inputValue.converted(to: outputDimension).value)
        
        let numberRounded = verifyNumberOfZero(inputElement: inputR)
        var outputvalue : String = ""
        
        if(numberRounded.exp == true){
            outputvalue = cutTheExponential(expNumber: inputValue.converted(to: outputDimension).value)
        }
        else{
            let roundedDecimal = typeOfRoundedMethod(number: numberRounded)
            outputvalue = String(format: "%.\(roundedDecimal)f", inputValue.converted(to: outputDimension).value)
        }
        
        return outputvalue
        
    }
    
    // round function for Lenght String
    
    func stringRoundedMeasurelenghtConversion (inputValue: Measurement<UnitLength>, outputDimension: UnitLength) -> String{
        
        let inputR : String = String(inputValue.converted(to: outputDimension).value)
        
        let numberRounded = verifyNumberOfZero(inputElement: inputR)
        var outputvalue : String = ""
        
        if(numberRounded.exp == true){
            outputvalue = cutTheExponential(expNumber: inputValue.converted(to: outputDimension).value)
        }
        else{
            let roundedDecimal = typeOfRoundedMethod(number: numberRounded)
            outputvalue = String(format: "%.\(roundedDecimal)f", inputValue.converted(to: outputDimension).value)
        }
        
        return outputvalue
        
    }
    
    // round function for Speed String
    
    func stringRoundedMeasureSpeedConversion (inputValue: Measurement<UnitSpeed>, outputDimension: UnitSpeed) -> String{
        
        let inputR : String = String(inputValue.converted(to: outputDimension).value)
        
        let numberRounded = verifyNumberOfZero(inputElement: inputR)
        var outputvalue : String = ""
        
        if(numberRounded.exp == true){
            outputvalue = cutTheExponential(expNumber: inputValue.converted(to: outputDimension).value)
        }
        else{
            let roundedDecimal = typeOfRoundedMethod(number: numberRounded)
            outputvalue = String(format: "%.\(roundedDecimal)f", inputValue.converted(to: outputDimension).value)
        }
        
        return outputvalue
        
    }
    
    // round function for Temperature String
    
    func stringRoundedMassConversion (inputValue: Measurement<UnitMass>, outputDimension: UnitMass) -> String{
        
        let inputR : String = String(inputValue.converted(to: outputDimension).value)
        
        let numberRounded = verifyNumberOfZero(inputElement: inputR)
        var outputvalue : String = ""
        
        if(numberRounded.exp == true){
            outputvalue = cutTheExponential(expNumber: inputValue.converted(to: outputDimension).value)
        }
        else{
            let roundedDecimal = typeOfRoundedMethod(number: numberRounded)
            outputvalue = String(format: "%.\(roundedDecimal)f", inputValue.converted(to: outputDimension).value)
        }
        
        return outputvalue
        
    }
    
    
    
    
    
    
    // ------------- LOIGIC for the SELECTION of the DECIMAL values ----- //
    
    
    
    // the function takes in input the string of the number that we have to save and will return the number of 0 after the . in order to save the exact rounded value for the user
    
    func verifyNumberOfZero(inputElement : String) -> NumberToBeConvertedFormat{
        var numberOfZero : Int = 0
        var numberofDigitAfterThePoint : Int = 0
        var consider : Bool = false
        var pointInTheNumber : Bool = false
        var deciamlNumberAfterZero: Bool = false
        var exponential : Bool = false
        
        
        if inputElement.contains("e"){
            exponential = true
        }
        
        
        if inputElement.contains("."){
            for digit in inputElement{
                
                
                
                if (pointInTheNumber == true){
                    numberofDigitAfterThePoint = numberofDigitAfterThePoint+1
                    
                    if (consider == true){
                        if (digit == "0"){
                            numberOfZero = numberOfZero+1
                        }
                        else{
                            consider = false
                            deciamlNumberAfterZero = true
                        }
                    }
                }
                // the verification of the . after the count to verify have a consistent calculation
                if (digit == "."){
                    consider = true
                    pointInTheNumber = true
                }
            }
        }
        
        
        /*
        the return object contains all the information of the string (number) that has to be saved or displayed
        */
        
        return NumberToBeConvertedFormat(numberofZero: numberOfZero, floatingPoint: pointInTheNumber, numberofDigitAfterThePoint: numberofDigitAfterThePoint, extraDeciamlNumerOtherZero:deciamlNumberAfterZero, exp: exponential)
    }
    
    
    /*
     the function return the number of digit after the . that has to be displayed.
     */
    
    
    
    func typeOfRoundedMethod(number: NumberToBeConvertedFormat) -> Int{
        var numberOfRoundedDigit = 0
        
//
//        print("CONVERSION NUMBER ------------")
//        print(number.exp)
//        print(number.extraDeciamlNumerOtherZero)
//        print(number.floatingPoint)
//        print(number.numberofDigitAfterThePoint)
//        print(number.numberofZero)
//        print("CONVERSION NUMBER ------------")
//
        
        if (number.exp == true){
            numberOfRoundedDigit = number.numberofDigitAfterThePoint
        }
            
        else if (number.floatingPoint == false || number.extraDeciamlNumerOtherZero == false){
//            print("no . no rounded")
        }
        else{
            if(number.numberofDigitAfterThePoint >= 4){
                
                // OLD LOGIC DIGIT MOST SIGNIFICATIVE .
                //            if(number.numberofZero >= 4){
                //                numberOfRoundedDigit = number.numberofZero+1
                //            }
                //            else{
                //                numberOfRoundedDigit = 4
                //            }
                
                //----
                if(number.numberofZero >= 4){
                    
                    /*
                     if we have a number with >= of four 0 in the string I don't consider the decimal
                     */
                    
                    numberOfRoundedDigit = 0
                }
                else{
                    /*
                     the logic can be improved cutting the non-significant 0 of the number...
                     */
                    numberOfRoundedDigit = 4
                }
            }
            else{
                /*
                 if we have a number with < of 4 decimal ....
                 */
                numberOfRoundedDigit = number.numberofDigitAfterThePoint
            }
        }
        
        return numberOfRoundedDigit
    }
    
    
    
    /*
     managing the exponential in the number. it applies the previous step by cut and reapply the exponential substring to the string
     */
    func cutTheExponential(expNumber: Double) -> String{
        
        var afterExp:Bool = false
        var newNumber : String = ""
        var exp = ""
        
        let exponentialNumber: String = String(expNumber)
        
        for digit in exponentialNumber{
            
            if (digit == "e"){
                afterExp = true
            }
            
            if(afterExp){
                exp.append(digit)
            }
            else{
                newNumber.append(digit)
            }
        }
        
        let roundedDecimal:Int = typeOfRoundedMethod(number: verifyNumberOfZero(inputElement: newNumber))
        
        
        let doubleNewNumber : Double = Double(newNumber)!
        
        let outputNumber = String(format: "%.\(roundedDecimal)f", doubleNewNumber)
        
        let fullOutputNumber : String = outputNumber+exp
        
//        print(fullOutputNumber)
        
        
        return fullOutputNumber
        
        
    }
    
}

