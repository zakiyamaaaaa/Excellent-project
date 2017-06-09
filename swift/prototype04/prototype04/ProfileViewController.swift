//
//  ProfileViewController.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/05/10.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var myTableView: UITableView!
    
    var sectionList = ["Job","Food","Background"]
    var jobItems = ["興味がある職種","興味がある業界"]
    var foodItems = ["好きな食べ物","嫌いな食べ物"]
    var backgroundItems = ["最終学歴／学部","資格"]
    
    var tohokuItem = ["Aomori","Iwate","Akita","Miyagi","Yamagata","Fukushima"]
    var kantoItem = ["Ibaraki","Chiba","Saitama","Toshigi","Tokyo","Kanagawa"]
    var shikokuItem = ["Kouchi","Tokushima","Kagawa","Ehime"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.view.frame.height)
        self.view.frame = CGRect(x: self.view.bounds.origin.x, y: self.view.bounds.origin.y, width: self.view.frame.width, height: self.view.frame.height + 500)
        myTableView.delegate = self
        myTableView.dataSource = self
//        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        myTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "myCell")
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionList[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("hoge")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return jobItems.count
        case 1:
            return foodItems.count
        case 2:
            return backgroundItems.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! CustomTableViewCell
        
        switch indexPath.section {
        case 0:
            cell.titleLabel.text = jobItems[indexPath.row]
            cell.titleLabel.font = UIFont.init(name: "BodoniSvtyTwoITCTT-Book", size: 15)
        case 1:
            cell.titleLabel.text = foodItems[indexPath.row]
        case 2:
            cell.titleLabel.text = backgroundItems[indexPath.row]
        default:
            print("default selected")
        }
        
        return cell
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
