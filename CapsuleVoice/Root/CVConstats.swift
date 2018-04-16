//
//  CVConstats.swift
//  CapsuleVoice
//
//  Created by 5i84 on 2017/5/16.
//  Copyright © 2017年 LiJingZe. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD
import SnapKit

let SCREEN_WIDTH  = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height


let MainColor  = UIColor.withHex(hexString: "59bccd")  // 89  188 205
let LeftColor  = UIColor.withHex(hexString: "66c1b0")  // 102 193 176
let RightColor = UIColor.withHex(hexString: "4bb5e6")  // 75  181 230

let tagArr = ["说感情","谈事业","聊梦想","许愿望","自己唱","勾搭","录游记","聊人生","闲置时光","长大一点","励志","家乡方言"]

class CVConstants: NSObject {
    // 弹出Hud
    class func showTextHud(_ text: String?) {
        let hud = MBProgressHUD.showAdded(to: UIApplication.shared.keyWindow!, animated: true)
        hud.mode = .text
        hud.label.text = text!
        hud.bezelView.backgroundColor = .black
        hud.label.textColor = .white
        hud.hide(animated: true, afterDelay: 0.7)
    
    }
    
}
