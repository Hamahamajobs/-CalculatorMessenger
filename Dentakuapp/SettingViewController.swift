//
//  SettingViewController.swift
//  Dentakuapp
//
//  Created by 濱田和孝 on 2019/07/22.
//  Copyright © 2019 jon濱田和孝. All rights reserved.
//

import UIKit
import Foundation


class SettingViewController: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource {
    
    var pickerView:UIPickerView = UIPickerView()
    
    
    let list = ["", "+","-","×","÷"]
 
    @IBOutlet weak var userZenko: UITextField!
    @IBOutlet weak var userEnzan: UITextField!
    @IBOutlet weak var userMessege: UITextField!
    @IBOutlet weak var userKouko: UITextField!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            return //これはお約束分かな？guard分を使って「セグエがなかったときはリターンを返してね」と指示している。
            
            
        }
        
        if(identifier == "segueUserSetting"){ //ここで設定画面でユーザーがあ入力する値を電卓画面上の変数に代入している。これできちんと値渡しができているはず。
            
            let viewcontroller = segue.destination as! ViewController
           viewcontroller.receiveEnzan = self.userEnzan.text
            
           viewcontroller.receiveZonko = Int(self.userZenko.text!)
            
            viewcontroller.receiveKouko = Int(self.userKouko.text!)
            
            viewcontroller.receiveMessege = self.userMessege.text
            
            
            
        }
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        self.userZenko.keyboardType = UIKeyboardType.numberPad
        self.userKouko.keyboardType = UIKeyboardType.numberPad
       // label.text = "乃木坂46\n十四福神"
        
        
       // .inputView = UIDatePicker()
        // DatePickerの設定(日付用)
        
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.showsSelectionIndicator = true
        
        
        let toolbar = UIToolbar(frame: CGRectMake(0, 0, 0, 35))
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(SettingViewController.done))
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(SettingViewController.cancel))
        toolbar.setItems([cancelItem, doneItem], animated: true)
        
        self.userEnzan.inputView = pickerView
        self.userEnzan.inputAccessoryView = toolbar
        
          //メッセージへのプレースホルダーの付与
        userMessege.attributedPlaceholder = NSAttributedString(string: "10文字以内", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        userEnzan.attributedPlaceholder = NSAttributedString(string: "+,-,×,÷", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        userZenko.attributedPlaceholder = NSAttributedString(string: "1~999999", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        userKouko.attributedPlaceholder = NSAttributedString(string: "1~999999", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       // userEnzan.text = list[row]
        self.userEnzan.text = list[row]
    }
    
    @objc func cancel() {
        self.userEnzan.text = ""
        self.userEnzan.endEditing(true)
    }
    
    @objc func done() {
        self.userEnzan.endEditing(true)
    }
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    var maxLength: Int = 10
    // 適当な所でこのターゲットアクションを設定してください。
    func textFieldEditingChanged(userMessege: UITextField) {
        guard let text = userMessege.text else { return }
        userMessege.text = String(text.prefix(maxLength))
    }
    
    
  
 
    }
    
    

    

