//
//  UserProfileViewController.swift
//  prototype01
//
//  Created by shoichiyamazaki on 2017/04/16.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate ,URLSessionTaskDelegate{

    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var userProfileImageView: UIImageView!
    
    @IBOutlet weak var beginFirstButton: UIButton!
    @IBOutlet weak var continueWriteProfileButton: UIButton!
    
    
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.delegate = self
        usernameTextField.placeholder = "UserName"
        errorMessageLabel.isHidden = true
        
        let buttonRadius:CGFloat = 50
        let buttonSize:CGSize = CGSize(width: buttonRadius*2, height: buttonRadius*2)
        
        beginFirstButton.backgroundColor = UIColor.green
        beginFirstButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        beginFirstButton.layer.cornerRadius = buttonRadius
        beginFirstButton.frame.size = buttonSize
        
        continueWriteProfileButton.backgroundColor = UIColor.orange
        continueWriteProfileButton.setTitleColor(UIColor.white, for: .normal)
        continueWriteProfileButton.frame.size = buttonSize
        continueWriteProfileButton.layer.cornerRadius = buttonRadius
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func imageUploadButton(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Confirmation", message: "Choose", preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { (UIAlertAction) in
                let ipc = UIImagePickerController()
                ipc.sourceType = .camera
                ipc.delegate = self
                self.present(ipc, animated: true, completion: nil)
                
            })
            alertController.addAction(cameraAction)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: { (UIAlertAction) in
                let ipc = UIImagePickerController()
                ipc.sourceType = .photoLibrary
                ipc.delegate = self
                self.present(ipc, animated: true, completion: nil)
            })
            alertController.addAction(photoLibraryAction)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        userProfileImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        dismiss(animated: true, completion: nil)
    }

    @IBAction func beginFirstButton(_ sender: Any) {
        //メインビューへ移動
        //ユーザーネーム、画像が入力されているかチェック。
        let userName:String?
        let userProfileImage:UIImage?
        
        let ud = UserDefaults.standard
        guard let uuid = ud.string(forKey: "uid") else { print("Not set UUID in User Default"); return }
        guard let email = ud.string(forKey: "email") else { print("Not set email in User Default"); return }
        
        // Check UserName TextField
        if usernameTextField.hasText == false {
            errorMessageLabel.isHidden = false
            errorMessageLabel.text = "Error:Input User Name"
            errorMessageLabel.textColor = UIColor.red
            return
        }else{
            userName = usernameTextField.text
            ud.set(userName, forKey: "username")
        }
        
        
        //Check User Image
        if userProfileImageView.image == nil{
            errorMessageLabel.isHidden = false
            errorMessageLabel.text = "Error:Input Your Profile Image"
            errorMessageLabel.textColor = UIColor.red
            return
        }else{
            userProfileImage = userProfileImageView.image
        }
        
        //PostProfileData
        postProfile(uuid: uuid, userName: userName!,email:email, profileImage: userProfileImage!)
//        transitionToSearchLocationView()
    }
    
    func postProfile(uuid:String,userName:String,email:String, profileImage:UIImage){
        
        let pngImageData = UIImagePNGRepresentation(profileImage)! as NSData
        let EncodedImageData = pngImageData.base64EncodedString(options: [])
        let postData:[String:Any] = ["uid":uuid,"userName":userName,"email":email,"profileImage":EncodedImageData]
        
        
        guard let urlString = URL(string: "http://localhost:8888/test/registerProfile.php") else { return }
        var request = URLRequest(url: urlString)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: postData, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                let str = String(data: data! , encoding:.utf8)
                print("sta:\(str)")
                print("resposnse:\(response)")
                self.transitionToSearchLocationView()
            })
            task.resume()
        }catch{
            print("Error:\(error.localizedDescription)")
        }
        
    }
    
    func transitionToSearchLocationView(){
        let searchLocationVC = self.storyboard!.instantiateViewController(withIdentifier: "searchLocation")
        self.present(searchLocationVC, animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    
    @IBAction func continueWriteProfileButton(_ sender: Any) {
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
