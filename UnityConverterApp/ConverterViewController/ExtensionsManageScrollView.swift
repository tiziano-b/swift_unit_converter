//
//  ExtensionsManageScrollView.swift
//  UnityConverterApp
//
//  Created by Tiziano on 14/03/2019.
//  Copyright © 2019 Tiziano Bissola. All rights reserved.
//


import Foundation
import UIKit

// HANDLING THE KEYBORAD WILL SHOW AND HIDE NOTIFICATION ON EACH CONTROLLER. necessary to each controller to manage the upadte of activeTextField

extension WeightConverterViewController{
    
    @objc func keyboardShowNotificationManagement2(notification: NSNotification){
        
        // when the keyboard appear, show the tabbar ! if it was hidden by the UIAction
        if (uiallertcontrolCalled == true){
            uiallertcontrolCalled = false
            tabBarController?.tabBar.isHidden = false
        }
        
        
        
        // calling the keyboardshownotification only if it is not present in the view.
        // NB moreover it is important to have just ONE observer per type (ex keyboardWillShow...), in order to not have proliferation
        if (keyboardHeight == nil){
            // the function is an extension of UIViewController.
            keyboardShowNotificationManagement(notification: notification)
        }
        if let keyboardSize = (notification.userInfo?[UIApplication.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            keyboardHeight = keyboardSize.height
        }
        //manageTheScrol()
         if let activeTextfield : UITextField = activeField{
            self.scrollTheView(scrollView: self.scrollView, textField: activeTextfield, keyboardHeigh: keyboardHeight, naturalOffset: self.scrollViewNaturalOffset)
        }
    }
    
    @objc func keyboardHideNotificationManagement2(notification: NSNotification){
        
        
        
        if (keyboardHeight != nil){
            keyboardHideNotificationManagement(notification: notification)
        }
        
        // if the keyboard is hidden due to a AllertControl, hide the tab Bar
        if (uiallertcontrolCalled == true){
            tabBarController?.tabBar.isHidden = true
        }
        
        
        UIView.animate(withDuration: 0.3, animations: {self.scrollView.contentOffset = CGPoint(x: self.scrollViewNaturalOffset.x, y: self.scrollViewNaturalOffset.y)})
        
        keyboardHeight = nil
    }
}


extension TemperatureConverterViewController{
    
    @objc func keyboardShowNotificationManagement2(notification: NSNotification){
        
        if (uiallertcontrolCalled == true){
            uiallertcontrolCalled = false
            tabBarController?.tabBar.isHidden = false
        }
        
        if (keyboardHeight == nil){
            // the function is an extension of UIViewController.
            keyboardShowNotificationManagement(notification: notification)
        }
        if let keyboardSize = (notification.userInfo?[UIApplication.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            keyboardHeight = keyboardSize.height
        }
        //manageTheScrol()
        if let activeTextfield : UITextField = activeField{
        self.scrollTheView(scrollView: self.scrollView, textField: activeTextfield, keyboardHeigh: keyboardHeight, naturalOffset: self.scrollViewNaturalOffset)
        }
    }
    
    @objc func keyboardHideNotificationManagement2(notification: NSNotification){
        
        //print("ADIOS KEYBOARD")
        if (keyboardHeight != nil){
            keyboardHideNotificationManagement(notification: notification)
        }
        
        // if the keyboard is hidden due to a AllertControl, hide the tab Bar
        if (uiallertcontrolCalled == true){
            tabBarController?.tabBar.isHidden = true
        }
        
        UIView.animate(withDuration: 0.3, animations: {self.scrollView.contentOffset = CGPoint(x: self.scrollViewNaturalOffset.x, y: self.scrollViewNaturalOffset.y)})
        
        keyboardHeight = nil
    }
}


extension LenghtConverterViewController{
    
    @objc func keyboardShowNotificationManagement2(notification: NSNotification){
        
        if (uiallertcontrolCalled == true){
            uiallertcontrolCalled = false
            tabBarController?.tabBar.isHidden = false
        }
        
        if (keyboardHeight == nil){
            // the function is an extension of UIViewController.
            keyboardShowNotificationManagement(notification: notification)
        }
        if let keyboardSize = (notification.userInfo?[UIApplication.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            keyboardHeight = keyboardSize.height
        }
        //manageTheScrol()
        if let activeTextfield : UITextField = activeField{
        self.scrollTheView(scrollView: self.scrollView, textField: activeTextfield, keyboardHeigh: keyboardHeight, naturalOffset: self.scrollViewNaturalOffset)
        }
    }
    
    @objc func keyboardHideNotificationManagement2(notification: NSNotification){
        
        //print("ADIOS KEYBOARD --> Lenght")
        if (keyboardHeight != nil){
            keyboardHideNotificationManagement(notification: notification)
        }
        
        // if the keyboard is hidden due to a AllertControl, hide the tab Bar
        if (uiallertcontrolCalled == true){
            tabBarController?.tabBar.isHidden = true
        }
        
        
        UIView.animate(withDuration: 0.3, animations: {self.scrollView.contentOffset = CGPoint(x: self.scrollViewNaturalOffset.x, y: self.scrollViewNaturalOffset.y)})
        
        keyboardHeight = nil
    }
}



extension LiquidsConverterViewController{
    
    @objc func keyboardShowNotificationManagement2(notification: NSNotification){
        
        if (uiallertcontrolCalled == true){
            uiallertcontrolCalled = false
            tabBarController?.tabBar.isHidden = false
        }
        
        if (keyboardHeight == nil){
            // the function is an extension of UIViewController.
            keyboardShowNotificationManagement(notification: notification)
        }
        if let keyboardSize = (notification.userInfo?[UIApplication.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            keyboardHeight = keyboardSize.height
        }
        //manageTheScrol()
        if let activeTextfield : UITextField = activeField{
             self.scrollTheView(scrollView: self.scrollView, textField: activeTextfield, keyboardHeigh: keyboardHeight, naturalOffset: self.scrollViewNaturalOffset)
        }
       
    }
    
    @objc func keyboardHideNotificationManagement2(notification: NSNotification){
        
        //print("ADIOS KEYBOARD --> Liquid")
        if (keyboardHeight != nil){
            keyboardHideNotificationManagement(notification: notification)
        }
        
        // if the keyboard is hidden due to a AllertControl, hide the tab Bar
        if (uiallertcontrolCalled == true){
            tabBarController?.tabBar.isHidden = true
        }
        
        
        UIView.animate(withDuration: 0.3, animations: {self.scrollView.contentOffset = CGPoint(x: self.scrollViewNaturalOffset.x, y: self.scrollViewNaturalOffset.y)})
        
        keyboardHeight = nil
    }
}


extension SpeedConverterViewController{
    
    @objc func keyboardShowNotificationManagement2(notification: NSNotification){
        
        if (uiallertcontrolCalled == true){
            uiallertcontrolCalled = false
            tabBarController?.tabBar.isHidden = false
        }
        
        if (keyboardHeight == nil){
            // the function is an extension of UIViewController.
            keyboardShowNotificationManagement(notification: notification)
        }
        if let keyboardSize = (notification.userInfo?[UIApplication.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            keyboardHeight = keyboardSize.height
        }
        //manageTheScrol()
        
        if let activeTextfield : UITextField = activeField{
            self.scrollTheView(scrollView: self.scrollView, textField: activeTextfield, keyboardHeigh: keyboardHeight, naturalOffset: self.scrollViewNaturalOffset)
        }
    }
    
    @objc func keyboardHideNotificationManagement2(notification: NSNotification){
        
        //print("ADIOS KEYBOARD --> Speed")ß
        if (keyboardHeight != nil){
            keyboardHideNotificationManagement(notification: notification)
        }
        
        // if the keyboard is hidden due to a AllertControl, hide the tab Bar
        if (uiallertcontrolCalled == true){
            tabBarController?.tabBar.isHidden = true
        }
        
        
        UIView.animate(withDuration: 0.3, animations: {self.scrollView.contentOffset = CGPoint(x: self.scrollViewNaturalOffset.x, y: self.scrollViewNaturalOffset.y)})
        
        keyboardHeight = nil
    }
}


