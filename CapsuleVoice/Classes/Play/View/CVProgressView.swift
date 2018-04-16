//
//  CVProgressView.swift
//  CapsuleVoice
//
//  Created by 5i84 on 2017/5/24.
//  Copyright © 2017年 LiJingZe. All rights reserved.
//

import UIKit

class CVProgressView: UIView {

    let bgView = UIView()
    let startLabel = UILabel()
    let allTimeLabel = UILabel()
    let proView = UIProgressView()
    
    init() {
        super.init(frame: CGRect.zero)
        //背景容器
        addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(12)
        }
        
        //开始时间
        startLabel.textAlignment = .center
        startLabel.textColor = .white
        startLabel.font = UIFont.systemFont(ofSize: 8)
        bgView.addSubview(startLabel)
        startLabel.snp.makeConstraints { (make) in
            make.left.centerY.equalTo(bgView)
            make.width.equalTo(30)
        }
        
        //总时间
        allTimeLabel.textAlignment = .center
        allTimeLabel.textColor = .white
        allTimeLabel.font = UIFont.systemFont(ofSize: 8)
        bgView.addSubview(allTimeLabel)
        allTimeLabel.snp.makeConstraints { (make) in
            make.right.centerY.equalTo(bgView)
            make.width.equalTo(30)
        }
        
        // 进度条
        proView.progressViewStyle = UIProgressViewStyle.default
        proView.progressTintColor = MainColor
        proView.trackTintColor = .clear
        bgView.addSubview(proView)
        proView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(bgView)
        }
    }
    
       
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
