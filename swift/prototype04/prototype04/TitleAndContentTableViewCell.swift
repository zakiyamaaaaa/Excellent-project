//
//  TitleAndContentTableViewCell.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/08/16.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class TitleAndContentTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var editButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
