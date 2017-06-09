//
//  RectButton.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/06/08.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

@IBDesignable
class RectButton: UIButton {

    @IBInspectable var textColor: UIColor?
    
    @IBInspectable var cornerRadius: CGFloat = 20 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
