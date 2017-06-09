//
//  TransitionButton.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/06/07.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class TransitionButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    */
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        self.layer.masksToBounds = true
//        self.layer.cornerRadius = 20
//        self.layer.borderWidth = 1
//        self.frame.size = CGSize(width: 111, height: 47)
//        self.backgroundColor = UIColor.white
//        
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
////        fatalError("init(coder:) has not been implemented")
//        super.init(coder: aDecoder)
//        self.layer.masksToBounds = true
//        self.layer.cornerRadius = 20
//        self.layer.borderWidth = 1
//        self.frame.size = CGSize(width: 111, height: 47)
//        self.backgroundColor = UIColor.white
//    }

    override func draw(_ rect: CGRect) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 1
        self.frame.size = CGSize(width: 111, height: 47)
        self.backgroundColor = UIColor.white
        
    }
}
