//
//  TagTestViewController.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/05/16.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class TagTestViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var myView: UIView!
    var myLabel:UILabel = UILabel()
    var myLabelText:[String] = []
    var myButtonList:[UIButton] = []
    @IBOutlet weak var myTextField: UITextField!
    var myButton:UIButton!
    var closeButton:UIButton!
    var labelList:[UILabel] = []
    
    @IBOutlet weak var bbb: UIButton!
    var i:Int?
    var num:[Int:Int] = [:]
    var labelList02:[UILabel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton()
        button.frame.size = CGSize(width: 50, height: 50)
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        button.backgroundColor = UIColor.green
        
        let button01 = UIButton()
        button01.frame.size = CGSize(width: 50, height: 50)
        button01.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        button01.backgroundColor = UIColor.red
        
        let button02 = UIButton()
        
        
        let contentView = UIView(frame: CGRect(x: self.view.center.x, y: self.view.center.y, width: 300, height: 300))
        contentView.backgroundColor = UIColor.yellow
        self.view.addSubview(contentView)
        contentView.addSubview(button01)
        contentView.addSubview(button)
        
        
        
//        let bottomBorder = CALayer()
//        bottomBorder.borderColor = UIColor.gray.cgColor
//        bottomBorder.borderWidth = 2
//        bottomBorder.frame = CGRect(x: 0, y: myView.frame.height - 2, width: myView.frame.width, height: 2)
//        
//        myView.layer.addSublayer(bottomBorder)
//        myTextField.delegate = self
//        
//        let inputView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100))
//        inputView.backgroundColor = UIColor.gray
//        
//        myButton = UIButton(frame: CGRect(x: 250, y: 50, width: 100, height: 50))
//        myButton.backgroundColor = UIColor.yellow
//        myButton.titleLabel?.text = "Add"
//        
//        myButton.titleLabel?.textColor = UIColor.black
//        myButton.addTarget(self, action: #selector(self.addLabel(sender:)), for: UIControlEvents.touchUpInside)
//        
//        inputView.addSubview(myButton)
//        closeButton = UIButton(frame: CGRect(x: 0, y: 70, width: 100, height: 30))
//        closeButton.backgroundColor = UIColor.white
//        closeButton.titleLabel?.text = "Close"
//        closeButton.addTarget(self, action: #selector(self.close(sender:)), for: UIControlEvents.touchUpInside)
//        
//        inputView.addSubview(closeButton)
//        myTextField.inputView = inputView
//        myLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
//        myLabel.backgroundColor = UIColor.gray
////        myView.addSubview(myLabel)
//        num = [0:0,1:0,2:0,3:0,4:0,5:0]
//        
//        
//        labelList02.append(UILabel())
//        labelList02.append(UILabel())
//        labelList02.append(UILabel())
//        var i = 0
//        for la in labelList02{
//            
//            la.text = "hoge\(i)"
//            la.sizeToFit()
//            la.frame.origin = CGPoint(x: 100*CGFloat(i), y: 50)
//            la.backgroundColor = UIColor.blue
//            self.view.addSubview(la)
//            i += 1
//            
//        }
        
        // Do any additional setup after loading the view.
    }
    
    
//    func addLabel(sender:UIButton){
//        print("add Label")
//        let txt = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
//        txt.text = "hoge"
//        txt.backgroundColor = UIColor.blue
//        myTextField.addSubview(txt)
//    }
//
//    func close(sender:UIButton){
//        myTextField.resignFirstResponder()
//    }
//    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    let labelTitle = ["Bacon","Humburguer","potato","naget","choco","cheese"]
//    
//    func addTag(senderTag:Int){
//        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
//        label.backgroundColor = UIColor.red
//        label.text = labelTitle[senderTag]
//        label.sizeToFit()
//        num[senderTag] = labelList.count
//        label.tag = senderTag
//        labelList.append(label)
//    }
//    
//    var rightEdge:CGFloat = 0
//    
//    func update(senderTag:Int){
//
//        var pointX:CGFloat = 0
//        for label in labelList{
//            
//            UIView.animate(withDuration: 0.3, animations: {
//                label.frame.origin.x = pointX
//                pointX = label.frame.origin.x + label.frame.width
//                self.myView.addSubview(label)
//            })
//            
//        }
//        
//    }
//    
//    func removeTag(senderTag:Int,senderOrder:Int){
//        
//        let firstLabelOriginX = labelList.first?.frame.origin.x
//        
//        switch labelList.count {
//        case 1:
//            print(1)
//        case 2:
////            labelList.last?.frame.origin.x = firstLabelOriginX!
//            
//            if senderOrder == 0{
//                num[labelList.last!.tag] = 0
//            }
//            
//            print(2)
//        case 3:
//            print(3)
//            
//            switch senderOrder{
//            case 0:
//                num[labelList[1].tag] = 0
//                num[labelList[2].tag] = 1
//            case 1:
//                num[labelList[2].tag] = 1
//            default:
//                print("aa")
//            }
//        default:
//            print("default")
//        }
//        labelList[senderOrder].removeFromSuperview()
//        labelList.remove(at: senderOrder)
//    }
//    
//    
//    @IBAction func baconButtonTapped(_ sender: flagButton) {
//        
//        sender.flag = !sender.flag
//        sender.tag = 0
//        if sender.flag{
//            addTag(senderTag: sender.tag)
//            
//        }else{
//
//            removeTag(senderTag:sender.tag,senderOrder: num[sender.tag]!)
//        }
//        update(senderTag: sender.tag)
//    }
//    
//
//    
//    @IBAction func HumbergurButtonTapped(_ sender: flagButton) {
//        sender.flag = !sender.flag
//        sender.tag = 1
//        if sender.flag{
//            addTag(senderTag: sender.tag)
//            
//        }else{
//            removeTag(senderTag:sender.tag,senderOrder:num[sender.tag]!)
//        }
//        update(senderTag: sender.tag)
//        
//    }
//    @IBAction func potatoButtonTapped(_ sender: flagButton) {
//        sender.flag = !sender.flag
//        sender.tag = 2
//        if sender.flag{
//            addTag(senderTag: sender.tag)
//            
//        }else{
//            
//            removeTag(senderTag:sender.tag,senderOrder: num[sender.tag]!)
//        }
//        update(senderTag: sender.tag)
//    }
//
//    @IBAction func nagetButtonTapped(_ sender: flagButton) {
//        sender.flag = !sender.flag
//        sender.tag = 3
//        if sender.flag{
//            addTag(senderTag: sender.tag)
//            
//        }else{
//            
//            removeTag(senderTag:sender.tag,senderOrder: num[sender.tag]!)
//        }
//        update(senderTag: sender.tag)
//    }
//    @IBAction func colaButtonTapped(_ sender: flagButton) {
//        sender.flag = !sender.flag
//        sender.tag = 4
//        if sender.flag{
//            addTag(senderTag: sender.tag)
//        }else{
//            
//            removeTag(senderTag:sender.tag,senderOrder: num[sender.tag]!)
//        }
//        update(senderTag: sender.tag)
//        
//    }
//    @IBAction func cheeseButtonTapped(_ sender: flagButton) {
//        sender.flag = !sender.flag
//        
//        sender.tag = 5
//        if sender.flag{
//            addTag(senderTag: sender.tag)
//            
//        }else{
//            
//            removeTag(senderTag:sender.tag,senderOrder: num[sender.tag]!)
//        }
//        update(senderTag: sender.tag)
//    }
//    
//    
//    
//    func addLabel(key:String)->UILabel{
//        
//        let nextLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
//        nextLabel.text = key
//        nextLabel.sizeToFit()
//        nextLabel.backgroundColor = UIColor.red
//        
//        labelList.append(nextLabel)
//        nextLabel.tag = labelList.count
//        
//        if let lastLabel = myView.subviews.last{
//            
//                nextLabel.frame.origin.x = lastLabel.center.x + lastLabel.frame.width/2 + 20
//        }
//        myView.addSubview(nextLabel)
//        
//        return nextLabel
//    }
//    @IBAction func write(_ sender: Any) {
//        let array = ["aaa","bbb","ccc"]
//        let ud = UserDefaults.standard
//        ud.set(array, forKey: "array")
//    }
//    
//    @IBAction func Read(_ sender: Any) {
//        let ud = UserDefaults.standard
//        print(ud.string(forKey: "array"))
//    }
//    
////    func removeLabel(target:UILabel){
////        
////        
////        labelList.removeLast()
////        target.removeFromSuperview()
////        print("tag:\(target.tag)+\(myView.subviews)")
////    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
