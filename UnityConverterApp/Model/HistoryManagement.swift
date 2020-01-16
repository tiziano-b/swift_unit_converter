//
//  HistoryManagement.swift
//  UnityConverterApp
//
//  Created by Tiziano on 18/03/2019.
//  Copyright © 2019 Tiziano Bissola. All rights reserved.
//

import Foundation


/*
 
 to nmanage the History I have used the following structure :
 
 - 1st user default key = "TYPE"+"NUMBER"    --> content = arrey of string
 = type is the type of measure
 = number is the number of the conversion in the stack of conversions
 = arrey of string of the conversion performed by the user
 
 - 2nd user default key = SAVEDIN+"type of measure"    --> content = number
 = it counts the number of conversion saved for measure type
 
 the protocol interface ensure low coupuling. the viewController will use the definition of that protocol
 
 
 */
 
 





protocol HistoryManagement {
    func savingItemsStringv2(elements : [String], type: String) -> Bool
        func extractStringHistory(type: String) -> [String]
}



class HistoryManagementImplementation: HistoryManagement{
    /*
     
     FUNCTIONs USED BY CONVERTER VIEW CONTROLLER
     
     */
    
    // ELEMENTS = STRING OF THE VALUES CONVERTED
    // TYPES = TYPE OF THE CONVERSION .. MEASUREMENT
    
    
    
    
    func savingItemsStringv2(elements : [String], type: String) -> Bool{
        
        //  var conversionAlreadySaved : Bool = false
        var conversionToBeSaved : Bool = true
        let defaults = UserDefaults.standard
        
        // verify if the conversion has been already saved
        
        if (self.exists(key: "savedIn"+type)){
            let saved = defaults.integer(forKey: "savedIn"+type)
            for index in 1...saved{
                let object = defaults.object(forKey: type+"\(index)")
                let historyElement : [String] = object as! [String]
                
                
                // -->          IF U WANNA BE SURE THAT the same conversion is not saved 2 times < ----
                
                
                //                for index in 0...elements.count-1{
                //                    if(historyElement[index] == elements[index]){
                //                        print("NO SAVE")
                //                        conversionAlreadySaved = true
                //                    }
                //                }
                
                // THIS IS CAUSED BY THE FOUNDATION -.-' in particular km_h and meter per seconds
                // -->          IF U WANNA BE SURE THAT the same conversion is not saved 2 times < ----
                
                
                if(historyElement[0] == elements[0]){
                    print("NO SAVE")
                    // conversionAlreadySaved = true
                    conversionToBeSaved = false
                }
                
                
                
                
            }
            
            
        }
        
        
        // saving the conversion if is not saved
        
        if (conversionToBeSaved == true){
            //            print("NEEDS to be SAVED")
            
            
            // manage the case if there are other conversion saved for the measure
            if (exists(key: "savedIn"+type)){
                //                print("SAVE IN EXIST")
                var saved = defaults.integer(forKey: "savedIn"+type)
                
                // manage the case if the saved number of conversion has reached the limit..
                if (saved == 5){
                    defaults.removeObject(forKey: type+"5")
                    let count = [4,3,2,1]
                    for index in count{
                        let object = defaults.object(forKey: type+"\(index)")
                        UserDefaults.standard.set(object, forKey: type+"\(index+1)")
                    }
                    UserDefaults.standard.set(elements, forKey: type+"1")
                }
                    
                    // manage the case if the saved number of conversion hasn't reached the limit..
                else{
                    var totalSaved = saved
                    
                    // INCREASING POSITION OF THE SAVED ELEMENT
                    repeat {
                        let object = defaults.object(forKey: type+"\(saved)")
                        UserDefaults.standard.set(object, forKey: type+"\(saved+1)")
                        
                        saved = saved-1
                        
                    }while(saved > 0)
                    
                    //SAVING THE LASTEST ELEMENT IN THE HISTORY
                    totalSaved = totalSaved+1
                    UserDefaults.standard.set(totalSaved, forKey: "savedIn"+type)
                    UserDefaults.standard.set(elements, forKey: type+"1")
                    
                    // JUST LOG
                    //                    for index in 1...totalSaved{
                    //                        let object = defaults.object(forKey: type+"\(index)")
                    //                    }
                    // JUST LOG ------
                }
            }
                
                // manage the case if there are no conversion saved for the measure
            else{
                // is the first element of the history
                UserDefaults.standard.set(elements, forKey: type+"1")
                UserDefaults.standard.set(1, forKey: "savedIn"+type)
            }
        }
        
        
        return conversionToBeSaved
    }
    
    // helper function. verify if a userdefault object exits or no
    private func exists(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    // ----------------------------------
    
    /*
     
     FUNCTIONs USED BY HISTORY VIEW CONTROLLER
     
     */
    
    // the function create the full string of conversion ...
    
    func extractStringHistory(type: String) -> [String]{
        let defaults = UserDefaults.standard
        var history : [String] = [String]()
        
        if (self.exists(key: "savedIn"+type)){
            let saved = defaults.integer(forKey: "savedIn"+type)
            
            
            for index in 1...saved{
                let object = defaults.object(forKey: type+"\(index)")
                let elements : [String] = object as! [String]
                
                var string_conversion : String = ""
                
                for el in 0...elements.count-1{
                    if (el == elements.count-1){
                        string_conversion.append(contentsOf: "\(elements[el])")
                        
                    }
                    else{
                        string_conversion.append(contentsOf: "\(elements[el]) = ")
                    }
                }
                history.append(string_conversion)
            }
        }
        
        return history
        
    }
    
//    func savingHistoryWeight(kg: String, gram: String, ounces: String, pound: String, stone: String) -> [String]{
//        
//        
//        
//    }
    
}
