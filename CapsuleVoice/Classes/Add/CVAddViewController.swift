//
//  CVAddViewController.swift
//  CapsuleVoice
//
//  Created by 5i84 on 2017/5/18.
//  Copyright © 2017年 LiJingZe. All rights reserved.
//

import UIKit
import AVFoundation

class CVAddViewController: UIViewController {
    
    var audioRecorder:AVAudioRecorder!
    var audioPlayer:AVAudioPlayer!

    var timer:Timer?
    var label:UILabel?
    var a = 0.0


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "添加胶囊"

        
        
        let recordSettings = [AVSampleRateKey : NSNumber(value: Float(44100.0)),//声音采样率
            AVFormatIDKey : NSNumber(value: Int32(kAudioFormatMPEG4AAC)),//编码格式
            AVNumberOfChannelsKey : NSNumber(value: 1),//采集音轨
            AVEncoderAudioQualityKey : NSNumber(value: Int32(AVAudioQuality.medium.rawValue))]//音频质量
    
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try audioRecorder = AVAudioRecorder(url: self.directoryURL()! as URL,
                                                settings: recordSettings)//初始化实例
//            audioRecorder.prepareToRecord()//准备录音
        } catch {
        }
        
        
        let label1 = UILabel()
        label1.frame = CGRect(x:50, y: 100, width: 100, height: 40)
        self.view.addSubview(label1)
        label = label1
        label1.text = "时长:\(a)s"
        
        let arr = ["开始","结束","播放","暂停","关闭界面"]
        for i in 0..<5 {
            let btn = UIButton()
            btn.frame = CGRect(x:50, y: 150+i*60, width: 100, height: 40)
            btn.setTitle(arr[i], for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
            btn.backgroundColor = .red
            btn.tag = i
            btn.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)

            self.view.addSubview(btn)

        }

    }
    
    
    
    func timerIntervalx() {
        a+=1
        label?.text = "时长: \(a)s"
        

    }

    func timeStart() {
        
        if !(timer != nil) {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerIntervalx), userInfo: nil, repeats: true)
            
        }
        

    }
    
    func timePause() {
        timer?.invalidate()
        timer = nil
    }
    


    
    func btnClick(_ btn : UIButton){

        if btn.tag == 0 {
            if !audioRecorder.isRecording {//判断是否正在录音状态
                let audioSession = AVAudioSession.sharedInstance()
                do {
                    try audioSession.setActive(true)
                    audioRecorder.record()
                    print("record!")
                    // 启用计时器
                    timeStart()
                    

                } catch {
                }
            }
        }
        if btn.tag == 1 {
            audioRecorder.stop()
            let audioSession = AVAudioSession.sharedInstance()
            do {
                try audioSession.setActive(false)
                print("stop!!")
                timePause()


            } catch {
             
            }

        }
        if btn.tag == 2 {
            try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            if (!audioRecorder.isRecording){
                do {
                    try audioPlayer = AVAudioPlayer(contentsOf: audioRecorder.url)
                    audioPlayer.play()
                    print("play!!")
                } catch {
                }
            }

        }
        if btn.tag == 3 {
            if (!audioRecorder.isRecording){
                do {
                    try audioPlayer = AVAudioPlayer(contentsOf: audioRecorder.url)
                    audioPlayer.pause()
                    
                    print("pause!!")
                } catch {
                    
                }
            }
            
            
        }
        if btn.tag == 4 {
            self.dismiss(animated: true, completion: { 
                self.timePause()  // 取消定时器
            })
        }
        
    }
    
    
    //定义并构建一个url来保存音频，音频文件名为ddMMyyyyHHmmss.caf
    func directoryURL() -> NSURL? {
        
        //根据时间设置存储文件名
        let currentDateTime = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "ddMMyyyyHHmmss"
        let recordingName = formatter.string(from: currentDateTime as Date)+".caf"
        print(recordingName)
        
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = urls[0] as NSURL
        //将音频文件名称追加在可用路径上形成音频文件的保存路径
        let soundURL = documentDirectory.appendingPathComponent(recordingName)
        print(soundURL! as NSURL)
        return soundURL as NSURL?
    }
    
    
}

