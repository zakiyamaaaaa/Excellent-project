//
//  TagButton.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/07/28.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class tagButton: UIButton {

    var enableFlag:Bool = true
    
    init(frame: CGRect,inText:String) {
        super.init(frame: .zero)
        
        self.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.setTitle(inText, for: .normal)
        self.titleLabel?.textAlignment = NSTextAlignment.center
        self.setTitleColor(UIColor.black, for: .normal)
        
        
        sizeToFit()
        
        self.frame.size = CGSize(width: self.frame.width + 10, height: self.frame.height + 4)
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.backgroundColor = UIColor.white
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
