//
//  CVFollowTableViewCell.swift
//  CapsuleVoice
//
//  Created by 5i84 on 2017/6/13.
//  Copyright © 2017年 LiJingZe. All rights reserved.
//

import UIKit

class CVFollowTableViewCell: UITableViewCell {
    @IBOutlet var userHeadImage: UIImageView!
    @IBOutlet var userName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //画一个部分圆角的矩形 rect: 需要画的矩形的Frame corners: 哪些部位需要画成圆角 cornerRadii: 圆角的Size
        let maskPath = UIBezierPath(roundedRect: userHeadImage.bounds, byRoundingCorners: .allCorners, cornerRadii: userHeadImage.bounds.size)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = userHeadImage.bounds
        maskLayer.path = maskPath.cgPath
        userHeadImage.layer.mask = maskLayer

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
