//
//  RegisterViewController02.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/06/07.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class RegisterViewController02: UIViewController,UITextFieldDelegate,UIScrollViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet weak var myScrollView: UIScrollView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var sexSegmentedControl: UISegmentedControl!
    @IBOutlet weak var belongingTextFiled: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var nextButton: RectButton!
    @IBOutlet weak var nextButtonUnderLabel: UILabel!
    
    var tappedTextField:UITextField!
    var originalY:CGFloat = 0
    
    let thisYear = 2017
    var userInfo:UserInfo = UserInfo()
    var udSetting:UserDefaultSetting02 = UserDefaultSetting02()
    
    //picker
    var agePicker:UIPickerView!
    var ageDataSource:[String] = [String]()
    var doneButton:UIButton!
    var toolBar:UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //dataのInitialSetting
        udSetting.initialize()
        udSetting.save(key: .uuid, value: "hoge")
        userInfo.uuid = udSetting.read(key: .uuid)
        //segment ctr初期値
        userInfo.sex = "female"
        
        //SegmentedControl setting
        sexSegmentedControl.addTarget(self, action: #selector(self.sexValueChanged(seg:)), for: UIControlEvents.valueChanged)
        
        
        //button
        nextButton.isUserInteractionEnabled = false
        nextButton.isEnabled = false
        nextButton.alpha = 0.5
        
        //delegate先の設定
        myScrollView.delegate = self
        nameTextField.delegate = self
        belongingTextFiled.delegate = self
        ageTextField.delegate = self
        
        
        //keyboardのイベント通知
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShown(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
        //age のpickerの設定
        agePicker = UIPickerView()
        agePicker.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 150)
        agePicker.delegate = self
        agePicker.dataSource  = self
        agePicker.isUserInteractionEnabled = true
        ageTextField.inputView = agePicker
        
        
        for i in 18 ... 80{
            ageDataSource.append("\(thisYear - i)年生まれ(\(i)歳)")
        }
        
        //pickerのツールバー設定
        toolBar = UIToolbar(frame: CGRect(x: 0, y: 30, width: self.view.frame.width, height: 30))
        toolBar.barStyle = .blackTranslucent
        toolBar.tintColor = UIColor.white
        let closeButton = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(self.resignAgeField(sender:)))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolBar.items = [flexible,closeButton]
        ageTextField.inputAccessoryView = toolBar
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Sex SegmentedControl Value Changed
    func sexValueChanged(seg:UISegmentedControl){
        
        switch seg.selectedSegmentIndex {
        case 0:
            print(seg.titleForSegment(at: 0)!)
            userInfo.sex = "female"
        case 1:
            print(seg.titleForSegment(at: 1)!)
            userInfo.sex = "male"
        default:
            break
        }
    }
    
    func resignAgeField(sender:UIBarButtonItem){
        
        ageTextField.resignFirstResponder()
    }
    
    //★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
    //pickerメソッド
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ageDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ageDataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(ageDataSource[row])
        ageTextField.text = ageDataSource[row]
        userInfo.age = renameAge(selectedAge: ageDataSource[row])
        
    }
    
    func renameAge(selectedAge:String)->String{
        let startIndex = selectedAge.index(selectedAge.endIndex, offsetBy: -4)
        let endIndex = selectedAge.index(selectedAge.endIndex, offsetBy: -2)
        let range = startIndex..<endIndex
        
        let subString = selectedAge.substring(with: range)
        return subString
    }
    
    
    
    //★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
    //Textfield
    
    //テキストフィールドが開かれるとき-------------------------------------------
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        tappedTextField = textField
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == nameTextField && textField.text?.isEmpty == false{
            userInfo.userName = textField.text!
        }
        
    }
    
    //Returnキーが押されたとき-------------------------------------------
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case nameTextField:
            print("name")
            userInfo.userName = textField.text!
        case ageTextField:
            break
//            print("age")
//            userInfo.age = textField.text!
        case belongingTextFiled:
            print("belonging")
            userInfo.belonging = textField.text!
        default:
            break
        }
        
        if userInfo.checkValue(){
            self.nextButton.isEnabled = true
            self.nextButton.isUserInteractionEnabled = true
            self.nextButton.alpha = 1
        }
        
        textField.resignFirstResponder()
        return true
    }
    
    //キーボードが開かれるとき-------------------------------------------
    func keyboardWillShown(notification:Notification){
        let userInfo = notification.userInfo!
        let keyboardScreenEndFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue
        
        let myBoundSize:CGSize = UIScreen.main.bounds.size
        
        let txtLimit = tappedTextField!.superview!.frame.origin.y + tappedTextField!.frame.height + 80
        let kbdLimit = myBoundSize.height - keyboardScreenEndFrame.cgRectValue.size.height
        print("テキストフィールドの下辺：(\(txtLimit))")
        print("キーボードの上辺：(\(kbdLimit))")
        originalY = myScrollView.contentOffset.y
        if txtLimit >= kbdLimit{
            myScrollView.contentOffset.y = txtLimit - kbdLimit + 50
            
        }
        self.view.isUserInteractionEnabled = true
    }
    
    
    //キーボードが閉じるとき-------------------------------------------
    func keyboardWillHidden(notification:Notification){
        
        myScrollView.contentOffset.y = originalY
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        udSetting.save(key: .age, value: userInfo.age)
        udSetting.save(key: .username, value: userInfo.userName)
        udSetting.save(key: .sex, value: userInfo.sex)
        udSetting.save(key: .belonging, value: userInfo.belonging)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
