//
//  CVAddCapsuleViewController.swift
//  CapsuleVoice
//
//  Created by 5i84 on 2017/6/21.
//  Copyright © 2017年 LiJingZe. All rights reserved.
//


//MARK: - LifeCycle

//MARK: - UITableViewDelegate & DataSource

//MARK: - CustomDelegate

//MARK: - Event response

//MARK: - Request Data

//MARK: - Prive methods

import UIKit
import AVFoundation

class CVAddCapsuleViewController: UIViewController {
    @IBOutlet var addBtn: UIButton!
    @IBOutlet var timerLabel: UILabel!
        
    var audioRecorder:AVAudioRecorder!
    var audioPlayer:AVAudioPlayer!
    var timer:Timer?
    var a = 0.0
    var demoView : CVLayerView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "添加胶囊"
        addBtn.layer.cornerRadius = 40
        timerLabel.text = "00:00:00"
        // 图层动画
        demoView = CVLayerView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_WIDTH))
        demoView.center = CGPoint(x: SCREEN_WIDTH/2, y:SCREEN_HEIGHT-45-40)

        self.view.insertSubview(demoView, belowSubview: addBtn)
   
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
        
        
    }

    @IBAction func btnClick(_ sender: UIButton) {
        if sender.tag == 11 {
            self.timePause()  // 取消定时器
            self.dismiss(animated: true, completion: nil)
        }else if sender.tag == 22{
            //wancheng
        }else{
             sender.isSelected = !sender.isSelected
            if sender.isSelected {
                demoView.starAnimation()
                addBtn.setImage(UIImage(named:"录音"), for: .normal)

            }else{
                demoView.stopAnimation()
                addBtn.setImage(UIImage(named:"关闭麦克风"), for: .normal)
            }
//            //开始录音
//            if !audioRecorder.isRecording {//判断是否正在录音状态
//                let audioSession = AVAudioSession.sharedInstance()
//                do {
//                    try audioSession.setActive(true)
//                    audioRecorder.record()
//                    print("record!")
//                    // 启用计时器
//                    timeStart()
//    
//                } catch {
//                }
//            }
//        
            
        }
        
    }

    
    
    func timeStart() {
        if !(timer != nil) {
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timerIntervalx), userInfo: nil, repeats: true)
        }
    }
    
    func timerIntervalx() {
        a+=0.01
        timerLabel?.text = self.formatLongToTimeStr(l: a) //"时长: \(a)s"
    }
    func timePause() {
        timer?.invalidate()
        timer = nil
    }
    
    func btnClic1k(_ btn : UIButton){

        if btn.tag == 1 { //结束
            audioRecorder.stop()
            let audioSession = AVAudioSession.sharedInstance()
            do {
                try audioSession.setActive(false)
                print("stop!!")
                timePause()
            } catch {
                
            }
            
        }
        if btn.tag == 2 { // 播放
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
        if btn.tag == 3 { //暂停
            if (!audioRecorder.isRecording){
                do {
                    try audioPlayer = AVAudioPlayer(contentsOf: audioRecorder.url)
                    audioPlayer.pause()
                    print("pause!!")
                } catch {
                    
                }
            }

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
    
    
    // 转换秒数
    func formatLongToTimeStr(l : Double) -> String {
        
        var hour = 0
        var minute = 0
        var second = 0
        
        second = Int(l) / 1000
        
        if (second > 60) {
            minute = second / 60
            second = second % 60
        }
        if (minute > 60) {
            hour = minute / 60
            minute = minute % 60
        }
        
        return "\(getTwoLength(data: hour)):\(getTwoLength(data: minute)):\(getTwoLength(data: second))"
    }
    
    func getTwoLength(data : Int) -> String {
        if(data < 10) {
            return "0\(data)"
        } else {
            return "\(data)"
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

