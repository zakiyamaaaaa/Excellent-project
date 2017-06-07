//
//  ProfileEditDetailViewController.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/05/11.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class ProfileEditDetailViewController: UIViewController, UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {

    //興味がある職種
    var interestingJob = ["Sales","Founder","Engineer","Accounting","Plannning","Human Resource","Other"]
    
    //業界
    var interestingCategory = ["Law","Education","IT","Public","Finance","Media","Talent","Beauty","Construction","Medical","Other"]
    
    var favoriteFood = ["coffee","sandwitch","chocolate"]
    var unfavoriteFood = ["natto","kimuchi","coconats","dorian"]
    var backgroundItem = ["abc Uni","koko college","abc highschool"]
    var qualification = ["toeic900","eiken","hishokentei","driver licence"]
    
    @IBOutlet weak var myTableView: UITableView!
    
    var tableList:[String]!
    var currentProfile:String?
    
    var categoryNum:Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(tableList[indexPath.row])
        
//        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
//        let vc:ProfileEditViewController = self.presentingViewController as! ProfileEditViewController
//        vc.tmp = "hoge"

//        switch categoryNum {
//        case 0:
//            print("interestingJob")
//            appDelegate.myDataDelegate["interestingJob"] = tableList[indexPath.row]
//            
//        case 1:
//            print("interestingCategory")
//            appDelegate.myDataDelegate["interestingCategory"] = tableList[indexPath.row]
//        case 2:
//            print("favoriteFood")
//            appDelegate.myDataDelegate["favoriteFood"] = tableList[indexPath.row]
//        case 3:
//            print("unfavoriteFood")
//            appDelegate.myDataDelegate["unfavoriteFood"] = tableList[indexPath.row]
//        case 4:
//            print("unfavoriteFood")
//            appDelegate.myDataDelegate["background"] = tableList[indexPath.row]
//        case 5:
//            print("unfavoriteFood")
//            appDelegate.myDataDelegate["qualification"] = tableList[indexPath.row]
//        default:
//            print("default")
//        }
        _ = navigationController?.popViewController(animated: true)
    }
    

    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tableList[indexPath.row]
        
        if tableList[indexPath.row] == currentProfile{
            cell.accessoryType = UITableViewCellAccessoryType.checkmark
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("back")
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        switch categoryNum {
        case 0:
            tableList = interestingJob
        case 1:
            tableList = interestingCategory
        case 2:
            tableList = favoriteFood
        case 3:
            tableList = unfavoriteFood
        case 4:
            tableList = backgroundItem
        case 5:
            tableList = qualification
        default:
            print("error")
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
