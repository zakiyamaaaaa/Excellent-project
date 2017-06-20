//
//  flagButton.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/05/16.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class flagButton: UIButton {
    
    var flag = false
    var type:jobTagType = jobTagType.industry
    var borderColor:UIColor = UIColor()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    init(frame: CGRect,title:String,Tagtype:jobTagType) {
        super.init(frame: frame)
        self.setTitle(title, for: .normal)
        self.setTitleColor(UIColor.black, for: .normal)
        self.titleLabel?.font = UIFont(name: "HiraginoSans-W3", size: 12)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
        self.backgroundColor = UIColor.white
        type = Tagtype
        
        switch Tagtype {
        case .industry:
            borderColor = UIColor.rgbColor(0x2A82E6)
            
        case .occupation:
            borderColor = UIColor.rgbColor(0x6EBF1D)
            
        }
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = 2
//        self.backgroundColor = borderColor
        self.sizeToFit()
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
