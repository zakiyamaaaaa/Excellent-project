//
//  ProfileRegistrationViewController.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/08/12.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class ProfileRegistrationViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPickerViewDelegate{

    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myNameLabel: UILabel!
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var myBirthLabel: UILabel!
    @IBOutlet weak var facultyLabel: UILabel!
    @IBOutlet weak var graduationYearLabel: UILabel!
    var selectedImage:UIImage?
    var nameText:String?
    var birthText:String?
    var schoolNameText:String?
    var facultyText:String?
    var graduationText:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var a = my()
        
        var educationArray:[Any] = a.getValue(key: .education) as! [Any]
        
        nameText = a.getValue(key: .name) as? String
        schoolNameText = educationArray[0] as? String
        facultyText = educationArray[1] as? String
        birthText = a.getValue(key: .birth) as? String
        graduationText = educationArray[2] as? String
        
        let documentDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let imgFileName = "userimg.png"
        let tmp = UIImage(contentsOfFile: "\(documentDir)/\(imgFileName)")
        myImageView.image = tmp
    }
    
    override func viewWillAppear(_ animated: Bool) {
        myNameLabel.text =  nameText
        schoolNameLabel.text = schoolNameText
        facultyLabel.text = facultyText
        myBirthLabel.text = birthText
        graduationYearLabel.text = graduationText
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { 
            
        }
        
    }
    
    @IBAction func uploadButtonTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Confirmation", message: "Choose", preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            print("Available to camera")
            
            
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: {(action:UIAlertAction) in
                let ipc = UIImagePickerController()
                ipc.sourceType = .camera
                ipc.delegate = self
                self.present(ipc, animated:true, completion: nil)
                
            })
            alertController.addAction(cameraAction)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: {(actioin:UIAlertAction) in
                
                let ipc :UIImagePickerController = UIImagePickerController()
                ipc.sourceType = .photoLibrary
                ipc.delegate = self
                self.present(ipc, animated:true, completion: nil)
                
                
            })
            alertController.addAction(photoLibraryAction)
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController,animated: true,completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        dismiss(animated: true) {
            self.performSegue(withIdentifier: "cropImageSegue", sender: self.selectedImage)
        }
    }

    @IBAction func editEducationInfo(_ sender: Any) {
        
        performSegue(withIdentifier: "editEducationInfoSegue", sender: nil)
        
    }
    
    @IBAction func editBasicInfo(_ sender: Any) {
        performSegue(withIdentifier: "basicInfoSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "basicInfoSegue"{
            let vc = segue.destination as! RegisterBasicInfoViewController
            vc.namaText = nameText
            vc.birthText = birthText
        }
        
        if segue.identifier == "editEducationInfoSegue"{
            let vc = segue.destination as! RegisterEducationViewController
            vc.schoolNameText = schoolNameText
            vc.facultyText = facultyText
            vc.graduationYearText = graduationText
        }
        
        if segue.identifier == "cropImageSegue"{
            let vc = segue.destination as! CropEditViewController
            vc.originalImage = selectedImage
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func returnToTop(segue: UIStoryboardSegue) {
        
        if segue.identifier  == "unwindCrop"{
            
            let vc = segue.source as! CropEditViewController
            myImageView.image = vc.maskedImage
        }
    }
    
    
    @IBAction func updateUser(_ sender: Any) {
        //userdefault更新して、サーバーのDBもデータ更新
        
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
