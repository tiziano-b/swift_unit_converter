//
//  CustomKeyboardViewController.swift
//  UnityConverterApp
//
//  Created by Tiziano on 03/03/2019.
//  Copyright © 2019 Tiziano Bissola. All rights reserved.
//

import UIKit


// the preferred way to declare a class-only protocol is to use AnyObject rather than class
protocol KeyboardDelegate: AnyObject {
    func keyWasTapped (character : String)
}


/*
 Controller for the custom Keyboard.
 it inherits from UIView class
 it use the delegate keyWasTapped when the button is pressed by the user
 it has 2 more function to handle the touchup and touchdown color change of the keyboard
 
 */

class CustomKeyboardViewController: UIView {
    var sizeScreenPhone : Int?
    weak var delegate: KeyboardDelegate?
    var doYouNeedMinus:Bool = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }
    
    // this init is the one used on the project to initialize the keyboard.
    init(frame: CGRect, sizeScreen: Int, minus:Bool) {
        super.init(frame: frame)
        self.sizeScreenPhone = sizeScreen
        self.doYouNeedMinus = minus
        initializeSubviews()
    }
    
    
    func initializeSubviews(){
        var xibFileName: String
        
        // the 2 custom keyboard designed... depending if the conversion needs the minus or not
        if(doYouNeedMinus == true){
            xibFileName = "ViewKeyboardCustom"
        }
        else{
            xibFileName = "ViewKeyboardCustomNoMinus"
        }
        // -------------------------------------------
        
        
        let view = Bundle.main.loadNibNamed(xibFileName, owner: self, options: nil)?[0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
    }
    
    
    @IBAction func touchUP(_ sender: UIButton) {

            sender.backgroundColor = UIColor.white
    }
    
    @IBAction func touchDOWN(_ sender: UIButton) {
        
            let color = UIColor.init(rgb: 0xd0d7e2, alphaVal: 0.8)
            sender.backgroundColor = color
    }
    @IBAction func buttonTouched(_ sender: UIButton) {
        
        
        // manage if you don't have anyhting on the KEY
        if let keypressed = sender.titleLabel?.text{
            self.delegate?.keyWasTapped(character: keypressed)

        }
        
      //  self.delegate?.keyWasTapped(character: (sender.titleLabel?.text)!)
    }

}
