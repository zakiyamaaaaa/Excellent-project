//
//  MatchViewController.swift
//  prototype02
//
//  Created by shoichiyamazaki on 2017/04/25.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class MatchViewController: UIViewController {

    var matchedUUID:String!
    
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var matchUserImageView: UIImageView!
    @IBOutlet weak var matchMessageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        matchMessageLabel.text = "Conglatulation!! \n You are Match!!"
        matchMessageLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        matchMessageLabel.numberOfLines = 2
        setImage(uuid: matchedUUID)
        // Do any additional setup after loading the view.
    }
    
    func setImage(uuid:String){
        let imgFilePath = URL(string: "http://localhost:8888/img/\(uuid)/userimg.jpg")
        do{
            let data = try Data(contentsOf: imgFilePath!)
            matchUserImageView.image = UIImage(data: data)
        }catch{
            print(error.localizedDescription)
        }
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
