//
//  MessageTableViewCellDemo.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/06/28.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class MessageTableViewCellDemo: UITableViewCell {

    @IBOutlet weak var labelImageView: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var companyImageView: UIImageView!
    @IBOutlet weak var mealImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var AgeLabel: UILabel!
    @IBOutlet weak var userJobLabel: UILabel!
    @IBOutlet weak var YeartoWorkLabel: UILabel!
    @IBOutlet weak var dateToMatch: UILabel!
    
    @IBOutlet weak var ogoriView: UIView!
    @IBOutlet weak var userImageButton: UIButton!
    @IBOutlet weak var companyNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        userImageButton.layer.masksToBounds = true
        userImageButton.layer.cornerRadius = userImageButton.frame.width/2
        companyImageView.layer.borderWidth = 1
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
