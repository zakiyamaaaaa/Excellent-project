//
//  UILabelBtmBorder.swift
//  prototype02
//
//  Created by shoichiyamazaki on 2017/04/26.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit
import Foundation

class UILabelBtmBorder: UIView,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
    
    var infoTextField:UITextField!
    var titleLabel:UILabel!
    var title:String = "title"
    var placeholder:String = "入力してください"
    var fieldTag:Int!
    var myPicker:UIPickerView!
    var values = ["あああ","いいい","ううう","えええ","おおお"]
    var values02 = ["かかか","ききき","くくく","けけけ","こここ"]
    var flag:Bool = false
    var activeTextField = UITextField()
    
    //業界
    var interestingJob = ["Sales","Founder","Engineer","Accounting","Plannning","Human Resource","Other"]
    var interestingCategory = ["Law","Education","IT","Public","Finance","Media","Talent","Beauty","Construction","Medical","Other"]
    
    var favoriteFood = ["coffee","sandwitch","chocolate"]
    var unfavoriteFood = ["natto","kimuchi","coconats","dorian"]
    var backgroundItem = ["abc Uni","koko college","abc highschool"]
    var qualification = ["toeic900","eiken","hishokentei","driver licence"]
    //0: Username, 1:興味がある業界,2:興味がある職種,3:好きな食べ物,4:嫌いな食べ物,5:学歴,6:資格
    
    
    
    override func draw(_ rect: CGRect) {
        let bottomBorder = CALayer()
        bottomBorder.borderColor = UIColor.gray.cgColor
        bottomBorder.borderWidth = 2
        self.layer.addSublayer(bottomBorder)
        bottomBorder.frame = CGRect(x: 0, y: self.frame.height - 2, width: self.frame.width, height: 1)
        
        titleLabel = UILabel(frame: CGRect(x: 10, y: 10, width: 100, height: 30))
        titleLabel.font = UIFont.italicSystemFont(ofSize: 13)
        titleLabel.text = title
        titleLabel.textColor = UIColor.lightGray
        
        
        infoTextField = UITextField(frame: CGRect(x: self.center.x - 40, y: 10, width: 200, height: 30))
        infoTextField.delegate = self
        infoTextField.placeholder = placeholder
        
        myPicker = UIPickerView()
        myPicker.delegate = self
        myPicker.dataSource = self
        myPicker.backgroundColor = UIColor.lightGray
        
        self.infoTextField.inputView = myPicker
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 35))
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.done))
        toolBar.setItems([doneItem], animated: true)
        self.infoTextField.inputAccessoryView = toolBar
        
        self.addSubview(titleLabel)
        self.addSubview(infoTextField)
        
//        let notificationCenter = NotificationCenter.default
//        notificationCenter.addObserver(self, selector: #selector(self.handleKeyboardWillShowNotification(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//        
//        notificationCenter.addObserver(self, selector: #selector(self.handleKeyboardWillHiddenNotification(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
    }
    
    func handleKeyboardWillShowNotification(notification:Notification){
        print("show")
        
        
    }
    
    func handleKeyboardWillHiddenNotification(notification:Notification){
        print("hidden")
    }
    
    
    func done(){
        print(self.infoTextField.text)
        self.flag = true
        self.endEditing(true)
    }
    
    func checkFlag()->Bool{
        return flag
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch fieldTag {
        case 0:
            infoTextField.text = values[row]
        case 1:
            infoTextField.text = interestingJob[row]
            
        case 2:
            infoTextField.text = interestingCategory[row]
        case 3:
            infoTextField.text = favoriteFood[row]
        case 4:
            infoTextField.text = unfavoriteFood[row]
        case 5:
            infoTextField.text = backgroundItem[row]
        case 6:
            infoTextField.text = qualification[row]
        default:
            print("hoge")
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch fieldTag {
        case 0:
            return 0
        case 1:
            return interestingJob.count
        case 2:
            return interestingCategory.count
        case 3:
            return favoriteFood.count
        case 4:
            return unfavoriteFood.count
        case 5:
            return backgroundItem.count
        case 6:
            return qualification.count
        default:
            return 0
        }
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch fieldTag {
        case 0:
            return values[row]
        case 1:
            return interestingJob[row]
        case 2:
            return interestingCategory[row]
        case 3:
            return favoriteFood[row]
        case 4:
            return unfavoriteFood[row]
        case 5:
            return backgroundItem[row]
        case 6:
            return qualification[row]
        default:
            return "hoge"
        }
    }
    
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        activeTextField = textField
        if fieldTag == 0{
            self.infoTextField.inputView = nil
        }else{
            
        }
        
        switch fieldTag {
        case 0:
            self.infoTextField.inputView = nil
        case 1:
            self.infoTextField.text = interestingJob[0]
        case 2:
            self.infoTextField.text = interestingCategory[0]
        case 3:
            self.infoTextField.inputView = nil
        case 4:
            self.infoTextField.inputView = nil
        case 5:
            self.infoTextField.inputView = nil
        case 6:
            self.infoTextField.inputView = nil
        default:
            print("hoge")
        }
        
        
        return true
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        infoTextField.resignFirstResponder()
        self.flag = true
        
        return true
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
