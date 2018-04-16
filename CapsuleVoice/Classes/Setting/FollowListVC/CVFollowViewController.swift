//
//  CVFollowViewController.swift
//  CapsuleVoice
//
//  Created by 5i84 on 2017/6/13.
//  Copyright © 2017年 LiJingZe. All rights reserved.
//

import UIKit

class CVFollowViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let cellID = "CVFollowTableViewCell"
    private let tableView = UITableView()
    var isFansList : Bool = false
    var array = ["3","5","6","1","18"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isFansList == false {
            self.title = "我的关注"
        }else{
            self.title = "我的粉丝"
        }
//        self.automaticallyAdjustsScrollViewInsets = false
        tableView.backgroundColor = UIColor.groupTableViewBackground
        tableView.frame = self.view.frame
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsetsMake(64, 60, 0, 0)
        tableView.rowHeight = 60
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
        self.view.addSubview(tableView)

        
    }
    
    // MARK: - UITableViewDelegate & DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! CVFollowTableViewCell
        cell.userHeadImage.image = UIImage(named:array[indexPath.row])
        return cell
    }
    
    // 单元格点击事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    // 是否允许tableview的cell能不能编辑
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    
    // 设置原始的删除按钮的title
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        if isFansList == false {
            return "取消关注"
        }else{
            return "移除粉丝"
        }
    }
    //点击删除按钮触发的函数。 需要判断是否是删除的类型
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CVConstants.showTextHud("点击删除")
        }

//         let dic =  itemArry.objectAtIndex(indexPath.row) as! NSDictionary
//            //进行删除后的网络请求接口
//            deleteCell(dic.objectForKey("Q_ID") as! String)
        
            //删除数组中的数据
            array.remove(at:indexPath.row)
            //刷新tableview
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
