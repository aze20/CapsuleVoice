//
//  CVCapsuleDetailViewController.swift
//  CapsuleVoice
//
//  Created by 5i84 on 2017/6/20.
//  Copyright © 2017年 LiJingZe. All rights reserved.
//

import UIKit

class CVCapsuleDetailViewController: UIViewController {

    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var weekLabel: UILabel!
    @IBOutlet var bgImageVIew: UIImageView!
    @IBOutlet var effVieew: UIVisualEffectView!
    @IBOutlet var playBtn: UIButton!
    @IBOutlet var shearBtn: UIButton!
    @IBOutlet var openBtn: UIButton!
    @IBOutlet var deleteBtn: UIButton!
    @IBOutlet var popBtn: UIButton!
    @IBOutlet var tagBgView: UIView!
    
    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "详情"
        shearBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
        openBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
        popBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
        deleteBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
        playBtn.layer.cornerRadius = 35

        bgImageVIew.layer.cornerRadius = 5
        bgImageVIew.clipsToBounds = true
        effVieew.layer.cornerRadius = 5
        effVieew.clipsToBounds = true
        
        
        for i in 0 ..< tagArr.count {
            let btn = UIButton()
            let width  = (SCREEN_WIDTH-80)/4
            if i > 7 {
                btn.frame = CGRect(x: CGFloat(i-8) * (width+10), y: 70, width: width, height: 25)
            }else if i > 3 {
                btn.frame = CGRect(x: CGFloat(i-4) * (width+10), y: 35, width: width, height: 25)
            }else{
                btn.frame = CGRect(x: CGFloat(i) * (width+10), y: 0, width: width, height: 25)
            }
            btn.tag = 100 + i
            btn.layer.cornerRadius = 5
            btn.layer.borderColor = MainColor.cgColor
            btn.layer.borderWidth = 1
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            btn.setTitleColor(MainColor, for: .normal)
            btn.setTitleColor(UIColor.white, for: .selected)
            btn.setTitle(tagArr[i], for: .normal)
            btn.addTarget(self, action: #selector(self.tagBtnClick(_:)), for: .touchUpInside)
            tagBgView.addSubview(btn)
        }
        
        
    }

    
    @IBAction func btnClick(_ sender: UIButton) {
        print(sender.tag)
        switch sender.tag {
        case 11:
            self.navigationController?.popViewController(animated: true)
        case 0:
            print("播放音频")
        case 1:
            print("分享")
        case 2:
            let alertController = UIAlertController(title: "请选择胶囊储存方式", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let openAction = UIAlertAction(title: "公开", style: .default, handler: { (alert) in
                print("公开")
            })
            let priveAction = UIAlertAction(title: "仅自己可见", style: .default, handler: { (alert) in
                print("私有")
            })
            alertController.addAction(cancelAction)
            alertController.addAction(openAction)
            alertController.addAction(priveAction)
            self.present(alertController, animated: true, completion: nil)

        default:
            let alertController = UIAlertController(title: "是否删除此胶囊", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
            let openAction = UIAlertAction(title: "删除", style: .destructive, handler: { (alert) in
                CVConstants.showTextHud("删除成功")
                self.navigationController?.popViewController(animated: true)
            })
            let priveAction = UIAlertAction(title: "取消", style: .cancel, handler: { (alert) in
            })
            alertController.addAction(openAction)
            alertController.addAction(priveAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
        

        
        
    }
    
    // 标签按钮事件
    func tagBtnClick(_ sender: UIButton){
        print(sender.tag)
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            sender.backgroundColor = MainColor
        }else{
            sender.backgroundColor = .white
        }
        switch sender.tag {
        case 100:
            print("")
        default:
            print("")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
