//
//  SelfIntroEditViewController.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/07/27.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class SelfIntroEditViewController: UIViewController,UITextViewDelegate{

    @IBOutlet weak var selfIntroTextView: UITextView!
    var selfIntroText:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        selfIntroTextView.delegate = self
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        selfIntroTextView.text = selfIntroText
        selfIntroTextView.becomeFirstResponder()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func finishButtonTapped(_ sender: UIBarButtonItem) {
        let navC = self.navigationController!
        
        let vc = navC.viewControllers[navC.viewControllers.count-2] as! EditProfileViewControllerTest
        vc.selfIntroText = selfIntroTextView.text
        self.navigationController?.popViewController(animated: true)
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
