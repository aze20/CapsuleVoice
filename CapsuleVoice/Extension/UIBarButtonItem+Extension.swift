//
//  UIBarButtonItem+Extension.swift
//  i84cpn
//
//  Created by 爱巴士-余夏伟 on 16/8/4.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    class func createBarButtonItem(imageName:String, target:AnyObject, action:Selector) -> UIBarButtonItem{
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: UIControlState.normal)
        btn.setImage(UIImage(named: imageName + "_highlighted"), for: UIControlState.highlighted)
        btn.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        btn.size = CGSize(width:30, height:30)
        return UIBarButtonItem(customView: btn)
    }

}
