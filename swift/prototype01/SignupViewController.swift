//
//  SignupViewController.swift
//  prototype01
//
//  Created by shoichiyamazaki on 2017/04/16.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit
import Firebase

class SignupViewController: UIViewController,UITextFieldDelegate {

//    @IBOutlet weak var signupEmailTextField: UITextField!
//    
//    @IBOutlet weak var signupPasswordTextField: UITextField!
    //なんかstoryboardで作ったviewControllerに対して、普通に。
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        signupEmailTextField.delegate = self
//        signupEmailTextField.placeholder = "Email"
//        signupPasswordTextField.delegate = self
//        signupPasswordTextField.placeholder = "Password"
//        signupPasswordTextField.isSecureTextEntry = true
//        
//        // Do any additional setup after loading the view.
//    }
//    
    
    @IBOutlet weak var signUpEmailTextField: UITextField!
    @IBOutlet weak var signUpPasswordTextField: UITextField!
    
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var successMessage: UILabel!
    
    let ref = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        signUpEmailTextField.delegate = self
        signUpPasswordTextField.delegate = self
        
        signUpEmailTextField.placeholder = "Email"
        signUpPasswordTextField.placeholder = "Password"
        signUpPasswordTextField.isSecureTextEntry = true
        
        errorMessageLabel.isHidden = true
        errorMessageLabel.textColor = UIColor.red
        
        successMessage.isHidden = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func userResisterButton(_ sender: Any) {
        signUp()
        
    }
    
    func signUp(){
        guard let email = signUpEmailTextField?.text else {return}
        guard let password = signUpPasswordTextField?.text else {return}
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, Error) in
            if Error == nil{
                user?.sendEmailVerification(completion: { (Error) in
                    if Error == nil{
                        //認証メール送信成功
                        print("success to send Email")
                        self.showNotificationEmailVerification()
//                        self.successMessage.isHidden = false
//                        self.successMessage.text = "入力したアドレスに確認メールを送信しました。\nご確認ください"
                    }else{
                        //認証メール送信失敗
                        self.errorMessageLabel?.isHidden = false
                        self.errorMessageLabel?.text = Error?.localizedDescription
                    }
                })
            }else{
                //ユーザー入力内容エラー
                self.errorMessageLabel?.isHidden = false
                self.errorMessageLabel?.text = Error?.localizedDescription
            }
        })
    }
    
    
    func showNotificationEmailVerification(){
        let alert = UIAlertController(title: "登録ありがとうございます", message: "登録したメールアドレスに確認用メールを送信しました。\nご確認ください", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }

//    @IBAction func userResisterButton_(_ sender: Any) {
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
