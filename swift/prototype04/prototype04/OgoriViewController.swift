//
//  OgoriViewController.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/08/16.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class OgoriViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var ogoriTableView: UITableView!

    let cellValue = ["カフェ","朝食","ランチ","ディナー"]
    var checkList:[Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ogoriTableView.delegate = self
        ogoriTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return cellValue.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ogoriTableView.dequeueReusableCell(withIdentifier: "imageAndLabelCell") as! ImageAndLabelTableViewCell
        
        if checkList.contains(indexPath.row){
            cell.accessoryType = .checkmark
        }
        
        switch indexPath.row {
        case 0:
            cell.myImageView.image = #imageLiteral(resourceName: "cafe_char_icon")
        case 1:
            cell.myImageView.image = #imageLiteral(resourceName: "morning_char_icon")
        case 2:
            cell.myImageView.image = #imageLiteral(resourceName: "lunch_char_icon")
        case 3:
            cell.myImageView.image = #imageLiteral(resourceName: "dinner_char_icon")
        default:
            break
        }
        cell.myLabel.text = cellValue[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let value = indexPath.row
        let cell = ogoriTableView.cellForRow(at: indexPath)
        
        //値が含まれてるかチェック
        for (index,item) in checkList.enumerated(){
            if item == value{
                checkList.remove(at: index)
                cell?.accessoryType = .none
                return
            }
        }
        checkList.append(value)
        cell?.accessoryType = .checkmark
        print(checkList)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = ogoriTableView.cellForRow(at: indexPath)
        let value = indexPath.row
        for (index,item) in checkList.enumerated(){
            if item == value{
                checkList.remove(at: index)
                continue
            }
        }
        cell?.accessoryType = .none
    }
    
    

    @IBAction func changeButtonTapped(_ sender: Any) {
        let navC = self.navigationController!
        let vc = navC.viewControllers[navC.viewControllers.count-2] as! RecruiterProfileViewController
        vc.ogoriList = checkList
        
        self.navigationController?.popViewController(animated: true)
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
