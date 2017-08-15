//
//  ProfileEditViewController2.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/07/20.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class ProfileEditViewController2: UIViewController,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var myCustomeCell: UITableViewCell!
    
    let sectionList = ["何をやってるのか","興味がある職種・業種","学歴","ひとことアピール","自分の長所","自分の短所","資格"]
    
    let cellContentList = ["vnaeifjvboaufhvan;ofjna;fosvldkkna;bafjksbvafksjvna","","","がんばります","やるき","やるき","英検"]
    
    let tagList = ["営業","金融","エンジニア"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.delegate = self
        myTableView.dataSource = self

        self.myTableView.estimatedRowHeight = 90
        self.myTableView.rowHeight = UITableViewAutomaticDimension
        
        myTableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
//    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        return sectionList
//    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionList[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "customCell") as! ProfileEditTableViewCell
        
        if indexPath.section == 1{
            pasteTag(forView: cell.myLabel, forTagList: tagList)
            return cell
        }
        
        cell.myLabel.text = cellContentList[indexPath.section]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            performSegue(withIdentifier: "WhatSegue", sender: nil)
        default:
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "WhatSegue"{
//            let vc = segue.destination as! WhatYouDoViewController
//            vc.str = cellContentList[0]
//            
//            print("cell0:\(cellContentList[0])")
//        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1{
            return interstingCellHeight
        }
        return UITableViewAutomaticDimension
    }
    
    
    var interstingCellHeight:CGFloat = 70
    //ビューとタグを指定して、タグフィールドを作る
    func pasteTag(forView targetView:UIView,forTagList TagList:[String]){
        
        var pointX:CGFloat = 0
        var pointY:CGFloat = 0
        var lastHeight:CGFloat = 0
        
        for view in targetView.subviews{
            if view == targetView.subviews.first{
                continue
            }
            view.removeFromSuperview()
        }
        
        
        
        for tagText in TagList{
            let tagLabel:TagLabel = TagLabel(frame: .zero, inText: tagText)
            targetView.addSubview(tagLabel)
            
            if pointX + tagLabel.frame.width + 10 > targetView.frame.width{
                pointX = 10
                pointY += 5 + tagLabel.frame.height
            }
            
            tagLabel.frame.origin = CGPoint(x: pointX, y: pointY)
            
            pointX += 5 + tagLabel.frame.width
            lastHeight = pointY + tagLabel.frame.height
            
        }
        
        if interstingCellHeight < lastHeight{
            interstingCellHeight = lastHeight
        }
        
        
//        heightConstraint.constant = lastHeight + 10
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
