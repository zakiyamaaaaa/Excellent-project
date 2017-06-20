//
//  TestViewController.swift
//  cardDesignPrototype
//
//  Created by shoichiyamazaki on 2017/06/20.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var textViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var myTextView: UITextView!
    
    var isStatusBarHidden: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        textViewHeightConstraint.isActive = false
        
        myTextView.sizeToFit()
        textViewHeightConstraint.constant = myTextView.frame.height
        myTextView.layer.masksToBounds = true
        myTextView.layer.borderWidth = 1
        myTextView.layer.cornerRadius = 5
        myTextView.textContainer.lineFragmentPadding = 0
        myTextView.textContainerInset = UIEdgeInsets.zero
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func statusBarControl(_ sender: Any) {
        
        isStatusBarHidden = !isStatusBarHidden
        UIView.animate(withDuration: 0.5) { 
            self.setNeedsStatusBarAppearanceUpdate()
        }
        
    }
    
    override var prefersStatusBarHidden: Bool{
        return isStatusBarHidden
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .fade
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
