//
//  SecondViewController.swift
//  UnityConverterApp
//
//  Created by Tiziano on 03/03/2019.
//  Copyright © 2019 Tiziano Bissola. All rights reserved.
//

import UIKit

class TemperatureConverterViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField_celsius: UITextField!
    @IBOutlet weak var textField_Fahrenheit: UITextField!
    @IBOutlet weak var textField_Kelvin: UITextField!
    
    
    // MANAGING THE SCROL VIEW //
    @IBOutlet weak var scrollView: UIScrollView!
    var scrollViewNaturalOffset : CGPoint!
    var activeField: UITextField?
    var keyboardHeight: CGFloat!        // used to verify if the view has been already scrolled
      var uiallertcontrolCalled: Bool = false // manage the tab bar when a UIAlertController is called
    
    @IBOutlet weak var navBarImageConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadCustomKeyboard()
        scrollViewNaturalOffset = self.scrollView.contentOffset     // initialize the position of scrollView

        navBarImageConstraint.constant = clearAndsetHeaderSize()
        
    }
    
    @IBAction func button_Save(_ sender: UIBarButtonItem) {
        
        if let celsiusInserted = Double(textField_celsius.text!){
            
            let conversion : TemperatureConversion = TemperatureConversionImplementation()
            
            // FORCE DOWNCAST !
            let result = conversion.conversionForSaving(inputValue: celsiusInserted) as! TemperatureMeasure
            
            let newHistoryElement : [String] = [result.cel, result.fara, result.kelvin]

            let history : HistoryManagement = HistoryManagementImplementation()
            let historysaved = history.savingItemsStringv2(elements: newHistoryElement, type: Constants.Conversion.temperature)
            
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
       // textField_celsius.delegate = CustomTextFieldDelegate.sharedInstance
        
        textField_celsius.delegate = self
        textField_celsius.setAsMyAmazingCustomKeyboard(doYouNeedMinus: true)
        textField_celsius.addTarget(self, action: #selector(calulation_Celsious(_:)), for: UIControl.Event.editingChanged)
        
        
        //textField_Fahrenheit.delegate = CustomTextFieldDelegate.sharedInstance
        textField_Fahrenheit.delegate = self
        textField_Fahrenheit.setAsMyAmazingCustomKeyboard(doYouNeedMinus: true)
        textField_Fahrenheit.addTarget(self, action: #selector(calulation_Fahrenheit(_:)), for: UIControl.Event.editingChanged)
        
        //textField_Kelvin.delegate = CustomTextFieldDelegate.sharedInstance
        
        textField_Kelvin.delegate = self
        textField_Kelvin.setAsMyAmazingCustomKeyboard(doYouNeedMinus: true)
        textField_Kelvin.addTarget(self, action: #selector(calulation_Kelvin(_:)), for: UIControl.Event.editingChanged)
    }
    
    
    // ---------------------------------- //
    // FUNCTION TO MANAGE THE EDITING-CHANGED //
    // ---------------------------------- //
    
    @objc func calulation_Celsious(_ textField: UITextField){
        print("TRIGGER \(textField.text!)")
        
        let conversion : TemperatureConversion = TemperatureConversionImplementation()
        
        let conversion_values = conversion.conversionForEditingTemperature(value: textField.text!, inputValueType: UnitTemperature.celsius.symbol)
        
        self.textField_Kelvin.text = conversion_values.kelvin
        self.textField_Fahrenheit.text = conversion_values.fara
        
        
        //self.conversionElementTemperatureForEdit(value: textField.text!, inputValueType: UnitTemperature.celsius.symbol)
    }
    
    @objc func calulation_Fahrenheit(_ textField: UITextField){
        print("TRIGGER \(textField.text!)")
        
        let conversion : TemperatureConversion = TemperatureConversionImplementation()
        
        let conversion_values = conversion.conversionForEditingTemperature(value: textField.text!, inputValueType: UnitTemperature.fahrenheit.symbol)
        
        self.textField_celsius.text = conversion_values.cel
        self.textField_Kelvin.text = conversion_values.kelvin
        //self.textField_Fahrenheit.text = conversion_values.fara
        
        
    }
    
    @objc func calulation_Kelvin(_ textField: UITextField){
        print("TRIGGER \(textField.text!)")
        let conversion : TemperatureConversion = TemperatureConversionImplementation()
        
        let conversion_values = conversion.conversionForEditingTemperature(value: textField.text!, inputValueType: UnitTemperature.kelvin.symbol)
        
        self.textField_celsius.text = conversion_values.cel
        //self.textField_Kelvin.text = conversion_values.kelvin
        self.textField_Fahrenheit.text = conversion_values.fara
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
        print("TEMP IS CLOSE. ADIOS")
        
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

