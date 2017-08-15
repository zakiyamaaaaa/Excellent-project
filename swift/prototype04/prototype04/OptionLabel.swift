//
//  OptionLabel.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/08/15.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class OptionLabel: UILabel {

    @IBInspectable var cornerRadius:CGFloat = 0
    
    
    @IBInspectable var padding: UIEdgeInsets = UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 8)
    
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
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.cornerRadius = cornerRadius
        self.textColor = UIColor.black
        self.font = UIFont.systemFont(ofSize: 13)
        self.text = "任意"
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
