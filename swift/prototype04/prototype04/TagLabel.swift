//
//  TagLabel.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/06/25.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class TagLabel: UILabel {

    init(frame: CGRect,inText:String) {
        super.init(frame: .zero)
        
        self.font = UIFont.systemFont(ofSize: 12)
        self.text = inText
        self.textAlignment = NSTextAlignment.center
        
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
