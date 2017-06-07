//
//  RegisterViewController.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/05/13.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController,UITextFieldDelegate,UIScrollViewDelegate {

    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var userNameSection: UIView!
    
    
    @IBOutlet weak var jobErrorMessage: UILabel!
    @IBOutlet weak var jobTextField: UITextField!
    @IBOutlet weak var backgroundSection: UIView!
    @IBOutlet weak var qualificationSection: UIView!
    
    var infoTextField:UITextField!
    var titleLabel:UILabel!
    var titleList = ["名前(必須)","学校","資格"]
    var jobTitleList = ["気になる業界","気になる業種"]
    var keyList = ["uuid","username","background","qualification"]
    var fieldList:[UIView]!

    var answerList01:[String:Any] = [String:Any]()
    let udSetting:UserDefaultSetting = UserDefaultSetting()
    
    var originalY:CGFloat = 0
    var activeTextField:UITextField?
    var jobCategoryList:[String] = jobTagTitleList.init().industry
    var jobTypeList:[String] = jobTagTitleList.init().occupation
    
    var jobInputView:UIScrollView!
    var selectedTagList:[flagButton] = []
    var selectedTagInfo:[[jobTagType:String]]?
    var num:[Int:Int] = [:]
    let tagLabelFontSize:CGFloat = 14
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        udSetting.initialize()
        udSetting.save(key: .uuid, value: "hoge")
        _ = udSetting.returnSetValue()
        
        jobErrorMessage.alpha = 0
        answerList01 = udSetting.returnSetValue()
        
        fieldList = [userNameSection,backgroundSection,qualificationSection]
        
        
        for i in 0 ..< jobCategoryList.count + jobTypeList.count - 1{
            num[i] = 0
        }
        
        
        for (index,field) in fieldList.enumerated(){

            field.tag = index
            sectionDesigned(target: field)
        }
        jobTextField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShown(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        scrollView.delegate = self
        
        jobInputView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200))
        jobInputView.contentSize = CGSize(width: self.view.frame.width, height: 500)

        
        let tagButtonHeight:CGFloat = 40
        let inputViewLabel01 = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: tagButtonHeight))
        let inputViewLabel02 = UILabel(frame: inputViewLabel01.frame)
        inputViewLabel01.backgroundColor = UIColor(white: 0.9, alpha: 1)
        inputViewLabel01.textAlignment = NSTextAlignment.center
        inputViewLabel02.backgroundColor = UIColor(white: 0.9, alpha: 1)
        inputViewLabel02.textAlignment = NSTextAlignment.center
        inputViewLabel01.text = jobTitleList[0]
        inputViewLabel02.text = jobTitleList[1]
        inputViewLabel01.center.x = jobInputView.center.x
        inputViewLabel02.center.x = jobInputView.center.x
        jobInputView.addSubview(inputViewLabel01)
        
        createTagButton(originY: inputViewLabel01.frame.height,list:jobCategoryList, type: .industry)
        
        guard let lastItem = jobInputView.subviews.last else { return }
        let lastHeight = lastItem.frame.origin.y + lastItem.frame.height
        inputViewLabel02.frame.origin.y = lastHeight + 20
        jobInputView.addSubview(inputViewLabel02)
        let y = inputViewLabel02.frame.origin.y + inputViewLabel02.frame.height
        
        createTagButton(originY: y, list: jobTypeList, type: .occupation)
        
        jobInputView.backgroundColor = UIColor.white
        jobInputView.isOpaque = false
        jobTextField.inputView = jobInputView
        
        //jobTagviewにつける完了ボタン（上）
        let doneButton = UIButton(frame: CGRect(x: jobInputView.frame.width - 50, y: 0, width: 50, height: tagButtonHeight))
        doneButton.titleLabel?.textAlignment = NSTextAlignment.right
        doneButton.setTitle("完了", for: UIControlState.normal)
        doneButton.backgroundColor = UIColor(white: 0.7, alpha: 1)
        doneButton.addTarget(self, action: #selector(self.closeField(sender:)), for: UIControlEvents.touchUpInside)
        doneButton.setTitleColor(UIColor.blue, for: UIControlState.normal)
        
        let last = jobInputView.subviews.last
        let scrollEdgeY = last!.frame.origin.y + last!.frame.height + tagButtonHeight
        jobInputView.contentSize.height = scrollEdgeY
        
        //jobTagviewにつける完了ボタン（下）
        let doneButtonEdge = UIButton(frame: doneButton.frame)
        doneButtonEdge.frame.origin = CGPoint(x: doneButton.frame.origin.x, y: scrollEdgeY - tagButtonHeight)
        doneButtonEdge.backgroundColor = UIColor(white: 0.7, alpha: 1)
        doneButtonEdge.addTarget(self, action: #selector(self.closeField(sender:)), for: UIControlEvents.touchUpInside)
        doneButtonEdge.setTitleColor(UIColor.blue, for: UIControlState.normal)
        jobInputView.addSubview(doneButtonEdge)
        jobInputView.addSubview(doneButton)
        
        // Do any additional setup after loading the view.
    }
    
    //★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
    //Tag
    
    
    //Tagを生成する------------------------------------------
    func createTagButton(originY:CGFloat,list:[String],type:jobTagType){
        var pointX:CGFloat = 0
        var pointY:CGFloat = originY + 10
        for (index,value) in list.enumerated(){
            
            let myButton = flagButton(frame: .zero, title: value, Tagtype: type)
            myButton.frame.origin.x = pointX + 10
            myButton.frame.origin.y = pointY
            myButton.frame.size = CGSize(width: myButton.frame.width + 10, height: myButton.frame.height)
            
            if myButton.frame.origin.x + myButton.frame.width > self.view.frame.width{
                myButton.frame.origin.x = 10
                myButton.frame.origin.y = pointY + myButton.frame.height + 10
            }
            
            pointX = myButton.frame.origin.x + myButton.frame.width
            pointY = myButton.frame.origin.y
            
            
            switch type {
            case .industry:

                myButton.tag = index
                myButton.type = .industry
            case .occupation:

                myButton.tag = index + jobCategoryList.count
                myButton.type = .occupation
            }
            
            myButton.addTarget(self, action: #selector(self.clickButton(sender:)), for: UIControlEvents.touchUpInside)
            jobInputView.addSubview(myButton)
        }
    }
    
    let maxJobSelectCount:Int = 6
    //Tagをクリックした時の動作-------------------------------------------
    func clickButton(sender:flagButton){
        
        if selectedTagList.count == maxJobSelectCount && sender.flag == false{
            jobErrorMessage.alpha = 1
            return
        }
        
        sender.flag = !sender.flag
        
        if sender.flag{
            sender.alpha = 0.2
            addTag(senderTag: sender.tag, sectionType: sender.type)
            
        }else{
            sender.alpha = 1
            removeTag(senderTag:sender.tag,senderOrder: num[sender.tag]!,sectionType: sender.type)
            jobErrorMessage.alpha = 0
        }
        update(senderTag: sender.tag,sectionType: sender.type)
        
        if selectedTagList.count > 0{
            jobTextField.placeholder = ""
        }else{
            jobTextField.placeholder = "入力してください"
        }
    }
    
    
    //Tagを選択リストに追加する-------------------------------------------
    func addTag(senderTag:Int,sectionType:jobTagType){
//        let button = flagButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        var list:[String] = []
        list = jobCategoryList + jobTypeList
        let button = flagButton(frame: .zero, title: list[senderTag], Tagtype: sectionType)
        
        
        switch sectionType {
        case .industry:
            list = jobCategoryList
            button.type = .industry
        case .occupation:
            list = jobTypeList
            button.type = .occupation
        
        }
        
        button.frame.size = CGSize(width: button.frame.width + 10, height: button.frame.height)
        num[senderTag] = selectedTagList.count
        button.tag = senderTag
        selectedTagList.append(button)
    }
    
    
    
    //タグの位置を更新する（追加・除外どちらにもうごく）
    func update(senderTag:Int,sectionType:jobTagType){
        let width = jobTextField.frame.width
        var pointX:CGFloat = 0
        var pointY:CGFloat = 10
        for button in selectedTagList{
            
            UIView.animate(withDuration: 0.3, animations: {
                button.frame.origin.x = pointX + 6
                button.frame.origin.y = pointY
                pointY = button.frame.origin.y
                pointX = button.frame.origin.x + button.frame.width
                
                if pointX + 5 > width{
                    button.frame.origin.x = 6
                    button.frame.origin.y = pointY + button.frame.height + 6
                }
                pointY = button.frame.origin.y
                pointX = button.frame.origin.x + button.frame.width
                
                self.jobTextField.addSubview(button)
            })
        }
        
    }
    
    //Tagを選択リストから除外する-------------------------------------------
    func removeTag(senderTag:Int,senderOrder:Int,sectionType:jobTagType){
        
        if selectedTagList.count > 1{
            for i in senderOrder ..< selectedTagList.count{
                num[selectedTagList[i].tag] = i - 1
            }
        }
        
        selectedTagList[senderOrder].removeFromSuperview()
        selectedTagList.remove(at: senderOrder)
    }

    
    //ジョブタグリストを閉じる-------------------------------------------
    func closeField(sender:UIButton){
        jobTextField.resignFirstResponder()
    }
    
    //★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
    //Textfield
    
    //テキストフィールドが開かれるとき-------------------------------------------
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        activeTextField = textField
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 0 && textField.text?.isEmpty == false{
            answerList01[userDefautlsKeyList.username.rawValue] = textField.text
        }
        
    }
    
    //Returnキーが押されたとき-------------------------------------------
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        // tag:1 username,2:background,3:qualification
        switch textField.tag {
        case 0:
            answerList01[userDefautlsKeyList.username.rawValue] = textField.text
        case 1:
            answerList01[userDefautlsKeyList.background.rawValue] = textField.text
        case 2:
            answerList01[userDefautlsKeyList.qualification.rawValue] = textField.text
        default:
            print("none")
        }
        return true
    }
    
    //キーボードが開かれるとき-------------------------------------------
    func keyboardWillShown(notification:Notification){
        
        let userInfo = notification.userInfo!
        let keyboardScreenEndFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue

        let myBoundSize:CGSize = UIScreen.main.bounds.size
        
        let txtLimit = activeTextField!.superview!.frame.origin.y + activeTextField!.frame.height + 80
        let kbdLimit = myBoundSize.height - keyboardScreenEndFrame.cgRectValue.size.height
        print("テキストフィールドの下辺：(\(txtLimit))")
        print("キーボードの上辺：(\(kbdLimit))")
        originalY = scrollView.contentOffset.y
        if txtLimit >= kbdLimit{
            scrollView.contentOffset.y = txtLimit - kbdLimit
            
        }
        self.view.isUserInteractionEnabled = true
    }
    
    
    //キーボードが閉じるとき-------------------------------------------
    func keyboardWillHidden(notification:Notification){
        
        scrollView.contentOffset.y = originalY
    }
    
    //★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
    //Section
    
    //セクションを作る-------------------------------------------
    func sectionDesigned(target:UIView){
        
        let bottomBorder = CALayer()
        bottomBorder.borderColor = UIColor.gray.cgColor
        bottomBorder.borderWidth = 2
        bottomBorder.frame = CGRect(x: 0, y: target.frame.height - 2, width: target.frame.width, height: 2)
        
        target.layer.addSublayer(bottomBorder)
        
        
        titleLabel = UILabel(frame: CGRect(x: 10, y: 10, width: 100, height: 30))
        titleLabel.font = UIFont.italicSystemFont(ofSize: 13)
        titleLabel.text = titleList[target.tag]
        titleLabel.textColor = UIColor.lightGray
        
        
        target.addSubview(titleLabel)
        
        infoTextField = UITextField(frame: CGRect(x: target.center.x - 40, y: 10, width: 200, height: 30))
        infoTextField.frame.origin.x = target.frame.width/2
        infoTextField.textAlignment = NSTextAlignment.left
        infoTextField.delegate = self
        infoTextField.font = UIFont.systemFont(ofSize: 14)
        infoTextField.placeholder = "入力してください"
        
        // tag:1 username,2:background,3:qualification
        infoTextField.tag = target.tag
        target.addSubview(infoTextField)
        
    }
    
    //『次へ』ボタンが押されたときに移る
    @IBAction func transitionNext(_ sender: Any) {
        
        //名前入力チェック
        if checkNameValue() == false{
            errorMessageLabel.alpha = 1
            return
        }
        saveToUserDefaults()
        errorMessageLabel.alpha = 0
        performSegue(withIdentifier: "segue", sender: nil)
    }
    
    
    
    
    //名前がちゃんと入力されてるかチェック
    func checkNameValue()->Bool{
        //answeList
        //0:名前
        //1:学校
        //2:資格
        
        if answerList01[userDefautlsKeyList.username.rawValue] as? String == ""{
            return false
        }
        
        return true
    }
    
    func saveToUserDefaults(){
        var selectedJobString:[String] = [String]()
        for button in selectedTagList{
            guard let str = button.titleLabel?.text else { continue }
            selectedJobString.append(str)
        }
        udSetting.save(key: .job, value: selectedJobString)
        
        udSetting.save(key: .username, value: answerList01[userDefautlsKeyList.username.rawValue] as! String)
        udSetting.save(key: .background, value: answerList01[userDefautlsKeyList.background.rawValue] as! String)
        udSetting.save(key: .qualification, value: answerList01[userDefautlsKeyList.qualification.rawValue] as! String)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
