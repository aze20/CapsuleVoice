//
//  CVPhotoCollectionViewController.swift
//  CapsuleVoice
//
//  Created by 5i84 on 2017/6/14.
//  Copyright © 2017年 LiJingZe. All rights reserved.
//

import UIKit
import AssetsLibrary

private let reuseIdentifier = "Cell"

class CVPhotoCollectionViewController: UICollectionViewController {

    //资源库管理类
    var assetsLibrary =  ALAssetsLibrary()
    //保存照片集合
    var assets = [ALAsset]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.register(UINib(nibName: "CVMainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CVMainCollectionViewCell")

        var countOne = 0
        //ALAssetsGroupSavedPhotos表示只读取相机胶卷（ALAssetsGroupAll则读取全部相簿）
        assetsLibrary.enumerateGroupsWithTypes(ALAssetsGroupSavedPhotos, usingBlock: {
            (group: ALAssetsGroup!, stop) in
            print("is goin")
            if group != nil
            {
                let assetBlock : ALAssetsGroupEnumerationResultsBlock = {
                    (result: ALAsset!, index: Int, stop) in
                    if result != nil
                    {
                        self.assets.append(result)
                        countOne+=1
                    }
                }
                group.enumerateAssets(assetBlock)
                print("assets:\(countOne)")
                //collectionView网格重载数据
                self.collectionView?.reloadData()
            }
        }, failureBlock: { (fail) in
            print(fail ?? "")
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return assets.count;

    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 获取设计的单元格，不需要再动态添加界面元素
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CVMainCollectionViewCell
        //取缩略图
        let myAsset = assets[indexPath.item]
        let image = UIImage(cgImage: myAsset.thumbnail().takeUnretainedValue())
        // 从界面查找到控件元素并设置属性
        cell.bgImage.image = image

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        var myAsset = assets[indexPath.item]
        //这里不使用segue跳转（建议用segue跳转）
        let vc = CVImageDetailViewController()
        vc.myAsset = self.assets[indexPath.row]
        self.navigationController!.pushViewController(vc, animated:true)
    }
    


}
