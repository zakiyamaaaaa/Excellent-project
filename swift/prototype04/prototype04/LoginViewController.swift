//
//  LoginViewController.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/08/11.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit
import Firebase

//ログイン画面
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
    
    @IBAction func resetPassWord(_ sender: Any) {
        let alert = UIAlertController(title: "パスワードの再設定", message: "登録したメールアドレスを入力してください", preferredStyle: .alert)
        alert.addTextField(configurationHandler: { (UITextField) in
            UITextField.placeholder = "メールアドレス"
            
            
        })
        
        
        let okAction:UIAlertAction = UIAlertAction(title: "送信", style: .default, handler: { (UIAlertAction) in
            let textField = alert.textFields![0] as UITextField
            if textField.text != nil{
                let auth = Auth.auth()
                //Firebase側にパスワードリセットをリクエストする
                 auth.sendPasswordReset(withEmail: textField.text!, completion: { (Error) in
                    if Error == nil{
                        let alert = UIAlertController(title: "パスワードのリセット", message: "入力したメールアドレスに再設定用のメールを送信しました。ご確認ください", preferredStyle: .alert)
                        
                        
                        self.present(alert, animated: true, completion: {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute:
                                {
                                    alert.dismiss(animated: true, completion: {
                                        self.dismiss(animated: true, completion: nil)
                                    })
                            })
                        })
                    }else{
                        
                        let alert = UIAlertController(title: "無効なメールアドレス", message: "入力したメールアドレスは登録されていません。再度ご確認ください", preferredStyle: .alert)
                        
                        
                        self.present(alert, animated: true, completion: {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute:
                                {
                                    self.present(alert, animated: true, completion: nil)
                            })
                        })
                    }
                })
                
                
            }else{
                self.present(alert, animated: true, completion: nil)
            }
            
        })
        let cancelAction:UIAlertAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: { (UIAlertAction) in
            
        })
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func loginButtonTapoed(_ sender: Any) {
        login()
    }
    
    func login(){
        guard let email = emailTextField.text else{return}
        guard let password = passwordTextField.text else{return}
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { (FIRUser, error) in
            if error == nil{
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
                print(error!.localizedDescription)
                
                if error!.localizedDescription == "There is no user record corresponding to this identifier. The user may have been deleted."{
                    self.errorMessageLabel.isHidden = false
                    self.errorMessageLabel.text = "登録されていないメールアドレスです"
                }
                
                if error!.localizedDescription == "The email address is badly formatted."{
                    self.errorMessageLabel.isHidden = false
                    self.errorMessageLabel.text = "登録されていないメールアドレスです"
                }
                
                if error!.localizedDescription == "The password is invalid or the user does not have a password."{
                    self.errorMessageLabel.isHidden = false
                    self.errorMessageLabel.text = "パスワードが違います"
                }
//                print(ErrorUserInfoKey.RawValue())
//                print(AuthErrorCode.emailAlreadyInUse)
//                print(AuthErrorCode)
//                print(AuthErrors)
//                if Error.debugDescription == AuthErrorCode.invalidEmail{
//                    print("hoge")
//                }
//                if Error == AuthErrorCode.invalidEmail{
//                    print("hogea")
//                }
                
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
