//
//  ProfileAnnotationViewController.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/08/14.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class ProfileAnnotationViewController: UIViewController {

    @IBOutlet weak var numberLabel: UILabel!
    var num:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        
        numberLabel.text = String(describing: num)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeScreen(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
