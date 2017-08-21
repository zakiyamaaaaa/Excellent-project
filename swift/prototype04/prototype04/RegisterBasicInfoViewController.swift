//
//  RegisterBasicInfoViewController.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/08/11.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

//名前と生年月日を登録する。どちらのステータスにも共通
class RegisterBasicInfoViewController: UIViewController,UITextFieldDelegate,UIPickerViewDelegate{

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var birthTextField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
//    var editingTextField:UITextField!
    var namaText:String?
    var birthText:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        birthTextField.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        namaText = User().name
        if let dateString = User().birth{
            let date = DateUtils.date(dateString, format: "YYYY-MM-dd")
            let year = NSCalendar.current.component(.year, from: date)
            let month = NSCalendar.current.component(.month, from: date)
            let day = NSCalendar.current.component(.day, from: date)
            birthText = String(year) + "年" + String(month) + "月" + String(day) + "日"
        }
        
        nameTextField.text = namaText
        birthTextField.text = birthText
    }
    
    
    let myDatePicker = UIDatePicker()
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == birthTextField{
            let screenWidth = self.view.frame.width
            let vc = UIViewController()
            vc.preferredContentSize = CGSize(width: screenWidth,height: 300)
            
            
            myDatePicker.datePickerMode = .date
            myDatePicker.maximumDate = Date()
            textField.inputView = myDatePicker
            
            vc.view.addSubview(myDatePicker)
            let editRadiusAlert = UIAlertController(title: "生年月日選択", message: "生年月日を選択してください", preferredStyle: UIAlertControllerStyle.actionSheet)
            editRadiusAlert.setValue(vc, forKey: "contentViewController")
            editRadiusAlert.addAction(UIAlertAction(title: "決定", style: .default, handler:  {
                (action:UIAlertAction!) in
                self.doneButtonTapped()
            }))
            editRadiusAlert.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: {
                (action:UIAlertAction!) in
                print("cancel tapped")
            }))
            self.present(editRadiusAlert, animated: true)
            
            
            return false
        }
        return true
    }
    
    
    func doneButtonTapped(){
        
        let mydateFormatter = DateFormatter()
        mydateFormatter.dateFormat = "yyyy年M月d日"
        let myselectedDate = mydateFormatter.string(from: myDatePicker.date)
        
        self.view.endEditing(true)
        birthTextField.text = myselectedDate
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextButton(_ sender: Any) {
        //名前と生年月日のフィールドに値が入ってなかったら、遷移しない
        if nameTextField.text?.isEmpty == false && birthTextField.text?.isEmpty == false{

            errorMessageLabel.isHidden = true
            var a = my()
            let str = DateUtils.string(myDatePicker.date, format: "yyyy-MM-dd")
            a.register(key: .name, value: nameTextField.text!)
            a.register(key: .birth, value: str)
            
            let status = a.status!
            
            
            switch status {
            case 1:
                performSegue(withIdentifier: "companySegue", sender: nil)
            case 2:
                performSegue(withIdentifier: "nextSegue1", sender: nil)
            default:
                break
            }
            
        }else{
            errorMessageLabel.isHidden = false
        }
    }
    
//    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//        editingTextField = textField
//        return true
//    }

    @IBAction func finishButtonTapped(_ sender: Any) {
        //名前と生年月日のフィールドに値が入ってなかったら、遷移しない
        if nameTextField.text?.isEmpty == false && birthTextField.text?.isEmpty == false{
            let navC = self.navigationController!
            let vc = navC.viewControllers[navC.viewControllers.count-2] as! ProfileRegistrationViewController
            let str = DateUtils.string(myDatePicker.date, format: "yyyy-MM-dd")
            //vc.selfIntroText = selfIntroTextView.text
            vc.nameText = nameTextField.text
            vc.birthText = birthTextField.text
            vc.birthDate = str
            self.navigationController?.popViewController(animated: true)
            errorMessageLabel.isHidden = true
        }else{
            errorMessageLabel.isHidden = false
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
