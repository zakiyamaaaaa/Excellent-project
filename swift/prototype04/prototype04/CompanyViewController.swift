//
//  CompanyViewController.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/06/25.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class CompanyViewController: UIViewController {

    
    @IBOutlet weak var specificTagView: UIView!
    @IBOutlet weak var specificTagViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var jobofferTagView: UIView!
    @IBOutlet weak var jobofferTagViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var data = dummyData()
        let specificTagList:[String] = data.specificTagTextList
        let jobofferTagList:[String] = data.jobofferTagTextList
        
        let experienceList:[String] = data.experienceList
        let skillList:[String] = data.skillList
        
        pasteTag(forView: specificTagView, forTagList: specificTagList, heightConstraint: specificTagViewHeightConstraint)
        pasteTag(forView: jobofferTagView, forTagList: jobofferTagList, heightConstraint: jobofferTagViewHeightConstraint)
        
        // Do any additional setup after loading the view.
    }
    
    //ビューとタグを指定して、タグフィールドを作る
    func pasteTag(forView targetView:UIView,forTagList TagList:[String],heightConstraint:NSLayoutConstraint){
        
        var pointX:CGFloat = 10
        var pointY:CGFloat = 10
        var lastHeight:CGFloat = 0
        
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
        
        heightConstraint.constant = lastHeight + 10
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
