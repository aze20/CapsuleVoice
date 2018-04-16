//
//  CVMyCapsuleTableViewCell.swift
//  CapsuleVoice
//
//  Created by 5i84 on 2017/6/12.
//  Copyright © 2017年 LiJingZe. All rights reserved.
//

import UIKit

class CVMyCapsuleTableViewCell: UITableViewCell {

    @IBOutlet var dataLable: UILabel!
    @IBOutlet var bottomView: UIView!
    @IBOutlet var dotView: UIView!
    @IBOutlet var timesLabel: UILabel!
    @IBOutlet var tipLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Futura-CondensedExtraBold  Futura-CondensedMedium
        dataLable.font = UIFont(name: "Futura-CondensedMedium", size: 16)//设置字体,大小

        // 圆点
        dotView.layer.cornerRadius = 3.5
        dotView.layer.borderColor = UIColor.white.cgColor
        dotView.layer.borderWidth = 1
        
        bottomView.layer.cornerRadius = 5

        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
