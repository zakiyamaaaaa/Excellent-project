//
//  NoUserViewController.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/08/14.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class NoUserViewController: UIViewController {

    @IBOutlet weak var myImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let documentDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let imgFileName = "userimg.png"
        var tmp = UIImage(contentsOfFile: "\(documentDir)/\(imgFileName)")
        if tmp == nil{
            tmp = #imageLiteral(resourceName: "anonymous")
        }
        
        myImageView.image = tmp
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("NoUserVCAppeared")
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
