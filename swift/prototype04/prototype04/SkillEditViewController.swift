//
//  SkillEditViewController.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/07/27.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class SkillEditViewController: UIViewController,UITextFieldDelegate{

    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var targetView: UIView!
    
    @IBOutlet weak var explainLabel: UILabel!
    
    var explainText:String?
    
    let ud = UserDefaults.standard
    var type:recruiterPropety?
    var tagList:[String]?
    let prefix = "✗ "
    
    var myStatus = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myTextField.delegate = self
        myTextField.becomeFirstResponder()
        
        if let status = User().status{
            myStatus = status
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        explainLabel.text = explainText
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard let list = tagList  else { return }
        
        pasteTag(forView: targetView, forTagList: list)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        
        if myTextField.text?.isEmpty == true { return }
        
        
        if tagList?.isEmpty == true || tagList == nil{
            tagList = []
        }
        tagList?.append(myTextField.text!)
        
        pasteTag(forView: targetView, forTagList: tagList!)
        myTextField.text = ""
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //talistに追加
        if tagList?.isEmpty == true || tagList == nil{
            tagList = []
        }
        tagList?.append(myTextField.text!)
        pasteTag(forView: targetView, forTagList: tagList!)
        textField.text = ""
        
        return true
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        
        switch myStatus {
        case 1:
            let navC = self.navigationController!
            let vc = navC.viewControllers[navC.viewControllers.count-2] as! RecruiterProfileViewController
            
            if type != nil{
                switch type! {
                case .company_recruitment:
                    vc.recruitmentList = tagList
                case .company_feature:
                    vc.featureList = tagList
                    
                default:
                    break
                }
            }
            
        case 2:
            let navC = self.navigationController!
            let vc = navC.viewControllers[navC.viewControllers.count-2] as! EditProfileViewControllerTest
            
            if tagList != nil{
                vc.skillList = tagList!
            }
        default:
            break
        }
        
        
        self.navigationController?.popViewController(animated: true)
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

extension SkillEditViewController{
    
    func pasteTag(forView targetView:UIView,forTagList TagList:[String]){
        
        var pointX:CGFloat = 10
        var pointY:CGFloat = 10
        //ここでは、高さをいじっていない
        //var lastHeight:CGFloat = 0
        
        for view in targetView.subviews{
            
            if view is EditableTagButton{
                view.removeFromSuperview()
            }
            
        }
        
        for tagText in TagList{
            let tag:EditableTagButton = EditableTagButton(frame: .zero, inText: tagText)
            targetView.addSubview(tag)
            tag.addTarget(self, action: #selector(self.tagPushed(sender:)), for: .touchUpInside)
            
            
            if pointX + tag.frame.width + 10 > targetView.frame.width{
                pointX = 10
                pointY += 5 + tag.frame.height
            }
            
            tag.frame.origin = CGPoint(x: pointX, y: pointY)
            
            pointX += 5 + tag.frame.width
//            lastHeight = pointY + tag.frame.height
        }
    }
    
    
    func tagPushed(sender:EditableTagButton){
        sender.removeFromSuperview()
        
        guard let list = tagList else { return }
        
        for (index,text) in list.enumerated(){
            if sender.title(for: .normal)! == prefix + text{
                tagList!.remove(at: index)
            }
        }
        
        if targetView.subviews != nil{
            for subView in targetView.subviews{
                subView.removeFromSuperview()
            }
        }
        pasteTag(forView: targetView, forTagList: tagList!)
    }
}
