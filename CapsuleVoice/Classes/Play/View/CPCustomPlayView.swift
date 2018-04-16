// 
// CPCustomPlayView.swift
// CPCustomPlayView
// 
// Created by 李京泽 on 16/10/20.
// Copyright © 2016年 李京泽. All rights reserved.
// 

import UIKit

class CPCustomPlayView: UIView {
    typealias clickAlertClosure = (_ index: Int) -> Void // 声明闭包，点击按钮传值
    // 把申明的闭包设置成属性
    var clickClosure: clickAlertClosure?
    // 为闭包设置调用函数
    func clickIndexClosure(_ closure:clickAlertClosure?){
        // 将函数指针赋值给myClosure闭包
        clickClosure = closure
    }
    
    // 控件内容
    let bgView = UIImageView()
    var playBtn = UIButton()            // 播放按钮
    var topImage = UIImageView()        // 顶部大图
    var headImage = UIImageView()       // 头像
    var userNameLabel = UILabel()       // 用户名
    var tipLabel = UILabel()            // 标题名称
    var coverImage = UIImageView()      // 封面图
    var recordImage = UIImageView()     // 黑色碟片背景
    let progressview = CVProgressView() // 进度条
    var progressTimes : Float = 0.0     // 进度条总时间
    
    private var cancelBtn = UIButton()      // 关闭按钮
    private let likeBtn = CVCustomBtn()     // 关注按钮
    private let discussBtn = CVCustomBtn()  // 播放按钮
    private let shareBtn = CVCustomBtn()    // 分享按钮


    init() {
        super.init(frame: CGRect.zero)
        // 背景容器
        bgView.isUserInteractionEnabled = true
        bgView.backgroundColor = UIColor.groupTableViewBackground
        bgView.layer.cornerRadius = 5
        bgView.layer.masksToBounds = true
        self.addSubview(bgView)
        bgView.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(self).multipliedBy(0.65)
            make.height.equalTo(self).multipliedBy(0.5)
            make.center.equalTo(self)
        }
        
        // topImage
        topImage.isUserInteractionEnabled = true
        bgView.addSubview(topImage)
        topImage.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(0)
            make.height.equalTo(topImage.snp.width).multipliedBy(1.15)
        }
        // 毛玻璃
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        topImage.addSubview(blurView)
        blurView.snp.makeConstraints { (make) in
            make.size.equalTo(topImage)
            make.center.equalTo(topImage)
        }
        
        // 关闭按钮
        cancelBtn.adjustsImageWhenHighlighted = false
        cancelBtn.setImage(UIImage(named:"guanbi"), for: .normal)
        cancelBtn.tag = 1
        cancelBtn.addTarget(self, action: #selector(clickBtnAction(_:)), for: .touchUpInside)
        topImage.addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(30)
            make.top.equalTo(topImage).offset(6)
            make.right.equalTo(topImage).offset(-6)
        }
        
        // 头像
        headImage.isUserInteractionEnabled = true
        headImage.layer.borderColor = UIColor.white.cgColor
        headImage.layer.borderWidth = 1.5
        headImage.layer.cornerRadius = 20
        headImage.layer.masksToBounds = true
        bgView.addSubview(headImage)
        headImage.snp.makeConstraints { (make) in
            make.width.height.equalTo(40)
            make.left.equalTo(topImage).offset(10)
            make.top.equalTo(topImage).offset(10)
        }
        
        // 用户名
        userNameLabel.textAlignment = .left
        userNameLabel.textColor = .white
        userNameLabel.font = UIFont.boldSystemFont(ofSize: 13)
        bgView.addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(headImage.snp.right).offset(5)
            make.right.equalTo(cancelBtn.snp.left).offset(15)
            make.top.equalTo(headImage.snp.top).offset(3)
            make.height.equalTo(20)
        }
        
        // tipLabel
        tipLabel.textAlignment = .left
        tipLabel.textColor = .white
        tipLabel.font = UIFont.systemFont(ofSize: 12)
        bgView.addSubview(tipLabel)
        tipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(userNameLabel)
            make.right.equalTo(bgView.snp.right).offset(-10)
            make.top.equalTo(userNameLabel.snp.bottom)
            make.height.equalTo(15)
        }
        
        // 碟片容器
        let btnBgView = UIView()
        bgView.addSubview(btnBgView)
        btnBgView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(tipLabel.snp.bottom)
            make.left.right.bottom.equalTo(topImage)
        }
        // 碟片
        recordImage.isUserInteractionEnabled = true
        recordImage.image = UIImage(named: "changpian")
        btnBgView.addSubview(recordImage)
        recordImage.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(btnBgView.snp.height).multipliedBy(0.85)
            make.height.equalTo(recordImage.snp.width).multipliedBy(1)
            make.center.equalTo(btnBgView)

        }
        
        coverImage.isUserInteractionEnabled = true
        recordImage.addSubview(coverImage)
        coverImage.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(recordImage.snp.height).multipliedBy(0.7)
            make.height.equalTo(coverImage.snp.width).multipliedBy(1)
            make.center.equalTo(btnBgView)

        }


        // 播放按钮
        playBtn.setImage(UIImage(named:"暂停white"), for: .normal)
        playBtn.adjustsImageWhenHighlighted = false
        playBtn.tag = 2
        playBtn.addTarget(self, action: #selector(clickBtnAction(_:)), for: .touchUpInside)
        btnBgView.addSubview(playBtn)
        playBtn.snp.makeConstraints { (make) in
            make.size.equalTo(coverImage)
            make.center.equalTo(btnBgView)
        }
        
        // 进度条
        progressview.startLabel.text = "00:00"
        progressview.allTimeLabel.text = "\(String.getFormatPlayTime(secounds: Float(progressTimes)))"
        bgView.addSubview(progressview)
        progressview.snp.makeConstraints { (make) in
            make.left.right.equalTo(topImage)
            make.bottom.equalTo(topImage)
        }
        
        // 按钮
        discussBtn.tag = 4
        discussBtn.adjustsImageWhenHighlighted = false
        discussBtn.configBtn(image: UIImage(named: "评论")!, title:" 999+") //debug
        discussBtn.addTarget(self, action: #selector(clickBtnAction(_:)), for: .touchUpInside)
        bgView.addSubview(discussBtn)
        discussBtn.snp.makeConstraints { (make) in
            make.width.equalTo(bgView.snp.width).offset(0).multipliedBy(0.3)
            make.centerX.equalTo(topImage)
            make.top.equalTo(topImage.snp.bottom)
            make.bottom.equalTo(bgView.snp.bottom)
        }
        // 点赞按钮
        likeBtn.tag = 3
        likeBtn.adjustsImageWhenHighlighted = false
        likeBtn.configBtn(image: UIImage(named: "喜欢")!, title: "")
        likeBtn.addTarget(self, action: #selector(clickBtnAction(_:)), for: .touchUpInside)
        bgView.addSubview(likeBtn)
        likeBtn.snp.makeConstraints { (make) in
            make.size.equalTo(discussBtn)
            make.right.equalTo(discussBtn.snp.left)
            make.centerY.equalTo(discussBtn)
        }

        // 分享按钮
        shareBtn.tag = 5
        shareBtn.adjustsImageWhenHighlighted = false
        shareBtn.configBtn(image: UIImage(named: "iconShare")!, title: "")
        shareBtn.addTarget(self, action: #selector(clickBtnAction(_:)), for: .touchUpInside)
        bgView.addSubview(shareBtn)
        shareBtn.snp.makeConstraints { (make) in
            make.size.equalTo(discussBtn)
            make.left.equalTo(discussBtn.snp.right)
            make.centerY.equalTo(discussBtn)
        }
        
    }
    
    // MARK: - 按键的对应的方法
    func clickBtnAction(_ sender: UIButton) {
        if (clickClosure != nil) {
            clickClosure!(sender.tag)
        }
        // 喜欢按钮的UI切换
        if sender.tag == 3 {
            sender.isSelected = !sender.isSelected
            if sender.isSelected == true {
                likeBtn.configBtn(image: UIImage(named: "喜欢2")!, title: "")
            }else{
                likeBtn.configBtn(image: UIImage(named: "喜欢")!, title: "")
            }
        }

    }
    
       
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
}



