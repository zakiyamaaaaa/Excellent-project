//
//  ViewController.swift
//  mulipartPostTest
//
//  Created by shoichiyamazaki on 2017/04/17.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, URLSessionDelegate {

    let userProfileImageView:UIImageView = UIImageView()
    var userProfileImage:UIImage?
    
    var file:NSData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func uploadPhotoAction(_ sender: Any) {
        
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
    
    
    @IBAction func postDataAction(_ sender: Any) {
        
        
//        if file == nil {return}
//        let myData:[String:Any] = ["id":"aaa","username":"hoge","imgfile":file!]
        
        registerDataFirstToMysql()
    }

    
    func registerDataFirstToMysql(){
        if userProfileImage == nil{
            return
        }
        
        let url:URL = URL(string: "http://localhost:8888/test/upload.php")!
//        let dict:[String:Any] = data as! [String:Any]
//        let img = dict["imgfile"] as! NSData
//        let img:UIImage = UIImage(named: "profile-photo03")!
//        let imgData = UIImagePNGRepresentation(img)! as NSData
        
        let uuid = UUID().uuidString
        let boundary = "multipart/form-data; boundary = " + uuid
        let session = URLSession.shared
        var request = URLRequest(url: url)
//        var body:NSMutableData = NSMutableData()
        let length = file?.length as! Int
        
        request.httpMethod = "POST"
        request.setValue(String(length), forHTTPHeaderField: "Content-Length")
        request.setValue(boundary, forHTTPHeaderField: "Content-Type")
        request.httpBody = CreateMultipart(boundary: uuid, key: "test", fileName: "profile-photo03.php", mineType: "image/png", postData: file as! Data)
        
        
        session.dataTask(with: request) { (data, response, error) in
//            if error != nil{
            print("request:\(request)")
                print("data:\(data)")
                print("response:\(response)")
            
            let str = String(data:data!,encoding:String.Encoding.utf8)
            print("str:\(str)")
//            }else{
//                print(error?.localizedDescription)
//            }
        }.resume()
        
    }
    
    func CreateMultipart(boundary:String, key:String, fileName:String, mineType:String, postData:Data)->Data{
        var multiPart:Data = Data()
        multiPart.append("--\(boundary)\r\n".data(using: .utf8)!)
        multiPart.append("Content-Disposition: form-data;".data(using: .utf8)!)
        multiPart.append("name=\"\(key)\";".data(using: .utf8)!)
        multiPart.append("filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        multiPart.append("Content-Type:\(mineType)\r\n\r\n".data(using: .utf8)!)
        multiPart.append(postData)
        multiPart.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        return multiPart as Data
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        userProfileImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        file = UIImagePNGRepresentation(userProfileImage!) as! NSData //step1
        
        print(type(of: file?.base64EncodedData(options: [])))
        dismiss(animated: true, completion: nil)
    }
}

