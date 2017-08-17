//
//  InterestingViewController.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/07/27.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class InterestingViewController: UIViewController,UITextFieldDelegate,UIScrollViewDelegate{

    @IBOutlet weak var tagTextField: UITextField!
    var interestingTagList:[String]?
    var jobInputView:UIScrollView!
    
    var inputViewLabel01:UILabel!
    var inputViewLabel02:UILabel!
    
    let inputViewTitleHeihgt:CGFloat = 50
    let jobTitleFontSize:CGFloat = 15
    
    let prefix = "✗ "
    //業界リスト一覧
    let jobIndustryList:[String] = jobTagTitleList.init().industry
    
    //業種リスト一覧
    let jobOccupationList:[String] = jobTagTitleList.init().occupation
    
    var myStatus = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tagTextField.delegate = self
        tagTextField.becomeFirstResponder()
        
        
        
        //jobTagViewをタップしたときに出てくる中のビューの設定
        jobInputView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 350))
        jobInputView.contentSize = CGSize(width: self.view.frame.width, height: 500)
        jobInputView.bounces = false
        jobInputView.delegate = self
        
        //jobTagViewをタップしたときに出てくる中のビューのラベルの設定
        //inputViewLabel01→気になる業界
        //inputViewLabel02→気になる業種
        
        let inputViewLabel01 = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: inputViewTitleHeihgt))
        let inputViewLabel02 = UILabel(frame: inputViewLabel01.frame)
        inputViewLabel01.backgroundColor = UIColor(white: 0.9, alpha: 1)
        inputViewLabel01.textAlignment = NSTextAlignment.center
        inputViewLabel02.backgroundColor = UIColor(white: 0.9, alpha: 1)
        inputViewLabel02.textAlignment = NSTextAlignment.center
        inputViewLabel01.text = "気になる職業"
        inputViewLabel02.text = "気になる業種"
        inputViewLabel01.font = UIFont.systemFont(ofSize: jobTitleFontSize)
        inputViewLabel02.font = UIFont.systemFont(ofSize: jobTitleFontSize)
        inputViewLabel01.center.x = jobInputView.center.x
        inputViewLabel02.center.x = jobInputView.center.x
        jobInputView.addSubview(inputViewLabel01)
        
        pasteTag(forView: jobInputView, forTagList: jobIndustryList, originalY: inputViewLabel01.frame.height)
        
        //jobTagViewの最後のタグボタンの変数:lastView
        let lastView = jobInputView.subviews.last!
        let lastHeight = lastView.frame.origin.y + lastView.frame.height
        inputViewLabel02.frame.origin.y = lastHeight + 20
        jobInputView.addSubview(inputViewLabel02)
        let y = inputViewLabel02.frame.origin.y + inputViewLabel02.frame.height
        
        pasteTag(forView: jobInputView, forTagList: jobOccupationList, originalY: y)
        
        jobInputView.backgroundColor = UIColor.white
        jobInputView.isOpaque = false
        tagTextField.inputView = jobInputView
        
        //jobTagViewの最後のタグボタンの変数:lastView
        let last = jobInputView.subviews.last
        let scrollEdgeY = last!.frame.origin.y + last!.frame.height + inputViewTitleHeihgt
        jobInputView.contentSize.height = scrollEdgeY
        
        if let status = User().status{
                myStatus = status
        }
        
        // Do any additional setup after loading the view.
    }
    
    

    override func viewWillAppear(_ animated: Bool) {
        guard let tagList = interestingTagList else { return }
        pasteEditTag(forView: tagTextField, forTagList: tagList, originalY: 0)
        
    }
    
    
    func pasteTag(forView targetView:UIView,forTagList TagList:[String],originalY:CGFloat){
        
        var pointX:CGFloat = 10
        var pointY:CGFloat = 10 + originalY
        var lastHeight:CGFloat = 0
        
        for tagText in TagList{
            let tag:tagButton = tagButton(frame: .zero, inText: tagText)
            targetView.addSubview(tag)
            tag.addTarget(self, action: #selector(self.tagButtonTapped(sender:)), for: .touchUpInside)
            
            
            if pointX + tag.frame.width + 10 > targetView.frame.width{
                pointX = 10
                pointY += 5 + tag.frame.height
            }
            
            tag.frame.origin = CGPoint(x: pointX, y: pointY)
            
            pointX += 10 + tag.frame.width
            lastHeight = pointY + tag.frame.height
            
            if interestingTagList != nil && interestingTagList!.contains(tagText){
                tag.enableFlag = false
                tag.alpha = 0.5
            }
            
        }
    }
    
    func pasteEditTag(forView targetView:UIView,forTagList TagList:[String],originalY:CGFloat){
        
        var pointX:CGFloat = 10
        var pointY:CGFloat = 10 + originalY
        var lastHeight:CGFloat = 0
        
        
        
        for tagText in TagList{
            let tag:EditableTagButton = EditableTagButton(frame: .zero, inText: tagText)
            targetView.addSubview(tag)
            tag.addTarget(self, action: #selector(self.tagPushed(sender:)), for: .touchUpInside)
            
            
            if pointX + tag.frame.width + 10 > targetView.frame.width{
                pointX = 10
                pointY += 5 + tag.frame.height
            }
            
            tag.frame.origin = CGPoint(x: pointX, y: pointY)
            
            pointX += 10 + tag.frame.width
            lastHeight = pointY + tag.frame.height
        }
    }
    
    func tagButtonTapped(sender:tagButton){
        
        switch sender.enableFlag {
        case true:
            
            if interestingTagList == nil{
                interestingTagList = []
            }
            
            interestingTagList?.append((sender.titleLabel?.text!)!)
            
            for subview in tagTextField.subviews{
                if subview == tagTextField.subviews.first{
                    continue
                }
                subview.removeFromSuperview()
            }
            
            
            
            pasteEditTag(forView: tagTextField, forTagList: interestingTagList!, originalY: 0)
            
            sender.alpha = 0.5
            
        case false:
            guard let list = interestingTagList else { return }
            
            for (index,text) in list.enumerated(){
                if sender.title(for: .normal)! == text{
                    interestingTagList!.remove(at: index)
                }
            }
            
            for subview in tagTextField.subviews{
                
                if subview == tagTextField.subviews.first{
                    continue
                }
                
                subview.removeFromSuperview()
            }
            pasteEditTag(forView: tagTextField, forTagList: interestingTagList!, originalY: 0)
            
            
            sender.alpha = 1
        }
        
        sender.enableFlag = !sender.enableFlag
        //sender.isEnabled = sender.enableFlag
        
    }
    
    
    
    
    func tagPushed(sender:EditableTagButton){
        
        print("tagpushed")
        guard let list = interestingTagList else { return }
        
        for (index,text) in list.enumerated(){
            if sender.title(for: .normal)! == prefix + text{
                print("remove")
                interestingTagList!.remove(at: index)
            }
        }
        
        
        for subView in tagTextField.subviews{
            if subView == tagTextField.subviews.first{
                continue
            }
            
            subView.removeFromSuperview()
        }
        
        pasteEditTag(forView: tagTextField, forTagList: interestingTagList!, originalY: 0)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        let navC = self.navigationController!
        
        switch myStatus {
        case 1:
            let vc = navC.viewControllers[navC.viewControllers.count-2] as! RecruiterProfileViewController
            
            if interestingTagList != nil{
                vc.skillList = interestingTagList!
            }
        case 2:
            let vc = navC.viewControllers[navC.viewControllers.count-2] as! EditProfileViewControllerTest
            
            if interestingTagList != nil{
                vc.interestingTagList = interestingTagList!
            }
        default:
            break
        }
        
        
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


