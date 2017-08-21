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
    
    var myStatus = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let status = User().status{
            myStatus = status
        }
        
        myImageView.layer.masksToBounds = true
        myImageView.layer.cornerRadius = myImageView.frame.width/2
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let app:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let documentDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let imgFileName = "userimg.png"
        var tmp = UIImage(contentsOfFile: "\(documentDir)/\(imgFileName)")
        if tmp == nil{
            tmp = #imageLiteral(resourceName: "anonymous_43")
        }
        
        myImageView.image = tmp
        myImageView.layer.masksToBounds = true
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        countProfileRatio()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //リクルーター変更項目
    //introduction
    //position
    //skill
    //ogori
    //education
    //message
    //company_name
    //company_link
    //company_population
    //compnay_industry
    //company_recruitment
    //company_feature
    
    
    func countProfileRatio(){
        let app:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        var count = 0
        var valueCount = 0
        let a = recruiterPropety.self
        let b = studentPropety.self
        
        
        switch myStatus {
        case 1:
            let message:String? = app.myInfoDelegate?[a.message.rawValue] as? String
            if message != nil && message?.isEmpty == false{
                count += 1
            }
            valueCount += 1
            
            let position:String? = app.myInfoDelegate?[a.position.rawValue] as? String
            if position != nil && position?.isEmpty == false{
                count += 1
            }
            valueCount += 1
            
            let education:[Any]? = app.myInfoDelegate?[a.education.rawValue] as? [Any]
            if education != nil && education?.isEmpty == false{
                count += 1
            }
            valueCount += 1
            
            let ogori:[Int]? = app.myInfoDelegate?[a.ogori.rawValue] as? [Int]
            if ogori != nil && ogori?.isEmpty == false{
                count += 1
            }
            valueCount += 1
            
            let introduction:String? = app.myInfoDelegate?[a.introduction.rawValue] as? String
            if introduction != nil && introduction?.isEmpty == false{
                count += 1
            }
            valueCount += 1
            
            let skill:[String]? = app.myInfoDelegate?[a.skill.rawValue] as? [String]
            if skill != nil && skill?.isEmpty == false{
                count += 1
            }
            valueCount += 1
            
            
            let feature:[String]? = app.myInfoDelegate?[a.company_feature.rawValue] as? [String]
            if feature != nil && feature?.isEmpty == false{
                count += 1
            }
            valueCount += 1
            
            let recruitment:[String]? = app.myInfoDelegate?[a.company_recruitment.rawValue] as? [String]
            if recruitment != nil && recruitment?.isEmpty == false{
                count += 1
            }
            valueCount += 1
            
            let population:Int? = app.myInfoDelegate?[a.company_population.rawValue] as? Int
            if population != nil{
                count += 1
            }
            valueCount += 1
            
            
            let industry:String? = app.myInfoDelegate?[a.company_industry.rawValue] as? String
            if industry != nil && industry?.isEmpty == false{
                count += 1
            }
            valueCount += 1
            
            let companyname:String? = app.myInfoDelegate?[a.company_name.rawValue] as? String
            if companyname != nil && companyname?.isEmpty == false{
                count += 1
            }
            valueCount += 1
            
            
            
            
            let companylink:String? = app.myInfoDelegate?[a.company_link.rawValue] as? String
            if companylink != nil && companylink?.isEmpty == false{
                count += 1
            }
            valueCount += 1
            
            
            
        case 2:
            let message:String? = app.myInfoDelegate?[b.message.rawValue] as? String
            if message != nil && message?.isEmpty == false{
                count += 1
            }
            valueCount += 1
            
            let education:[Any]? = app.myInfoDelegate?[b.education.rawValue] as? [Any]
            if education != nil && education?.isEmpty == false{
                count += 1
            }
            valueCount += 1
            
            let goodpoint:String? = app.myInfoDelegate?[b.goodpoint.rawValue] as? String
            if goodpoint != nil && goodpoint?.isEmpty == false{
                count += 1
            }
            valueCount += 1
            
            let badpoint:String? = app.myInfoDelegate?[b.badpoint.rawValue] as? String
            if badpoint != nil && goodpoint?.isEmpty == false{
                count += 1
            }
            valueCount += 1
            
            let introduction:String? = app.myInfoDelegate?[b.introduction.rawValue] as? String
            if introduction != nil && introduction?.isEmpty == false{
                count += 1
            }
            valueCount += 1
            
            let belonging:[Any]? = app.myInfoDelegate?[b.belonging.rawValue] as? [Any]
            if belonging != nil && belonging?.isEmpty == false{
                count += 1
            }
            valueCount += 1
            
            let interesting:[Any]? = app.myInfoDelegate?[b.interesting.rawValue] as? [Any]
            if interesting != nil && interesting?.isEmpty == false{
                count += 1
            }
            valueCount += 1
        default:
            break
        }
        
        
        profileEditedRatio.text = String(count*100/valueCount) + " %"
        
    }
    
    //1ひとこと
    //2良い点
    //3悪い点
    //4興味
    //5学歴
    //6自己紹介
    //7所属団体について
    @IBAction func editButtonTapped(_ sender: Any) {
        
        let sb = UIStoryboard(name: "Profile", bundle: nil)
        //statusによって遷移先のVCを切り替える
        switch myStatus {
        case 1:
            let controller = sb.instantiateViewController(withIdentifier: "companyProfileNav") as! UINavigationController
            show(controller, sender: nil)
        case 2:
            
            let controller = sb.instantiateViewController(withIdentifier: "studentProfileNav") as! UINavigationController
            show(controller, sender: nil)
        default:
            break
        }
        
        
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
