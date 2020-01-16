//
//  ViewControllerKeyboardExtension.swift
//  UnityConverterApp
//
//  Created by Tiziano on 11/03/2019.
//  Copyright © 2019 Tiziano Bissola. All rights reserved.
//

import Foundation
import UIKit

/*
 
Extension of the UIViewController for handling the Notification for the keyboard
 */

extension UIViewController{
    
    @objc func keyboardHideNotificationManagement(notification: NSNotification){
//        print("ADIOS KEYBOARD")
        
        
        var keyboardHeight : CGFloat = 0
        if let keyboardSize = (notification.userInfo?[UIApplication.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{

            keyboardHeight = keyboardSize.origin.y - (self.tabBarController?.tabBar.frame.height)!
            
        }
        else{
            print("NO KEYBOARD TO KILL")
        }
        
        var safeZoneBottom : CGFloat = 0
        
        // managing of the size of the tab bar. in X series the tabbar has size different from the previous series.
        // uses of a helper let to store the size of the X series
        // Improving the User Experience of the App
        
        // in order to catch if the phone is X series or not --- we can verify the iOS version or size of phone
    
//        if #available(iOS 11.0, *) {
//            let window = UIApplication.shared.keyWindow
//            if let bottomPadding = window?.safeAreaInsets.bottom{
//                safeZoneBottom = bottomPadding
//            }
//        }
        
        if(isItanIphoneX()){
            let window = UIApplication.shared.keyWindow
            if let bottomPadding = window?.safeAreaInsets.bottom{
                safeZoneBottom = bottomPadding
            }
        }
        
        
        let tabBarFrame : CGRect = (self.tabBarController?.tabBar.frame)!        
        
        var tabBarNewFrame : CGRect = CGRect(x: tabBarFrame.origin.x, y: tabBarFrame.origin.y, width: tabBarFrame.width, height: tabBarFrame.height+safeZoneBottom)
        
        keyboardHeight = self.view.frame.maxY - (tabBarNewFrame.height)
        
        tabBarNewFrame.origin.y = keyboardHeight
        UIView.animate(withDuration: 0.25, animations: {() -> Void in self.tabBarController?.tabBar.frame = tabBarNewFrame})
    }
    
    @objc func keyboardShowNotificationManagement(notification: NSNotification){
        
        var keyboardHeight : CGFloat = 0
        var safeZoneBottom : CGFloat = 0
        
        // managing of the size of the tab bar. in X series the tabbar has size different from the previous series.
        // uses of a helper let to store the size of the X series
        
//        if #available(iOS 11.0, *) {
//            let window = UIApplication.shared.keyWindow
//            if let bottomPadding = window?.safeAreaInsets.bottom{
//                safeZoneBottom = bottomPadding
//            }
//        }
        
        if(isItanIphoneX()){
            let window = UIApplication.shared.keyWindow
            if let bottomPadding = window?.safeAreaInsets.bottom{
                safeZoneBottom = bottomPadding
            }
        }
      
        // keyboardWillShow is fired before the keyboard appears, keyboardDidShow is fired afterwards.
        // using keyboardWillShow I had different behaviour of the application, so I used the DidShow version that gives me the same size every time
        
        if let keyboardSize = (notification.userInfo?[UIApplication.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            //self.keyboardHeight = keyboardSize.origin.y - keyboardSize.height - (self.tabBarController?.tabBar.frame.height)!
        keyboardHeight = keyboardSize.origin.y - (self.tabBarController?.tabBar.frame.height)!
            
        }
        let tabBarFrame : CGRect = (self.tabBarController?.tabBar.frame)!
        
        // the tabFrame size is different from X to old. managing of the sizes
        var tabBarNewFrame : CGRect = CGRect(x: tabBarFrame.origin.x, y: tabBarFrame.origin.y, width: tabBarFrame.width, height: tabBarFrame.height-safeZoneBottom)
        
        // the origin of the Frame depends if the System has or not the safe zone

        tabBarNewFrame.origin.y = keyboardHeight+safeZoneBottom
        UIView.animate(withDuration: 0.75, animations: {() -> Void in self.tabBarController?.tabBar.frame = tabBarNewFrame})
        
    }
    
    
    
    // verify the type of phone.
    func isItanIphoneX() -> Bool{
        var isItanIphoneX : Bool = false
        switch UIScreen.main.nativeBounds.height {
        case 1136:
//            print("iPhone 5 or 5S or 5C/ SE")
            isItanIphoneX = false
        case 1334:
//            print("iPhone 6/6S/7/8")
            isItanIphoneX = false
        case 1920, 2208:
//            print("iPhone 6+/6S+/7+/8+")
            isItanIphoneX = false
        case 2436:
//            print("iPhone X, XS")
            isItanIphoneX = true
        case 2688:
//            print("iPhone XS Max")
            isItanIphoneX = true
        case 1792:
//            print("iPhone XR")
            isItanIphoneX = true
        default:
            print("Unknown --> ERROR DETECTION PHONE !!")
        }
        return isItanIphoneX
    }
    
    
}


