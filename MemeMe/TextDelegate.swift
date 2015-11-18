//
//  TextDelegate.swift
//  MemeMe
//
//  Created by Guanqun Mao on 10/30/15.
//  Copyright © 2015 Guanqun Mao. All rights reserved.
//

import Foundation
import UIKit

class TextDelegate:NSObject,UITextFieldDelegate{
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}