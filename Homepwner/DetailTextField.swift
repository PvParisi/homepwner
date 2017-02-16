//
//  DetailTextField.swift
//  Homepwner
//
//  Created by Piervincenzo Parisi on 16/02/17.
//  Copyright © 2017 Piervincenzo Parisi. All rights reserved.
//

import UIKit

class DetailTextField: UITextField {

    override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        
        borderStyle = .bezel
        
        return true
    }
    
    override func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
        
        borderStyle = .roundedRect
        
        return true
    }

}
