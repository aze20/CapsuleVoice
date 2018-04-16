//
//  CVMyCapsuleViewController.swift
//  CapsuleVoice
//
//  Created by 5i84 on 2017/6/12.
//  Copyright © 2017年 LiJingZe. All rights reserved.
//

import UIKit

class CVMyCapsuleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellID = "CVMyCapsuleTableViewCell"
    let tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.automaticallyAdjustsScrollViewInsets = false
        self.title = "我的胶囊"
        let view = DCGradientView(frame:self.view.frame)
        self.view.addSubview(view)
        
        tableView.backgroundColor = .clear
        tableView.frame = view.frame
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.separatorInset = UIEdgeInsetsMake(64, 15, 0, 15)
        tableView.estimatedRowHeight = 110
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
        view.addSubview(tableView)

    }
    
    
    //MARK: - UITableViewDelegate & DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! CVMyCapsuleTableViewCell
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        
        return cell
    }
    
    //单元格点击事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let detailVC = CVCapsuleDetailViewController()
        self.navigationController?.pushViewController(detailVC, animated: true)

    }
    
    
    
    //MARK: - CustomDelegate & DataSource

}
