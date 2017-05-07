//
//  MessageTableViewCell.swift
//  MainViewWithFunction05
//
//  Created by shoichiyamazaki on 2017/04/24.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    var messageableUserImageView:UIImageView = UIImageView()
    var messageableUserNameLabel:UILabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
//        let tableCellWidth = self.frame.maxX
        
        messageableUserImageView = UIImageView(frame: CGRect(x: 15, y: 10, width: 50, height: 50))
        messageableUserImageView.layer.cornerRadius = 25
        messageableUserImageView.layer.masksToBounds = true
        
        messageableUserNameLabel = UILabel(frame: CGRect(x: 15, y: 60, width: 50, height: 20))
        
        messageableUserNameLabel.textAlignment = NSTextAlignment.center
        
        
        self.addSubview(messageableUserImageView)
        self.addSubview(messageableUserNameLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
