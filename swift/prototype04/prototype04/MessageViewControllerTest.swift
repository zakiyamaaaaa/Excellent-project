//
//  MessageViewControllerTest.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/06/26.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class MessageViewControllerTest: UIViewController {

    let ud = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ud.set(3, forKey: "num")
        
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        print("message")
        print(ud.integer(forKey: "num"))
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
