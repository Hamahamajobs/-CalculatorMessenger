//
//  ViewController.swift
//  Dentakuapp
//
//  Created by 濱田和孝 on 2019/07/12.
//  Copyright © 2019 jon濱田和孝. All rights reserved.
//

import UIKit
import Foundation
//import SwiftKickMobile

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
 // ポップアップを表示がタップされた時
 
   
    @IBAction func toexplain(_ sender: Any) {
    
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let popupView: ContainerViewController = storyBoard.instantiateViewController(withIdentifier: "popupView") as! ContainerViewController
        popupView.modalPresentationStyle = .overFullScreen
        popupView.modalTransitionStyle = .crossDissolve
        
        self.present(popupView, animated: false, completion: nil)
        
 
        
     
        
    }

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
        
        let party = button_2.frame.size.width * 0.5
        
        // button_0.layer.masksToBounds = true
        button_0.layer.cornerRadius = party
        button_1.layer.cornerRadius = party
        button_2.layer.cornerRadius = party
        button_3.layer.cornerRadius = party
        button_4.layer.cornerRadius = party
        button_5.layer.cornerRadius = party
        button_6.layer.cornerRadius = party
        button_7.layer.cornerRadius = party
        button_8.layer.cornerRadius = party
        button_9.layer.cornerRadius = party
        button_dot.layer.cornerRadius = party
        button_C.layer.cornerRadius = party
        button_mul.layer.cornerRadius = party
        button_hiku.layer.cornerRadius = party
        button_maipura.layer.cornerRadius = party
        button_plus.layer.cornerRadius = party
        button_parcent.layer.cornerRadius = party
        button_divi.layer.cornerRadius = party
        button_equal.layer.cornerRadius = party
        
    }
    var numberOnScreen:Int = 0 //値部の数値。計算時にはこれが後項になる。これをキャストしで値げをゲットしている
    var previousNumber:Int = 0//前項の値
    var performingMath = true //後項の入力を有効にするための仕組み。
    var operation = 0
    var userPreviousNumber:Int = 0
    var userNumberOnScreen:Int = 0
    var tyukei :String!
    var tyukeihensu: String!
    
  
    @IBOutlet weak var label: UILabel! //入力値、演算子、計算結果やメッセージを表示する。
    
    var receiveZonko  : Int?
    var receiveEnzan : String?
    var receiveKouko : Int?
    var receiveMessege : String?
    var receiveEnzanTag : Int?
    
    
    @IBAction func numbers(_ sender: UIButton) {
        if numberOnScreen > 999999 {
            return
        }
        if performingMath == true{//後項の一桁目はこっちが処理される。
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
    
    
    func changeTextAndBackColer(Enzan:UIButton) -> Void {

        Enzan.setTitleColor(UIColor.orange, for: .normal)
    //    Enzan.backgroundColor = UIColor.orange
        Enzan.backgroundColor = UIColor(red:1.0, green:1.0, blue:1.0, alpha:0.95)
        
    }
    
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
    
    @IBAction func buttons(_ sender: UIButton) { //ダグ名に関わらず、 func buttons にグループ付されたボタンがアクションされたら実行される。
        if label.text != "" && sender.tag != 11 && sender.tag != 16 { //もし前項作成前に値部に入力値があれば、それを「前項」に代入する。
            //１６ってなんだっけ？
            previousNumber = Int(label.text!)!//アンラップしたやつをアンアップする？
            numberOnScreen = 0
            
            //演算子を押下したら全てのボタンの配色が初期値に戻る。
           if sender.tag == 12||sender.tag ==  13||sender.tag == 14||sender.tag == 15{
            changeAllEnzanColor() //演算子の色を全てリセット　→リセットしたのちに押下された演算子の色を変化させる。
            }
            
            //演算子が押下されると配色が変化
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
            operation = sender.tag //演算子をに、実行する演算子を入力している。
            performingMath = true //後項を入力するためにブール型トリガーをリセット。
        }
            
            
        else if sender.tag == 16
        {
            
            if receiveEnzan == "÷" {receiveEnzanTag = 12}
            else if receiveEnzan == "×" {receiveEnzanTag = 13}
            else if receiveEnzan == "-" {receiveEnzanTag = 14}
            else if receiveEnzan == "+" {receiveEnzanTag = 15}
            
            
            if previousNumber == receiveZonko && operation == receiveEnzanTag && numberOnScreen == receiveKouko { //ここに設定内容と同じだった時の処理を書く。
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
        else if sender.tag == 11{
            label.text = "0"
            previousNumber = 0
            numberOnScreen = 0
            operation = 0
            performingMath = true
        }
      
        
    }
    
  

}

