//
//  RotationableView.swift
//  cardDesignPrototype
//
//  Created by shoichiyamazaki on 2017/06/20.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

@IBDesignable
class RotationableView: UIView {

    @IBInspectable var rotationAngle: CGFloat = 0 {
        didSet {
            transform = transform.rotated(by: rotationAngle)
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
