//
//  MaskViewController.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/05/31.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class MaskViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {

    @IBOutlet weak var overlayView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let maskLayer:CAShapeLayer = CAShapeLayer()
//        maskLayer.frame.size = CGSize(width: self.view.frame.width, height: self.view.frame.width/4*3)
        
        let maskView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        maskView.center = self.view.center
        
//        overlayView.mask = maskView
        
        
        let maskView02 = UIView()
        maskView02.backgroundColor = UIColor(white: 0, alpha: 0.5) //you can modify this to whatever you need
        maskView02.frame = CGRect(x: 0, y: 0, width: overlayView
            .frame.width, height: overlayView.frame.height)
        
//        overlayView.addSubview(maskView02)
        
        let newView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        newView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        // You can play with these values and find one that fills your need
        let rectangularHole = CGRect(x: view.bounds.width*0, y: view.bounds.height*0.3, width: view.bounds.width, height: view.bounds.height*0.5)
//        overlayView.addSubview(newView)
        overlayView.addSubview(newView)
        
        // Set the mask in the created view
        setMask(with: rectangularHole, in: newView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var myImageView: UIImageView!
    @IBAction func returnToTop(segue: UIStoryboardSegue) {
        print("segue")
        print("desination")
        print(segue.destination)
        print("source")
        print(segue.source)
        
        if segue.identifier  == "unwindCrop"{
            print("unwind")
         let vc = segue.source as! CropEditViewController
//            cropedImageView.image = vc.maskedImage
            cropedImageView.image = vc.maskedImage
            print(vc.maskedImage)
        }
    }
    
    override func unwind(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        print("unwind!!")
        
        
    }
    @IBAction func tapCropButton(_ sender: Any) {
        
//        var image = UIImage(named: "myimage")
//        print(image?.size)
//        let rectV = CGRect(x: 100, y: 100, width: 100, height: 100)
//        let viewV = UIView(frame: rectV)
//        viewV.backgroundColor = UIColor.yellow
////        self.view.addSubview(viewV)
//        viewV.alpha = 0.7
//        myImageView.addSubview(viewV)
//        
//        let widthRatio = image!.size.width/myImageView.frame.width
//        let heightRatio = image!.size.height/myImageView.frame.height
//        let rect:CGRect = CGRect(x: 100*widthRatio, y: 100*heightRatio*image!.size.height/image!.size.width, width: 100*widthRatio, height: 100*heightRatio)
////        UIGraphicsBeginImageContext(CGSize(width: 50, height: 50))
////        image = UIGraphicsGetImageFromCurrentImageContext()
////        UIGraphicsEndImageContext()
//        
////        let cropedImage:UIImage = crop(image: myImageView.image!, withWidth: 10, andHeight: 100)!
////        cropedImageView.image = myImageView.image.
////        let image:CGImage = myImageView.image?.cgImage
////        if let image:CGImage = myImageView.image?.cgImage{
////            cropedImageView.image = UIImage(cgImage: image.cropping(to: rect)!, scale: myImageView.image!.scale/10, orientation: UIImageOrientation.down)
////        }
////        cropedImageView.contentMode = .center
//        
////        let cropedImage = cropThumbnailImage(image: myImageView.image!, w: 100, h: 100)
//        cropedImageView.image = image?.cropping(to: rect)
//        cropedImageView.image?.resizingMode
//        cropedImageView.contentMode = .center
        
        guard let urlString:URL = URL(string:"http:52.163.126.71/test/createDBtest.php") else { return }
        var request = URLRequest(url: urlString)
        request.httpMethod = "GET"
        
        
        let task = try URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error == nil{
                print("data:\(data)")
                print("res:\(response)")
            }else{
                print("error:\(error)")
            }
        }
        
        
        task.resume()
        
        
    }
    
    func cropThumbnailImage(image :UIImage, w:Int, h:Int) ->UIImage
    {
        // リサイズ処理
        let origRef    = image.cgImage
        let origWidth  = Int(origRef!.width)
        let origHeight = Int(origRef!.height)
        var resizeWidth:Int = 0, resizeHeight:Int = 0
        
        if (origWidth < origHeight) {
            resizeWidth = w
            resizeHeight = origHeight * resizeWidth / origWidth
        } else {
            resizeHeight = h
            resizeWidth = origWidth * resizeHeight / origHeight
        }
        
        let resizeSize = CGSize.init(width: CGFloat(resizeWidth), height: CGFloat(resizeHeight))
        
        UIGraphicsBeginImageContext(resizeSize)
        
        image.draw(in: CGRect.init(x: 0, y: 0, width: CGFloat(resizeWidth), height: CGFloat(resizeHeight)))
        
        let resizeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // 切り抜き処理
        
        let cropRect  = CGRect.init(x: CGFloat((resizeWidth - w) / 2), y: CGFloat((resizeHeight - h) / 2), width: CGFloat(w), height: CGFloat(h))
        let cropRef   = resizeImage!.cgImage!.cropping(to: cropRect)
        let cropImage = UIImage(cgImage: cropRef!)
        
        return cropImage
    }
    
    func crop(image: UIImage, withWidth width: Double, andHeight height: Double) -> UIImage? {
        
        if let cgImage = image.cgImage {
            
            let contextImage: UIImage = UIImage(cgImage: cgImage)
            
            let contextSize: CGSize = contextImage.size
            
            var posX: CGFloat = 0.0
            var posY: CGFloat = 0.0
            var cgwidth: CGFloat = CGFloat(width)
            var cgheight: CGFloat = CGFloat(height)
            
            // See what size is longer and create the center off of that
            if contextSize.width > contextSize.height {
                posX = ((contextSize.width - contextSize.height) / 2)
                posY = 0
                cgwidth = contextSize.height
                cgheight = contextSize.height
            } else {
                posX = 0
                posY = ((contextSize.height - contextSize.width) / 2)
                cgwidth = contextSize.width
                cgheight = contextSize.width
            }
            
            let rect: CGRect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)
            
            // Create bitmap image from context using the rect
            var croppedContextImage: CGImage? = nil
            if let contextImage = contextImage.cgImage {
                if let croppedImage = contextImage.cropping(to: rect) {
                    croppedContextImage = croppedImage
                }
            }
            
            // Create a new image based on the imageRef and rotate back to the original orientation
            if let croppedImage:CGImage = croppedContextImage {
                let image: UIImage = UIImage(cgImage: croppedImage, scale: image.scale, orientation: image.imageOrientation)
                return image
            }
            
        }
        
        return nil
    }

    @IBAction func uploadImage(_ sender: UIButton) {
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
    
    var selectedImage:UIImage?
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        profileImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
//        selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
//        registerButton.isEnabled = true
//        registerButton.alpha = 1
//        dismiss(animated: true, completion: nil)
        
        selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
//        myImageView.image = selectedImage
        
//        dismiss(animated: true) { 
//            print("selected image")
//            self.performSegue(withIdentifier: "segueCrop", sender: nil)
//        }
//        dismiss(animated: true, completion: nil)
//        performSegue(withIdentifier: "segueCrop", sender: nil)
        dismiss(animated: true) {
            self.performSegue(withIdentifier: "segueCrop", sender: self.selectedImage)
        }
        
//        let nextVC:UIViewController = CropEditViewController()
//        self.present(nextVC, animated: true, completion: nil)
        
    }
    
    @IBAction func segueButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "segueCrop", sender: nil)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueCrop"{
         let vc = segue.destination as! CropEditViewController
            vc.originalImage = selectedImage
//            vc.originalSelectedImageView.image
//            vc.originalSelectedImageView.image = sender as! UIImage
//            vc.originalSelectedImageView.image = UIImage(named: "myimage")
        }
    }
    
    @IBOutlet weak var cropedImageView: UIImageView!
    
    func setMask(with hole: CGRect, in view: UIView){
        
        // Create a mutable path and add a rectangle that will be h
        let mutablePath = CGMutablePath()
        mutablePath.addRect(view.bounds)
        mutablePath.addRect(hole)
        
        // Create a shape layer and cut out the intersection
        let mask = CAShapeLayer()
        mask.path = mutablePath
        mask.fillRule = kCAFillRuleEvenOdd
        
        // Add the mask to the view
        view.layer.mask = mask
        
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

//extension UIImage {
//    func cropping(to rect: CGRect) -> UIImage {
//        UIGraphicsBeginImageContextWithOptions(rect.size, false, self.scale)
//        
//        self.draw(in: CGRect(x: -rect.origin.x, y: -rect.origin.y, width: self.size.width, height: self.size.height))
//        
//        let croppedImage = UIGraphicsGetImageFromCurrentImageContext()!
//        UIGraphicsEndImageContext()
//        
//        return croppedImage
//    }
//}

extension UIImage {
    func cropping(to: CGRect) -> UIImage? {
        var opaque = false
        if let cgImage = cgImage {
            switch cgImage.alphaInfo {
            case .noneSkipLast, .noneSkipFirst:
                opaque = true
            default:
                break
            }
        }
        
        UIGraphicsBeginImageContextWithOptions(to.size, opaque, scale)
        draw(at: CGPoint(x: -to.origin.x, y: -to.origin.y))
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
}
