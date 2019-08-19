//
//  ViewController.swift
//  Dentakuapp
//
//  Created by 濱田和孝 on 2019/07/12.
//  Copyright © 2019 jon濱田和孝. All rights reserved.

import UIKit
import Foundation

class ViewController: UIViewController {
    
    
    @IBOutlet weak var button_0: UIButton!
    @IBOutlet weak var button_1: UIButton!
    @IBOutlet weak var button_2: UIButton!
    @IBOutlet weak var button_3: UIButton!
    @IBOutlet weak var button_4: UIButton!
    @IBOutlet weak var button_5: UIButton!
    @IBOutlet weak var button_6: UIButton!
    @IBOutlet weak var button_7: UIButton!
    @IBOutlet weak var button_8: UIButton!
    @IBOutlet weak var button_9: UIButton!
    @IBOutlet weak var button_dot: UIButton!
    @IBOutlet weak var button_C: UIButton!
    @IBOutlet weak var button_maipura: UIButton!
    @IBOutlet weak var button_parcent: UIButton!
    @IBOutlet weak var button_divi: UIButton!
    @IBOutlet weak var button_mul: UIButton!
    @IBOutlet weak var button_hiku: UIButton!
    @IBOutlet weak var button_plus: UIButton!
    @IBOutlet weak var button_equal: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
    }
     //” ％ ”ボタンでポップアップ画面を表示させる
    @IBAction func toexplain(_ sender: Any) {
    
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let popupView: ContainerViewController = storyBoard.instantiateViewController(withIdentifier: "popupView") as! ContainerViewController
        popupView.modalPresentationStyle = .overFullScreen
        popupView.modalTransitionStyle = .crossDissolve
        
        self.present(popupView, animated: false, completion: nil)
    }
    
    
 //” . ”ボタンで開発者からのメッセージを表示。
    @IBAction func dotclick(_ sender: Any) {
        let alertController = UIAlertController(
            title:"素晴らしいサプライズを！",
            message:"Just For Your Lover",
            preferredStyle:UIAlertController.Style.alert)
        
        alertController.addAction(
            UIAlertAction(
                title:"OK",
                style:UIAlertAction.Style.default,
                handler:nil))
        
        present(
            alertController,
            animated:true,
            completion:nil)
    }
    
    
    
    
    override func viewDidLayoutSubviews() {
        
        let commonwidth = button_2.frame.size.width * 0.5
        
        //ボタンの大きさは同じなので、定数にしてコードを簡略化。
        button_0.layer.cornerRadius = commonwidth
        button_1.layer.cornerRadius = commonwidth
        button_2.layer.cornerRadius = commonwidth
        button_3.layer.cornerRadius = commonwidth
        button_4.layer.cornerRadius = commonwidth
        button_5.layer.cornerRadius = commonwidth
        button_6.layer.cornerRadius = commonwidth
        button_7.layer.cornerRadius = commonwidth
        button_8.layer.cornerRadius = commonwidth
        button_9.layer.cornerRadius = commonwidth
        button_dot.layer.cornerRadius = commonwidth
        button_C.layer.cornerRadius = commonwidth
        button_mul.layer.cornerRadius = commonwidth
        button_hiku.layer.cornerRadius = commonwidth
        button_maipura.layer.cornerRadius = commonwidth
        button_plus.layer.cornerRadius = commonwidth
        button_parcent.layer.cornerRadius = commonwidth
        button_divi.layer.cornerRadius = commonwidth
        button_equal.layer.cornerRadius = commonwidth
        
    }
    var numberOnScreen:Int = 0//ラベルに表示されている値を格納するための変数。
    var previousNumber:Int = 0//前項の値。
    var performingMath = true //後項の入力を有効にするためのトリガー。
    var operation = 0        //演算子
    var userPreviousNumber:Int = 0
    var userNumberOnScreen:Int = 0
    var tyukei :String!
    var tyukeihensu: String!
    
  
    @IBOutlet weak var label: UILabel! //入力値、演算子、計算結果やメッセージを表示する。
    
    //設定画面でせユーザーが設定した値を、このクラスで受け取るための変数。
    var receiveZonko  : Int?
    var receiveEnzan : String?
    var receiveKouko : Int?
    var receiveMessege : String?
    var receiveEnzanTag : Int?
    
    
    @IBAction func numbers(_ sender: UIButton) {
        //機能簡略化のために、7桁以上の入力を受け付けない。
        if numberOnScreen > 999999 {
            return
        }
        if performingMath == true{//１桁目の数値入力が０の時は、受け付けない。
            if sender.tag == 1{
                return
            }
            label.text = String(sender.tag-1)
            numberOnScreen = Int(label.text!)!
            performingMath = false
        }
        else{//2桁目以降の入力
            label.text = label.text! + String(sender.tag-1)
            numberOnScreen = Int(label.text!)!
        }
    }
    
    
    //演算子ボタンのテキストと背景の色を変える。
    func changeTextAndBackColer(Enzan:UIButton) -> Void {
        Enzan.setTitleColor(UIColor.orange, for: .normal)
        Enzan.backgroundColor = UIColor(red:1.0, green:1.0, blue:1.0, alpha:0.95)
    }
    
    
    //全ての演算子ボタンのテキストと背景の色を元の配色に戻す。
    //changeTextAndBackColer()とchangeAllEnzanColor()を用いて、iphoneの電卓のアクションを表現している。
    //ボタン押下時にボタンが光るメソッドがあったが期待していたものではなかったのでこちらを採用。
    func changeAllEnzanColor(){
        button_plus.backgroundColor = UIColor(red:1.0, green:147/255, blue:0, alpha:1.0)
        button_hiku.backgroundColor = UIColor(red:1.0, green:147/255, blue:0, alpha:1.0)
        button_mul.backgroundColor = UIColor(red:1.0, green:147/255, blue:0, alpha:1.0)
        button_divi.backgroundColor = UIColor(red:1.0, green:147/255, blue:0, alpha:1.0)
        
        button_plus.setTitleColor(UIColor.white, for: .normal)
        button_hiku.setTitleColor(UIColor.white, for: .normal)
        button_mul.setTitleColor(UIColor.white, for: .normal)
        button_divi.setTitleColor(UIColor.white, for: .normal)
        
    }
    //演算子、C、＝、が接続されている。
    @IBAction func buttons(_ sender: UIButton) {
        if label.text != "" && sender.tag != 11 && sender.tag != 16 {
            
            previousNumber = Int(label.text!)! //前項を生成する。
            numberOnScreen = 0 //値入力部に表示されている文字が０にする。次に入力される数値は「後項」になる。
            
            //演算子ボタンを押下したら全ての演算子ボタンの配色が初期値に戻る。
           if sender.tag == 12||sender.tag ==  13||sender.tag == 14||sender.tag == 15{
            changeAllEnzanColor() //演算子の色を全てリセット
            }
            
            //演算子ボタンが押下されるとその演算子ボタンの配色が変化。
            if sender.tag == 12{
                
            changeTextAndBackColer(Enzan: button_divi)
        
            }
            else if sender.tag == 13{
            changeTextAndBackColer(Enzan: button_mul)

            }
            else if sender.tag == 14{
            changeTextAndBackColer(Enzan: button_hiku)
                
            }
            else if sender.tag == 15{
            changeTextAndBackColer(Enzan: button_plus)
                
            }
            operation = sender.tag //演算子を格納。
            performingMath = true //performingMathを元に戻す。後項入力時の１桁目の入力処理に繋がる。
        }
            
            //" = "の時。
        else if sender.tag == 16
        {
            
            if receiveEnzan == "÷" {receiveEnzanTag = 12}
            else if receiveEnzan == "×" {receiveEnzanTag = 13}
            else if receiveEnzan == "-" {receiveEnzanTag = 14}
            else if receiveEnzan == "+" {receiveEnzanTag = 15}
            
            //もし計算する、前項、演算子、後項が、ユーザーが設定した値と等しいのならば、設定されたメッセージを表示する。
            if previousNumber == receiveZonko && operation == receiveEnzanTag && numberOnScreen == receiveKouko {
                label.font = label.font.withSize(70)
                label.text = receiveMessege
                
            }
                
            else {
                
             if operation == 12{
                label.text = String(previousNumber / numberOnScreen)
             }
             else if operation == 13{
                label.text = String(previousNumber * numberOnScreen)
             }
             else if operation == 14{
                label.text = String(previousNumber - numberOnScreen)
             }
             else if operation == 15{
               label.text = String(previousNumber + numberOnScreen)
             }
            
            }
            
            changeAllEnzanColor() //演算子の色を全てリセット
            
            
        }
            //” C ”クリアボタンの時。
        else if sender.tag == 11{
            label.text = "0"
            previousNumber = 0
            numberOnScreen = 0
            operation = 0
            performingMath = true
        }
      
        
    }
    
  

}

