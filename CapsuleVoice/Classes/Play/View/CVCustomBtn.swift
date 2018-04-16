//
//  CVCustomBtn.swift
//  CapsuleVoice
//
//  Created by 5i84 on 2017/6/9.
//  Copyright © 2017年 LiJingZe. All rights reserved.
//

import UIKit

class CVCustomBtn: UIButton {

    var aboveImageView = UIImageView()
    var bottomLabel = UILabel()

    init() {
        super.init(frame: CGRect.zero)
        self.addSubview(aboveImageView)
        aboveImageView.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.width.height.equalTo(25)
        }

        bottomLabel.textColor = MainColor
        bottomLabel.textAlignment = .left
        bottomLabel.backgroundColor = .groupTableViewBackground
        bottomLabel.font = UIFont.systemFont(ofSize:8)
        aboveImageView.addSubview(bottomLabel)
        bottomLabel.snp.makeConstraints { (make) in
            make.top.equalTo(aboveImageView.snp.top)
            make.centerX.equalTo(aboveImageView.snp.right).offset(-3)
            make.height.equalTo(9)
        }
        
    }

    func configBtn(image:UIImage, title:String?)  {
        aboveImageView.image = image
        if title == nil || title == "" {
            bottomLabel.isHidden = true
        }else{
            bottomLabel.text = " 9" //title
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

