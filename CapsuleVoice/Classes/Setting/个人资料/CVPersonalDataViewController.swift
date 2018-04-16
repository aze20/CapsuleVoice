//
//  CVPersonalDataViewController.swift
//  CapsuleVoice
//
//  Created by 5i84 on 2017/6/13.
//  Copyright © 2017年 LiJingZe. All rights reserved.
//

import UIKit

class CVPersonalDataViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    private let cellID = "CVPersonalDataTableViewCell"
    private let tableView = UITableView()
    private var userNameTip = "斯凯"
    private var sexTitle = ""
    var customTextView : CustomTextView? //textview

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.groupTableViewBackground
        tableView.frame = self.view.frame
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
        tableView.separatorInset = UIEdgeInsetsMake(64, 15, 0, 0)
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
        self.view.addSubview(tableView)

    }
    // MARK: - UITableViewDelegate & DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    // 设置行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return indexPath.row == 0 || indexPath.row == 1 ? 60 : 40
        }else{
            return indexPath.row == 0 ? 40 : 140
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 4 : 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! CVPersonalDataTableViewCell
        switch indexPath.section {
        case 0:
            cell.label.text = ["头像","个人主页背景","胶囊昵称","性别"][indexPath.row]
            cell.accessoryType = .disclosureIndicator
            if indexPath.row == 0 {
                cell.userImage.image = UIImage(named: "6")
                cell.userImage.layer.cornerRadius = 20
                cell.userImage.clipsToBounds = true
            }
            if indexPath.row == 1 {
                cell.userImage.image = UIImage(named: "15")
            }
            if indexPath.row == 2 {
                cell.tipLabel.text = userNameTip
            }
            if indexPath.row == 3 {
                cell.tipLabel.text = sexTitle
            }
        default:
            if indexPath.row == 0 {
                cell.label.text = "个人简介"
            }else{
                cell.label.text = ""
                customTextView = CustomTextView(frame: CGRect(x: 15, y: 0, width: SCREEN_WIDTH-30, height: cell.height))
                customTextView!.SetPlaceholder("个人介绍...")
                customTextView!.SetMaxLength(200)
                cell.addSubview(customTextView!)
            }
        }
        cell.selectionStyle = .none
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        
        return cell
    }
    // 单元格点击事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == 0 else {
            return //第二个区cell不接受点击事件
        }
        if (indexPath.row == 0){

            //这里不使用segue跳转（建议用segue跳转）
//            let vc = CVPhotoCollectionViewController()
//            self.navigationController!.pushViewController(vc, animated:true)

        }else if(indexPath.row == 1){
            
        }else if(indexPath.row == 2){
            let vc = CVReviseNameViewController()
            vc.userName = userNameTip
            vc.clickIndexClosure { (title) in
                //debug block 循环引用
                self.userNameTip = title
                self.tableView.reloadData()
            }
            self.present(vc, animated:true, completion: nil)
        }else{
            //弹出选择器
            let custompickView = CVCustomPickView()
            custompickView.show()
            custompickView.clickIndexClosure { (title) in
                if title != "" {
                    self.sexTitle = title
                }else{
                    self.sexTitle = "男"
                }
                self.tableView.reloadData()
            }
        }
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
