//
//  ProfileEditViewController02.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/06/09.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class ProfileEditViewController02: UIViewController,UITextFieldDelegate,UIScrollViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate {

    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var sexSegmentedControl: UISegmentedControl!
    @IBOutlet weak var ageTextField: NonCaretTextField!
    @IBOutlet weak var belongingTextField: UITextField!
    @IBOutlet weak var jobTagErrorLabel: UILabel!
    @IBOutlet weak var myScrollView: UIScrollView!

    @IBOutlet weak var jobTagTextField: NonCaretTextField!
    @IBOutlet weak var appealTextField: UITextField!
    @IBOutlet weak var appealErrorLabel: UILabel!
    var selectedImage:UIImage?
    let udSetting:UserDefaultSetting = UserDefaultSetting()
    var userInfo:UserInfo = UserInfo()
    let jobIndustryList:[String] = jobTagTitleList.init().industry
    let jobOccupationList:[String] = jobTagTitleList.init().occupation
    
    var jobInputView:UIScrollView!
    let jobTitleList = ["気になる業界","気になる業種"]
    let jobTitleFontSize:CGFloat = 13
    var selectedTagList:[flagButton] = []
    var selectedTagInfo:[[jobTagType:String]]?
    var num:[Int:Int] = [:]
    var tappedTextField:UITextField!
    let tagLabelFontSize:CGFloat = 14
    var originalY:CGFloat = 0
    var selectedTagList02:[jobTagType:[flagButton]] = [.industry:[],.occupation:[]]
    var toolBar:UIToolbar!
    var toolBar02:UIToolbar!
    
    //タグを選択できる最大の数
    let maxJobSelectCount:Int = 6
    
    //ageの設定のため今年の年を設定
    let thisYear = 2017
    
    //picker
    var agePicker:UIPickerView!
    var ageDataSource:[String] = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //key:タグ value:選択されてる順番 ※選択されてないときは0
        for i in 0 ..< jobIndustryList.count + jobOccupationList.count - 1{
            num[i] = 0
        }
        
        //初期設定
        initialSet()
        
        //エラーのラベルを透過
        appealErrorLabel.alpha = 0
        jobTagErrorLabel.alpha = 0
        
        myImageView.layer.borderWidth = 1
        
        //tagviewのツールバー設定
        toolBar = UIToolbar(frame: CGRect(x: 0, y: 30, width: self.view.frame.width, height: 30))
        toolBar.barStyle = .blackTranslucent
        toolBar.tintColor = UIColor.white
        let closeButton = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(self.resignJobFieled(sender:)))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolBar.items = [flexible,closeButton]
        
        
        //ageのところのツールバー設定
        toolBar02 = UIToolbar(frame: CGRect(x: 0, y: 30, width: self.view.frame.width, height: 30))
        toolBar02.barStyle = .blackTranslucent
        toolBar02.tintColor = UIColor.white
        let closeButton02 = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(self.resignAgeField(sender:)))
        let flexible02 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolBar02.items = [flexible02,closeButton02]
        //age のpickerの設定
        agePicker = UIPickerView()
        agePicker.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 150)
        agePicker.delegate = self
        agePicker.dataSource  = self
        agePicker.isUserInteractionEnabled = true
        ageTextField.inputView = agePicker
        
        //Pickerに設定するageDataを格納
        for i in 18 ... 80{
            ageDataSource.append("\(thisYear - i)年生まれ(\(i)歳)")
        }
        let initialPickerNum = Int(userInfo.age)!
        agePicker.selectRow(initialPickerNum - 18, inComponent: 0, animated: false)
        ageTextField.inputAccessoryView = toolBar02
        jobTagTextField.inputAccessoryView = toolBar
        
        
        //testfieldのNotificationの設定
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShown(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        myScrollView.delegate = self
        
        //segmentedControl
        switch userInfo.sex {
        case "female":
            sexSegmentedControl.selectedSegmentIndex = 0
        case "male":
            sexSegmentedControl.selectedSegmentIndex = 1
        default:
            break
        }
        
        
        nameTextField.delegate = self
        jobTagTextField.delegate = self
        ageTextField.delegate = self
        appealTextField.delegate = self
        belongingTextField.delegate = self
        
        //JobTagViewの設定
        jobInputView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 250))
        jobInputView.contentSize = CGSize(width: self.view.frame.width, height: 500)
        jobInputView.delegate = self
        
        let tagButtonHeight:CGFloat = 30
        let inputViewLabel01 = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: tagButtonHeight))
        let inputViewLabel02 = UILabel(frame: inputViewLabel01.frame)
        inputViewLabel01.backgroundColor = UIColor(white: 0.9, alpha: 1)
        inputViewLabel01.textAlignment = NSTextAlignment.center
        inputViewLabel02.backgroundColor = UIColor(white: 0.9, alpha: 1)
        inputViewLabel02.textAlignment = NSTextAlignment.center
        inputViewLabel01.text = jobTitleList[0]
        inputViewLabel02.text = jobTitleList[1]
        inputViewLabel01.font = UIFont.systemFont(ofSize: jobTitleFontSize)
        inputViewLabel02.font = UIFont.systemFont(ofSize: jobTitleFontSize)
        inputViewLabel01.center.x = jobInputView.center.x
        inputViewLabel02.center.x = jobInputView.center.x
        jobInputView.addSubview(inputViewLabel01)
        
        createTagButton(originY: inputViewLabel01.frame.height,list:jobIndustryList, type: .industry)
        
        let lastItem = jobInputView.subviews.last!
        let lastHeight = lastItem.frame.origin.y + lastItem.frame.height
        inputViewLabel02.frame.origin.y = lastHeight + 20
        jobInputView.addSubview(inputViewLabel02)
        let y = inputViewLabel02.frame.origin.y + inputViewLabel02.frame.height
        
        createTagButton(originY: y, list: jobOccupationList, type: .occupation)
        
        jobInputView.backgroundColor = UIColor.white
        jobInputView.isOpaque = false
        jobTagTextField.inputView = jobInputView
        
        
        let last = jobInputView.subviews.last
        let scrollEdgeY = last!.frame.origin.y + last!.frame.height + tagButtonHeight
        jobInputView.contentSize.height = scrollEdgeY
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    //★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
    //初期設定
    func initialSet(){
        userInfo.userName = udSetting.read(key: .username)
        userInfo.sex = udSetting.read(key: .sex)
        userInfo.age = udSetting.read(key: .age)
        userInfo.appeal = udSetting.read(key: .appeal)
        userInfo.favoriteJob = udSetting.read(key: .job)
        userInfo.belonging = udSetting.read(key: .belonging)
        
        nameTextField.text = userInfo.userName
        ageTextField.text = userInfo.age + "歳"
        appealTextField.text = userInfo.appeal
        belongingTextField.text = userInfo.belonging
        
        let documentDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let imgFileName = "sample.png"
        let tmp = UIImage(contentsOfFile: "\(documentDir)/\(imgFileName)")
        myImageView.image = tmp
        
        createTag()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
    //pickerメソッド
    //Pickerのコンポーネントの数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //Pickerのコンポーネントの中の数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ageDataSource.count
    }
    
    //Pickerのコンポーネントの中の値
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ageDataSource[row]
    }
    
    //Pickerのコンポーネントが選択されたとき
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(ageDataSource[row])
        ageTextField.text = ageDataSource[row]
        userInfo.age = renameAge(selectedAge: ageDataSource[row])
    }
    
    //Ageの切り取り
    func renameAge(selectedAge:String)->String{
        let startIndex = selectedAge.index(selectedAge.endIndex, offsetBy: -4)
        let endIndex = selectedAge.index(selectedAge.endIndex, offsetBy: -2)
        let range = startIndex..<endIndex
        
        let subString = selectedAge.substring(with: range)
        return subString
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
            
            if (self.userInfo.favoriteJob?.contains(value))!{
                myButton.flag = true
                myButton.alpha = 0.2
            }
            
            switch type {
            case .industry:
                
                myButton.tag = index
                myButton.type = .industry
            case .occupation:
                
                myButton.tag = index + jobIndustryList.count
                myButton.type = .occupation
            }
            
            myButton.addTarget(self, action: #selector(self.clickButton(sender:)), for: UIControlEvents.touchUpInside)
            jobInputView.addSubview(myButton)
        }
    }
    
    
    //Tagをクリックした時の動作-------------------------------------------
    func clickButton(sender:flagButton){
        if selectedTagList.count == maxJobSelectCount && sender.flag == false{
            jobTagErrorLabel.alpha = 1
            return
        }
        
        sender.flag = !sender.flag
        
        if sender.flag{
            sender.alpha = 0.2
            addTag(senderTag: sender.tag, sectionType: sender.type)
            
        }else{
            sender.alpha = 1
            removeTag(senderTag:sender.tag,senderOrder: num[sender.tag]!,sectionType: sender.type)
            jobTagErrorLabel.alpha = 0
        }
        update(senderTag: sender.tag,sectionType: sender.type)
        
        if selectedTagList.count > 0{
            jobTagTextField.placeholder = ""
        }else{
            jobTagTextField.placeholder = "入力してください"
        }
    }
    
    
    //Tagを選択リストに追加する-------------------------------------------
    func addTag(senderTag:Int,sectionType:jobTagType){
        //        let button = flagButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        var list:[String] = []
        list = jobIndustryList + jobOccupationList
        let button = flagButton(frame: .zero, title: list[senderTag], Tagtype: sectionType)
        
        
        switch sectionType {
        case .industry:
            list = jobIndustryList
            button.type = .industry
        case .occupation:
            list = jobOccupationList
            button.type = .occupation
            
        }
        
        button.frame.size = CGSize(width: button.frame.width + 10, height: button.frame.height)
        
        num[senderTag] = selectedTagList.count
        button.tag = senderTag
        selectedTagList.append(button)
        
    }
    
    //最初に設定
    func createTag(){
        //最初addして
        
        guard let favoriteJob = userInfo.favoriteJob else { return }
        
        for jobTag in favoriteJob{
            if jobIndustryList.contains(jobTag){
                let tagNum = jobIndustryList.index(of: jobTag)!
                print("357tag:\(tagNum)")
                addTag(senderTag: tagNum, sectionType: .industry)
            }
            if jobOccupationList.contains(jobTag){
                let tagNum = jobOccupationList.index(of: jobTag)! + jobIndustryList.count
                addTag(senderTag: tagNum, sectionType: .occupation)
                print("363tag:\(tagNum)")
            }
            
        }
        
        //次にupdate
        update()
        print("num:\(num)")
    }
    
    
    //タグの位置を更新する（追加・除外どちらにもうごく）
    func update(senderTag:Int,sectionType:jobTagType){
        let width = jobTagTextField.frame.width
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
                
                self.jobTagTextField.addSubview(button)
            })
        }
        
    }
    
    //最初に使用
    func update(){
        let width = jobTagTextField.frame.width
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
                
                self.jobTagTextField.addSubview(button)
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
    func resignJobFieled(sender:UIBarButtonItem){
        var selectedJobString:[String] = [String]()
        for button in selectedTagList{
            guard let str = button.titleLabel?.text else { continue }
            selectedJobString.append(str)
        }
        userInfo.favoriteJob = selectedJobString
        jobTagTextField.resignFirstResponder()
    }
    
    func resignAgeField(sender:UIBarButtonItem){
        
        ageTextField.resignFirstResponder()
    }


    //★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
    //Textfield
    
    //テキストフィールドが開かれるとき-------------------------------------------
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        tappedTextField = textField
        originalY = myScrollView.contentOffset.y
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
        case belongingTextField:
            print("belonging")
            userInfo.belonging = textField.text!
        case appealTextField:
            userInfo.appeal = textField.text!
        default:
            break
        }
        
        
        textField.resignFirstResponder()
        return true
    }
    
    //textfieldの値が変更されたときに呼ばれる
    //入力できる最大数を設定
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength:Int = 20
        let str = textField.text! + string
        if str.characters.count <= maxLength{
            appealErrorLabel.alpha = 0
            return true
        }
        
        appealErrorLabel.alpha = 1
        return false
    }
    
    
    //keyboard
    func keyboardWillShown(notification:Notification){
        
        
        let userInfo = notification.userInfo!
        let keyboardScreenEndFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue
        
        let myBoundSize:CGSize = UIScreen.main.bounds.size
        
//        var txtLimit:CGFloat = tappedTextField.frame.origin.y + tappedTextField.frame.height
        var txtLimit:CGFloat = 500
        
        if let superView = tappedTextField.superview{
            txtLimit = superView.frame.origin.y + superView.frame.height + self.navigationController!.navigationBar.frame.height
        }
        
        var kbdLimit = myBoundSize.height - keyboardScreenEndFrame.cgRectValue.size.height
        if tappedTextField == jobTagTextField{
            kbdLimit = myBoundSize.height - self.jobInputView.frame.height + 100
        }
        
        
        print("テキストフィールドの下辺：(\(txtLimit))")
        print("キーボードの上辺：(\(kbdLimit))")
        
        if txtLimit >= kbdLimit{
            
            myScrollView.contentOffset.y = txtLimit - kbdLimit + 30
            
        }
        self.view.isUserInteractionEnabled = true
    }
    
    
    
    
    //キーボードが閉じるとき-------------------------------------------
    func keyboardWillHidden(notification:Notification){
        
        myScrollView.contentOffset.y = originalY
    }
    
    
    
    @IBAction func returnToTop(segue: UIStoryboardSegue) {
        
        if segue.identifier  == "unwindCrop"{
            print("unwind")
            let vc = segue.source as! CropEditViewController
            myImageView.image = vc.maskedImage
            
            //            registerButton.isEnabled = true
            //            registerButton.alpha = 1
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueCrop"{
            let vc = segue.destination as! CropEditViewController
            vc.originalImage = selectedImage
        }
    }

    //★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
    //画像アップ
    @IBAction func photoUpload(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Confirmation", message: "Choose", preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            print("Available to camera")
            
            
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: {(action:UIAlertAction) in
                let ipc = UIImagePickerController()
                ipc.sourceType = .camera
                ipc.delegate = self
                self.present(ipc, animated:true, completion: nil)
                
            })
            alertController.addAction(cameraAction)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: {(actioin:UIAlertAction) in
                
                let ipc :UIImagePickerController = UIImagePickerController()
                ipc.sourceType = .photoLibrary
                ipc.delegate = self
                self.present(ipc, animated:true, completion: nil)
                
                
            })
            alertController.addAction(photoLibraryAction)
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController,animated: true,completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        dismiss(animated: true) {
            self.performSegue(withIdentifier: "segueCrop", sender: self.selectedImage)
        }
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


extension ProfileEditViewController02{
    
    func updateTag(type:jobTagType){
        
        var pointX:CGFloat =  10
        var pointY:CGFloat =  10
        var lastHeight:CGFloat = 0
        let width = jobTagTextField.frame.width
        
        guard let list = selectedTagList02[type] else { return }
        
        //セルの中のviewを初期化。
        //もともとセルには、ラベルがくっついてるので、それらはスルーする。0,1
        
        for button in list{
            jobTagTextField.addSubview(button)
            button.frame.origin = CGPoint(x: pointX, y: pointY)
            pointY = button.frame.origin.y
            pointX = button.frame.origin.x + button.frame.width
            
            
            if pointX > width{
                button.frame.origin.x = 10
                button.frame.origin.y = pointY + button.frame.height + 6
                
            }
            
            
            pointX = button.frame.origin.x + button.frame.width + 10
            pointY = button.frame.origin.y
            
            if lastHeight < pointY + button.frame.height{
                lastHeight = pointY + button.frame.height
            }
        }
//        guard let lastbutton = targetCell.subviews.last else { return }
    }
    
    
    func addTag02(type:jobTagType){
        guard let job = userInfo.favoriteJob else { return }
        selectedTagList02[type]?.removeAll()
        for data in job{
            var tag:jobTagType
            var buttonColor:UIColor = UIColor()
            var num:Int
            if jobIndustryList.contains(data){
                tag = jobTagType.industry
                buttonColor = UIColor.red
                num = jobIndustryList.index(of: data)!
                
            }else{
                tag = jobTagType.occupation
                num = jobOccupationList.index(of: data)!
                buttonColor = UIColor.blue
            }
            if type != tag {
                continue
            }
            
            let button = flagButton(frame: .zero, title: data, Tagtype: type)
            button.frame.size = CGSize(width: button.frame.width + 20, height: button.frame.height)
            button.tag = num
            
            selectedTagList02[type]?.append(button)
        }
        
    }

    
    
    func clickTag(sender:flagButton){
        let a = selectedTagList02[.industry]?.count ?? 0
        let b = selectedTagList02[.occupation]?.count ?? 0
        
        print(sender.type)
        print(sender.flag)
        if  a + b == 6{
            
            //６文字まで
            
        }
        
        sender.flag = !sender.flag
        guard let str = sender.titleLabel?.text else {return}
        
        if sender.flag{
            sender.alpha = 0.2
            userInfo.favoriteJob!.append(str)
            addTag02(type: sender.type)
        }else{
            sender.alpha = 1
            removeTag(sender: sender)
        }
        
    }
    
    func removeTag(sender:flagButton){
        print("senderTag:\(sender.tag)")
        guard let str = sender.titleLabel?.text else { return }
        userInfo.favoriteJob!.remove(at: userInfo.favoriteJob!.index(of: str)!)
        guard let list = selectedTagList02[sender.type] else { return }
        for (index,button) in list.enumerated() {
            print("buttonTag:\(button.tag)")
            if button.tag == sender.tag{
                print(index)
                button.removeFromSuperview()
                selectedTagList02[sender.type]?.remove(at: index)
                
            }
        }
    }
    
    //★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
    //Segue
    
    //なにもせずに前画面に戻る
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //Saveボタンを御した時
    //状態をlocalStorageに保存して前画面に戻る
    @IBAction func save(_ sender: Any) {
        
        udSetting.write(key: .username, value: userInfo.userName)
        udSetting.write(key: .age, value: userInfo.age)
        
        
        udSetting.write(key: .belonging, value: userInfo.belonging)
        udSetting.write(key: .username, value: userInfo.userName)
        
        if let job = userInfo.favoriteJob{
            udSetting.write(key: .job, value: job)
        }
        if let appeal = userInfo.appeal{
            udSetting.write(key: .appeal, value: appeal)
        }
        
        
        let documentDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let imgFileName = "sample.png"
        
        if selectedImage != nil{
            let pngData = UIImagePNGRepresentation(selectedImage!)
            do{
                try pngData?.write(to: URL(fileURLWithPath: "\(documentDir)/\(imgFileName)"))
            }catch{
                print(error.localizedDescription)
            }
        }
        
        dismiss(animated: true, completion: nil)
    }


    
}
