//
//  CVPlayerViewController.swift
//  CapsuleVoice
//
//  Created by 5i84 on 2017/5/26.
//  Copyright © 2017年 LiJingZe. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class CVPlayerViewController: UIViewController {

    let alertView = CPCustomPlayView()
    
    var tipLabel : String!                   //标题名称
    var userNameLabel : String!              //用户名
    
    private var timer : Timer?
    private var starTime : Float = 0.0      //开始时间
    private var allTime : Float = 0.0       //音频总时长
    private var progressTimes : Float = 0.0 //进度条总时间
    private var isPlay = -1                 //播放状态  0=停止  1=播放 2=暂停
    private var player = AVAudioPlayer()
    
    // MARK: - LifeCycle
    // Masonry布局情况下设置UIView 的cornerRadius/borderWidth
    override func viewWillLayoutSubviews() {
        alertView.coverImage.layer.cornerRadius = alertView.coverImage.width/2
        alertView.coverImage.layer.masksToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.withRGBA(0, 0, 0, 0.5)
        
        isPlay = 1
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            
        }
        UIApplication.shared.beginReceivingRemoteControlEvents()
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        let str =  Bundle.main.path(forResource: "music", ofType: "mp3")
        let pathURL = NSURL(fileURLWithPath: str!)
        do {
            player = try AVAudioPlayer(contentsOf: pathURL as URL)
        } catch {

        }
        //获取音频时长
        let duration = Float(player.duration)
        allTime                 = duration
        progressTimes           = duration
        alertView.progressTimes = duration
        
        //debug假数据
        let image = UIImage(named: "\(Int(arc4random()%17)+1)")
        alertView.topImage.image = image //模糊背景图
        alertView.headImage.image = image //头像
        alertView.coverImage.image = image //封面
        alertView.userNameLabel.text = userNameLabel
        alertView.tipLabel.text  = tipLabel
        alertView.frame = self.view.frame
        self.view.addSubview(alertView)
        
        //获取点击事件
        alertView.clickIndexClosure { (index) in
            if index == 1 {
                //关闭界面 停止播放
                self.timePause() //取消定时器
                self.player.stop() //停止播放
                self.dismiss(animated: false, completion: nil)
            }
            if index == 2 {
                print("播放音乐")
                if self.isPlay == 0 { //继续
                    self.alertView.recordImage.resumeRotate()
                    self.playVoice() //debug
                }else if self.isPlay == 1{
                    self.alertView.recordImage.rotate360Degree()
                    //启动计时器/播放
                    self.playVoice()
                }else{
                    self.alertView.recordImage.pauseRotate()
                    self.isPlay = 0
                    self.timePause() //停
                    self.player.pause()

                }
                
                
            }
            if index == 3 {
                print("点赞")
            }
            if index == 4 {
                print("评论")
                let disVC = CVDiscussViewController()
//                self.navigationController?.pushViewController(disVC, animated: true)
                self.present(disVC, animated: true, completion: nil)
            }
            if index == 5 {
                print("分享")
            }
        }
    
        self.setLockView() //设置歌曲信息

    }

    //MARK: - CustomDelegate
    
    //MARK: - Event response
    
    //MARK: - Request Data
    
    //MARK: - Prive methods
    // 播放音频
    func playVoice() {
        if !(timer != nil) {
            timer = Timer.scheduledTimer(timeInterval:0.5, target: self, selector: #selector(timerIntervalx), userInfo: nil, repeats: true)
        }
        isPlay = 2
        self.player.play()
        alertView.playBtn.setImage(nil, for: .normal)

        
    }
    //暂停
    func timePause() {
        timer?.invalidate()
        timer = nil
        //按钮显示暂停
        self.alertView.playBtn.setImage(UIImage(named:"暂停white"), for: .normal)

    }
    // timerSelector
    func timerIntervalx() {
        starTime+=0.5
        allTime-=0.5
        if allTime <= 0 {
            self.timePause() //取消定时器
            alertView.progressview.startLabel.text = "00:00"
            alertView.progressview.allTimeLabel.text = "\(String.getFormatPlayTime(secounds: Float(self.progressTimes)))"
            starTime = 0
            allTime = progressTimes
            alertView.progressview.proView.setProgress(0, animated: false)
            alertView.recordImage.stopRotate() //碟片停止旋转
            alertView.playBtn.setImage(UIImage(named:"暂停white"), for: .normal)
            isPlay = 1
            
        }else{
            //进度条UI
            alertView.progressview.startLabel.text = String.getFormatPlayTime(secounds: Float(starTime))
            alertView.progressview.allTimeLabel.text = "\(String.getFormatPlayTime(secounds: Float(allTime)))"
            alertView.progressview.proView.setProgress(Float(starTime/progressTimes), animated: true)
        }
        
    }
    //设置锁屏信息
    func setLockView(){
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = [
            // 歌曲名称
            MPMediaItemPropertyTitle:tipLabel,
            // 演唱者
            MPMediaItemPropertyArtist:userNameLabel,
            // 锁屏图片
            MPMediaItemPropertyArtwork:MPMediaItemArtwork(image: UIImage(named: "\(Int(arc4random()%17)+1)")!),
            //
            MPNowPlayingInfoPropertyPlaybackRate:1.0,
            // 总时长            
            MPMediaItemPropertyPlaybackDuration:player.duration,
            // 当前时间
            MPNowPlayingInfoPropertyElapsedPlaybackTime:player.currentTime
        ]

    }
    //锁屏远程控制音乐播放代码
    override func remoteControlReceived(with event: UIEvent?) {
        self.setLockView()

        switch event!.subtype {
        case .remoteControlPlay:  // play按钮
            self.playVoice()
            self.player.play()
            self.alertView.recordImage.rotate360Degree()

        case .remoteControlPause:  // pause按钮
            self.timePause()
            self.player.pause()
            self.alertView.recordImage.stopRotate()

        case .remoteControlNextTrack:  // next
            // ▶▶
            break
        case .remoteControlPreviousTrack:  // previous
            // ◀◀
            break
        default:
            break
        }
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
