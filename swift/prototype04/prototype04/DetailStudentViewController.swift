//
//  DetailStudentViewController.swift
//  
//
//  Created by shoichiyamazaki on 2017/08/17.
//
//

import UIKit

class DetailStudentViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

//    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet weak var detailTableView: UITableView!
    
    let sectionTitle = ["自己紹介","所属団体・サークル"]
    let titleOfSection1 = ["自分について","長所","短所","資格・スキル"]
    let imageOfSection1 = [#imageLiteral(resourceName: "cafe_mono"),#imageLiteral(resourceName: "morning_mono"),#imageLiteral(resourceName: "lunchIconColored"),#imageLiteral(resourceName: "dinnerIconColored")]
    let titleOfSection2 = ["団体名","役割"]
    let imageOfSection2 = [#imageLiteral(resourceName: "camera"),#imageLiteral(resourceName: "education")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detailTableView.delegate = self
        detailTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return titleOfSection1.count
        case 1:
            return titleOfSection2.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = detailTableView.dequeueReusableCell(withIdentifier: "detailCell") as! DetailTableViewCell
        
        switch indexPath.section {
        case 0:
            cell.titleLabel.text = titleOfSection1[indexPath.row]
            cell.titleImageView.image = imageOfSection1[indexPath.row]
            switch indexPath.row {
            case 0:
                cell.conetntLabel.text = "hogehoeg"
            default:
                break
            }
        case 1:
            cell.titleLabel.text = titleOfSection2[indexPath.row]
            cell.titleImageView.image = imageOfSection2[indexPath.row]
            
            switch indexPath.row {
            case 0:
                cell.conetntLabel.text = "aaaa"
            default:
                break
            }
        default:
            break
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
