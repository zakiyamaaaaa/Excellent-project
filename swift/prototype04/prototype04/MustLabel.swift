//
//  MustLabel.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/08/12.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

@IBDesignable
class MustLabel: UILabel {

    @IBInspectable var cornerRadius:CGFloat = 5
    
    
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
        self.text = "必須"
        self.font = UIFont.boldSystemFont(ofSize: 13)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
