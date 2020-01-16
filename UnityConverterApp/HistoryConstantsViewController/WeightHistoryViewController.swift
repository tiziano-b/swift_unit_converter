//
//  WeightHistoryViewController.swift
//  UnityConverterApp
//
//  Created by Tiziano on 03/03/2019.
//  Copyright © 2019 Tiziano Bissola. All rights reserved.
//

import UIKit

// viewController inherits from the sclass UIViewController and the protocl HistoryPopulation that defines the function "populateView" 

class WeightHistoryViewController: UIViewController, HistoryPopulation {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    

    @IBOutlet weak var navBarImageConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // --------------- CUSTOMIZE THE NAVIGATION BAR
        let a : NavigationBarCustom = ChangeTextNavigationBarAttribute()
        self.navigationItem.titleView = a.textNavBarAttributes(color1: UIColor.black, text1: "LAST5", color2: UIColor(rgb: 0x076037, alphaVal: 1.0), text2: "history")
        // ---------------
        
        let history : HistoryManagement = HistoryManagementImplementation()
        
        // returns the arrey of string of the saved conversions
        let history_population = history.extractStringHistory(type: Constants.Conversion.weights)
        
        // function called by the extension HistoryPopulation --> PopulateView
        self.populateView(elements: [label1,label2,label3,label4,label5], population: history_population)
        
        // resize the custom navigationBar Image depending of the screen size og the phone
        navBarImageConstraint.constant = clearAndsetHeaderSize()
        
    }
    
    
}


    



