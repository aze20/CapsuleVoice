//
//  CAGradientLayer+Extension.swift
//  CapsuleVoice
//
//  Created by 5i84 on 2017/5/16.
//  Copyright © 2017年 LiJingZe. All rights reserved.
//

import Foundation
import UIKit

extension CAGradientLayer {
    
    static func gradientLayerWithFrame(frame : CGRect) -> CAGradientLayer {

        let gradientLayer = CAGradientLayer()
        // CGColor是无法放入数组中的，必须要转型。
        gradientLayer.colors = [
           UIColor.withRGB(37, 191, 191).cgColor,
           UIColor.withRGB(75, 181, 230).cgColor
        ];
//        gradientLayer.locations = [0, 0.85, 1.4]
        // 颜色渐变的起点和终点，范围为 (0~1.0, 0~1.0)
        gradientLayer.startPoint = CGPoint(x:0, y:0)
        gradientLayer.endPoint = CGPoint(x:0, y:1.0)
        gradientLayer.frame = frame
        return gradientLayer;
        
    }
    
}
