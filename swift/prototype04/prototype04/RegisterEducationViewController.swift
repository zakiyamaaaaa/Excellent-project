//
//  RegisterEducationViewController.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/08/11.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class RegisterEducationViewController: UIViewController,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource{

    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var schooNameTextField: UITextField!
    @IBOutlet weak var facultyTextField: UITextField!
    @IBOutlet weak var graduationYearTextField: UITextField!
    
    var schoolNameText:String?
    var facultyText:String?
    var graduationYearText:String?
    
    var years = (1950...2015).map { $0 }.sorted(by: >)
    var selectYears:Int?
    let currentYear = NSCalendar.current.component(.year, from: Date())
    
    var myStatus = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        if let status = User().status{
            myStatus = status
        }
        
        
        years = (1950...currentYear + 4).map{$0}.sorted(by:>)
        
        schooNameTextField.delegate = self
        facultyTextField.delegate = self
        graduationYearTextField.delegate = self

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        schooNameTextField.becomeFirstResponder()
        
        schooNameTextField.text = schoolNameText
        facultyTextField.text = facultyText
        if graduationYearText != nil{
            graduationYearTextField.text = graduationYearText
        }
        
    }
    
    let myDatePicker = UIDatePicker()
    let myPickerView = UIPickerView()
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == graduationYearTextField{
            let screenWidth = self.view.frame.width
            let vc = UIViewController()
            vc.preferredContentSize = CGSize(width: screenWidth,height: 180)
            
            myPickerView.delegate = self
            myPickerView.dataSource = self
            
//            myDatePicker.datePickerMode = .date
//            myDatePicker.maximumDate = Date()
//            textField.inputView = myDatePicker
            textField.inputView = myPickerView
            
            vc.view.addSubview(myPickerView)
            let editRadiusAlert = UIAlertController(title: "卒業予定年度年選択", message: "卒業予定年を選択してください", preferredStyle: UIAlertControllerStyle.actionSheet)
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
        
        if selectYears == nil{
            selectYears = currentYear + 4
        }
        
        graduationYearTextField.text = String(selectYears!) + "年"
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        if schooNameTextField.text?.isEmpty == false && facultyTextField.text?.isEmpty == false && graduationYearTextField.text?.isEmpty == false{
            
            let array = [schooNameTextField.text!,facultyTextField.text!,selectYears!] as [Any]
            var a = my()
            a.register(key: .education, value: array)
            
            performSegue(withIdentifier: "nextSegue2", sender: nil)
            errorMessageLabel.isHidden = true
        }else{
            errorMessageLabel.isHidden = false
        }
        
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return years.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(years[row])年"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectYears = years[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @IBAction func finishButtonTapped(_ sender: Any) {
        
        switch myStatus {
        case 1:
            
            //textfieldに値がすべて入ってるもしくは、すべてはいっていない場合は状態変更可
            if schooNameTextField.text?.isEmpty == false && facultyTextField.text?.isEmpty == false && graduationYearTextField.text?.isEmpty == false{
                let navC = self.navigationController!
                let vc = navC.viewControllers[navC.viewControllers.count-2] as! RecruiterProfileViewController
                vc.educationList = [schooNameTextField.text!,facultyTextField.text!,selectYears!]
                
                self.navigationController?.popToViewController(vc, animated: true)
                errorMessageLabel.isHidden = true
                
            }
            
            if schooNameTextField.text?.isEmpty == true && facultyTextField.text?.isEmpty == true && graduationYearTextField.text?.isEmpty == true{
                
                let navC = self.navigationController!
                let vc = navC.viewControllers[navC.viewControllers.count-2] as! RecruiterProfileViewController
                vc.educationList = []
                
                self.navigationController?.popToViewController(vc, animated: true)
                
                errorMessageLabel.isHidden = true
            }
            
            
                
        case 2:
            if schooNameTextField.text?.isEmpty == false && facultyTextField.text?.isEmpty == false && graduationYearTextField.text?.isEmpty == false{
                let navC = self.navigationController!
                let vc = navC.viewControllers[navC.viewControllers.count-2] as! ProfileRegistrationViewController
                vc.schoolNameText = schooNameTextField.text!
                
                self.navigationController?.popToViewController(vc, animated: true)
                errorMessageLabel.isHidden = true
            }else{
                errorMessageLabel.isHidden = false
            }
        default:
            break
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
