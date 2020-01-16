//
//  FirstViewController.swift
//  UnityConverterApp
//
//  Created by Tiziano on 03/03/2019.
//  Copyright © 2019 Tiziano Bissola. All rights reserved.
//

import UIKit

class WeightConverterViewController: UIViewController, UITextFieldDelegate{

    
    @IBOutlet weak var textFieldKilograms: UITextField!
    @IBOutlet weak var textFieldGram: UITextField!
    @IBOutlet weak var textFieldOnces: UITextField!
    @IBOutlet weak var textFieldPounds: UITextField!
    @IBOutlet weak var textFieldStonePound: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var navBarImageConstraint: NSLayoutConstraint!
    
    // MANAGING THE SCROL VIEW //
    var scrollViewNaturalOffset : CGPoint!
    var activeField: UITextField?
    var keyboardHeight: CGFloat!        // used to verify if the keyboard is displayed + viewScrolled
    
    var uiallertcontrolCalled: Bool = false // manage the tab bar when a UIAlertController is called - it will apply the case of Keyboard willhidden due to a UIAllert. keyboard will be hidden because textfield lost the property of firstResponder and therefore the keyboard disapper.
    // in case the saving will be performed with no keyb -> no manage.

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadCustomKeyboard()
        scrollViewNaturalOffset = self.scrollView.contentOffset     // initialize the position of scrollView
        // clear the navBar
        navBarImageConstraint.constant = clearAndsetHeaderSize()
        
  
    }
    
    @IBAction func buttonSave(_ sender: UIBarButtonItem) {
        
        // just if in the textfield is present a double the conversion can be saved
        if let kilogramInserted = Double(textFieldKilograms.text!){
            let conversion : WeightConversion = WeightMeasureImplementation()
            
            //***** NB = *************************************************
            
            /*
             the simple and easiest way is
             let newHistoryElement : [String] = [textFieldKilograms.text!+"\(UnitMass.kilograms.symbol)", textFieldGram.text! ... ]
             
             Due to the numerous error on Measurement of Foundation I have decided to apply the conversion again, taking as reference the first measure in the list for each conversion type.
             Ideally we can provide display different feature in the history, not just what the user can see...
            */
            
            // FORCE DOWNCAST ! --> nb look at the comment in the function implementation
            let result = conversion.conversionForSaving(inputValue: kilogramInserted) as! WeightMeasure
            
            // JUST FOR ACCADEMIC PURPOSE
            //***** NB = *************************************************

            let newHistoryElement : [String] = [result.kg, result.grams, result.ounces, result.pounds, result.stone]
            
            // saving in User Defaults
            let history : HistoryManagement = HistoryManagementImplementation()
            let historysaved = history.savingItemsStringv2(elements: newHistoryElement, type: Constants.Conversion.weights)
            
            uiallertcontrolCalled = true        // there will be an UIAllert, so turn on the boolean
            if (historysaved == true){
                let alert = UIAlertController(title: "History", message: "Conversion saved.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
                self.present(alert, animated: true, completion: nil)
                
            }
            else{
                let alert = UIAlertController(title: "History", message: "Conversion already present...", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
                self.present(alert, animated: true, completion: nil)
            }
            
        
        }
        else{
            print("KOOOOP NO INPUT!")
        }
        
    }
        // ---------------------------------- //
        // FUNCTION TO MANAGE THE EDITING-CHANGED //
        // ---------------------------------- //
    
    @objc func calulation_Kilo(_ textField: UITextField){
        
        // define the type of conversion
        let conversion : WeightConversion = WeightMeasureImplementation()
        // input value from the user
        let conversion_values = conversion.conversionForEditingWeight(value: textField.text!, inputValueType: UnitMass.kilograms.symbol)
        
        // updating the textfield with the converted values
        self.textFieldGram.text = conversion_values.grams
        self.textFieldOnces.text = conversion_values.ounces
        self.textFieldPounds.text = conversion_values.pounds
    //    self.textFieldKilograms.text = conversion_values.kg
        self.textFieldStonePound.text = conversion_values.stone
        
    }
    
    @objc func calulation_Gram(_ textField: UITextField){
        let conversion : WeightConversion = WeightMeasureImplementation()
        
        let conversion_values = conversion.conversionForEditingWeight(value: textField.text!, inputValueType: UnitMass.grams.symbol)
        
        //self.textFieldGram.text = conversion_values.grams
        self.textFieldOnces.text = conversion_values.ounces
        self.textFieldPounds.text = conversion_values.pounds
        self.textFieldKilograms.text = conversion_values.kg
        self.textFieldStonePound.text = conversion_values.stone
    }
    
    @objc func calulation_Once(_ textField: UITextField){
        let conversion : WeightConversion = WeightMeasureImplementation()
        
        let conversion_values = conversion.conversionForEditingWeight(value: textField.text!, inputValueType: UnitMass.ounces.symbol)
        
        self.textFieldGram.text = conversion_values.grams
  //      self.textFieldOnces.text = conversion_values.ounces
        self.textFieldPounds.text = conversion_values.pounds
        self.textFieldKilograms.text = conversion_values.kg
        self.textFieldStonePound.text = conversion_values.stone
    }
    
    @objc func calulation_Pounds(_ textField: UITextField){
        let conversion : WeightConversion = WeightMeasureImplementation()
        
        let conversion_values = conversion.conversionForEditingWeight(value: textField.text!, inputValueType: UnitMass.pounds.symbol)
        
        self.textFieldGram.text = conversion_values.grams
        self.textFieldOnces.text = conversion_values.ounces
    //    self.textFieldPounds.text = conversion_values.pounds
        self.textFieldKilograms.text = conversion_values.kg
        self.textFieldStonePound.text = conversion_values.stone
    }
    
    @objc func calulation_Stone(_ textField: UITextField){
        let conversion : WeightConversion = WeightMeasureImplementation()
        
        let conversion_values = conversion.conversionForEditingWeight(value: textField.text!, inputValueType: UnitMass.stones.symbol)
        
        self.textFieldGram.text = conversion_values.grams
        self.textFieldOnces.text = conversion_values.ounces
        self.textFieldPounds.text = conversion_values.pounds
        self.textFieldKilograms.text = conversion_values.kg
       // self.textFieldStonePound.text = conversion_values.stone
    }
    
    
    
    // ---------------------------------- //
    // LOAD CUSTOM KEYBOARD FUNCTION + add target //
    // ---------------------------------- //
    
    func loadCustomKeyboard(){
        
        
        // ------ delegation , set keyboard, and textfieldEditingChanged target for all the textfield in the View
        
        textFieldKilograms.delegate = self
        textFieldKilograms.setAsMyAmazingCustomKeyboard(doYouNeedMinus: false)
        textFieldKilograms.addTarget(self, action: #selector(calulation_Kilo(_:)), for: UIControl.Event.editingChanged)
        
        textFieldGram.delegate = self
        textFieldGram.setAsMyAmazingCustomKeyboard(doYouNeedMinus: false)
        textFieldGram.addTarget(self, action: #selector(calulation_Gram(_:)), for: UIControl.Event.editingChanged)
        
        textFieldOnces.delegate = self
        textFieldOnces.setAsMyAmazingCustomKeyboard(doYouNeedMinus: false)
        textFieldOnces.addTarget(self, action: #selector(calulation_Once(_:)), for: UIControl.Event.editingChanged)
        
        textFieldPounds.delegate = self
        textFieldPounds.setAsMyAmazingCustomKeyboard(doYouNeedMinus: false)
         textFieldPounds.addTarget(self, action: #selector(calulation_Pounds(_:)), for: UIControl.Event.editingChanged)
        
        textFieldStonePound.delegate = self
        textFieldStonePound.setAsMyAmazingCustomKeyboard(doYouNeedMinus: false)
        textFieldStonePound.addTarget(self, action: #selector(calulation_Stone(_:)), for: UIControl.Event.editingChanged)
        
 
 

    }
    

    // ---------- KEYBOARD MANAGEMENT + OBSERVERS ----------- //
    
    
    // observer for the keyboard
    override func viewWillAppear(_ animated: Bool) {
        let notificationCenter = NotificationCenter.default

        // observer for the custom Keyboard tabbar + scroll view
        notificationCenter.addObserver(self, selector: #selector(self.keyboardShowNotificationManagement2), name: UIApplication.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(self.keyboardHideNotificationManagement2), name: UIApplication.keyboardWillHideNotification, object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.view.endEditing(true)
        
        NotificationCenter.default.removeObserver(self, name: UIApplication.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.keyboardWillHideNotification, object: nil)

    }
    
    deinit {
        
    }
 
    
    // managing the begin of the editing in a textfield -->
    // change color of background , border and set it as the activeTextfield to manage the scrollView event
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        textField.backgroundColor = UIColor.clear
        textField.layer.backgroundColor = UIColor(rgb: 0x5E97F2, alphaVal: 0.1).cgColor
        textField.layer.borderColor = UIColor(rgb: 0xCC3333, alphaVal: 0.9).cgColor
        
        
        activeField = textField
        if(keyboardHeight != nil){
            self.scrollTheView(scrollView: self.scrollView, textField: activeField!, keyboardHeigh: keyboardHeight, naturalOffset: self.scrollViewNaturalOffset)
        }
        
        // color ench
        
        
        return true
    }
    
    // reset 
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeField = nil
        
        // color goodbye
        textField.backgroundColor = UIColor.clear
        
        textField.layer.borderColor = UIColor(rgb: 0x336699, alphaVal: 0.9).cgColor
        
    }
    
    

    
    
   


}

