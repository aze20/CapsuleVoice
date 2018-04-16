//
//  CVMainViewController.swift
//  CapsuleVoice
//
//  Created by 5i84 on 2017/5/16.
//  Copyright © 2017年 LiJingZe. All rights reserved.
//

import UIKit
import AVFoundation

class CVMainViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {
    
    let btn = UIButton()
    //MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.groupTableViewBackground
        self.setupUI()
        
        
    }
    
    
    //MARK: - UICollectionViewDelegate && DataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 18
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVMainCollectionViewCell", for: indexPath) as! CVMainCollectionViewCell
        let nameArr = ["西瓜卷卷卷卷卷卷卷卷","SheMad","泽泽泽泽泽啊","方寸不乱单身Maa","___Smile掛念","37°男人"]
        let titleArr = ["一段声音, 一次记忆","好久不见","旅行的意义cheer","大叔的告诫","为什我们的友谊陌生了","2015年5月10日"]

        cell.typeLabel.setTitle(tagArr[Int(arc4random()%6)], for: .normal)
        cell.bgImage.image = UIImage(named: "\((indexPath as NSIndexPath).row + 1).png")
        cell.titleLabel.text = titleArr[Int(arc4random()%6)]
        cell.userLabel.text = nameArr[Int(arc4random()%6)]
        cell.numLabel.text = "\(Int(arc4random()%2000))"
        cell.userHeadImg.image = UIImage(named: "\(Int(arc4random()%17)+1)")
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("(\((indexPath as NSIndexPath).section),\((indexPath as NSIndexPath).row))")
        
        //获取点击的Cell
        let cell = collectionView.cellForItem(at: indexPath) as! CVMainCollectionViewCell
        //弹出半透明VC
        let playVC = CVPlayerViewController()
        //内容赋值
        playVC.userNameLabel  = cell.userLabel.text     //用户名
        playVC.tipLabel       = cell.titleLabel.text   //标题

        playVC.modalPresentationStyle = .custom
        self.present(playVC, animated: false, completion: {
            playVC.alertView.bgView.transform = CGAffineTransform(translationX: 0, y: -SCREEN_WIDTH/2)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
                playVC.alertView.bgView.transform = CGAffineTransform.identity
            }, completion: nil)
            
        })

        
    }
    
    
    //MARK: - UITableViewDelegate & DataSource
    
    //MARK: - CustomDelegate
    
    //MARK: - Event response
    func rightBtnClick(){
        let setVC = CVSettingViewController()
        self.navigationController?.pushViewController(setVC, animated: true)
        
    }
    
    func addBtnClick(){
        let addVC = CVAddCapsuleViewController() //
        self.present(addVC, animated: true, completion: nil)
    }

    //MARK: - Request Data
    
    
    //MARK: - Prive methods
    private func setupUI(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.createBarButtonItem(imageName: "category",target:self, action:#selector(self.rightBtnClick))
        self.title = "胶囊广场"
        
        //定义collectionView
        let layout = UICollectionViewFlowLayout()
        let cellWidth = (SCREEN_WIDTH-32-16)/2
        let cellHeight = cellWidth * 1.25
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.scrollDirection = .vertical
        //左右 上下 间距
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 20
        //定义一个UICollectionView
        let collectionView = UICollectionView(frame: CGRect(x:16, y:10, width:SCREEN_WIDTH-32, height: SCREEN_HEIGHT-11), collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, 15, 0)
        collectionView.backgroundColor = UIColor.groupTableViewBackground
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceVertical = true;
        collectionView.delegate = self
        collectionView.dataSource = self
        //CollectionViewCell的注册
        collectionView.register(UINib(nibName: "CVMainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CVMainCollectionViewCell")
        self.view.addSubview(collectionView)
        
        btn.layer.cornerRadius = 25
        btn.backgroundColor = .white
        btn.layer.shadowColor = UIColor.lightGray.cgColor
        btn.layer.shadowOffset = CGSize(width: 0, height: 3)
        btn.layer.shadowOpacity = 1
        btn.setImage(UIImage(named:"语音"), for: .normal)
        btn.addTarget(self, action:#selector(self.addBtnClick) , for: .touchUpInside)
        self.view.addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.height.width.equalTo(50)
            make.bottom.equalTo(self.view).offset(-50)
            make.right.equalTo(self.view).offset(-20)
        }
        
    }

    //MARK: - ScrollViewWDelegate
    //开始拖动
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.5, animations: {
            self.btn.x = SCREEN_WIDTH-10
        })

    }
    //停止滚动的3种方式
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let scrollToScrollStop = !scrollView.isTracking && !scrollView.isDragging && !scrollView.isDecelerating
        if scrollToScrollStop {
            self.scrollViewDidEndScroll()
        }
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            let dragToDragStop = !scrollView.isTracking && !scrollView.isDragging && !scrollView.isDecelerating
            if dragToDragStop {
                self.scrollViewDidEndScroll()
            }
        }
    }
    //停止滚动触发
    func scrollViewDidEndScroll(){
        UIView.animate(withDuration: 0.5, animations: {
            self.btn.x = SCREEN_WIDTH - 70
        })
        
    }
    
    

}
