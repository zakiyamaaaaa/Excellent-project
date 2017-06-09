//
//  messageTableViewCell.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/05/24.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class messageTableViewCell: UITableViewCell {
    @IBOutlet weak var messageUserImageView: UIImageView!

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userCompayLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
