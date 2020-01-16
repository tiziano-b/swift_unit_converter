//
//  NavigationBarText.swift
//  UnityConverterApp
//
//  Created by Tiziano on 17/03/2019.
//  Copyright © 2019 Tiziano Bissola. All rights reserved.
//

import Foundation
import UIKit


/*
Class for Customize the Navigation Bar
 The protocol just define the method to create a title composed by 2 possible elements, with different possile color
 */


protocol NavigationBarCustom {
    func textNavBarAttributes(color1: UIColor, text1: String, color2: UIColor, text2: String) -> UILabel
}


class ChangeTextNavigationBarAttribute : NavigationBarCustom{
    func textNavBarAttributes(color1: UIColor, text1: String, color2: UIColor, text2: String) -> UILabel {
        
        
        /*
         Usage of MutableAttributetring to define new attributes for the string..
         in this case I defined a DEFAULT pattern Light + Medium
         */
        
        let navigationBarLabel = UILabel()
        let naviagationBarTitle = NSMutableAttributedString(string: text1, attributes: [NSAttributedString.Key.foregroundColor: color1, NSAttributedString.Key.font: UIFont.systemFont(ofSize: Constants.GeneralValues.sizeNavigationBar, weight: Constants.GeneralValues.weightNavigationBarLight)])
        
       naviagationBarTitle.append(NSMutableAttributedString(string: text2, attributes: [NSAttributedString.Key.foregroundColor: color2, NSAttributedString.Key.font: UIFont.systemFont(ofSize: Constants.GeneralValues.sizeNavigationBar, weight: Constants.GeneralValues.weightNavigationBarMedium)]))
        
    
        navigationBarLabel.attributedText = naviagationBarTitle
        
        return navigationBarLabel
        
        
    }
    
}
