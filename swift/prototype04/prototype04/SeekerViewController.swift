//
//  SeekerViewController.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/06/29.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class SeekerViewController: UIViewController {

    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var cardView01: UserCard!
    @IBOutlet weak var matchingView: UIView!
    @IBOutlet weak var blurView: UIView!
    
    @IBOutlet weak var card1UserImageView: UIImageView!
    @IBOutlet weak var card1UserNameLabel: UILabel!
    @IBOutlet weak var card1AgeLabel: UILabel!
    @IBOutlet weak var card1UserStatusLabel: UILabel!
    @IBOutlet weak var card1FormerJobLabel: UILabel!
    @IBOutlet weak var card1LabelImageView: UIImageView!
    @IBOutlet weak var card1ExperienceTagView: RectView!
    @IBOutlet weak var card1ExperienceTagViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var matchingUserImageView: UIImageView!
    @IBOutlet weak var matchingMyImageView: UIImageView!
    @IBOutlet weak var card1AppealMessage: UITextView!
//    @IBOutlet weak var card1AppealMessage: UITextView!
    @IBOutlet weak var cardView02: UserCard!
    @IBOutlet weak var card2UserImageView: UIImageView!
    @IBOutlet weak var card2LabelmageView: UIImageView!
    @IBOutlet weak var card2UserNameLabel: UILabel!
    @IBOutlet weak var card2UserStatusLabel: UILabel!
    @IBOutlet weak var card2AgeLabel: UILabel!
    @IBOutlet weak var card2ExperienceTagView: RectView!
    @IBOutlet weak var card2ExperienceTagViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var judgeButtonView: UIView!
    @IBOutlet weak var segmentScrollView: UIScrollView!
    @IBOutlet weak var userDetailExperienceTagView: RectView!
    @IBOutlet weak var userDetailExperienceTagViewHeightConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var segmentationBar: UIView!
    @IBOutlet weak var navBar: UIView!
    @IBOutlet weak var userDetailView: UIScrollView!
    @IBOutlet weak var card2AppealMessage: UITextView!
    
    @IBOutlet weak var card2FormerJobLabel: UILabel!
    
    
    //------------------------------------------
    var locationBySnap:CGPoint!
    var userViewDefaultLocation:CGPoint!
    
    var snapAnimator:UIDynamicAnimator!
    var pushAnimator:UIDynamicAnimator!
    var pushBehavior:UIPushBehavior!
    var snapBehavior:UISnapBehavior!
    
    var cardList:[[Any]]!
    
    
    let kambe:[Any] = [
    "神戸　宗近",
    #imageLiteral(resourceName: "kambe-icon"),
    28,
    "フリーター",
    "円天",
    #imageLiteral(resourceName: "chuto-label"),
    ["EC","物流"],
    ["PHP","ブロックチェーン","IoT","ドローン","宅配ボックス","スポーツ"],
    "物流に革命を起こしたい!!"
    ]
    
    let yamazakiD:[Any] = [
    "山崎　翔一",
    #imageLiteral(resourceName: "yamazaki"),
    27,
    "ニート",
    "国際航業",
    #imageLiteral(resourceName: "chuto-label"),
    ["環境コンサル","fortran"],
    ["Swift","After Effetcs","PHP","Docker","恋愛コンサルタント"],
    "幅広くコンサルタントしてました"
    ]
    
    let harazono:[Any] = [
    "原園　愛仮名",
    #imageLiteral(resourceName: "aikana"),
    25,
    "ニート",
    "JR東海",
    #imageLiteral(resourceName: "chuto-label"),
    ["料理","大阪"],
    ["HTML","CSS","JavaScript","Firebase","PHP"],
    "ボケかツッコミかと言われたらツッコミです"
    ]
    
    let eita:[Any] = [
    "大久保　英太",
    #imageLiteral(resourceName: "eita-icon"),
    21,
    "早稲田大学商学部\n杉山研究室3年",
    "-",
    #imageLiteral(resourceName: "shinsotsu-label"),
    ["簿記２級"],
    ["コンサルタント","ファイナンス","マーケティング","アパレル","環境"],
    "アパレルを一番に希望しております！！よろしくお願いします"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let blurEffect = UIBlurEffect(style: .dark)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.alpha = 1
        visualEffectView.frame = self.matchingView.bounds
        self.blurView.addSubview(visualEffectView)
        
        cardList = []
        cardList.append(kambe)
        cardList.append(eita)
        cardList.append(yamazakiD)
        cardList.append(harazono)
        
        
        
        let tappedImageGesrute1 = UITapGestureRecognizer(target: self, action: #selector(self.tappedCard(gestureRecognizer:)))
        let tappedImageGesrute2 = UITapGestureRecognizer(target: self, action: #selector(self.tappedCard(gestureRecognizer:)))
        cardView01.addGestureRecognizer(tappedImageGesrute1)
        cardView02.addGestureRecognizer(tappedImageGesrute2)
        
        closeButton.layer.masksToBounds = true
        closeButton.layer.cornerRadius = closeButton.frame.width/2
        
        matchingMyImageView.layer.masksToBounds = true
        matchingUserImageView.layer.masksToBounds = true
        
        matchingMyImageView.layer.cornerRadius = matchingUserImageView.frame.width/2
        matchingUserImageView.layer.cornerRadius = matchingMyImageView.frame.width/2
        
        //ViewのSnap動き関係-------------------------------------------------------------------
        userViewDefaultLocation = CGPoint(x: cardView01.center.x, y: self.view.frame.height/2)
        locationBySnap = CGPoint(x: self.view.center.x, y: self.view.frame.height/2 - 40)
        
        let choiceGestureRecogizer = UIPanGestureRecognizer(target: self, action: #selector(self.choiceGesture(sender:)))
        cardView01.isUserInteractionEnabled = true
        cardView01.addGestureRecognizer(choiceGestureRecogizer)
        snapAnimator = UIDynamicAnimator(referenceView: self.view)
        pushAnimator = UIDynamicAnimator(referenceView: self.view)
        pushBehavior = UIPushBehavior(items: [cardView01], mode: UIPushBehaviorMode.continuous)
        
        
        cardView01.numberOfOage = 0
        cardView02.numberOfOage = 1
        
        updateCard(target: cardView01)
        updateCard(target: cardView02)
        
        
        self.view.sendSubview(toBack: self.cardView02)
        cardView02.transform = CGAffineTransform.init(scaleX: 0.8, y: 0.8)
        
        updateDetailCardTag(targetView: cardView01)
        // Do any additional setup after loading the view.
    }

    
    //★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
    //gesture関係-----------------------------------------------------------------
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
            print("ended")
            
            
            if fabs(sender.velocity(in: view).x) > 100{
                
                let velX = sender.velocity(in: view).x
                let velY = sender.velocity(in: view).y
                
                pushBehavior.pushDirection = CGVector(dx: velX, dy: velY)
                pushAnimator.addBehavior(pushBehavior)
                
                //左スワイプなら画面もどる
                //右スワイプなら、アプリをスタートする
                
                
                var swipeDirection:direction
                if sender.velocity(in: view).x > 0{
                    swipeDirection = .right
                    print("right swipe")
                    
                    
                }else{
                    print("left swipe")
                    swipeDirection = .left
                }
                
                //                while abs(sender.location(in: self.view).x) < 500 {
                //                    print(sender.location(in: self.view).x)
                ////                    pushBehavior.pushDirection = CGVector(dx: velX, dy: velY)
                //                    pushAnimator.addBehavior(pushBehavior)
                //                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                    //                    self.swipeHandler(swipedView: sender.view as! UserCard, direction: swipeDirection)
                    self.moveCard(swipedView: sender.view as! UserCard)
//                    if swipeDirection == direction.right{
//                        self.matchingEvent()
//                    }
                    
                })
                
            }else{
                snapBehavior = UISnapBehavior(item: sender.view!, snapTo: locationBySnap!)
                snapAnimator.addBehavior(snapBehavior!)
            }
        default:
            print("default")
        }
        
    }
    
    //スワイプされたときのカードの入れ替え
    func moveCard(swipedView:UserCard){
        
        print("number of page:\(swipedView.numberOfOage)")
        swipedView.numberOfOage += 2
        let toBackView = swipedView
        var toFrontView:UserCard!
        switch swipedView {
        case cardView01:
            toFrontView = cardView02
        case cardView02:
            toFrontView = cardView01
        default:
            print("default")
        }
        
        
        toBackView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        pushBehavior.removeItem(toBackView)
        pushBehavior = UIPushBehavior(items: [toFrontView], mode: UIPushBehaviorMode.continuous)
        let choicePanRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.choiceGesture(sender:)))
        toFrontView.isUserInteractionEnabled = true
        toBackView.isUserInteractionEnabled = false
        toFrontView.addGestureRecognizer(choicePanRecognizer)
        self.view.bringSubview(toFront: toFrontView)
        UIView.animate(withDuration: 1) {
            toFrontView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        
        toBackView.layer.position = userViewDefaultLocation
        updateCard(target: swipedView)
        updateDetailCardTag(targetView: toFrontView)
    }
    
    func updateCard(target:UserCard){
        
        let userInfo:[Any] = cardList[target.numberOfOage]
        
        
        switch target {
        case cardView01:
            card1UserNameLabel.text = userInfo[0] as? String
            card1UserImageView.image = userInfo[1] as? UIImage
            card1AgeLabel.text = "(" + String(describing: userInfo[2]) + ")"
            card1UserStatusLabel.text = userInfo[3] as? String
            card1FormerJobLabel.text = userInfo[4] as? String
            card1LabelImageView.image = userInfo[5] as? UIImage
            var tagList:[String] = [String]()
//            tagList = userInfo[6] as! [String]
            tagList.append(contentsOf: userInfo[6] as! [String])
            tagList.append(contentsOf: userInfo[7] as! [String])
            card1AppealMessage.text = userInfo[8] as? String
            pasteTag(forView: card1ExperienceTagView, forTagList: tagList, heightConstraint: card1ExperienceTagViewHeightConstraint)
            
        case cardView02:
            card2UserNameLabel.text = userInfo[0] as? String
            card2UserImageView.image = userInfo[1] as? UIImage
            card2AgeLabel.text = "(" + String(describing: userInfo[2]) + ")"
            card2UserStatusLabel.text = userInfo[3] as? String
            card2FormerJobLabel.text = userInfo[4] as? String
            card2LabelmageView.image = userInfo[5] as? UIImage
            var tagList:[String] = [String]()
            tagList.append(contentsOf: userInfo[6] as! [String])
            tagList.append(contentsOf: userInfo[7] as! [String])
            card2AppealMessage.text = userInfo[8] as? String
            pasteTag(forView: card2ExperienceTagView, forTagList: tagList, heightConstraint: card2ExperienceTagViewHeightConstraint)
        default:
            break
        }
    }
    
    func updateDetailCardTag(targetView:UserCard){
        let userInfo:[Any] = cardList[targetView.numberOfOage]
        var tagList:[String] = [String]()
        tagList.append(contentsOf: userInfo[6] as! [String])
        tagList.append(contentsOf: userInfo[7] as! [String])
        pasteTag(forView: userDetailExperienceTagView, forTagList: tagList, heightConstraint: userDetailExperienceTagViewHeightConstraint)
    }
    
    //ビューとタグを指定して、タグフィールドを作る
    func pasteTag(forView targetView:UIView,forTagList TagList:[String],heightConstraint:NSLayoutConstraint){
        
        var pointX:CGFloat = 10
        var pointY:CGFloat = 10
        var lastHeight:CGFloat = 0
        
        for view in targetView.subviews{
            if view == targetView.subviews.first{
                continue
            }
            view.removeFromSuperview()
        }
        
        
        
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
    
    func tappedCard(gestureRecognizer:UITapGestureRecognizer){
        
        //        recruiterVCDelegate?.hiddenBar()
        
        let vc = self.parent as! ContainerViewControllerTest
        vc.navigationView.isHidden = true
        let messageVC = vc.childViewControllers.last as! SeekerMessageViewController
//        messageVC.strList.append("hogehoge")
//        messageVC.myTableView.reloadData()
        
        
        self.view.bringSubview(toFront: self.userDetailView)
        self.view.bringSubview(toFront: self.judgeButtonView)
        
        userDetailView.isHidden = false
        judgeButtonView.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.userDetailView.transform = CGAffineTransform(translationX: 0, y: -15)
        }
        
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        segmentationBar.transform = CGAffineTransform.init(translationX: self.segmentScrollView.contentOffset.x/2, y: 0)
        
        if self.userDetailView.contentOffset.y > 100 && self.userDetailView.contentOffset.y < 150{
            navBar.isHidden = false
            navBar.transform = CGAffineTransform.init(translationX: 0, y: self.userDetailView.contentOffset.y + self.userDetailView.contentOffset.y - 100)
        }else if self.userDetailView.contentOffset.y > 150{
            navBar.transform = CGAffineTransform.init(translationX: 0, y: self.userDetailView.contentOffset.y + 50)
        }else{
            navBar.isHidden = true
        }
    }

    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.view.sendSubview(toBack: self.userDetailView)
        self.view.sendSubview(toBack: self.judgeButtonView)
        
        let vc = self.parent as! ContainerViewControllerTest
        vc.navigationView.isHidden = false
        
        UIView.animate(withDuration: 0.3) {
            self.userDetailView.transform = CGAffineTransform(translationX: 0, y: 0)
            
        }
        defer {
            self.userDetailView.isHidden = true
            judgeButtonView.isHidden = true
        }
        
    }
    
    @IBAction func closeMatchingView(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            self.matchingView.alpha = 0
            
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            let vc = self.parent as! ContainerViewControllerTest
            vc.navigationView.isHidden = false
            self.matchingView.isHidden = true
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func conetntsFirstButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            self.segmentScrollView.contentOffset.x = 0
            self.segmentationBar.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }

    @IBAction func conetntsSecondButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            self.segmentScrollView.contentOffset.x = self.segmentScrollView.frame.width
            self.segmentationBar.transform = CGAffineTransform(translationX: self.view.frame.width/2, y: 0)
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
