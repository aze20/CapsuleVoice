//
//  CVSettingViewController.swift
//  CapsuleVoice
//
//  Created by 5i84 on 2017/6/1.
//  Copyright © 2017年 LiJingZe. All rights reserved.
//

import UIKit
import StoreKit
import MessageUI

class CVSettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,MFMailComposeViewControllerDelegate {
    @IBOutlet weak var topImage: UIImageView!   //顶部背景图
    @IBOutlet weak var headImage: UIImageView!  //用户头像
    @IBOutlet weak var userNameLabel: UILabel!  //用户名
    @IBOutlet weak var tipLabel: UILabel!
    // 字体Futura-CondensedMedium
    @IBOutlet weak var playTimesLabl: UILabel!  //播放次数
    @IBOutlet weak var appludaLabel: UILabel!   //关注数量
    @IBOutlet weak var fansNumLabel: UILabel!   //粉丝数量
    @IBOutlet weak var tableView: UITableView!  //table
    @IBOutlet weak var hei: NSLayoutConstraint! //tipLabel高度
    @IBOutlet weak var myCapBtn: UIButton!      //我的胶囊按钮

    let cellID = "CellID"
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
        self.setUI()
        // 头像 关注 粉丝lable添加手势 
        headImage.isUserInteractionEnabled = true
        appludaLabel.isUserInteractionEnabled = true
        fansNumLabel.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(CVSettingViewController.userClick(sender:)))
        headImage.addGestureRecognizer(tapGesture)
        let tapGesture1 = UITapGestureRecognizer.init(target: self, action: #selector(CVSettingViewController.userClick(sender:)))
        appludaLabel.addGestureRecognizer(tapGesture1)
        let tapGesture2 = UITapGestureRecognizer.init(target: self, action: #selector(CVSettingViewController.userClick(sender:)))
        fansNumLabel.addGestureRecognizer(tapGesture2)
    }
    
    //MARK: - UITableViewDelegate & DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = ["我的评论","我喜欢"][indexPath.row]
            cell.imageView?.image = [UIImage(named:"我的评论"),UIImage(named:"我喜欢")][indexPath.row]
        case 1:
            cell.textLabel?.text = ["邀请好友","一键评分"][indexPath.row]
            cell.imageView?.image = [UIImage(named:"邀请好友"),UIImage(named:"给我评分")][indexPath.row]
        default:
            cell.textLabel?.text = ["意见反馈","关于声音胶囊"][indexPath.row]
            cell.imageView?.image = [UIImage(named:"意见反馈"),UIImage(named:"关于我们")][indexPath.row]
        }
        cell.textLabel?.textColor = MainColor
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        return cell
    }
    //单元格点击事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        switch indexPath.section {
        case 0:
            if (indexPath.row == 0){
                
            } else {
                
            }
        case 1:
            if (indexPath.row == 0){
                
            } else {
                if #available(iOS 10.3, *) { // 应用内部打分
                    SKStoreReviewController.requestReview()
                } else { //App Stores
                    // onlyLatestVersion：true 只针对最新的版本
                    // pageNumber：0 第一页显示评论
                    // sortOrdering（0：默认进入的是APP详情 1：直接进入评论 3：直接进入相关）
                    let url = NSURL(string:"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=(app对应的App Store中的ID)&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software")
                    UIApplication.shared.openURL(url! as URL)
                }
            }
        default:
            if indexPath.row == 0{
                print("意见反馈")
                if MFMailComposeViewController.canSendMail() {
                    //注意这个实例要写在if block里，否则无法发送邮件时会出现两次提示弹窗（一次是系统的）
                    let mailComposeViewController = configuredMailComposeViewController()
                    self.present(mailComposeViewController, animated: true, completion: nil)
                } else {
                    self.showSendMailErrorAlert()
                }
                
            } else {
                let view = CVAboutMeAlertView()
                view.show()
            }
        
        }
    }
    
    //MARK: - CustomDelegate
    //发送邮件代理方法
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
        switch result{
        case .sent:
            CVConstants.showTextHud("发送成功")
        case .cancelled:
            CVConstants.showTextHud("邮件已取消")
        case .saved:
            CVConstants.showTextHud("邮件已保存")
        case .failed:
            CVConstants.showTextHud("邮件发送失败")
        }
    }
    //MARK: - Event response
    //返回
    @IBAction func backBtn(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
    }
    
    //设置按钮
    @IBAction func setBtnClick(_ sender: Any) {
        
    }
    //我的胶囊
    @IBAction func myCapsuleBtnClick(_ sender: Any) {
        let vc = CVMyCapsuleViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    //MARK: - Request Data
    
    //MARK: - Prive methods
    // 发送邮件
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        // 设置邮件地址、主题及正文
        mailComposeVC.setToRecipients(["lijingze.dev@gmail.com"])
        mailComposeVC.setSubject("声音胶囊APP用户反馈")
        // 获取系统版本号
        let systemVersion = UIDevice.current.systemVersion
        // 获取APP版本的型号
        let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        mailComposeVC.setMessageBody("系统版本：\(systemVersion)\nAPP版本：\(appVersion)", isHTML: false)
        return mailComposeVC
        
    }
    // 邮箱启动失败回调
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertController(title: "无法发送邮件", message: "您的设备尚未设置邮箱，请在-邮件-应用中设置后再尝试发送。", preferredStyle: .alert)
        sendMailErrorAlert.addAction(UIAlertAction(title: "确定", style: .default) { _ in })
        self.present(sendMailErrorAlert, animated: true)
        
    }
    
    func setUI(){
        self.automaticallyAdjustsScrollViewInsets = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 40
        tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15)
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: cellID)
        //顶部背景图+毛玻璃
        let num = [1,2,0][Int(arc4random()%3)]
        if  num == 0 {
            topImage.image = nil
        }else {
            topImage.image = UIImage(named: "\(Int(arc4random()%17)+1)")
        }
        if topImage.image == nil {
            let view = DCGradientView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 254))
            topImage.addSubview(view)
        }else{
            let blurEffect = UIBlurEffect(style: .light)
            let blurView = UIVisualEffectView(effect: blurEffect)
            topImage.addSubview(blurView)
            blurView.snp.makeConstraints { (make) in
                make.size.equalTo(topImage)
                make.center.equalTo(topImage)
            }
        }
        
        //头像
        headImage.layer.cornerRadius = 40
        headImage.layer.masksToBounds = true
        hei.constant = SCREEN_HEIGHT > 568 ?  20 : 10
        //我的胶囊
        myCapBtn.layer.cornerRadius = 20
        myCapBtn.layer.shadowColor = UIColor.lightGray.cgColor
        myCapBtn.layer.shadowOffset = CGSize(width: 0, height: 3)
        myCapBtn.layer.shadowOpacity = 1



    }
    

    // 头像 关注 粉丝 点击手势响应
     @objc private func userClick(sender: UITapGestureRecognizer) {
        
        switch (sender.view?.tag)! {
        case 11: // 点击头像
            let vc = CVPersonalDataViewController()
            vc.title = "个人资料"
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = CVFollowViewController()
            vc.isFansList = false
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = CVFollowViewController()
            vc.isFansList = true
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
            
        }

    }


    
    
}
