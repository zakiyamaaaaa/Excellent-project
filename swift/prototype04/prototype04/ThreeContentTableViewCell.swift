//
//  ThreeContentTableViewCell.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/07/31.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class ThreeContentTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel1: UILabel!
    @IBOutlet weak var titleLabel2: UILabel!
    @IBOutlet weak var titleLabel3: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
