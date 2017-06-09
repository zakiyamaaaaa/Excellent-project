//
//  testViewController.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/05/15.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class testViewController: UIViewController {

    @IBOutlet weak var testLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        
//        self.testLabel.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        testLabel.sizeToFit()
        self.testLabel.frame.size = CGSize(width: self.testLabel.frame.width + 80, height: self.testLabel.frame.height)
//        UIView.animate(withDuration: 0) { 
//            self.testLabel.frame.size = CGSize(width: self.testLabel.frame.width + 50, height: self.testLabel.frame.height)
//        }
        testLabel.textAlignment = NSTextAlignment.center
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
