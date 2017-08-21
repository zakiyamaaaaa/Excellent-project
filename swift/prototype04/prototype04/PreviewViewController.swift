//
//  PreviewViewController02.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/06/08.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {

    @IBOutlet weak var userCard: UIView!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var belongingLabel: UILabel!
    @IBOutlet weak var jobTagTextField: UITextField!
    @IBOutlet weak var appealLabel: UILabel!
    @IBOutlet weak var rightSlideImageView: UIImageView!
    @IBOutlet weak var leftSlideImageView: UIImageView!
    
    @IBOutlet weak var jobTagHeightConstraint: NSLayoutConstraint!
    var snapAnimator:UIDynamicAnimator!
    var pushAnimator:UIDynamicAnimator!
    var pushBehavior:UIPushBehavior!
    var snapBehavior:UISnapBehavior!
    var locationBySnap:CGPoint!
    var userViewDefaultLocation:CGPoint!
    var jobTagList:[String] = [String]()
    
    let udSetting:UserDefaultSetting = UserDefaultSetting()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //NavigationBarを隠す
        self.navigationController?.isNavigationBarHidden = true
        
        //imageViewに画像を設定
        let documentDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let imgFileName = "sample.png"
        let tmp = UIImage(contentsOfFile: "\(documentDir)/\(imgFileName)")
        myImageView.image = tmp
        myImageView.layer.borderWidth = 1
        
        //-----------------------------------------------------------------------
        userViewDefaultLocation = CGPoint(x: userCard.center.x, y: userCard.center.y)
        locationBySnap = CGPoint(x: self.view.center.x, y: self.view.center.y)
        
        //userardにgestureを登録
        let choiceGestureRecogizer = UIPanGestureRecognizer(target: self, action: #selector(self.choiceGesture(sender:)))
        userCard.isUserInteractionEnabled = true
        userCard.addGestureRecognizer(choiceGestureRecogizer)
        snapAnimator = UIDynamicAnimator(referenceView: self.view)
        pushAnimator = UIDynamicAnimator(referenceView: self.view)
        pushBehavior = UIPushBehavior(items: [userCard], mode: UIPushBehaviorMode.continuous)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //ラベルの設定
//        userNameLabel.text = udSetting.read(key: .username)
//        ageLabel.text = "(" + udSetting.read(key: .age) + ")"
//        belongingLabel.text = udSetting.read(key: .belonging)
//        appealLabel.text = udSetting.read(key: .appeal)
        
        //タグを貼り付け
        addTag()
        
        //スワイプアイコンの動き
        UIView.animate(withDuration: 2, delay: 0, options: UIViewAnimationOptions.repeat, animations: {
            self.rightSlideImageView.transform = CGAffineTransform.init(translationX: 50, y: 0)
            self.leftSlideImageView.transform = CGAffineTransform.init(translationX: -50, y: 0)
        }, completion: nil)
    }
    
    func addTag(){
        var pointX:CGFloat = 10
        var pointY:CGFloat = 10
        var lastHeight:CGFloat = 0
        let width = jobTagTextField.frame.width
//        jobTagList = udSetting.read(key: .job)
        let jobIndustyList = jobTagTitleList.init().industry
        let jobOccupationList = jobTagTitleList.init().occupation
        
        for jobTagTitle in jobTagList{
            var tagType:jobTagType = .industry
            if jobIndustyList.contains(jobTagTitle){
                tagType = .industry
            }
            
            if jobOccupationList.contains(jobTagTitle){
                tagType = .occupation
            }
            
            let button = flagButton(frame: .zero, title: jobTagTitle, Tagtype: tagType)
            button.frame.size = CGSize(width: button.frame.width + 10, height: button.frame.height)
            
            jobTagTextField.addSubview(button)
            
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
        
        //一番最後のタグの高さをjobTagViewの高さコンストレイントを設定
        jobTagHeightConstraint.constant = lastHeight + 10
        
        
    }
    
    //カードを選択したとき
    func choiceGesture(sender:UIPanGestureRecognizer){
        switch sender.state {
        case .began:
            snapAnimator.removeAllBehaviors()
            print("began")
        case .changed:
            
            
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
            break
        }
        
        
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
