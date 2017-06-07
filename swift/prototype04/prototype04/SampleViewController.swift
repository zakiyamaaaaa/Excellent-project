//
//  SampleViewController.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/05/11.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class SampleViewController: UIViewController {

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "hoge"
        self.navigationItem.titleView?.layer.shadowRadius = 10
        self.navigationItem.titleView?.layer.shadowOffset = CGSize(width: 10, height: 10)
        self.navigationItem.titleView?.layer.shadowOpacity = 1
        self.navigationItem.titleView?.layer.shadowColor = UIColor.gray.cgColor
        let a = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        a.backgroundColor = UIColor.green
        self.navigationItem.titleView?.addSubview(a)
        
        
        // Do any additional setup after loading the view.
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
