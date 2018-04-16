//
//  CVCustomPickView.swift
//  CapsuleVoice
//
//  Created by 5i84 on 2017/6/14.
//  Copyright © 2017年 LiJingZe. All rights reserved.
//

import UIKit

class CVCustomPickView: UIView ,UIPickerViewDelegate, UIPickerViewDataSource{
    
    typealias clickAlertClosure = (_ title: String) -> Void //声明闭包，点击按钮传值
    //把申明的闭包设置成属性
    var clickClosure: clickAlertClosure?
    //为闭包设置调用函数
    func clickIndexClosure(_ closure:clickAlertClosure?){
        //将函数指针赋值给myClosure闭包
        clickClosure = closure
    }
    
    private let pickerView = UIPickerView()
    private var result = ""
    private var array = ["男","女"]
    private let bgWhiteView = UIView()
    private let doneBtn = UIButton()

    //用代码创建的时候会进入这个init函数体
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        self.backgroundColor = UIColor.withRGBA(0, 0, 0, 0.5)

        bgWhiteView.backgroundColor = .white
        self.addSubview(bgWhiteView)
        bgWhiteView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(200)
        }
        
        let topView = UIView()
        topView.backgroundColor = UIColor.groupTableViewBackground
        bgWhiteView.addSubview(topView)
        topView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(bgWhiteView)
            make.height.equalTo(40)
        }
        
        doneBtn.setTitleColor(MainColor, for: .normal)
        doneBtn.setTitle("完成", for: .normal)
        doneBtn.addTarget(self, action: #selector(self.hidden), for: .touchUpInside)
        topView.addSubview(doneBtn)
        doneBtn.snp.makeConstraints { (make) in
            make.top.right.equalTo(bgWhiteView)
            make.size.equalTo(CGSize(width: 60, height: 40))
        }
        
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = .white
        pickerView.selectRow(0,inComponent:0,animated:true)
        bgWhiteView.addSubview(pickerView)
        pickerView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(bgWhiteView)
            make.top.equalTo(doneBtn.snp.bottom)
        }
    }
    
    
    //设置选择框的列数为1列,继承于UIPickerViewDataSource协议
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //设置选择框的行数为2行，继承于UIPickerViewDataSource协议
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return array.count
    }
    
    //设置选择框各选项的内容，继承于UIPickerViewDelegate协议
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return array[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(array[row])
        result = array[row]
    }

    
    func show(){
        let wind = UIApplication.shared.keyWindow
        self.alpha = 0
        wind?.addSubview(self)
        UIView.animate(withDuration: 0.25, animations: { () -> Void in
            self.alpha = 1
        })
    }

    func hidden(){
        UIView.animate(withDuration: 0.25, animations: { () -> Void in
            self.alpha = 0
        }, completion: { (finish) -> Void in
            if finish {
                self.removeFromSuperview()
                if (self.clickClosure != nil) {
                    self.clickClosure!(self.result)
                }
            }
        })
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
