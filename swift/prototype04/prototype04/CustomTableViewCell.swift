//
//  CustomTableViewCell.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/05/10.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    var titleLabel:UILabel = UILabel()
    var myLabel:UILabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        titleLabel = UILabel(frame: CGRect(x: 10, y: 10, width: 120, height: 30))
        myLabel = UILabel(frame: CGRect(x: 150, y: 10, width: 220, height: 30))
//        titleLabel.backgroundColor = UIColor.blue
//        myLabel.backgroundColor = UIColor.gray
        titleLabel.font = UIFont.systemFont(ofSize: 15)
//        myLabel.font = UIFont.systemFont(ofSize: 17)
        myLabel.font = UIFont(name: "HiraginoSans-W3", size: 14)
        titleLabel.textAlignment = NSTextAlignment.left
        myLabel.textAlignment = NSTextAlignment.center
        
        titleLabel.textColor = UIColor.gray
        
//        myLabel.backgroundColor = UIColor.rgbColor(0x79B74A)
        myLabel.textColor = UIColor.black
        myLabel.layer.cornerRadius = 5
        myLabel.layer.masksToBounds = true
        myLabel.bounds.origin.x = UIScreen.main.bounds.width
        
        self.addSubview(titleLabel)
        self.addSubview(myLabel)
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
