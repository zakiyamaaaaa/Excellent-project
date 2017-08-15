//
//  RectLabel.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/06/08.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

@IBDesignable
class RectLabel: UILabel {
    
    @IBInspectable var cornerRadius: CGFloat = 20{
        
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
//    @IBInspectable var cornerRadius:CGFloat = 20
    
    
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
    
    @IBInspectable var padding: UIEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
    
    override func drawText(in rect: CGRect) {
        let newRect = UIEdgeInsetsInsetRect(rect, padding)
        super.drawText(in: newRect)
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right
        return contentSize
    }
    
//    override func draw(_ rect: CGRect) {
//        self.layer.cornerRadius = cornerRadius
//    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
