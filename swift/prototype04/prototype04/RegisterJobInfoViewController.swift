//
//  RegisterJobInfoViewController.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/06/07.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class RegisterJobInfoViewController: UIViewController,UITextFieldDelegate,UIScrollViewDelegate {

    @IBOutlet weak var jobTagTextField: UITextField!
    @IBOutlet weak var apeealTextField: UITextField!
    @IBOutlet weak var myScrollView: UIScrollView!
    @IBOutlet weak var jobErrorLabel: UILabel!
    @IBOutlet weak var appealErrorLabel: UILabel!
    
    @IBOutlet weak var nextButton: RectButton!
    @IBOutlet weak var nextButtonUnderLabel: UILabel!
    
    //業界リスト一覧
    var jobIndustryList:[String] = jobTagTitleList.init().industry
    
    //業種リスト一覧
    var jobOccupationList:[String] = jobTagTitleList.init().occupation
    let jobTitleList = ["気になる業界","気になる業種"]
    let jobTitleFontSize:CGFloat = 13
    
    let udSetting:UserDefaultSetting = UserDefaultSetting()
    var userInfo:UserInfo = UserInfo()
    
    //jobTagをタップしたときのビュー
    var jobInputView:UIScrollView!
    
    //jobTagを選択したときのリスト
    var selectedTagList:[flagButton] = []
    
    //↓キー：jobTagのtag番号、バリュー：選択されたときの順番
    var num:[Int:Int] = [:]
    
    //タップされたTextfieldを検出
    var tappedTextField:UITextField!
    let tagLabelFontSize:CGFloat = 14
    
    //jobTagViewの中のビューのタイトルラベルの高さ
    let inputViewLabelHeight:CGFloat = 20
    
    var originalY:CGFloat = 0
    
    //jobTagViewを開いたときについてる完了ボタンバー
    var toolBar:UIToolbar!
    
    //選択できるTagの最大数
    let maxJobSelectCount:Int = 6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
        _ = udSetting.returnSetValue()
        
        //ラベルを最初透明にする
        appealErrorLabel.alpha = 0
        jobErrorLabel.alpha = 0
        
        //Tagviewのツールバー設定
        //完了ボタン
        toolBar = UIToolbar(frame: CGRect(x: 0, y: 30, width: self.view.frame.width, height: 30))
        toolBar.barStyle = .blackTranslucent
        toolBar.tintColor = UIColor.white
        let closeButton = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(self.resignJobFieled(sender:)))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolBar.items = [flexible,closeButton]
        jobTagTextField.inputAccessoryView = toolBar
        
        //すべての番号を0にする
        for i in 0 ..< jobIndustryList.count + jobOccupationList.count - 1{
            num[i] = 0
        }
        
        
        jobTagTextField.delegate = self
        apeealTextField.delegate = self
        
        //jobTagViewをタップしたときに出てくる中のビューの設定
        jobInputView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 250))
        jobInputView.contentSize = CGSize(width: self.view.frame.width, height: 500)
        jobInputView.delegate = self
        
        //jobTagViewをタップしたときに出てくる中のビューのラベルの設定
        //inputViewLabel01→気になる業界
        //inputViewLabel02→気になる業種
        
        let inputViewLabel01 = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: inputViewLabelHeight))
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
        
        //ビューの中のタグを作成(業界)
        createTagButton(originY: inputViewLabel01.frame.height,list:jobIndustryList, type: .industry)
        
        //jobTagViewの最後のタグボタンの変数:lastView
        let lastView = jobInputView.subviews.last!
        let lastHeight = lastView.frame.origin.y + lastView.frame.height
        inputViewLabel02.frame.origin.y = lastHeight + 20
        jobInputView.addSubview(inputViewLabel02)
        let y = inputViewLabel02.frame.origin.y + inputViewLabel02.frame.height
        
        //ビューの中のタグを作成(業種)
        createTagButton(originY: y, list: jobOccupationList, type: .occupation)
        
        jobInputView.backgroundColor = UIColor.white
        jobInputView.isOpaque = false
        jobTagTextField.inputView = jobInputView
        
        //jobTagViewの最後のタグボタンの変数:lastView
        let last = jobInputView.subviews.last
        let scrollEdgeY = last!.frame.origin.y + last!.frame.height + inputViewLabelHeight
        jobInputView.contentSize.height = scrollEdgeY
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
    //Tag
    
    //Tagを生成する------------------------------------------
    //jobTagInputViewの中に配置するボタン
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
                
                myButton.tag = index + jobIndustryList.count
                myButton.type = .occupation
            }
            
            myButton.addTarget(self, action: #selector(self.clickButton(sender:)), for: UIControlEvents.touchUpInside)
            jobInputView.addSubview(myButton)
        }
    }
    
    
    //Tagをクリックした時の動作-------------------------------------------
    func clickButton(sender:flagButton){
        
        //タグが最大数を超えてタップされたとき
        //errorラベルを不透明化
        if selectedTagList.count == maxJobSelectCount && sender.flag == false{
            jobErrorLabel.alpha = 1
            return
        }
        
        
        sender.flag = !sender.flag
        
        
        //flag→true
        //選択された状態
        if sender.flag{
            sender.alpha = 0.2
            addTag(senderTag: sender.tag, sectionType: sender.type)
            
        }else{
        //flag→false
        //選択解除された状態
            sender.alpha = 1
            removeTag(senderTag:sender.tag,senderOrder: num[sender.tag]!,sectionType: sender.type)
            jobErrorLabel.alpha = 0
        }
        
        //配置を更新
        update(senderTag: sender.tag,sectionType: sender.type)
        
        //jobtagtextfieldのplaceholderを更新
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
    
    
    
    //タグの位置を更新する（追加・除外どちらでも使用）
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
    
    //jobTagViewを閉じる-------------------------------------------
    func resignJobFieled(sender:UIBarButtonItem){
        var selectedJobString:[String] = [String]()
        for button in selectedTagList{
            guard let str = button.titleLabel?.text else { continue }
            selectedJobString.append(str)
        }
        userInfo.favoriteJob = selectedJobString
        jobTagTextField.resignFirstResponder()
    }
    
    //★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
    //Textfield
    
    //テキストフィールドが開かれるとき-------------------------------------------
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        tappedTextField = textField
        if textField == apeealTextField{
            myScrollView.contentOffset.y = 70
        }
        
        return true
    }
    
    //textfieldの値が変更したときに呼ばれる。
    //ここでは文字数制限を２０として、入力の可否を実装
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
    
    //textfiledが閉じるときに呼ばれる
    func textFieldDidEndEditing(_ textField: UITextField) {
        myScrollView.contentOffset.y = 0
        if textField == apeealTextField{
            userInfo.appeal = textField.text
        }
        
    }
    
    //Returnキーが押されたとき-------------------------------------------
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    //戻るボタンが押されたとき
    //前の画面に戻る
    @IBAction func backVC(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    //すすむボタンが押されたとき
    //次の画面に戻る
    //job,appealプロパティの値の保存
    //値が入ってない場合は空文字を格納
    @IBAction func nextButtonTapped(_ sender: Any) {
//        _ = userInfo.checkJobValue()
        udSetting.write(key: .job, value: userInfo.favoriteJob ?? [""])
        udSetting.write(key: .appeal, value: userInfo.appeal ?? "")
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
