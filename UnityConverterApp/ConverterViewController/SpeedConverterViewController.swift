//
//  SpeedConverterViewController.swift
//  UnityConverterApp
//
//  Created by Tiziano on 03/03/2019.
//  Copyright © 2019 Tiziano Bissola. All rights reserved.
//

import UIKit

class SpeedConverterViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField_meters_Sec: UITextField!
    @IBOutlet weak var textField_Km_Hour: UITextField!
    @IBOutlet weak var textField_Miles_Hours: UITextField!
    @IBOutlet weak var textField_NauticalMiles_hours: UITextField!
    
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

        // Do any additional setup after loading the view.
        
        navBarImageConstraint.constant = clearAndsetHeaderSize()
    }
    
    @IBAction func button_Save(_ sender: UIBarButtonItem) {
        
        if let textField_meters_SecInserted = Double(textField_meters_Sec.text!){
            
            let conversion : SpeedConversion = SpeedConversionImplementation()
            
            // FORCE DOWNCAST !
            let result = conversion.conversionForSaving(inputValue: textField_meters_SecInserted) as! SpeedMeasure
            
            let newHistoryElement : [String] = [result.metres_sec, result.km_h, result.miles_h, result.nauticalMiles_h]
            
            let history : HistoryManagement = HistoryManagementImplementation()
            let historysaved = history.savingItemsStringv2(elements: newHistoryElement, type: Constants.Conversion.speed)
            
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
        textField_meters_Sec.delegate = self
        textField_meters_Sec.setAsMyAmazingCustomKeyboard(doYouNeedMinus: false)
        textField_meters_Sec.addTarget(self, action: #selector(calulation_textField_meters_Sec(_:)), for: UIControl.Event.editingChanged)
        
        textField_Km_Hour.delegate = self
        textField_Km_Hour.setAsMyAmazingCustomKeyboard(doYouNeedMinus: false)
        textField_Km_Hour.addTarget(self, action: #selector(calulation_textField_Km_Hour(_:)), for: UIControl.Event.editingChanged)
        
        textField_Miles_Hours.delegate = self
        textField_Miles_Hours.setAsMyAmazingCustomKeyboard(doYouNeedMinus: false)
        textField_Miles_Hours.addTarget(self, action: #selector(calculation_textField_Miles_Hours(_:)), for: UIControl.Event.editingChanged)
        
        textField_NauticalMiles_hours.delegate = self
        textField_NauticalMiles_hours.setAsMyAmazingCustomKeyboard(doYouNeedMinus: false)
        textField_NauticalMiles_hours.addTarget(self, action: #selector(calculation_textField_NauticalMiles_hours(_:)), for: UIControl.Event.editingChanged)
        

    }
    
    
    // ---------------------------------- //
    // FUNCTION TO MANAGE THE EDITING-CHANGED //
    // ---------------------------------- //
    
    @objc func calulation_textField_meters_Sec(_ textField: UITextField){
        
        let conversion : SpeedConversion = SpeedConversionImplementation()
        
        let conversion_values = conversion.conversionForEditingSpeed(value: textField.text!, inputValueType: UnitSpeed.metersPerSecond.symbol)
        
        self.textField_Km_Hour.text = conversion_values.km_h
      //  self.textField_meters_Sec.text = conversion_values.metres_sec
        self.textField_Miles_Hours.text = conversion_values.miles_h
        self.textField_NauticalMiles_hours.text = conversion_values.nauticalMiles_h
        
        
//        self.conversionElementSpeedForEdit(value: textField.text!, inputValueType: UnitSpeed.metersPerSecond.symbol)
    }
    @objc func calulation_textField_Km_Hour(_ textField: UITextField){
        
        let conversion : SpeedConversion = SpeedConversionImplementation()
        
        let conversion_values = conversion.conversionForEditingSpeed(value: textField.text!, inputValueType: UnitSpeed.kilometersPerHour.symbol)
        
       // self.textField_Km_Hour.text = conversion_values.km_h
        self.textField_meters_Sec.text = conversion_values.metres_sec
        self.textField_Miles_Hours.text = conversion_values.miles_h
        self.textField_NauticalMiles_hours.text = conversion_values.nauticalMiles_h
    }
    @objc func calculation_textField_Miles_Hours(_ textField: UITextField){
        
        let conversion : SpeedConversion = SpeedConversionImplementation()
        
        let conversion_values = conversion.conversionForEditingSpeed(value: textField.text!, inputValueType: UnitSpeed.milesPerHour.symbol)
        
        self.textField_Km_Hour.text = conversion_values.km_h
        self.textField_meters_Sec.text = conversion_values.metres_sec
     //   self.textField_Miles_Hours.text = conversion_values.miles_h
        self.textField_NauticalMiles_hours.text = conversion_values.nauticalMiles_h
    }
    @objc func calculation_textField_NauticalMiles_hours(_ textField: UITextField){
        
        let conversion : SpeedConversion = SpeedConversionImplementation()
        
        let conversion_values = conversion.conversionForEditingSpeed(value: textField.text!, inputValueType: UnitSpeed.knots.symbol)
        
        self.textField_Km_Hour.text = conversion_values.km_h
        self.textField_meters_Sec.text = conversion_values.metres_sec
        self.textField_Miles_Hours.text = conversion_values.miles_h
    //    self.textField_NauticalMiles_hours.text = conversion_values.nauticalMiles_h
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
