//
//  RegisterCompanyViewController.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/08/15.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class RegisterCompanyViewController: UIViewController,UITextFieldDelegate{

    
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var positionTextField: UITextField!
    @IBOutlet weak var companyYearTextField: UITextField!
    
    @IBOutlet weak var anonymousSwitch: UISwitch!
    
    var companyName:String?
    var position:String?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        companyTextField.delegate = self
        positionTextField.delegate = self
        
        // Do any additional setup after loading the view.
        let user = Recruiter()
        companyName = user.company_name
        position = user.position
    }
    
    override func viewWillAppear(_ animated: Bool) {
        companyTextField.text = companyName
        positionTextField.text = position
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        
        
        if companyTextField.text?.isEmpty == false{
            
            var a = Recruiter()
            a.register(key: .company_name, value: companyTextField.text!)
            
            if positionTextField.text != nil && positionTextField.text?.isEmpty == false{
                a.register(key: .position, value: positionTextField.text!)
            }
            
            if anonymousSwitch.isOn == true{
                a.register(key: .anonymous, value: true)
            }else{
                a.register(key: .anonymous, value: false)
            }
            
            errorMessageLabel.isHidden = true
            performSegue(withIdentifier: "photoSegue", sender: nil)
        }else{
            errorMessageLabel.isHidden = false
        }
        
    }

    
    @IBAction func changedValue(_ sender: UISwitch) {
        switch sender.isOn {
        case true:
            let alert = UIAlertController(title: "説明", message: "会社情報を相手に匿名として表示します", preferredStyle: .alert)
            let defaultAction:UIAlertAction = UIAlertAction(title: "OK",style: UIAlertActionStyle.default,handler:{
                                                                (action:UIAlertAction!) -> Void in
                
            })
            alert.addAction(defaultAction)
            present(alert, animated: true, completion: nil)
        case false:
            break
        }
        
        
    }
    
    @IBAction func finishButtonTapped(_ sender: Any) {
        if companyTextField.text?.isEmpty == false{
            let navC = self.navigationController!
            let vc = navC.viewControllers[navC.viewControllers.count-2] as! ProfileRegistrationViewController
            
            vc.schoolNameText = self.companyTextField.text
            vc.facultyText = self.positionTextField.text
            
            
            errorMessageLabel.isHidden = true
        }else{
            errorMessageLabel.isHidden = false
        }
        
    }
    @IBAction func changeButtonTapped(_ sender: Any) {
        
        if companyTextField.text?.isEmpty == false{
            let navC = self.navigationController!
            let vc = navC.viewControllers[navC.viewControllers.count-2] as! ProfileRegistrationViewController
            vc.schoolNameText = companyTextField.text
            vc.facultyText = self.positionTextField.text
            var recruiter = Recruiter()
            if anonymousSwitch.isOn == true{
                recruiter.register(key: .anonymous, value: true)
            }else{
                recruiter.register(key: .anonymous, value: false)
            }
            
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
