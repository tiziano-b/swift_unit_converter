//
//  ScrollViewManagementExtension.swift
//  UnityConverterApp
//
//  Created by Tiziano on 14/03/2019.
//  Copyright © 2019 Tiziano Bissola. All rights reserved.
//

import Foundation
import UIKit

/*
 
function to scroll the scrollView
 
 */

extension UIViewController{
    
    func scrollTheView(scrollView : UIScrollView, textField : UITextField, keyboardHeigh: CGFloat, naturalOffset: CGPoint)  {
        
        // define the distance that has to be scrolled
        let distanceToBottom = scrollView.frame.size.height - (textField.frame.origin.y) - (textField.frame.height)
        
        // --------- TO MANAGE THE SCROLLVIEW WITH THE CUSTOM KEYBOARD ... INCREASE THE VALUE AND GO UP !!
        let customKeyboardValue = Constants.GeneralValues.increaseSizeVerificationKeyboardOffset
        
        // define the offset value of the keyboard and the textfield
        let weNeedMoreSpace = keyboardHeigh - distanceToBottom + customKeyboardValue
        
        // if the space is enought ....
        if weNeedMoreSpace < 0{
            
            // BUT if the scroll view has to be replaced because the selected textfield is not covered by the keyboard ....
            if (scrollView.contentOffset.y != naturalOffset.y){
                UIView.animate(withDuration: 0.3, animations: {scrollView.contentOffset = CGPoint(x: naturalOffset.x, y: naturalOffset.y)})
            }
            
            return // no collapse
        }
        else{
            // if the space is not enought.... scroll the view!
            
//            print("YES ---> COLLAPSE SPACE --> \(weNeedMoreSpace)")
            UIView.animate(withDuration: 0.3, animations: {scrollView.contentOffset = CGPoint(x: naturalOffset.x, y: weNeedMoreSpace+70)})
        }
    }
}




