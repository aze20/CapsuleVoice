//
//  CVReviseNameViewController.swift
//  CapsuleVoice
//
//  Created by 5i84 on 2017/6/14.
//  Copyright © 2017年 LiJingZe. All rights reserved.
//

import UIKit

class CVReviseNameViewController: UIViewController,UITextFieldDelegate {

    typealias clickAlertClosure = (_ title: String) -> Void //声明闭包，点击按钮传值
    //把申明的闭包设置成属性
    var clickClosure: clickAlertClosure?
    //为闭包设置调用函数
    func clickIndexClosure(_ closure:clickAlertClosure?){
        //将函数指针赋值给myClosure闭包
        clickClosure = closure
    }
    var userName = ""
    @IBOutlet var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        textField.text = userName

    }
    
    @IBAction func doneBtnClick(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
        if (self.clickClosure != nil) {
            self.clickClosure!(self.userName)
        }

    }
    @IBAction func cancleBtnClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        print("发起请求,输入框内容为:"+"\(newText)")
        self.userName = newText
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
