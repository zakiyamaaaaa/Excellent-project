//
//  NearUserView.swift
//  MainViewWithFunction05
//
//  Created by shoichiyamazaki on 2017/04/24.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import Foundation
import UIKit

class NearUserView{
    var userInfoNameLabel:UILabel
    var myView:UIView
    var myImageView:UIImageView
    
    var numberOfPage:Int
    
    init(frame:CGRect,page:Int) {
        myView = UIView(frame: frame)
        myView.layer.borderWidth = 1
        myView.layer.shadowOffset = CGSize(width: 0, height: 0)
        myView.layer.masksToBounds = false
        myView.layer.shadowColor = UIColor.darkGray.cgColor
        myView.layer.cornerRadius = 10
        myView.layer.shadowOpacity = 0.8
        myView.backgroundColor = UIColor.white
        
        let userImageViewHeight = frame.height/4*3
        let userImageViewWidth = frame.width/10*9
        let userViewHeight = frame.height
        let userViewWidth = frame.width
        
        myImageView = UIImageView(frame: CGRect(x: (userViewWidth-userImageViewWidth)/2, y: 10, width: userImageViewWidth, height: userImageViewHeight))
        myImageView.layer.borderWidth = 1
        myImageView.layer.borderColor = UIColor.darkGray.cgColor
        
        myView.addSubview(myImageView)
        
        let userInfoLabelHeight = (userViewHeight - userImageViewHeight)/5
        let userInfoLabelWidth = userImageViewWidth
        
        let userInfoLabelFrame = CGRect(x: (userViewWidth-userImageViewWidth)/2, y: userImageViewHeight/17*18, width: userInfoLabelWidth, height: userInfoLabelHeight)
        userInfoNameLabel = UILabel(frame: userInfoLabelFrame)
        myView.addSubview(userInfoNameLabel)
        
        self.numberOfPage = page
    }
    
}
