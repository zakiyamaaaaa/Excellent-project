//
//  MaskView.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/06/01.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class MaskView: UIView {

    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView:UIView? = super.hitTest(point, with: event)
        if(self == hitView)
        {
            return nil
        }
        return hitView
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
