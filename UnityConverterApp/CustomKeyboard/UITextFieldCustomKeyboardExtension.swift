//
//  CustomKeyboardExtensionTextField.swift
//  UnityConverterApp
//
//  Created by Tiziano on 08/03/2019.
//  Copyright © 2019 Tiziano Bissola. All rights reserved.
//

import Foundation
import UIKit

/* extension of the UITextfield to manage the custom keyboard
    it includes the function definiton of Keyboard Delegate to handle the touch of the buttons
 
*/
extension UITextField: KeyboardDelegate {
    
    
    func keyWasTapped(character: String) {
        
        /*
         //self.view.endEditing(true)
         
         I typically reserve this for scenarios when I just absolutely need to clear the keyboard no matter what is currently going on, for whatever reason. Perhaps, I've got a slide-over menu? Just before this slides out, no matter what is going on, the keyboard should go away, so I'll make sure everything resigns its first responder status. It's important to note that endEditing() will look through the entire hierarchy of subviews and make sure whatever is the first responder resigns its status. This makes it less efficient then calling resignFirstResponder() if you already have a concrete reference to the first responder, but if not, it's easier than finding that view and having it resign.
         */
        
        /*
         resignFirstResponder() is good to use any time you know exactly which text field is the first responder and you want to resign its first responder status. This can be slightly more efficient then the alternative, but if you're doing something such as creating a custom control, this can make plenty of sense.
         */
        
        if(character == "="){
            self.resignFirstResponder()
        }
        else{
            // handling the input of the user using the model - the 2 elements are decoupled
            let newInput : String = KeyboardInputHandler.output(keyPressed: character, textfield: self.text!)
            
            // USING INSERTTEXT over a basic assignment operation = in order to be identified as an editingChanged operation by the UIControl
            self.text = ""
            // this solution is not looking GOOD --> try to find an alternative!
            // ---
            self.insertText(newInput)
            
        }
        
    }

    // the  method will create(set) a new view for the input of textField
    // the method set the new view as a inputview for the textField
    // the method bridge the delegation to itself. the firstresponder(view) is the delegate to execute function of the CustomKeyboardViewController
    func setAsMyAmazingCustomKeyboard(doYouNeedMinus : Bool) {

        
        // identify which phone is used
        var sizePhoneScreen : Int = 220
        switch UIScreen.main.nativeBounds.height {
        case 1136:
//            print("iPhone 5 or 5S or 5C/ SE")
            sizePhoneScreen = Constants.PhoneKeyboardSize.iPhone_5_5S_SE
        case 1334:
//            print("iPhone 6/6S/7/8")
            sizePhoneScreen = Constants.PhoneKeyboardSize.iPhone_6_6S_7_8
        case 1920, 2208:
//            print("iPhone 6+/6S+/7+/8+")
            sizePhoneScreen = Constants.PhoneKeyboardSize.iPhone_6p_6Sp_7p_8p
        case 2436:
//            print("iPhone X, XS")
            sizePhoneScreen = Constants.PhoneKeyboardSize.iPhone_X_XS
        case 2688:
//            print("iPhone XS Max")
            sizePhoneScreen = Constants.PhoneKeyboardSize.iPhone_XS_Max
        case 1792:
//            print("iPhone XR")
            sizePhoneScreen = Constants.PhoneKeyboardSize.iPhone_XR
        default:
            print("Unknown --> ERROR DETECTION PHONE !!")
        }
    
        let screenWidth : CGFloat = UIScreen.main.bounds.width
//        let myCustomKey = CustomKeyboardViewController(frame: CGRect(x: 0, y: 0, width: 0, height: 270))
        
//        print (Int(screenWidth))
        // define the size of the keyboard based on the phone
        let myCyustomKey = CustomKeyboardViewController(frame: CGRect(x: 0, y: 0, width: Int(screenWidth), height: sizePhoneScreen), sizeScreen: sizePhoneScreen, minus: doYouNeedMinus)
            

        
        // assigne the inputview to my custom Keyboard
        
        self.inputView = myCyustomKey
        // adding the clear button to the ALL textfield ! (:
        self.clearButtonMode = .whileEditing
        myCyustomKey.delegate = self

        
    }
    
    
    

}
