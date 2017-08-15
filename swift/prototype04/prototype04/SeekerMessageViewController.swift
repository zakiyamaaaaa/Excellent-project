//
//  SeekerMessageViewController.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/06/30.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class SeekerMessageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    var strList:[String] = ["vsda","vasddasd","vfvsava","zfvdfvd"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "seekerMessageCell", for: indexPath) as! MessageTableViewCellDemo
        cell.userNameLabel.text = strList[indexPath.row]
        cell.labelImageView.image = #imageLiteral(resourceName: "wakate-label")
        cell.userImageView.image = #imageLiteral(resourceName: "kimura")
        cell.mealImageView.image = #imageLiteral(resourceName: "caffeIconColored")
        cell.companyImageView.image = #imageLiteral(resourceName: "gsacademy")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return strList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
        performSegue(withIdentifier: "segueChat", sender: nil)
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
