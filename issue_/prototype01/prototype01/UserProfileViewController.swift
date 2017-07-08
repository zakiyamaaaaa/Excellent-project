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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.delegate = self
        usernameTextField.placeholder = "UserName"
        
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
        
        let alertController = UIAlertController(title: "Confirmaetin", message: "Chose", preferredStyle: .actionSheet)
        
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
        
        let ud = UserDefaults.standard
        let uid = ud.string(forKey: "uid")
        
        guard let username = usernameTextField.text else { return }
        let file:NSData = UIImagePNGRepresentation(userProfileImageView.image!)! as NSData
        let myData:[String:Any] = ["uid":uid,"username":username,"imgfile":file]
//        var username1 = "default"
        print("uid:\(uid)")
        print("username:\(username)")
//        print("file:\(file))")
        self.registerDataFirstToMysql(myData)
        
        dismiss(animated: true, completion: nil)
    }

    @IBAction func beginFirstButton(_ sender: Any) {
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let ud = UserDefaults.standard
        
        guard let username = usernameTextField.text else {return}
        ud.set(username, forKey: "username")
        
        //mysqlへデータPOST
    }
    
    
    func registerDataFirstToMysql(_ data:Any){
        let myConfig:URLSessionConfiguration = URLSessionConfiguration.default
        let url:URL = URL(string: "http://localhost:8888/test/resister_first_userdata.php")!
        
        var request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        
        if userProfileImageView.image != nil{
            do{
                request.httpBody = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                let task:URLSessionDataTask = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (resData, res, error) in
                    
                })
                task.resume()
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
//    func registerDataFirstToMysql(){
//        let myConfig:URLSessionConfiguration = URLSessionConfiguration.default
//        let url:NSURL = NSURL(string: "http://localhost:8888/test/register_first_data.php")!
//        
//        var request:URLRequest = URLRequest(url: url as URL)
//        request.httpMethod = "POST"
//        
//        let session:URLSession = URLSession(configuration: myConfig, delegate: self, delegateQueue: OperationQueue.main)
//        
//        if userProfileImageView.image != nil{
//            let file:NSData = UIImagePNGRepresentation(userProfileImageView.image!)! as NSData
////            let image:UIImage = UIImage(data: file as Data)!
//            
//            let task:URLSessionUploadTask = session.uploadTask(with: request, from: file as Data)
//            task.resume()
//        }
//    }
    
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
