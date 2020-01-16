//
//  LiquidsConverterViewController.swift
//  UnityConverterApp
//
//  Created by Tiziano on 03/03/2019.
//  Copyright © 2019 Tiziano Bissola. All rights reserved.
//

import UIKit

class LiquidsConverterViewController: UIViewController, UITextFieldDelegate {

    
    
    @IBOutlet weak var textField_Litres: UITextField!
    @IBOutlet weak var textField_Gallons: UITextField!
    
    @IBOutlet weak var textField_Pints: UITextField!
    @IBOutlet weak var textField_Ounces: UITextField!
    
    @IBOutlet weak var textField_Milliliters: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    // MANAGING THE SCROL VIEW //
    var scrollViewNaturalOffset : CGPoint!
    var activeField: UITextField?
    var keyboardHeight: CGFloat!        // used to verify if the view has been already scrolled
    var uiallertcontrolCalled: Bool = false // manage the tab bar when a UIAlertController is called
    
    @IBOutlet weak var navBarImageConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadCustomKeyboard()
        scrollViewNaturalOffset = self.scrollView.contentOffset     // initialize the position of scrollView
        
        navBarImageConstraint.constant = clearAndsetHeaderSize()    // inizialize the navigation bar
    
    }
    
    
    
    @IBAction func button_Save(_ sender: UIBarButtonItem) {
        
        if let textField_Litres_inserted = Double(textField_Litres.text!)
        {
            let conversion : LiquidConversion = LiquidConversionImplementation()
            
            // FORCE DOWNCAST !
            let result = conversion.conversionForSaving(inputValue: textField_Litres_inserted) as! LiquidMeasure
            
            let newHistoryElement : [String] = [result.litre, result.millilitre, result.fluid_ounce, result.gallon, result.pint_uk]
            
            // calling the saving function.
            let history : HistoryManagement = HistoryManagementImplementation()
            let historysaved = history.savingItemsStringv2(elements: newHistoryElement, type: Constants.Conversion.liquid_volumes)
            
            uiallertcontrolCalled = true

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
    // LOAD CUSTOM KEYBOARD FUNCTION + add target //
    // ---------------------------------- //
    
    func loadCustomKeyboard(){
        textField_Litres.delegate = self
        textField_Litres.setAsMyAmazingCustomKeyboard(doYouNeedMinus: false)
        textField_Litres.addTarget(self, action: #selector(calculation_textField_Litres(_:)), for: UIControl.Event.editingChanged)
        
        textField_Gallons.delegate = self
        textField_Gallons.setAsMyAmazingCustomKeyboard(doYouNeedMinus: false)
        textField_Gallons.addTarget(self, action: #selector(calculation_textField_Gallons(_:)), for: UIControl.Event.editingChanged)
        
        textField_Pints.delegate = self
        textField_Pints.setAsMyAmazingCustomKeyboard(doYouNeedMinus: false)
        textField_Pints.addTarget(self, action: #selector(calculation_textField_Pints(_:)), for: UIControl.Event.editingChanged)
        
        textField_Milliliters.delegate = self
        textField_Milliliters.setAsMyAmazingCustomKeyboard(doYouNeedMinus: false)
        textField_Milliliters.addTarget(self, action: #selector(calculation_textField_Milliliters(_:)), for: UIControl.Event.editingChanged)
        
        textField_Ounces.delegate = self
        textField_Ounces.setAsMyAmazingCustomKeyboard(doYouNeedMinus: false)
        textField_Ounces.addTarget(self, action: #selector(calculation_textField_Ounces(_:)), for: UIControl.Event.editingChanged)

 

    }
    
    
    // ---------------------------------- //
    // FUNCTION TO MANAGE THE EDITING-CHANGED //
    // ---------------------------------- //
    
    @objc func calculation_textField_Litres(_ textField: UITextField){

        let conversion : LiquidConversion = LiquidConversionImplementation()
        
        let conversion_values = conversion.conversionForEditingLiquid(value: textField.text!, inputValueType: UnitVolume.liters.symbol)
        
        self.textField_Pints.text = conversion_values.pint_uk
    //    self.textField_Litres.text = conversion_values.litre
        self.textField_Ounces.text = conversion_values.fluid_ounce
        self.textField_Gallons.text = conversion_values.gallon
        self.textField_Milliliters.text = conversion_values.millilitre
    }
    
    
    @objc func calculation_textField_Gallons(_ textField: UITextField){
        
        let conversion : LiquidConversion = LiquidConversionImplementation()
        
        let conversion_values = conversion.conversionForEditingLiquid(value: textField.text!, inputValueType: UnitVolume.gallons.symbol)
        
        self.textField_Pints.text = conversion_values.pint_uk
        self.textField_Litres.text = conversion_values.litre
        self.textField_Ounces.text = conversion_values.fluid_ounce
     //   self.textField_Gallons.text = conversion_values.gallon
        self.textField_Milliliters.text = conversion_values.millilitre
    }
    
    @objc func calculation_textField_Pints(_ textField: UITextField){
        
        let conversion : LiquidConversion = LiquidConversionImplementation()
        
        let conversion_values = conversion.conversionForEditingLiquid(value: textField.text!, inputValueType: UnitVolume.pints.symbol)
        
  //      self.textField_Pints.text = conversion_values.pint_uk
        self.textField_Litres.text = conversion_values.litre
        self.textField_Ounces.text = conversion_values.fluid_ounce
        self.textField_Gallons.text = conversion_values.gallon
        self.textField_Milliliters.text = conversion_values.millilitre
    }
    
    @objc func calculation_textField_Milliliters(_ textField: UITextField){
        
        let conversion : LiquidConversion = LiquidConversionImplementation()
        
        let conversion_values = conversion.conversionForEditingLiquid(value: textField.text!, inputValueType: UnitVolume.milliliters.symbol)
        
        self.textField_Pints.text = conversion_values.pint_uk
        self.textField_Litres.text = conversion_values.litre
        self.textField_Ounces.text = conversion_values.fluid_ounce
        self.textField_Gallons.text = conversion_values.gallon
//        self.textField_Milliliters.text = conversion_values.millilitre
    }
    
    @objc func calculation_textField_Ounces(_ textField: UITextField){
        
        let conversion : LiquidConversion = LiquidConversionImplementation()
        
        let conversion_values = conversion.conversionForEditingLiquid(value: textField.text!, inputValueType: UnitVolume.fluidOunces.symbol)
        
        self.textField_Pints.text = conversion_values.pint_uk
        self.textField_Litres.text = conversion_values.litre
 //       self.textField_Ounces.text = conversion_values.fluid_ounce
        self.textField_Gallons.text = conversion_values.gallon
        self.textField_Milliliters.text = conversion_values.millilitre
    }
    

    
    
    
    // ---------- KEYBOARD MANAGEMENT + OBSERVERS ----------- //
    
    // error right now cuz it doens't identify if the keyboard is displayed
    override func viewWillAppear(_ animated: Bool) {
        let notificationCenter = NotificationCenter.default

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
    
    // ----- scroll view management ----- ///
    // HELPER METHODS ON EXTENSIONSMANAGESCROLLVIEW AND SCROLVIEWMANAGEMENT EXTENSION ON CUSTOMKEYBOARD
    
    // these function of UITextField delegate can not be placed in another class without unwrap! the argument and brake the definition of the function ??
    
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
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeField = nil
        
        // color goodbye
        textField.backgroundColor = UIColor.clear
        
        textField.layer.borderColor = UIColor(rgb: 0x336699, alphaVal: 0.9).cgColor
        
    }
}


    


