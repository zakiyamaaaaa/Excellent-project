//
//  UITestFieldBtmBorder.swift
//  prototype02
//
//  Created by shoichiyamazaki on 2017/04/26.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class UITextFieldBtmBorder: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        let bottomBorder = CALayer()
        bottomBorder.borderColor = UIColor.gray.cgColor
        bottomBorder.borderWidth = 2
        self.layer.addSublayer(bottomBorder)
        bottomBorder.frame = CGRect(x: 0, y: self.frame.height - 2, width: self.frame.width, height: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
