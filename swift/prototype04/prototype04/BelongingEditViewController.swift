//
//  BelongingEditViewController.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/08/07.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class BelongingEditViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate{

    @IBOutlet weak var belongingNameLabel: UITextField!
    
    @IBOutlet weak var enrollmentTextView: UITextView!
    
    
    var belongingNameText:String?
    var enrollmentText:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        belongingNameLabel.text = belongingNameText
        enrollmentTextView.text = enrollmentText
        
        belongingNameLabel.delegate = self
        enrollmentTextView.delegate = self
        
        enrollmentTextView.layer.borderWidth = 0.3
        belongingNameLabel.becomeFirstResponder()
        
        // Do any additional setup after loading the view.
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func finishButtonTapped(_ sender: UIBarButtonItem) {
        let navC = self.navigationController!
        let vc = navC.viewControllers[navC.viewControllers.count-2] as! EditProfileViewControllerTest
        vc.belonging?[0] = belongingNameLabel.text!
        vc.belonging?[1] = enrollmentTextView.text!
        
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
