//
//  EducationEditViewController.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/07/27.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class EducationEditViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{

    @IBOutlet weak var myTableVIew: UITableView!
    
    var editingTextField:UITextField!
    var schoolNameTextEdited:String = ""
    var facultyTextEdited:String = ""
    var graduationNameNumEdited:Int = 0
    
    let cellRowTitleList = ["学校名","学部・学科名","卒業年"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableVIew.delegate = self
        myTableVIew.dataSource = self

        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableVIew.dequeueReusableCell(withIdentifier: "educationEditCell") as! EducationEditTableViewCell
        cell.editTextField.delegate = self
        
        switch indexPath.row {
        case 0:
            cell.titleLabel.text = cellRowTitleList[0]
            cell.editTextField.tag = 0
            cell.editTextField.text = schoolNameTextEdited
        case 1:
            cell.titleLabel.text = cellRowTitleList[1]
            cell.editTextField.tag = 1
            cell.editTextField.text = facultyTextEdited
        case 2:
            cell.editTextField.tag = 2
            cell.titleLabel.text = cellRowTitleList[2]
            //ここはpickerviewを使用（未実装）
            cell.editTextField.text = String(graduationNameNumEdited) + "年"
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellRowTitleList.count
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 0:
            editingTextField = textField
            
        case 2: break
            
        default:
            break
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        editingTextField = textField
        switch textField.tag {
        case 0:
            schoolNameTextEdited = textField.text!
        case 1:
            facultyTextEdited = textField.text!
        default:
            break
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func finishButtonTapped(_ sender: Any) {
        
        _ = textFieldShouldEndEditing(editingTextField!)
        
        
        let navC = self.navigationController!
        let vc = navC.viewControllers[navC.viewControllers.count-2] as! EditProfileViewControllerTest
        //vc.selfIntroText = selfIntroTextView.text
//        vc.educationArray?[0] = self.schoolNameTextEdited
//        vc.educationArray?[1] = self.facultyTextEdited
        
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
