//
//  RegisterPhotoViewController02.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/06/07.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class RegisterPhotoViewController02: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIViewControllerTransitioningDelegate {

    @IBOutlet weak var imageFrameView: UIView!
    @IBOutlet weak var myImageView: UIImageView!
    
    var selectedImage:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        imageFrameView.layer.borderWidth = 1
        myImageView.layer.borderWidth = 1
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func uploadPhoto(_ sender: Any) {
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
            self.performSegue(withIdentifier: "segueCrop", sender: self.selectedImage)
        }
    }
    
    @IBAction func returnToTop(segue: UIStoryboardSegue) {
        
        if segue.identifier  == "unwindCrop"{
            print("unwind")
            let vc = segue.source as! CropEditViewController
            myImageView.image = vc.maskedImage
            
//            registerButton.isEnabled = true
//            registerButton.alpha = 1
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        if segue.identifier == "segueCrop"{
            let vc = segue.destination as! CropEditViewController
            vc.originalImage = selectedImage
        }
    }

    @IBAction func backVC(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return Animation()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return Animation()
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        let documentDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let imgFileName = "sample.png"
        
        if let image = myImageView.image {
            let pngData = UIImagePNGRepresentation(image)
            do{
                try pngData?.write(to: URL(fileURLWithPath: "\(documentDir)/\(imgFileName)"))
            }catch{
                print(error.localizedDescription)
            }
        }
            
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "previewVC") as! PreviewViewController02
        vc.transitioningDelegate = self
        self.present(vc, animated: true, completion: nil)
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
