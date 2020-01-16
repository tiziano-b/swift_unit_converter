//
//  CustomKeyboardHelper.swift
//  UnityConverterApp
//
//  Created by Tiziano on 08/03/2019.
//  Copyright © 2019 Tiziano Bissola. All rights reserved.
//

import Foundation


// Protocol for the keyboard ouput definition
protocol KeyboardInput {
    // the function is static can be called without instantiate the element
    static func output(keyPressed: String, textfield: String) -> String
}


// Model Handling for the Keyboard
class KeyboardInputHandler : KeyboardInput{
    static func output(keyPressed: String, textfield: String) -> String
    {
        var newTextField: String = textfield
                
        // user experience improve handling the "0"
        if (keyPressed == "C"){
            if (newTextField == "0."){
                newTextField.removeAll()
            }
            
            if(newTextField.count > 0){
                newTextField.removeLast()
            }
            
            if (newTextField == "0"){
                newTextField.removeLast()
            }
        }
            
        else if (keyPressed == "."){
            if(!newTextField.contains(".") && newTextField.count == 0){
                newTextField = "0."
                
            }
            else if (!newTextField.contains(".")){
                newTextField.append(".")
                //newTextField = textfield+keyPressed
            }
        }
            
        else if (keyPressed == "+/-"){
            // user experience - handling if the user wants to change the sign to a number with a . in the last position
            var dropPoint : Bool = false
            if (textfield.last == "."){
                dropPoint = true
                newTextField.removeLast()
            }
            // ---
            
            
            // in order to not display the decimal if the number doesn't have any decimal
            if(!newTextField.contains(".")){
                if var number = Int(newTextField){
                    number = -number
                    newTextField = String(number)
                }
                    // error handling. ? // if the string is equal to zero.
                else{
                    print("error!")
                }
            }
            else{
                if var number = Double(newTextField){
                    number = -number
                    newTextField = String(number)
                }
                    // error handling. ? // if the string is equal to zero.
                else{
                    print("error!")
                }
            }
            
            
            // user experience - handling if the user wants to change the sign to a number with a . in the last position
            if(dropPoint == true){
                newTextField.append(".")
            }
        }
        else {
            newTextField.append(keyPressed)
        }
        return newTextField
    }
}
