//
//  RegisterBasicInfoViewController.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/08/11.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class RegisterBasicInfoViewController: UIViewController,UITextFieldDelegate,UIPickerViewDelegate{

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var birthTextField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    var editingTextField:UITextField!
    var namaText:String?
    var birthText:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        birthTextField.delegate = self
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        namaText = User().name
        birthText = User().birth
        
        nameTextField.text = namaText
        birthTextField.text = birthText
    }
    
    
    let myDatePicker = UIDatePicker()
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == birthTextField{
            let screenWidth = self.view.frame.width
            let vc = UIViewController()
            vc.preferredContentSize = CGSize(width: screenWidth,height: 200)
            
            
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
    
    func onDidChangeDate(sender:UIDatePicker){
        
    }
    
    
    func doneButtonTapped(){
        
        let mydateFormatter = DateFormatter()
        mydateFormatter.dateFormat = "yyyy/M/d"
        let myselectedDate = mydateFormatter.string(from: myDatePicker.date)
        
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
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        editingTextField = textField
        return true
    }

    @IBAction func finishButtonTapped(_ sender: Any) {
        
        
        let navC = self.navigationController!
        let vc = navC.viewControllers[navC.viewControllers.count-2] as! ProfileRegistrationViewController
        //vc.selfIntroText = selfIntroTextView.text
        vc.nameText = self.nameTextField.text
        vc.birthText = self.birthTextField.text
        
        self.navigationController?.popViewController(animated: true)
        
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
