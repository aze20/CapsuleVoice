//
//  CVMainCollectionViewCell.swift
//  CapsuleVoice
//
//  Created by 5i84 on 2017/5/17.
//  Copyright © 2017年 LiJingZe. All rights reserved.
//

import UIKit

class CVMainCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet var typeLabel: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var titleH: NSLayoutConstraint!
    @IBOutlet weak var tiptitleH: NSLayoutConstraint!
    @IBOutlet weak var userHeadImg: UIImageView!
    @IBOutlet weak var bottomJBView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 3.5

        userHeadImg.layer.borderColor = UIColor.white.cgColor
        userHeadImg.layer.borderWidth = 1.5
        userHeadImg.layer.cornerRadius = 20
        //画一个部分圆角的矩形 rect: 需要画的矩形的Frame corners: 哪些部位需要画成圆角 cornerRadii: 圆角的Size
        let maskPath = UIBezierPath(roundedRect: userHeadImg.bounds, byRoundingCorners: .allCorners, cornerRadii: userHeadImg.size)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = userHeadImg.bounds
        maskLayer.path = maskPath.cgPath
        userHeadImg.layer.mask = maskLayer
        
        //添加渐变色
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.withHex(hexString: "000000", alpha: 0).cgColor,
                                UIColor.withHex(hexString: "000000", alpha: 0.6).cgColor];
        gradientLayer.frame = bottomJBView.bounds
        bottomJBView.layer.insertSublayer(gradientLayer, at: 1)

        if SCREEN_WIDTH < 375 { //ip4 5
            titleH.constant = 18
            tiptitleH.constant = 12
            userLabel.font = UIFont.systemFont(ofSize: 12)
            titleLabel.font = UIFont.systemFont(ofSize: 10)
            
        }else if SCREEN_WIDTH < 414 { //ip6
            titleH.constant = 20
            userLabel.font = UIFont.systemFont(ofSize: 13)
            titleLabel.font = UIFont.systemFont(ofSize: 11)
            
        }else { //plus
            
            
            
        }
        
    }


}
