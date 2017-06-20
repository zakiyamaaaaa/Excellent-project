//
//  ViewController.swift
//  cardDesignPrototype
//
//  Created by shoichiyamazaki on 2017/06/20.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cardDetailView: UIScrollView!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var label: UIImageView!
    @IBOutlet weak var userCard: UserCard!
    @IBOutlet weak var companyIntroductionTextView: UITextView!
    
    let statusBarHeight = UIApplication.shared.statusBarFrame.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let maskPath = UIBezierPath(roundedRect: myImageView.frame, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 10, height: 10))
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        
        let maskLayer2 = CAShapeLayer()
        maskLayer2.path = maskPath.cgPath
        
        myImageView.layer.mask = maskLayer
        label.layer.mask = maskLayer2
        
        companyIntroductionTextView.layer.masksToBounds = true
        companyIntroductionTextView.layer.cornerRadius = 5
        companyIntroductionTextView.layer.borderWidth = 1
//        let tappedImageGesture = UIGestureRecognizer(target: self, action: #selector(self.tappedImage(gestureRecognizer:)))
//        let tappedImageGesture = UIGestureRecognizer(target: self, action: Selector("tappedImage:"))
        let tappedImageGesrute = UITapGestureRecognizer(target: self, action: #selector(self.tappedImage(gestureRecognizer:)))
//        myImageView.addGestureRecognizer(tappedImageGesrute)
//        self.view.addGestureRecognizer(tappedImageGesrute)
        userCard.addGestureRecognizer(tappedImageGesrute)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.cardDetailView.transform = CGAffineTransform.init(translationX: 0, y: 0)
        }
        cardDetailView.isHidden = true
        statusBarChange()
        
    }
    
    
    func tappedImage(gestureRecognizer:UITapGestureRecognizer){
        print("tapped")
        
        
        UIView.animate(withDuration: 0.3) {
            self.cardDetailView.transform = CGAffineTransform.init(translationX: 0, y: -15)
            self.cardDetailView.isHidden = false
        }
        
        statusBarChange()
    }
    
    func statusBarChange(){
        isStatusBarHidden = !isStatusBarHidden
        UIView.animate(withDuration: 0.5) {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    
    var isStatusBarHidden: Bool = false
    override var prefersStatusBarHidden: Bool{
        return isStatusBarHidden
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

