//
//  PreviewProfileViewController.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/05/14.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class PreviewProfileViewController: UIViewController {

    @IBOutlet weak var previewUserCard: UserCard!
    
    var snapAnimator:UIDynamicAnimator!
    var pushAnimator:UIDynamicAnimator!
    var pushBehavior:UIPushBehavior!
    var snapBehavior:UISnapBehavior!
    
    @IBOutlet weak var tagView: UIView!
    @IBOutlet weak var jobLabelTitle: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var backgroundLabel: UILabel!
    @IBOutlet weak var qualificationLabel: UILabel!
    
    var locationBySnap:CGPoint!
    var userViewDefaultLocation:CGPoint!
    @IBOutlet weak var leftSlideButton: UIButton!
    @IBOutlet weak var rightSlideButton: UIButton!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    var jobTagList:[[jobTagType:String]]?
    var jobTagList01:[String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let documentDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let imgFileName = "sample.png"
        let tmp = UIImage(contentsOfFile: "\(documentDir)/\(imgFileName)")
        userImageView.image = tmp
        
        
        //-----------------------------------------------------------------------
        userViewDefaultLocation = CGPoint(x: previewUserCard.center.x, y: previewUserCard.center.y)
        locationBySnap = CGPoint(x: self.view.center.x, y: self.view.center.y)
        
        let choiceGestureRecogizer = UIPanGestureRecognizer(target: self, action: #selector(self.choiceGesture(sender:)))
        previewUserCard.isUserInteractionEnabled = true
        previewUserCard.addGestureRecognizer(choiceGestureRecogizer)
        snapAnimator = UIDynamicAnimator(referenceView: self.view)
        pushAnimator = UIDynamicAnimator(referenceView: self.view)
        pushBehavior = UIPushBehavior(items: [previewUserCard], mode: UIPushBehaviorMode.continuous)
        
        
        
        var image = UIImage(named: "slide_material")
        image = image?.withRenderingMode(.alwaysTemplate)
        rightSlideButton.setImage(image, for: UIControlState.normal)
        rightSlideButton.tintColor = UIColor.blue
        
        leftSlideButton.setImage(image, for: UIControlState.normal)
        leftSlideButton.tintColor = UIColor.red
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let udSetting:UserDefaultSetting = UserDefaultSetting()
    
    override func viewWillAppear(_ animated: Bool) {
        
        jobLabelTitle.sizeToFit()
        
        userNameLabel.text = udSetting.read(key: .username)
        backgroundLabel.text = udSetting.read(key: .background)
        qualificationLabel.text = udSetting.read(key: .qualification)
        addTag()
        UIView.animate(withDuration: 2, delay: 0, options: UIViewAnimationOptions.repeat, animations: {
            
            self.rightSlideButton.transform = CGAffineTransform.init(translationX: 50, y: 0)
            self.leftSlideButton.transform = CGAffineTransform.init(translationX: -50, y: 0)
        }, completion: nil)
    }
    
    func addTag(){
        var pointX:CGFloat = 10
        var pointY:CGFloat = 10
        var lastHeight:CGFloat = 0
        let width = tagView.frame.width
        jobTagList01 = udSetting.read(key: .job)
        let jobIndustyList = jobTagTitleList.init().industry
        let jobOccupationList = jobTagTitleList.init().occupation
        
        for jobTagTitle in jobTagList01{
            var tagType:jobTagType = .industry
            if jobIndustyList.contains(jobTagTitle){
                tagType = .industry
            }
            
            if jobOccupationList.contains(jobTagTitle){
                tagType = .occupation
            }
            
            let button = flagButton(frame: .zero, title: jobTagTitle, Tagtype: tagType)
            button.frame.size = CGSize(width: button.frame.width + 10, height: button.frame.height)
            
            tagView.addSubview(button)
            
            button.frame.origin = CGPoint(x: pointX, y: pointY)
            pointY = button.frame.origin.y
            pointX = button.frame.origin.x + button.frame.width
            
            
            if pointX > width{
                button.frame.origin.x = 10
                button.frame.origin.y = pointY + button.frame.height + 6
            }
            
            
            pointX = button.frame.origin.x + button.frame.width + 10
            pointY = button.frame.origin.y
            
            if lastHeight < pointY + button.frame.height{
                lastHeight = pointY + button.frame.height
            }
        }
        
        tagView.frame.size = CGSize(width: width, height: lastHeight + 20)
        
    }

    
    func process(label:UILabel){
        label.sizeToFit()
        label.frame.size = CGSize(width: label.frame.width + 40, height: label.frame.height)
    }
    
    func choiceGesture(sender:UIPanGestureRecognizer){
        switch sender.state {
        case .began:
            snapAnimator.removeAllBehaviors()
            print("began")
        case .changed:
            print("changed")
            
            let moveValue:CGPoint = sender.translation(in: view)
            sender.view!.center.x += moveValue.x
            sender.view!.center.y += moveValue.y
            sender.setTranslation(CGPoint.zero, in: view)
            
            
        case .ended:
            
            if fabs(sender.velocity(in: view).x) > 500{
                let velX = sender.velocity(in: view).x
                let velY = sender.velocity(in: view).y
                
                pushBehavior.pushDirection = CGVector(dx: velX, dy: velY)
                pushAnimator.addBehavior(pushBehavior)
                
                //左スワイプなら画面もどる
                //右スワイプなら、アプリをスタートする
                
                print(sender.location(in: self.view).x)
                
                if sender.velocity(in: view).x > 0{
                    
                    print("right swipe")
                    
                    //１秒後に実行する
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    
                        self.performSegue(withIdentifier: "segueSearch", sender: nil)
                    }
                    
                    
                }else{
                    print("left swipe")
                    self.dismiss(animated: true, completion: nil)
                }
                
                return
            }else{
                
                
                //ここでアニメーションが終わるまえに他の画面に映ると、アニメーション途中でとまったりバグるので、一括処理をするように。
                snapBehavior = UISnapBehavior(item: sender.view!, snapTo: locationBySnap!)
                snapAnimator.addBehavior(snapBehavior!)
            }
            
            
            
        default:
            print("default")
        }
        
        
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
