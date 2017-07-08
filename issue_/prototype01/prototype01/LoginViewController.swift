//
//  LoginViewController.swift
//  prototype01
//
//  Created by shoichiyamazaki on 2017/04/15.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var verificationEmailTextField: UITextField!
    
    @IBOutlet weak var verificationErrorLabel: UILabel!
    

    private var userId:String?
    
    let ref = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.placeholder = "Email"
        emailTextField.delegate = self
        passwordTextField.placeholder = "Password"
        passwordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
        
        verificationErrorLabel.isHidden = true
        verificationErrorLabel.numberOfLines = 2
        verificationErrorLabel.textColor = UIColor.red
        
        
        
        // Do any additional setup after loading the view.
    }
    
    //Login Button Tapped
    @IBAction func loginButton(_ sender: Any) {
        login()
    }
    
    @IBAction func verificationEmailSendButton(_ sender: Any) {
        
    }
    
    func FbCreateUser(){
        guard let email = emailTextField.text else {return}
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {return}
        
        self.ref.child("users").child((FIRAuth.auth()?.currentUser?.uid)!).setValue(["uid":uid,"CreateDate":FIRServerValue.timestamp(),"email":email])
        
        //Local Data Save
        setUDData(uid: uid, email: email)
        
        userId = uid
    }
    
    func setUDData(uid:String,email:String){
        let ud = UserDefaults.standard
        ud.set(uid, forKey: "uid")
        ud.set(email, forKey: "email")
    }
    
    
    //Signup Button Tapped
    @IBAction func signupButton(_ sender: Any) {
//        let signupVC:UIViewController = SignupViewController()
//        self.present( self.storyboard. signupVC, animated: true, completion: nil)
//        let signup = self.storyboard!.instantiateViewController(withIdentifier: "signup")
//        self.performSegue(withIdentifier: "signup", sender: nil)
        transitionToSignupView()
    }
    
    func login(){
        guard let email = emailTextField.text else{return}
        guard let password = passwordTextField.text else{return}
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (FIRUser, Error) in
            if Error == nil{
                if self.checkUserValidate(user: FIRUser!){
                    self.FbCreateUser()
                    self.transitionToUserProfileView()
                }else{
                    self.validationAlert()
                    
                }
            }else{
                print(Error!.localizedDescription)
                self.verificationErrorLabel.text = Error!.localizedDescription
                self.verificationErrorLabel.isHidden = false
            }
            
        })
    }
    
    func checkUserValidate(user:FIRUser)->Bool{
        return user.isEmailVerified
    }
    
    
    
    func transitionToSignupView(){
        let signupVC = self.storyboard!.instantiateViewController(withIdentifier: "signup")
        self.present(signupVC, animated: true, completion: nil)
    }
    
    func transitionToUserProfileView(){
        let userProfileVC = self.storyboard!.instantiateViewController(withIdentifier: "userprofile")
        self.present(userProfileVC, animated: true, completion: nil)
    }
    
    func validationAlert(){
        let alert = UIAlertController(title: "メール認証", message: "メール認証をおこなってください", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
