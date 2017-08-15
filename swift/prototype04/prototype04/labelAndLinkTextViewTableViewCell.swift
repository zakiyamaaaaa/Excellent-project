//
//  labelAndLinkTextViewTableViewCell.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/07/31.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class labelAndLinkTextViewTableViewCell: UITableViewCell {

    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var linkTextView: ClickableTextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
