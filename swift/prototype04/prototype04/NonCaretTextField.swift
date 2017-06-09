//
//  NonCaretTextField.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/05/17.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class NonCaretTextField: UITextField {

    
    override func caretRect(for position: UITextPosition) -> CGRect {
        return .zero
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
