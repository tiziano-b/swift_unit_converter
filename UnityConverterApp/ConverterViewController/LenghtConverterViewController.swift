//
//  LenghtConverterViewController.swift
//  UnityConverterApp
//
//  Created by Tiziano on 03/03/2019.
//  Copyright © 2019 Tiziano Bissola. All rights reserved.
//

import UIKit

class LenghtConverterViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField_meters: UITextField!
    @IBOutlet weak var textField_Miles: UITextField!
    @IBOutlet weak var textField_centimeters: UITextField!
    @IBOutlet weak var textField_milimeters: UITextField!
    @IBOutlet weak var textField_Yards: UITextField!
    @IBOutlet weak var textField_Inches: UITextField!
    
    
    @IBOutlet weak var navBarImageConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MANAGING THE SCROL VIEW //
    var scrollViewNaturalOffset : CGPoint!
    var activeField: UITextField?
    var keyboardHeight: CGFloat!        // used to verify if the view has been already scrolled
        var uiallertcontrolCalled: Bool = false // manage the tab bar when a UIAlertController is called
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadCustomKeyboard()
        scrollViewNaturalOffset = self.scrollView.contentOffset     // initialize the position of scrollView
        // Do any additional setup after loading the view.
        
        navBarImageConstraint.constant = clearAndsetHeaderSize()
    }
    

    @IBAction func button_Save(_ sender: UIBarButtonItem) {
        
        
        if let metersInserted = Double(textField_meters.text!){
          
            
            let conversion : LenghtConversion = LenghtConversionImplementation()
            
            // FORCE DOWNCAST !
            
            let result = conversion.conversionForSaving(inputValue: metersInserted) as! LenghtMeasure
            
            
            let newHistoryElement : [String] = [result.metre, result.cm, result.mm, result.inch,  result.mile, result.yard]

            
            // calling the saving function.
            let history : HistoryManagement = HistoryManagementImplementation()
            let historysaved = history.savingItemsStringv2(elements: newHistoryElement, type: Constants.Conversion.lenght)
        
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
        textField_meters.delegate = self
        textField_meters.setAsMyAmazingCustomKeyboard(doYouNeedMinus: false)
        textField_meters.addTarget(self, action: #selector(calulation_Meters(_:)), for: UIControl.Event.editingChanged)
        
        textField_Miles.delegate = self
        textField_Miles.setAsMyAmazingCustomKeyboard(doYouNeedMinus: false)
        textField_Miles.addTarget(self, action: #selector(calulation_textField_Miles(_:)), for: UIControl.Event.editingChanged)
        
        textField_centimeters.delegate = self
        textField_centimeters.setAsMyAmazingCustomKeyboard(doYouNeedMinus: false)
        textField_centimeters.addTarget(self, action: #selector(calulation_textField_centimeters(_:)), for: UIControl.Event.editingChanged)
        
        textField_milimeters.delegate = self
        textField_milimeters.setAsMyAmazingCustomKeyboard(doYouNeedMinus: false)
        textField_milimeters.addTarget(self, action: #selector(calulation_textField_milimeters(_:)), for: UIControl.Event.editingChanged)
        
        textField_Yards.delegate = self
        textField_Yards.setAsMyAmazingCustomKeyboard(doYouNeedMinus: false)
        textField_Yards.addTarget(self, action: #selector(calulation_textField_Yards(_:)), for: UIControl.Event.editingChanged)
        
        textField_Inches.delegate = self
        textField_Inches.setAsMyAmazingCustomKeyboard(doYouNeedMinus: false)
        textField_Inches.addTarget(self, action: #selector(calulation_textField_Inches(_:)), for: UIControl.Event.editingChanged)
        
        

    }
    
    
    // ---------------------------------- //
    // FUNCTION TO MANAGE THE EDITING-CHANGED //
    // ---------------------------------- //
    
    @objc func calulation_Meters(_ textField: UITextField){

        let conversion : LenghtConversion = LenghtConversionImplementation()
        
        let conversion_values = conversion.conversionForEditingLenght(value: textField.text!, inputValueType: UnitLength.meters.symbol)
        
        self.textField_Miles.text = conversion_values.mile
        self.textField_Yards.text = conversion_values.yard
        self.textField_Inches.text = conversion_values.inch
       // self.textField_meters.text = conversion_values.metre
        self.textField_milimeters.text = conversion_values.mm
        self.textField_centimeters.text = conversion_values.cm
        
    }
    @objc func calulation_textField_Miles(_ textField: UITextField){
        
        let conversion : LenghtConversion = LenghtConversionImplementation()
        
        let conversion_values = conversion.conversionForEditingLenght(value: textField.text!, inputValueType: UnitLength.betterImplementationMiles.symbol)
        
        //self.textField_Miles.text = conversion_values.mile
        self.textField_Yards.text = conversion_values.yard
        self.textField_Inches.text = conversion_values.inch
        self.textField_meters.text = conversion_values.metre
        self.textField_milimeters.text = conversion_values.mm
        self.textField_centimeters.text = conversion_values.cm
    }
    @objc func calulation_textField_centimeters(_ textField: UITextField){
        
        let conversion : LenghtConversion = LenghtConversionImplementation()
        
        let conversion_values = conversion.conversionForEditingLenght(value: textField.text!, inputValueType: UnitLength.centimeters.symbol)
        
        self.textField_Miles.text = conversion_values.mile
        self.textField_Yards.text = conversion_values.yard
        self.textField_Inches.text = conversion_values.inch
        self.textField_meters.text = conversion_values.metre
        self.textField_milimeters.text = conversion_values.mm
     //   self.textField_centimeters.text = conversion_values.cm
        
    }
    @objc func calulation_textField_milimeters(_ textField: UITextField){
        
        let conversion : LenghtConversion = LenghtConversionImplementation()
        
        let conversion_values = conversion.conversionForEditingLenght(value: textField.text!, inputValueType: UnitLength.millimeters.symbol)
        
        self.textField_Miles.text = conversion_values.mile
        self.textField_Yards.text = conversion_values.yard
        self.textField_Inches.text = conversion_values.inch
        self.textField_meters.text = conversion_values.metre
        //self.textField_milimeters.text = conversion_values.mm
        self.textField_centimeters.text = conversion_values.cm
    }
    @objc func calulation_textField_Yards(_ textField: UITextField){
        
        let conversion : LenghtConversion = LenghtConversionImplementation()
        
        let conversion_values = conversion.conversionForEditingLenght(value: textField.text!, inputValueType: UnitLength.yards.symbol)
        
        self.textField_Miles.text = conversion_values.mile
    //    self.textField_Yards.text = conversion_values.yard
        self.textField_Inches.text = conversion_values.inch
        self.textField_meters.text = conversion_values.metre
        self.textField_milimeters.text = conversion_values.mm
        self.textField_centimeters.text = conversion_values.cm
    }
    @objc func calulation_textField_Inches(_ textField: UITextField){
        
        let conversion : LenghtConversion = LenghtConversionImplementation()
        
        let conversion_values = conversion.conversionForEditingLenght(value: textField.text!, inputValueType: UnitLength.inches.symbol)
        
        self.textField_Miles.text = conversion_values.mile
        self.textField_Yards.text = conversion_values.yard
     //   self.textField_Inches.text = conversion_values.inch
        self.textField_meters.text = conversion_values.metre
        self.textField_milimeters.text = conversion_values.mm
        self.textField_centimeters.text = conversion_values.cm
    }
    

    
    
    // ---------- KEYBOARD MANAGEMENT + OBSERVERS ----------- //
    
    // error right now cuz it doens't identify if the keyboard is displayed
    
    // observer for the keyboard
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
