//
//  CVLayerView.swift
//  CapsuleVoice
//
//  Created by 5i84 on 2017/6/23.
//  Copyright © 2017年 LiJingZe. All rights reserved.
//

import UIKit

class CVLayerView: UIView {

    var pulseLayer: CAShapeLayer!
    let groupAnimation = CAAnimationGroup()
    let replicatorLayerX = CAReplicatorLayer()

     override init(frame: CGRect) {
        super.init(frame: frame)
        
        let width = self.bounds.size.width

        // 动画图层
        pulseLayer = CAShapeLayer()
        pulseLayer.bounds = CGRect(x: 0, y: 0, width: width, height: width)
        pulseLayer.position = CGPoint(x: width/2, y: width/2)
        pulseLayer.backgroundColor = UIColor.clear.cgColor
        pulseLayer.path = UIBezierPath(ovalIn: pulseLayer.bounds).cgPath
        pulseLayer.fillColor = #colorLiteral(red: 0.3490196078, green: 0.737254902, blue: 0.8039215686, alpha: 1).cgColor
        pulseLayer.opacity = 0.0
        
        replicatorLayerX.bounds = CGRect(x: 0, y: 0, width: width, height: width)
        replicatorLayerX.position = CGPoint(x: width/2, y: width/2)
        replicatorLayerX.instanceCount = 3  // 三个复制图层
        replicatorLayerX.instanceDelay = 1  // 频率
        replicatorLayerX.addSublayer(pulseLayer)
        self.layer.addSublayer(replicatorLayerX)

        
    }
    
    
    func starAnimation() {
        // 透明
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 0.8
        opacityAnimation.toValue = 0
        
        // 扩散动画
        let scaleAnimation = CABasicAnimation(keyPath: "transform")
        let t = CATransform3DIdentity
        scaleAnimation.fromValue = NSValue(caTransform3D: CATransform3DScale(t, 0.0, 0.0, 0.0))
        scaleAnimation.toValue = NSValue(caTransform3D: CATransform3DScale(t, 1.0, 1.0, 0.0))
        
        
        groupAnimation.animations = [opacityAnimation,scaleAnimation]
        groupAnimation.duration = 3
        groupAnimation.autoreverses = false //循环效果,
        groupAnimation.repeatCount = HUGE
        pulseLayer.add(groupAnimation, forKey: nil)
    }
    
    func stopAnimation() {
        //延时1秒执行
//        let time: TimeInterval = 3.0
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
//            //code
//            print("1 秒后输出")
            self.pulseLayer.removeAllAnimations()
//
//        }
        
        UIView.animate(withDuration: 3) { 
         
        }



    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
     
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
