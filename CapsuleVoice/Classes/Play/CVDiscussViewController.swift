//
//  CVDiscussViewController.swift
//  CapsuleVoice
//
//  Created by 5i84 on 2017/6/8.
//  Copyright © 2017年 LiJingZe. All rights reserved.
//

import UIKit

class CVDiscussViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SecondVCDelegate, UITextFieldDelegate {

    @IBOutlet var viewTitile: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var textField: UITextField!

    let cellID = "CVDiscussTableViewCell"
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
//        self.automaticallyAdjustsScrollViewInsets = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsetsMake(64, 15, 0, 15)
        tableView.rowHeight = 80
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(UINib(nibName: "CVDiscussTableViewCell", bundle: nil), forCellReuseIdentifier: cellID)
        
    }
    
    
    //MARK: - UITableViewDelegate & DataSource    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 18
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! CVDiscussTableViewCell
        cell.selectionStyle = .none
        cell.delegate = self
        cell.goodBtn.setTitle(String(Int(arc4random()%2227)), for: .normal)
        cell.headImage.setImage(UIImage(named: "\((indexPath as NSIndexPath).row + 1).png"), for: .normal)
        return cell
    }
    //单元格点击事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (indexPath.row == 0){
            
        }else if (indexPath.row == 1){
            return;
        }
    }
    
   //MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.text = ""
        CVConstants.showTextHud("评论成功")
        
        return true
    }
    
    //MARK: - CustomDelegate
    func passOnInformation(sender: UIButton) {
        //        print(sender.tag)
        if sender.tag == 1 {
            if !sender.isSelected == true {
                print("+1请求")
            }else{
                print("-1请求")
                
            }
        }else{
            print("点击头像")
            
        }
        
    }
    //MARK: - Event response
    @IBAction func disMissBtn(_ sender: Any) {
        self.dismiss(animated: true) {
            
        }
    }
    
    
    //MARK: - Request Data
    
    //MARK: - Prive methods
    
    
  
    
    

}
