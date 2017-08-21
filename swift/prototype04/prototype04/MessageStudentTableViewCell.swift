//
//  MessageStudentTableViewCell.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/08/18.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class MessageStudentTableViewCell: UITableViewCell {

    
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageButton: UIButton!
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageButton.layer.masksToBounds = true
        imageButton.layer.cornerRadius = imageButton.frame.width/2
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
