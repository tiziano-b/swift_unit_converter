//
//  HeaderCustomExtension.swift
//  UnityConverterApp
//
//  Created by Tiziano on 15/03/2019.
//  Copyright © 2019 Tiziano Bissola. All rights reserved.
//

import Foundation
import UIKit


/*
 
extension of the UIViewController to clear the navigation bar and retrieve the size of the header
 
 */

extension UIViewController {
    func clearAndsetHeaderSize () -> CGFloat{
        
        var headerSize : CGFloat = 0
        
        if let navController = navigationController{
            System.clearNavigationBar(forBar: navController.navigationBar)
            navController.view.backgroundColor = .clear
            
            headerSize = CGFloat(retrieveSizeHeader())
            
            
            
        }
        return headerSize

        
    }
    
    func retrieveSizeHeader() -> Int{
        var sizePhoneScreen : Int = 0
        switch UIScreen.main.nativeBounds.height {
        case 1136:
//            print("iPhone 5 or 5S or 5C/ SE")
            sizePhoneScreen = Constants.PhoneHeaderSize.iPhone_5_5S_SE
        case 1334:
//            print("iPhone 6/6S/7/8")
            sizePhoneScreen = Constants.PhoneHeaderSize.iPhone_6_6S_7_8
        case 1920, 2208:
//            print("iPhone 6+/6S+/7+/8+")
            sizePhoneScreen = Constants.PhoneHeaderSize.iPhone_6p_6Sp_7p_8p
        case 2436:
            print("iPhone X, XS")
            sizePhoneScreen = Constants.PhoneHeaderSize.iPhone_X_XS
        case 2688:
//            print("iPhone XS Max")
            sizePhoneScreen = Constants.PhoneHeaderSize.iPhone_XS_Max
        case 1792:
            print("iPhone XR")
            sizePhoneScreen = Constants.PhoneHeaderSize.iPhone_XR
        default:
            print("Unknown --> ERROR DETECTION PHONE !!")
        }
        return sizePhoneScreen
    }
}
