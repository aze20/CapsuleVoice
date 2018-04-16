//
//  UIColor+Extension.swift
//  CapsuleVoice
//
//  Created by 5i84 on 2017/5/16.
//  Copyright © 2017年 LiJingZe. All rights reserved.
//

import Foundation
import UIKit

/// 获取颜色的方法
extension UIColor {

    static func withHex(hexString: String, alpha:CGFloat = 1) -> UIColor {
        // 去除空格等
        var cString: String = hexString.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        // 去除#
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        // 必须为6位
        if (cString.characters.count != 6) {
            return UIColor.gray
        }
        // 红色的色值
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        // 字符串转换
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
    
    //获取颜色，通过16进制数值
    static func withHex(hexInt:Int32, alpha:CGFloat = 1) -> UIColor {
        let r = CGFloat((hexInt & 0xff0000) >> 16) / 255
        let g = CGFloat((hexInt & 0xff00) >> 8) / 255
        let b = CGFloat(hexInt & 0xff) / 255
        return UIColor(red: r, green: g, blue: b, alpha: alpha)
    }
    

    static func withRGB(_ red:CGFloat, _ green:CGFloat, _ blue:CGFloat) -> UIColor {
        return UIColor.withRGBA(red, green, blue, 1)
    }
    

    static func withRGBA(_ red:CGFloat, _ green:CGFloat, _ blue:CGFloat, _ alpha:CGFloat) -> UIColor {
        return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha)
    }
}
