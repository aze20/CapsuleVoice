//
//  CVAboutMeAlertView.swift
//  CapsuleVoice
//
//  Created by 5i84 on 2017/6/15.
//  Copyright © 2017年 LiJingZe. All rights reserved.
//

import UIKit

class CVAboutMeAlertView: UIView ,UITextViewDelegate{

    private let bgWhiteView = UIView()
    private let logoImage = UIImageView()
    private let titleLabel = UILabel()
    private let textView = UITextView()
    private let doneBtn = UIButton()
    
    //创建函数体
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        self.backgroundColor = UIColor.withRGBA(0, 0, 0, 0.5)
        // 添加全屏点击手势
        self.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(self.hidden))
        self.addGestureRecognizer(tapGesture)
        
        bgWhiteView.layer.cornerRadius = 5
        bgWhiteView.backgroundColor = .white
        self.addSubview(bgWhiteView)
        bgWhiteView.snp.makeConstraints { (make) in
            make.width.equalTo(self).multipliedBy(0.75)
            make.height.equalTo(self).multipliedBy(0.6)
            make.center.equalTo(self)
        }
        // logo
        logoImage.image = UIImage(named: "logo2")
        bgWhiteView.addSubview(logoImage)
        logoImage.snp.makeConstraints { (make) in
            make.centerX.equalTo(bgWhiteView)
            make.centerY.equalTo(bgWhiteView.snp.top)
            make.height.width.equalTo(60)
        }
        
        // title
        titleLabel.text = "声音胶囊"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textColor = MainColor
        bgWhiteView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(bgWhiteView).offset(15)
            make.top.equalTo(logoImage.snp.bottom).offset(5)
            make.right.equalTo(bgWhiteView).offset(-15)
            make.height.equalTo(20)
        }
        
        let cutView = UIView()
        cutView.backgroundColor = MainColor
        bgWhiteView.addSubview(cutView)
        cutView.snp.makeConstraints { (make) in
            make.left.right.equalTo(bgWhiteView)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.height.equalTo(0.5)
        }
        
        // 确定按钮
        doneBtn.backgroundColor = MainColor
        doneBtn.layer.cornerRadius = 5
        doneBtn.setTitleColor(UIColor.white, for: .normal)
        doneBtn.setTitle("我读完了", for: .normal)
        doneBtn.titleLabel!.font = UIFont.systemFont(ofSize: 14)
        doneBtn.addTarget(self, action: #selector(self.hidden), for: .touchUpInside)
        bgWhiteView.addSubview(doneBtn)
        doneBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(bgWhiteView)
            make.left.equalTo(bgWhiteView).offset(15)
            make.right.bottom.equalTo(bgWhiteView).offset(-15)
            make.height.equalTo(30)
        }
        
        //站点名称设置行间距
        let contentStr = "    用最简单的方法，做最纯粹的声音记忆。\n    声音胶囊正处于成长过程，如果你对声音胶囊有任何的建议，请不要吝啬。\n    如果你有梦想，恰好你是UI，那么我们需要一个简单的开始。\n\n设计:\n    @夏颖Nina     \n开发:\n    @京泽     lijingze.dev@gmail.com  \n    @憧憬此年     610392592@qq.com" as NSString
        
        let nameStr : NSMutableAttributedString = NSMutableAttributedString(string:contentStr as String)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        paragraphStyle.alignment = .left
        // 行间距
        nameStr.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, contentStr.length))
        // 添加链接
        let range = contentStr.range(of: "@夏颖Nina", options: .regularExpression, range: NSMakeRange(0,contentStr.length))
        let range1 = contentStr.range(of: "@京泽", options: .regularExpression, range: NSMakeRange(0,contentStr.length))
        let range2 = contentStr.range(of: "@憧憬此年", options: .regularExpression, range: NSMakeRange(0,contentStr.length))
        nameStr.addAttribute(NSLinkAttributeName, value: "xiaying://", range: range)
        nameStr.addAttribute(NSLinkAttributeName, value: "jingze://", range: range1)
        nameStr.addAttribute(NSLinkAttributeName, value: "lihao://", range: range2)

        textView.attributedText = nameStr
        textView.isEditable = false
        textView.delegate = self
        textView.font = UIFont.systemFont(ofSize: 12)
        bgWhiteView.addSubview(textView)
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(cutView.snp.bottom).offset(10)
            make.left.equalTo(bgWhiteView).offset(15)
            make.right.equalTo(bgWhiteView).offset(-15)
            make.bottom.equalTo(doneBtn.snp.top).offset(-10)
        }
    }

    
    // MARK: - UITextViewDelegate
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        if URL.scheme == "xiaying" {
            if let url = NSURL(string:"http://weibo.com/2326233410")  {
                UIApplication.shared.openURL(url as URL)
            }
            return false
        }
        if URL.scheme == "jingze" {
            if let url = NSURL(string:"http://weibo.com/577843333")  {
                UIApplication.shared.openURL(url as URL)
            }
            return false
        }
        if URL.scheme == "lihao" {
            if let url = NSURL(string:"http://weibo.com/2153247023")  {
                UIApplication.shared.openURL(url as URL)
            }
            return false
        }
        return true
    }

    
    func show(){
        let wind = UIApplication.shared.keyWindow
        self.alpha = 0
        wind?.addSubview(self)
        UIView.animate(withDuration: 0.25, animations: { () -> Void in
            self.alpha = 1
        })
    }
    
    func hidden(){
        UIView.animate(withDuration: 0.25, animations: { () -> Void in
            self.alpha = 0
        }, completion: { (finish) -> Void in
            if finish {
                self.removeFromSuperview()
            }
        })
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
