//
//  ContainerViewControllerTest.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/06/26.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class ContainerViewControllerTest: UIViewController,RecruiterDelegate{
    
    var vc:RecruiterViewController=RecruiterViewController()
    
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var contentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vc.recruiterVCDelegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func hiddenBar(){
//        navigationView.isHidden = true
        print("hidden---")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func leftButtonTapped(_ sender: Any) {
        UIView.animate(withDuration: 1) { 
            self.contentView.transform = CGAffineTransform.init(translationX: self.view.frame.width, y: 0)
        }
    }

    
    @IBAction func centerButtonTapped(_ sender: Any) {
        UIView.animate(withDuration: 1) {
            self.contentView.transform = CGAffineTransform.init(translationX: 0, y: 0)
        }
    }
    
    
    @IBAction func rightButtonTapped(_ sender: Any) {
        UIView.animate(withDuration: 1) {
            self.contentView.transform = CGAffineTransform.init(translationX: -self.view.frame.width, y: 0)
        }
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
