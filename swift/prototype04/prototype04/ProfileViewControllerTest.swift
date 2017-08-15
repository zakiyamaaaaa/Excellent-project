//
//  ProfileViewControllerTest.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/08/06.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class ProfileViewControllerTest: UIViewController {

    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myNameLabel: UILabel!
    @IBOutlet weak var profileEditedRatio: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let app:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        myNameLabel.text = app.myInfoDelegate?["username"] as? String
        
        let documentDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let imgFileName = "userimg.png"
        var tmp = UIImage(contentsOfFile: "\(documentDir)/\(imgFileName)")
        if tmp == nil{
            tmp = #imageLiteral(resourceName: "anonymous")
        }
        
        myImageView.image = tmp
        myImageView.layer.masksToBounds = true
        
        
        countProfileRatio()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func countProfileRatio(){
        let app:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        var count = 0
        var valueCount = 0
        let b = studentPropety.self
        
        let message:String? = app.myInfoDelegate?[b.message.getString()] as? String
        if message != nil && message?.isEmpty == false{
            count += 1
        }
        valueCount += 1
        
        let education:[Any]? = app.myInfoDelegate?[b.education.getString()] as? [Any]
        if education != nil && education?.isEmpty == false{
            count += 1
        }
        valueCount += 1
        
        let goodpoint:String? = app.myInfoDelegate?[b.goodpoint.getString()] as? String
        if goodpoint != nil && goodpoint?.isEmpty == false{
            count += 1
        }
        valueCount += 1
        
        let badpoint:String? = app.myInfoDelegate?[b.badpoint.getString()] as? String
        if badpoint != nil && goodpoint?.isEmpty == false{
            count += 1
        }
        valueCount += 1
        
        let introduction:String? = app.myInfoDelegate?[b.introduction.getString()] as? String
        if introduction != nil && introduction?.isEmpty == false{
            count += 1
        }
        valueCount += 1
        
        let belonging:[Any]? = app.myInfoDelegate?[b.belonging.getString()] as? [Any]
        if belonging != nil && belonging?.isEmpty == false{
            count += 1
        }
        valueCount += 1
        
        let interesting:[Any]? = app.myInfoDelegate?[b.interesting.getString()] as? [Any]
        if interesting != nil && interesting?.isEmpty == false{
            count += 1
        }
        valueCount += 1
        
        profileEditedRatio.text = String(count*100/valueCount) + " %"
        
    }
    
    //1ひとこと
    //2良い点
    //3悪い点
    //4興味
    //5学歴
    //6自己紹介
    //7所属団体について

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
