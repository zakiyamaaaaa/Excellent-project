//
//  RegisterMailViewController.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/08/11.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit
import Firebase

class RegisterMailViewController: UIViewController,UITextFieldDelegate{

    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var regiterButton: RectButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func registerButtonTapped(_ sender: Any) {
        signUp()
        
    }
    
    func signUp(){
        let inputEmail = emailTextField.text
        let inputPassword = passwordTextField.text
        
        Auth.auth().createUser(withEmail: inputEmail!, password: inputPassword!, completion: { (user, Error) in
            if Error == nil{
                user?.sendEmailVerification(completion: { (Error) in
                    if Error == nil{
                        //認証メール送信成功
                        print("success to send Email")
                        self.performSegue(withIdentifier: "sendMailSegue", sender: nil)
                        //                        self.successMessage.isHidden = false
                        //                        self.successMessage.text = "入力したアドレスに確認メールを送信しました。\nご確認ください"
                    }else{
                        //認証メール送信失敗
                        //アラート表示
//                        self.errorMessageLabel?.isHidden = false
//                        self.errorMessageLabel?.text = Error?.localizedDescription
                        print(Error!.localizedDescription + "1")
                    }
                })
            }else{
                //ユーザー入力内容エラー
                //アラート表示
                
                self.errorMessageLabel?.isHidden = false
                if Error.debugDescription == "The email address is already in use by another account."{
                    self.errorMessageLabel.text = "このアドレスはすでに登録されています"
                }
                if Error.debugDescription == "The password must be 6 characters long or more"{
                    self.errorMessageLabel.text = "パスワードは６文字以上で入力してください"
                }
                
                if Error.debugDescription == "The email address is badly formatted."{
                    self.errorMessageLabel.text = "無効なメールアドレスです"
                }
                //The email address is badly formatted.
                //The password must be 6 characters long or more
                //The email address is already in use by another account.
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sendMailSegue"{
            let vc = segue.destination as! MailModalViewController
            vc.inputEmail = emailTextField.text!
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
