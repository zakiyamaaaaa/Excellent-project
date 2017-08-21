//
//  AssessmentViewController.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/08/12.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit
import Firebase

class AssessmentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        var a = my()
        a.register(key: .birth, value: "1990-10-10")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //相手が一定数以上いれば、次の画面へ遷移する
        
        let ref = Database.database().reference()
        if let uuid = Auth.auth().currentUser?.uid{
            print(ref.child("users").child(uuid).description())
            ref.child("users").child(uuid).observe(.value, with: { (snapshot) in
                var dict = snapshot.value as! [String:Any]
                let flag = dict["valid"] as? Bool
                
                if flag == true{
                    let storyboard = UIStoryboard(name: "Register", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "readyToMain") as! ReadyMainViewController
                    vc.modalTransitionStyle = .crossDissolve
                    vc.modalPresentationStyle = .overFullScreen
//                    self.show(vc, sender: nil)
                }
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func confirmProfile(_ sender: Any) {
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
