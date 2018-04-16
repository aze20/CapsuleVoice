//
//  CVPersonalDataTableViewCell.swift
//  CapsuleVoice
//
//  Created by 5i84 on 2017/6/13.
//  Copyright © 2017年 LiJingZe. All rights reserved.
//

import UIKit

class CVPersonalDataTableViewCell: UITableViewCell {

    @IBOutlet var label: UILabel!
    @IBOutlet var userImage: UIImageView!
    
    @IBOutlet var tipLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
