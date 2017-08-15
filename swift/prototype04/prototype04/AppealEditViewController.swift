//
//  AppealEditViewController.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/07/28.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class AppealEditViewController: UIViewController,UITextFieldDelegate{
    
    @IBOutlet weak var myTextField: UITextField!
    var appealText:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        myTextField.text = appealText
        myTextField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        let navC = self.navigationController!
        let vc = navC.viewControllers[navC.viewControllers.count-2] as! EditProfileViewControllerTest
        
        if myTextField.text != nil{
            vc.appealText = myTextField.text
        }
        
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
