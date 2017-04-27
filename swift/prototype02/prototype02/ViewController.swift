//
//  ViewController.swift
//  prototype02
//
//  Created by shoichiyamazaki on 2017/04/24.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var myDummyData:[String:Any] = ["uuid":"hoge","username":"takashi"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ud = UserDefaults.standard
        let myuuid = myDummyData["uuid"] as! String
        let myusername = myDummyData["username"] as! String
        
        ud.set(myuuid, forKey: "uuid")
        ud.set(myusername, forKey: "username")
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        transitionNextView()
    }
    
    func transitionNextView(){
        performSegue(withIdentifier: "firstSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "firstSegue"{
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

