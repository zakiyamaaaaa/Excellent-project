//
//  ViewController.swift
//  MyCameraApp
//
//  Created by 山崎翔一 on 2017/03/12.
//  Copyright © 2017年 山崎翔一. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


  @IBOutlet weak var pictureImage: UIImageView!
  
  @IBAction func cameraButtonAction(_ sender: Any) {
    //カメラかフォトライブラリーどちらから画像を取得するか選択
    let alertController = UIAlertController(title: "確認", message: "選択してください", preferredStyle: .actionSheet)
    
    //カメラが利用可能かどうかのチェック
    if UIImagePickerController.isSourceTypeAvailable(.camera){
      let cameraAction = UIAlertAction(title: "カメラ", style: .default, handler: {(action:UIAlertAction)in
        
        //start camera
        let ipc : UIImagePickerController = UIImagePickerController()
        ipc.sourceType = .camera
        ipc.delegate = self
        self.present(ipc,animated: true, completion: nil)
        
        })
      alertController.addAction(cameraAction)
    }
    
    if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
      
      let photoLibraryAction = UIAlertAction(title: "フォトライブラリー", style: .default, handler: {(action:UIAlertAction) in
      
        //start photolibrary
        let ipc : UIImagePickerController = UIImagePickerController()
        ipc.sourceType = .photoLibrary
        ipc.delegate = self
        self.present(ipc,animated: true, completion: nil)
      })
      alertController.addAction(photoLibraryAction)
    }
    
    
    let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
    alertController.addAction(cancelAction)
    
    alertController.popoverPresentationController?.sourceView = view
    present(alertController, animated: true,completion: nil)
    
    
    // check if camera is available or not
    if UIImagePickerController.isSourceTypeAvailable(.camera){
      print("カメラは利用できます")
      
      let ipc = UIImagePickerController()
      
      ipc.sourceType = .camera
      
      ipc.delegate = self
      
      present(ipc,animated: true, completion: nil)
    }else{
      print("カメラが利用できません")
    }
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String:Any]){
    
//    pictureImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    captureImage = info[UIImagePickerControllerOriginalImage] as? UIImage
    
    dismiss(animated:true, completion:{
      self.performSegue(withIdentifier: "showEffectView", sender: nil)
    })
    
//    dismiss(animated: true, completion: nil)
  }
  // Place to put image when moving to next screen
  var captureImage:UIImage?
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let nextViewController = segue.destination as! EffectViewController
    
    nextViewController.originalImage = captureImage
  }
}

