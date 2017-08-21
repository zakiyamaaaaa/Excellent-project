//
//  MatchingViewController.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/08/06.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class MatchingViewController: UIViewController {

    @IBOutlet weak var matchingUserImageView1: UIImageView!
    @IBOutlet weak var matchingUserImageView2: UIImageView!
    var image1:UIImage?
    var image2:UIImage?
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let blurEffect = UIBlurEffect(style: .dark)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.alpha = 1
        visualEffectView.frame = self.view.bounds
//        self.view.addSubview(visualEffectView)
        self.view.insertSubview(visualEffectView, at: 0)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let documentDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let imgFileName = "userimg.png"
        var tmp = UIImage(contentsOfFile: "\(documentDir)/\(imgFileName)")
        if tmp == nil{
            tmp = #imageLiteral(resourceName: "anonymous_43")
        }
        
        image1 = tmp
        
        matchingUserImageView1.layer.masksToBounds = true
        matchingUserImageView2.layer.masksToBounds = true
        
        matchingUserImageView1.layer.cornerRadius = matchingUserImageView1.frame.width/2
        matchingUserImageView2.layer.cornerRadius = matchingUserImageView2.frame.width/2
        
        matchingUserImageView1.image = image1
        matchingUserImageView2.image = image2
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
