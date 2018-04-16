//
//  UIImageView+Extension.swift
//  CapsuleVoice
//
//  Created by 5i84 on 2017/5/24.
//  Copyright © 2017年 LiJingZe. All rights reserved.
//

import Foundation

extension UIImageView {
    // 360度旋转图片
    func rotate360Degree() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z") // 让其在z轴旋转
        rotationAnimation.toValue = NSNumber(value: Double.pi * 2.0) // 旋转角度
        rotationAnimation.duration = 30         // 旋转周期/速度
        rotationAnimation.isCumulative = true  // 旋转累加角度
        rotationAnimation.repeatCount = 11111  // 旋转次数
        rotationAnimation.isRemovedOnCompletion = false
        rotationAnimation.fillMode = kCAFillModeForwards
        layer.add(rotationAnimation, forKey: "rotationAnimation")
        
    }
    
    func pauseRotate(){
         //暂停封面图片的旋转
        self.pauseLayer(layer: self.layer)
    }
    
    func resumeRotate(){
        self.resumeLayer(layer: self.layer)
    }
    
    // 停止旋转
    func stopRotate() {
        layer.removeAllAnimations()
       
    }
    
    //暂停
    func pauseLayer(layer : CALayer){
        var pausedTime = CFTimeInterval()
        pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0.0
        layer.timeOffset = pausedTime
    }
    
    //继续 debug
    func resumeLayer(layer : CALayer){
        var pausedTime = CFTimeInterval()
        pausedTime = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        
        let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePause
        
    }
}


