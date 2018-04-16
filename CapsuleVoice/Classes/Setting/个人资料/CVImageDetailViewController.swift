//
//  CVImageDetailViewController.swift
//  CapsuleVoice
//
//  Created by 5i84 on 2017/6/14.
//  Copyright © 2017年 LiJingZe. All rights reserved.
//

import UIKit

import AssetsLibrary

class CVImageDetailViewController: UIViewController {
    //选中的图片资源
    var myAsset:ALAsset!
    //用于显示图片信息
    @IBOutlet weak var textView: UITextView!
    //用于显示原图
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //获取文件名
        let representation =  myAsset.defaultRepresentation()
        self.title = representation?.filename()
        
        //获取图片信息
        textView.text = "日期：\(myAsset.value(forProperty: ALAssetPropertyDate))\n"
            + "类型：\(myAsset.value(forProperty: ALAssetPropertyType))\n"
            + "位置：\(myAsset.value(forProperty: ALAssetPropertyLocation))\n"
            + "时长：\(myAsset.value(forProperty: ALAssetPropertyDuration))\n"
            + "方向：\(myAsset.value(forProperty: ALAssetPropertyOrientation))"
        
        //获取原图
        let imageBuffer = UnsafeMutablePointer<UInt8>.allocate(capacity: Int((representation?.size())!))
        let bufferSize = representation?.getBytes(imageBuffer, fromOffset: Int64(0),
                                                 length: Int((representation?.size())!), error: nil)
        let data =  NSData(bytesNoCopy:imageBuffer ,length:bufferSize!, freeWhenDone:true)
        imageView.image = UIImage(data: data as Data)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

