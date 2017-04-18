//
//  ViewController.swift
//  multipartPOSTTest02
//
//  Created by shoichiyamazaki on 2017/04/18.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    @IBOutlet weak var PostAction: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func UploadAction(_ sender: Any) {
        ImagePick()
        
    }

    
    @IBAction func postAction(_ sender: Any) {
        HttpPostRequest()
    }
    
    func HttpPostRequest(){
        do{
            let uuid = UUID().uuidString
            
            let boundary = "multipart/form-data; boundary=" + uuid
            
            let session:URLSession = URLSession(configuration: .default)
            
//            let imagePath = Bundle.main.path(forResource: "dl", ofType: "png")
//            
//            let imageData:NSData = try! NSData(contentsOfFile: imagePath!)
            
            let imageData:NSData = file!
            
            let url:URL = URL(string: "http://localhost:8888/test/upload.php")!
            
            var request: URLRequest = URLRequest(url: url)
            
            let hogeId = "hogehogehoge"
            
            request.setValue("\(imageData.length)", forHTTPHeaderField: "Content-Length")
            request.setValue(boundary, forHTTPHeaderField: "Content-Type")
            request.httpBody = CreateMultipart(boundary: uuid, key: "upfile", fileName: "\(hogeId).png", mineType: "image/png", postData: imageData as Data)


            request.httpMethod = "POST"
            
            session.dataTask(with: request, completionHandler: { (data, response, error) in
                let str = String(data:data!, encoding:String.Encoding.utf8)
                print("response\(response)")
                print("str:\(str)")
            }).resume()
        }
    }
    
    func CreateMultipart(boundary:String, key:String, fileName: String, mineType:String, postData:Data)->Data{
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
    
    func ImagePick(){
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
    
    var userProfileImage:UIImage?
    var file:NSData?
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        userProfileImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        file = UIImagePNGRepresentation(userProfileImage!) as! NSData //step1
        
        print(type(of: file?.base64EncodedData(options: [])))
        dismiss(animated: true, completion: nil)
    }
    
}

