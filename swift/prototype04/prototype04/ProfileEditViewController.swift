//
//  ProfileEditViewController.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/05/11.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class ProfileEditViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIScrollViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate{

    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var myNameLabel: UILabel!
    var sectionList = ["Job(選べるのは6つまで)","Background"]
    var jobItems = ["気になる職種","気になる業界"]
//    var foodItems = ["好きな食べ物","嫌いな食べ物"]
    var backgroundItems = ["学校","資格"]
    var selectedImage:UIImage?
    
    @IBOutlet weak var myScrollView: UIScrollView!
    var interestingJob:String?
    var interestingCategory:String?
    var originalY:CGFloat = 0
    
    var favoriteFood:String?
    var unfavoriteFood:String?
    var background:String?
    var qualification:String?
    
    var originData:[String:Any]!
    var tmpData:[String:Any]!
    
    var jobTextField01:UITextField!
    var jobTextField02:UITextField!
    
    var jobCategoryList:[String] = jobTagTitleList.init().industry
    var jobTypeList:[String] = jobTagTitleList.init().occupation
    var jobCellHeight:[jobTagType:CGFloat] = [:]
    var dummyJobData = ["営業","不動産","経営企画","経営コンサル"]
    var jobInputView01:UIView!
    var jobInputView02:UIView!
    var activeTextField:UITextField?
    var userSettingList:[String:Any]?
    let UDsetting:UserDefaultSetting = UserDefaultSetting()
    
    var backgroundTextField:UITextField!
    var qualificationTextField:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let documentDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let imgFileName = "sample.png"
        let tmp = UIImage(contentsOfFile: "\(documentDir)/\(imgFileName)")
        myImageView.image = tmp
        
        
        userSettingList = UDsetting.returnSetValue()
        dummyJobData = userSettingList?[userDefautlsKeyList.job.rawValue] as! [String]
        
        myNameLabel.text = userSettingList?[userDefautlsKeyList.username.rawValue] as? String
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShown(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        myScrollView.delegate = self
        
        backgroundTextField = UITextField(frame: CGRect.zero)
        qualificationTextField = UITextField(frame: CGRect.zero)
        backgroundTextField.delegate = self
        qualificationTextField.delegate = self
        
        
        jobTextField01 = UITextField(frame: CGRect.zero)
        jobTextField01.delegate = self
        jobTextField02 = UITextField(frame: CGRect.zero)
        jobTextField02.delegate = self
        self.view.addSubview(jobTextField01)
        self.view.addSubview(jobTextField02)
        
        let screenWidth = self.view.frame.width
        
        jobInputView01 = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 300))
        jobInputView01.backgroundColor = UIColor.white
        jobInputView02 = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 300))
        jobInputView02.backgroundColor = UIColor.lightGray
        
        
        
        createTagButton(originY: 10, list: jobCategoryList, type: .industry)
        createTagButton(originY: 10, list: jobTypeList, type: .occupation)
        
        jobTextField01.inputView = jobInputView01
        jobTextField02.inputView = jobInputView02
        
        jobInputView01.frame.size = CGSize(width: screenWidth, height: jobInputView01.subviews.last!.frame.origin.y + jobInputView01.subviews.last!.frame.height + 50)
        jobInputView02.frame.size = CGSize(width: screenWidth, height: jobInputView02.subviews.last!.frame.origin.y + jobInputView02.subviews.last!.frame.height + 50)
        
        
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "myCell")
        
        
//        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
//        originData = appDelegate.myDataDelegate
        // Do any additional setup after loading the view.
    }
    
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
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionList.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionList[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return jobItems.count
        case 1:
            return backgroundItems.count
//        case 2:
//            return backgroundItems.count
        default:
            return 0
        }
    }
    
    let tagLabelFontSize:CGFloat = 13
    func createTagButton(originY:CGFloat,list:[String],type:jobTagType){
        
        let screenWidth = self.view.frame.width
        let doneButton:UIButton = UIButton(frame: CGRect(x: screenWidth - 50, y: 0, width: 50, height: 40))
        let inputViewLabel:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 40))
        inputViewLabel.text = "選べるタグは６個までです"
        inputViewLabel.textColor = UIColor.red
        inputViewLabel.alpha = 0
        
        
        doneButton.addTarget(self, action: #selector(self.closeTagView(sender:)), for: UIControlEvents.touchUpInside)
        doneButton.setTitle("完了", for: UIControlState.normal)
        doneButton.backgroundColor = UIColor.blue
        
        switch type {
        case .industry:
            doneButton.tag = 1
//            inputViewLabel.text = ""
            jobInputView01.addSubview(inputViewLabel)
            jobInputView01.addSubview(doneButton)
        case .occupation:
            doneButton.tag = 2
//            inputViewLabel.text = "気になる職種"
            jobInputView02.addSubview(inputViewLabel)
            jobInputView02.addSubview(doneButton)
        }
        
        var pointX:CGFloat = 0
        var pointY:CGFloat = doneButton.frame.height + 10
        for (index,value) in list.enumerated(){
            
//            let myButton = flagButton(frame: CGRect(x: 0, y: 0, width: 50, height: 20))
            let myButton = flagButton(frame: .zero, title: value, Tagtype: type)
//            myButton.titleLabel?.font = UIFont.systemFont(ofSize: tagLabelFontSize)
//            myButton.setTitle(value, for: UIControlState.normal)
//            myButton.sizeToFit()
            myButton.frame.origin.x = pointX + 10
            myButton.frame.origin.y = pointY
//            myButton.layer.masksToBounds = true
//            myButton.layer.cornerRadius = 10
//            myButton.layer.borderWidth = 3
            myButton.frame.size = CGSize(width: myButton.frame.width + 20, height: myButton.frame.height)
            
            if myButton.frame.origin.x + myButton.frame.width > self.view.frame.width{
                myButton.frame.origin.x = 10
                myButton.frame.origin.y = pointY + myButton.frame.height + 10
            }
            
            pointX = myButton.frame.origin.x + myButton.frame.width
            pointY = myButton.frame.origin.y
//            myButton.setTitleColor(UIColor.black, for: .normal)
            myButton.tag = index
            
            if dummyJobData.contains(value){
                myButton.alpha = 0.2
                myButton.flag = true
                
            }
            
            myButton.addTarget(self, action: #selector(self.clickTag(sender:)), for: UIControlEvents.touchUpInside)
            switch type {
            case .industry:
//                myButton.layer.borderColor = UIColor.red.cgColor
//                myButton.type = .industry
                jobInputView01.addSubview(myButton)
            case .occupation:
//                myButton.layer.borderColor = UIColor.blue.cgColor
//                myButton.type = .occupation
                jobInputView02.addSubview(myButton)
            }
            
//            myButton.addTarget(self, action: #selector(self.clickButton(sender:)), for: UIControlEvents.touchUpInside)
            
        }
    }
    
    func closeTagView(sender:UIButton){
        print("162:\(sender.tag)")
        switch sender.tag {
        case 1:
            jobTextField01.resignFirstResponder()
        case 2:
            jobTextField02.resignFirstResponder()
        default:
            print("error")
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            
            switch jobItems[indexPath.row] {
            case "気になる職種":
                
                jobTextField01.becomeFirstResponder()
                
            case "気になる業界":
                
                jobTextField02.becomeFirstResponder()
            default:
                print("hogeho")
            }
            
        case 1:
            
            switch backgroundItems[indexPath.row] {
            case "学校":
                
                backgroundTextField.becomeFirstResponder()
            case "資格":
                
                qualificationTextField.becomeFirstResponder()
            default:
                print("hoge")
            }

        default:
            print("kakaka")
        }
        
//        performSegue(withIdentifier: "segueEditDetailView", sender: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        myTableView.reloadData()
        
        textField.clearsContextBeforeDrawing = true
        
        return true
    }
    
    func clickTag(sender:flagButton){
        let a = selectedTagList[.industry]?.count ?? 0
        let b = selectedTagList[.occupation]?.count ?? 0
        
        print(sender.type)
        print(sender.flag)
        if  a + b == 6{
            
            var inputView = UIView()
            switch sender.type {
            case .industry:
                inputView = jobInputView01
            case .occupation:
                inputView = jobInputView02
            }
            let label = inputView.subviews.first as! UILabel
            switch sender.flag {
            case true:
                label.alpha = 0
            case false:
                label.alpha = 1
                return
            }
            
        }
        
        sender.flag = !sender.flag
        guard let str = sender.titleLabel?.text else {return}
        
        if sender.flag{
            sender.alpha = 0.2
            dummyJobData.append(str)
            addTag02(type: sender.type)
        }else{
            sender.alpha = 1
            removeTag(sender: sender)
        }
        
        myTableView.reloadData()
        
    }
    
    func removeTag(sender:flagButton){
        print("senderTag:\(sender.tag)")
        guard let str = sender.titleLabel?.text else { return }
        dummyJobData.remove(at: dummyJobData.index(of: str)!)
        guard let list = selectedTagList[sender.type] else { return }
        for (index,button) in list.enumerated() {
            print("buttonTag:\(button.tag)")
            if button.tag == sender.tag{
                print(index)
                button.removeFromSuperview()
                selectedTagList[sender.type]?.remove(at: index)
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = tableView.rowHeight
        
        if indexPath.section == 0{
            switch indexPath.row {
            case 0:
                if jobCellHeight[.industry] != nil{
                    height = jobCellHeight[jobTagType.industry]!
                }
                return height + 10
            case 1:
                if jobCellHeight[.occupation] != nil{
                    height = jobCellHeight[jobTagType.occupation]!
                }
                return height + 10
            default:
                return height + 10
            }
        }
        
        return tableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! CustomTableViewCell
        let titleLabelEdge = cell.titleLabel.frame.width + cell.titleLabel.frame.origin.x
        
        switch indexPath.section {
        case 0:
            cell.titleLabel.text = jobItems[indexPath.row]
            cell.titleLabel.font = UIFont.init(name: "BodoniSvtyTwoITCTT-Book", size: 15)
            
            
            switch jobItems[indexPath.row] {
            case "気になる職種":
                
                //Add tag
//                addTag(targetCell: cell, originX: titleLabelEdge, type: .industry)
                updateTag(targetCell: cell, originX: titleLabelEdge, type: .industry)
            case "気になる業界":
                //Add tag
//                addTag(targetCell: cell, originX: titleLabelEdge, type: .occupation)
                updateTag(targetCell: cell, originX: titleLabelEdge, type: .occupation)
            default:
                print("hogeho")
            }
            
        case 1:
            cell.titleLabel.text = backgroundItems[indexPath.row]
            switch backgroundItems[indexPath.row] {
            case "学校":
                cell.addSubview(backgroundTextField)
                backgroundTextField.frame.size = CGSize(width: cell.frame.width/2, height: cell.frame.height)
                backgroundTextField.frame.origin.x = titleLabelEdge + 10
                cell.myLabel.text = userSettingList?[userDefautlsKeyList.background.rawValue] as? String
                if cell.myLabel.text == ""{
                    backgroundTextField.placeholder = "入力なし"
                }else{
                    backgroundTextField.text = ""
                    backgroundTextField.placeholder = ""
                }
                cell.myLabel.frame.origin.x = titleLabelEdge + 10
                
            case "資格":
                
                cell.addSubview(qualificationTextField)
                qualificationTextField.frame.size = CGSize(width: cell.frame.width/2, height: cell.frame.height)
                qualificationTextField.frame.origin.x = titleLabelEdge + 10
                cell.myLabel.text = userSettingList?[userDefautlsKeyList.qualification.rawValue] as? String

                if cell.myLabel.text == ""{
                    qualificationTextField.placeholder = "入力なし"
                }else{
                    qualificationTextField.text = ""
                    qualificationTextField.placeholder = ""
                }
                
                
                cell.myLabel.frame.origin.x = titleLabelEdge + 10
                
            default:
                print("hoge")
            }
            
        default:
            print("default selected")
        }
        cell.myLabel.sizeToFit()
        cell.myLabel.frame.size = CGSize(width: cell.myLabel.frame.width + 10, height: cell.myLabel.frame.height)
        return cell
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case backgroundTextField:
            userSettingList?[userDefautlsKeyList.background.rawValue] = textField.text

        case qualificationTextField:
            userSettingList?[userDefautlsKeyList.qualification.rawValue] = textField.text

        default:
            print("textfield end")
        }
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("aaa")
        return true
    }
    
    var inputWord:String = ""
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        inputWord += string
//        userSettingList?[userDefautlsKeyList.background.rawValue] = inputWord
//        myTableView.reloadData()
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addTag02(type: .industry)
        addTag02(type: .occupation)
        
        

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func saveEditProfile(_ sender: Any) {
        //userdefaultに保存
        UDsetting.save(key: .job, value: dummyJobData)
        UDsetting.save(key: .background, value: userSettingList?[userDefautlsKeyList.background.rawValue] as! String)
        UDsetting.save(key: .qualification, value: userSettingList?[userDefautlsKeyList.qualification.rawValue] as! String)
        
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
    
    @IBAction func cancelEditProfile(_ sender: Any) {
        
        //delegateのデータを戻す
        
        dismiss(animated: true, completion: nil)
    }
    
    var selectedTagList:[jobTagType:[flagButton]] = [.industry:[],.occupation:[]]
    
    func updateTag(targetCell:CustomTableViewCell,originX:CGFloat,type:jobTagType){
        
        var pointX:CGFloat =  originX + 10
        var pointY:CGFloat =  10
        var lastHeight:CGFloat = 0
        let width = targetCell.frame.width
        
        guard let list = selectedTagList[type] else { return }
        
        //セルの中のviewを初期化。
        //もともとセルには、ラベルがくっついてるので、それらはスルーする。0,1
        for (index,view) in targetCell.subviews.enumerated(){
            if index == 0 { continue }
            if index == 1 { continue }
            view.removeFromSuperview()
        }
        
        for button in list{
            targetCell.addSubview(button)
            button.frame.origin = CGPoint(x: pointX, y: pointY)
            pointY = button.frame.origin.y
            pointX = button.frame.origin.x + button.frame.width
            
            
            if pointX > width{
                button.frame.origin.x = originX + 10
                button.frame.origin.y = pointY + button.frame.height + 6
                
            }
            
            
            pointX = button.frame.origin.x + button.frame.width + 10
            pointY = button.frame.origin.y
            
            if lastHeight < pointY + button.frame.height{
                lastHeight = pointY + button.frame.height
            }
        }
        guard let lastbutton = targetCell.subviews.last else { return }
        jobCellHeight[type] = lastbutton.frame.height + lastbutton.frame.origin.y
    }
    
    
    func addTag02(type:jobTagType){

        selectedTagList[type]?.removeAll()
        for data in dummyJobData{
            var tag:jobTagType
            var buttonColor:UIColor = UIColor()
            var num:Int
            if jobCategoryList.contains(data){
                tag = jobTagType.industry
                buttonColor = UIColor.red
                num = jobCategoryList.index(of: data)!
                
            }else{
                tag = jobTagType.occupation
                num = jobTypeList.index(of: data)!
                buttonColor = UIColor.blue
            }
            if type != tag {
                continue
            }
            
            let button = flagButton(frame: .zero, title: data, Tagtype: type)
            button.frame.size = CGSize(width: button.frame.width + 20, height: button.frame.height)
            button.tag = num
            
            selectedTagList[type]?.append(button)
        }
        
    }
    
    func keyboardWillShown(notification:Notification){
        
        let userInfo = notification.userInfo!
        let keyboardScreenEndFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue
        
        let myBoundSize:CGSize = UIScreen.main.bounds.size
        
//        var txtLimit:CGFloat = (activeTextField!.frame.origin.y) + (activeTextField!.frame.height)
        var txtLimit:CGFloat = 500
        if activeTextField?.inputView != nil{
           txtLimit = activeTextField!.inputView!.frame.origin.y + activeTextField!.inputView!.frame.height + 100
        }
        
        let kbdLimit = myBoundSize.height - keyboardScreenEndFrame.cgRectValue.size.height
        print("テキストフィールドの下辺：(\(txtLimit))")
        print("キーボードの上辺：(\(kbdLimit))")
        
        if txtLimit >= kbdLimit{
            myScrollView.contentOffset.y = txtLimit - kbdLimit
        }
        self.view.isUserInteractionEnabled = true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        activeTextField = textField
        
        return true
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
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueCrop"{
            let vc = segue.destination as! CropEditViewController
            vc.originalImage = selectedImage
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
