//
//  UserDetailViewController.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/07/28.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var myTableView: UITableView!
    
    let sectionTitle = ["","何をやっているのか","経歴","学歴","会社情報","会社紹介","特徴","募集求人"]
    
    var userData:[Any] = [#imageLiteral(resourceName: "kimura"),#imageLiteral(resourceName: "middle-label"),#imageLiteral(resourceName: "sumoacademy-icon"),"木村","プロデューサー","こここｖｆぢｖびあｂｖぁｆｈｂｖぁｓｋｊｖｌばｆｋｓｂｖぁｋｊｂｓｆｋｈふぁｂｓｌｋ","Sumo Academy","強めの横綱を育てます","優しい",["Rails","SRE"]]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.delegate = self
        myTableView.dataSource = self

        myTableView.estimatedRowHeight = 90
        // Do any additional setup after loading the view.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "detailUserCell") as! DetailUserTableViewCell
        switch indexPath.section {
        case 0:
            let cell = myTableView.dequeueReusableCell(withIdentifier: "basicUserCell") as! BasicUserTableViewCell
            cell.userImageView.image = userData[0] as? UIImage
            cell.labelImageView.image = userData[1] as? UIImage
            cell.companyImageView.image = userData[2] as? UIImage
            
            return cell
        case 1:
            cell.contentLabel.text = userData[5] as? String
            
            return cell
        case 4:
            let cell = UITableViewCell()
            cell.textLabel?.text = userData[6] as? String
            
            return cell
        case 5:
            cell.contentLabel.text = userData[7] as? String
            
            return cell
        case 6:
            cell.contentLabel.text = userData[8] as? String
            
            return cell
        case 7:
            let cell = UITableViewCell()
            var str:String = ""
            
            let recruitmentArray:[String] = userData[9] as! [String]
            
            for text in recruitmentArray{
                if text == recruitmentArray.first{
                    continue
                }
                
                str += "/" + text
            }
            
            cell.textLabel?.text = str
            
            return cell
        default:
            
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func finishButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
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
