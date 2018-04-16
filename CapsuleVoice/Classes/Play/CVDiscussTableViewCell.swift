//
//  CVDiscussTableViewCell.swift
//  CapsuleVoice
//
//  Created by 5i84 on 2017/6/8.
//  Copyright © 2017年 LiJingZe. All rights reserved.
//

import UIKit
//传值代理
protocol SecondVCDelegate{
    
    func passOnInformation(sender:UIButton)
}

class CVDiscussTableViewCell: UITableViewCell {

    @IBOutlet var headImage: UIButton!
    @IBOutlet var userName: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var goodBtn: UIButton!
    @IBOutlet var contentLabel: UILabel!
    var title1 : String = ""

    //    在SecondVC的代理声明为SVC的属性
    var delegate:SecondVCDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // 头像圆角
        headImage.layer.cornerRadius = 35/2
        //画一个部分圆角的矩形 rect: 需要画的矩形的Frame corners: 哪些部位需要画成圆角 cornerRadii: 圆角的Size
        let maskPath = UIBezierPath(roundedRect: headImage.bounds, byRoundingCorners: .allCorners, cornerRadii: headImage.bounds.size)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = headImage.bounds
        maskLayer.path = maskPath.cgPath
        headImage.layer.mask = maskLayer
        headImage.adjustsImageWhenHighlighted = false
    }

    //用户头像
    @IBAction func btnClick(_ sender: UIButton) {
        //判断代理是否为空
        if (self.delegate != nil) {
            //传值
            delegate?.passOnInformation(sender: sender)
        }
        if sender.tag == 1 {
            sender.isSelected = !sender.isSelected
            //如果为空就说明未点赞 设置初始值未0
            if sender.titleLabel?.text == nil {
                title1 = "0"
            }else{
                title1 = (sender.titleLabel?.text)!
            }
            
            if sender.isSelected == true {
                sender.setImage(UIImage(named:"已赞"), for: .normal)
                sender.setTitleColor(MainColor, for: .normal)
                title1 = String(Int(title1)!+1)
                sender.setTitle(title1, for: .normal)
            }else{
                sender.setImage(UIImage(named:"未赞"), for: .normal)
                sender.setTitleColor(UIColor.lightGray, for: .normal)
                title1 = String(Int(title1)!-1)
                //如果为0 则隐藏title
                if title1 == "0" {
                    sender.setTitle("", for: .normal)
                    sender.titleLabel?.text = nil
                }else{
                    sender.setTitle(title1, for: .normal)
                }
                
            }
            
        }
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
