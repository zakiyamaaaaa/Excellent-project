//
//  UserCard.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/05/09.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit
import Foundation

class UserCard: UIView {
    
    var numberOfOage:Int = 0
    
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        self.layer.masksToBounds = false
        self.layer.borderWidth = 5
        self.layer.borderColor = UIColor.gray.cgColor
//        self.layer.cornerRadius = 10
        
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.layer.shadowRadius = 10
        
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
