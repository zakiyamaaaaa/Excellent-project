//
//  LoginViewController.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/08/11.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController,UITextFieldDelegate{

    @IBOutlet weak var errorMessageLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        
        if let uuid = Auth.auth().currentUser?.uid {
            var a = my()
            a.register(key: .uuid, value: uuid)
        }
        // Do any additional setup after loading the view.
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func loginButtonTapoed(_ sender: Any) {
        login()
    }
    
    func login(){
        guard let email = emailTextField.text else{return}
        guard let password = passwordTextField.text else{return}
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { (FIRUser, Error) in
            if Error == nil{
                if FIRUser?.isEmailVerified != nil{
//                    self.RegisterUser()
                    
                    //次の画面に遷移
                    let storyboard = UIStoryboard(name: "Register", bundle: nil)
                    guard let vc = storyboard.instantiateInitialViewController() else { return }
                    self.show(vc, sender: nil)
                    
                }else{
//                    self.validationAlert()
                    self.errorMessageLabel.isHidden = false
                    self.errorMessageLabel.text = "メールアドレスの認証がまだできていません。"
                }
            }else{
                print(Error!.localizedDescription)
//                self.verificationErrorLabel.text = Error!.localizedDescription
//                self.verificationErrorLabel.isHidden = false
            }
            
        })
    }
    
    func RegisterUser(){
        guard let email = emailTextField.text else {return}
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let ref = Database.database().reference()
        ref.child("users").child((Auth.auth().currentUser?.uid)!).setValue(["UUID":uid,"CreateDate":ServerValue.timestamp(),"email":email,"valid":false])
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
