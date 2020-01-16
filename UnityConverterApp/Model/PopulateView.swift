//
//  PopulateView.swift
//  UnityConverterApp
//
//  Created by Tiziano on 11/03/2019.
//  Copyright © 2019 Tiziano Bissola. All rights reserved.
//

import Foundation
import UIKit


protocol HistoryPopulation {
    func populateView(elements: [UILabel], population: [String])
}

extension HistoryPopulation{
    func populateView(elements: [UILabel], population: [String]){
        // clear the view
        for index in 0...elements.count-1{
            elements[index].text = ""
        }
        
        if population.count > 0{
            
            let numberOfHistory : Int = population.count-1
            
           
            
            
            for i in 0...numberOfHistory{
                // population
                
                elements[i].text = population[i]
                // adjust the font and line of the view
                elements[i].numberOfLines = 3
                elements[i].adjustsFontSizeToFitWidth = true
            }
        }
        else{
            elements[2].text = "NO HISTORY SAVED"
        }
    }
}
