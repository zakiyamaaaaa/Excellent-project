//
//  ProfileView.swift
//  prototype02
//
//  Created by shoichiyamazaki on 2017/04/25.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class ProfileView: UIScrollView , UIScrollViewDelegate{
    
    var myImageView:UIImageView!
    
    var mynameLabel:UILabel!
    var rankLabel:UILabel!
    var oneMessageLabel:UILabel!
    
    var facultyLabel:UILabel!
    var schoolLabel:UILabel!
    var schoolYearLabel:UILabel!
    var favoriteFoodLabel:UILabel!
    var unFavoriteFoodLabel:UILabel!
    
    
    var profileEditButton:UIButton?
    var screenHeight:CGFloat!
    var screenWidth:CGFloat!
    
    var animation:CABasicAnimation!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //Screen Setting -------------------------------------------------------------
        screenHeight = UIScreen.main.bounds.height
        screenWidth = UIScreen.main.bounds.width
        self.contentSize = CGSize(width: screenWidth, height: screenHeight/10*17)
        
        //Image Setting -------------------------------------------------------------
        let imgWidth:CGFloat = frame.maxX/4*3
        let imgHeight:CGFloat = frame.maxX/4*3
        myImageView = UIImageView(frame: CGRect(x: (frame.maxX - imgWidth)/2, y: 50, width: imgWidth, height: imgHeight))
        myImageView.layer.cornerRadius = imgWidth/2
        myImageView.layer.masksToBounds = true
        myImageView.image = UIImage(named: "myimg")
        myImageView.layer.borderWidth = 1
        self.addSubview(myImageView)
        
        let backViewRadius:CGFloat = imgWidth+20
        let backView = UIView(frame:CGRect(x: (frame.maxX - backViewRadius)/2, y: 40, width: backViewRadius, height: backViewRadius))
        backView.layer.cornerRadius = backViewRadius/2
        backView.layer.masksToBounds = true
        backView.layer.borderWidth = 1
        self.addSubview(backView)
        
        //Label Setting -------------------------------------------------------------
        let nameLabelY:CGFloat = 80+imgHeight
        let nameLabelHeight:CGFloat = 30
        
        mynameLabel = UILabelBtmBorder(frame: CGRect(x: (frame.maxX - imgWidth)/2, y: nameLabelY, width: imgWidth, height: nameLabelHeight))
        mynameLabel.textAlignment = NSTextAlignment.center
        mynameLabel.font = UIFont.systemFont(ofSize: 30)
        
        rankLabel = UILabel(frame: CGRect(x:0, y: nameLabelHeight, width: imgWidth, height: nameLabelHeight))
        rankLabel.text = "🥉"
        rankLabel.textAlignment = NSTextAlignment.center
        rankLabel.font = UIFont.systemFont(ofSize: nameLabelHeight)
        
        //Label :School,:Facluty,:Age,:Interesting,:One Message, Favorite food, Unfavorite food
        
        oneMessageLabel = UILabel(frame: CGRect(x:0, y: nameLabelHeight*2, width: imgWidth, height: nameLabelHeight*3))
        oneMessageLabel.backgroundColor = UIColor.darkGray
        
        rankLabel.addSubview(oneMessageLabel)
        mynameLabel.addSubview(rankLabel)
        self.addSubview(mynameLabel)
        
        
        let profileDetailWidth:CGFloat = frame.maxX/3*2
        //Label :School,:Facluty,:Years ,:Favorite food, :Unfavorite food
        schoolLabel = UILabelBtmBorder(frame: CGRect(x: (frame.maxX - profileDetailWidth)/2, y: UIScreen.main.bounds.height, width: profileDetailWidth, height: nameLabelHeight))
        facultyLabel = UILabelBtmBorder(frame: CGRect(x: 50, y: nameLabelHeight*3, width: profileDetailWidth - 100, height: nameLabelHeight))
        schoolYearLabel = UILabelBtmBorder(frame: CGRect(x: 0, y: nameLabelHeight*3, width: profileDetailWidth - 100, height: nameLabelHeight))
        favoriteFoodLabel = UILabelBtmBorder(frame: CGRect(x: -50, y: nameLabelHeight*3, width: profileDetailWidth, height: nameLabelHeight))
        unFavoriteFoodLabel = UILabelBtmBorder(frame: CGRect(x: 0, y: nameLabelHeight*3, width: profileDetailWidth, height: nameLabelHeight))
        
        
        profileEditButton = UIButton(frame: CGRect(x: self.frame.width - 100, y: screenHeight-225, width: 100, height: 100))
        profileEditButton!.backgroundColor = UIColor.green
        profileEditButton?.setTitle("Edit", for: UIControlState.normal)
        profileEditButton?.layer.cornerRadius = 50
        self.delegate = self
        
        schoolLabel.addSubview(facultyLabel)
        facultyLabel.addSubview(schoolYearLabel)
        schoolYearLabel.addSubview(favoriteFoodLabel)
        favoriteFoodLabel.addSubview(unFavoriteFoodLabel)
        self.addSubview(schoolLabel)
        self.addSubview(profileEditButton!)
        
        animation = CABasicAnimation(keyPath: "opacity")
        animation.duration = 1
        animation.fromValue = 0
        animation.toValue = 100
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        profileEditButton?.isHidden = true
        
        let a = scrollView.contentOffset
        profileEditButton?.layer.position.y = screenHeight - 225 + a.y + 50
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        profileEditButton?.isHidden = true
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        profileEditButton?.isHidden = false
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        profileEditButton?.layer.animation(forKey: "isHidden")
//        profileEditButton?.layer.add(animation, forKey: nil)
        profileEditButton?.isHidden = false
        
        
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
