//
//  String+Extension.swift
//  CapsuleVoice
//
//  Created by 5i84 on 2017/5/26.
//  Copyright © 2017年 LiJingZe. All rights reserved.
//

import Foundation

extension String {
    //时间格式转换
  static func getFormatPlayTime(secounds:Float)->String{
        if secounds.isNaN{
            return "00:00"
        }
        var Min = Int(secounds / 60)
        let Sec = Int(secounds.truncatingRemainder(dividingBy: 60))
        var Hour = 0
        if Min>=60 {
            Hour = Int(Min / 60)
            Min = Min - Hour*60
            return String(format: "%02d:%02d:%02d", Hour, Min, Sec)
        }
        return String(format: "%02d:%02d", Min, Sec)
    }
    
}
