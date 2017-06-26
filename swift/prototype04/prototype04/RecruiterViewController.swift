//
//  RecruiterViewController.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/06/25.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

protocol RecruiterDelegate {
    func hiddenBar()
}


class RecruiterViewController: UIViewController,UIScrollViewDelegate,UINavigationControllerDelegate{

    //Main---------------------------------------------------------------------
    var locationBySnap:CGPoint!
    var userViewDefaultLocation:CGPoint!
    
    var recruiterVCDelegate:RecruiterDelegate?
    
    @IBOutlet weak var throwButton: UIButton!
    @IBOutlet weak var interstingButton: UIButton!
    
    @IBOutlet weak var cardView01: UserCard!
    @IBOutlet weak var cardView02: UserCard!
    
    @IBOutlet weak var judgeButton: UIView!
    
    @IBOutlet weak var navBar: UIView!
    @IBOutlet weak var userDetailView: UIScrollView!
    @IBOutlet weak var segmentScrollView: UIScrollView!
    @IBOutlet weak var scrollBar: UIView!
    @IBOutlet weak var experienceTagView: RectView!
    @IBOutlet weak var experienceTagViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var closeButton: UIButton!
    var recruiterTagList:[String] = [String]()
    
    @IBOutlet weak var experienceTagView2: RectView!
    @IBOutlet weak var experienceTagView2HeightConstraint: NSLayoutConstraint!
    
    
    var snapAnimator:UIDynamicAnimator!
    var pushAnimator:UIDynamicAnimator!
    var pushBehavior:UIPushBehavior!
    var snapBehavior:UISnapBehavior!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        segmentScrollView.delegate = self
        userDetailView.delegate = self
        
        throwButton.layer.borderWidth = 1
        interstingButton.layer.borderWidth = 1
        
        
        closeButton.layer.masksToBounds = true
        closeButton.layer.cornerRadius = closeButton.frame.width/2
        
        let data:dummyData = dummyData()
        recruiterTagList = data.experienceList + data.skillList
        pasteTag(forView: experienceTagView, forTagList: recruiterTagList, heightConstraint: experienceTagViewHeightConstraint)
        pasteTag(forView: experienceTagView2, forTagList: recruiterTagList, heightConstraint: experienceTagView2HeightConstraint)
        
        let tappedImageGesrute = UITapGestureRecognizer(target: self, action: #selector(self.tappedCard(gestureRecognizer:)))
        cardView01.addGestureRecognizer(tappedImageGesrute)
        
        //ViewのSnap動き関係-------------------------------------------------------------------
        userViewDefaultLocation = CGPoint(x: cardView01.center.x, y: self.view.frame.height/2)
        locationBySnap = CGPoint(x: self.view.center.x, y: self.view.frame.height/2 - 15)
        
        let choiceGestureRecogizer = UIPanGestureRecognizer(target: self, action: #selector(self.choiceGesture(sender:)))
        cardView01.isUserInteractionEnabled = true
        cardView01.addGestureRecognizer(choiceGestureRecogizer)
        snapAnimator = UIDynamicAnimator(referenceView: self.view)
        pushAnimator = UIDynamicAnimator(referenceView: self.view)
        pushBehavior = UIPushBehavior(items: [cardView01], mode: UIPushBehaviorMode.continuous)
        
        self.view.sendSubview(toBack: self.cardView02)
        cardView02.transform = CGAffineTransform.init(scaleX: 0.8, y: 0.8)
        // Do any additional setup after loading the view.
    }
    
    func tappedCard(gestureRecognizer:UITapGestureRecognizer){
        
        recruiterVCDelegate?.hiddenBar()
        
        self.view.bringSubview(toFront: self.userDetailView)
        self.view.bringSubview(toFront: self.judgeButton)
        
        userDetailView.isHidden = false
        judgeButton.isHidden = false
        UIView.animate(withDuration: 0.3) { 
            self.userDetailView.transform = CGAffineTransform(translationX: 0, y: -15)
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollBar.transform = CGAffineTransform.init(translationX: self.segmentScrollView.contentOffset.x/2, y: 0)
        
        if self.userDetailView.contentOffset.y > 100 && self.userDetailView.contentOffset.y < 150{
            navBar.isHidden = false
        navBar.transform = CGAffineTransform.init(translationX: 0, y: self.userDetailView.contentOffset.y + self.userDetailView.contentOffset.y - 100)
        }else if self.userDetailView.contentOffset.y > 150{
        navBar.transform = CGAffineTransform.init(translationX: 0, y: self.userDetailView.contentOffset.y + 50)
        }else{
            navBar.isHidden = true
        }
    }

    @IBAction func contentsFirstButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            self.segmentScrollView.contentOffset.x = 0
            self.scrollBar.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
    @IBAction func contentsSecondButtonTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.segmentScrollView.contentOffset.x = self.segmentScrollView.frame.width
            self.scrollBar.transform = CGAffineTransform(translationX: self.view.frame.width/2, y: 0)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            
            
            if fabs(sender.velocity(in: view).x) > 500{
                
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
                })
                
            }else{
                snapBehavior = UISnapBehavior(item: sender.view!, snapTo: locationBySnap!)
                snapAnimator.addBehavior(snapBehavior!)
            }
        default:
            print("default")
        }
        
    }

//    //スワイプされたときの処理
//    func swipeHandler(swipedView:UserCard,direction:direction){
//        let userInfo = cardList[swipedView.numberOfOage] as? [String:Any]
//        
//        var encounterList:[String] = myInfo["encounterd"] as! [String]
//        
//        //        let myUUID = UDSetting.read(key: .uuid) as String
//        let myUUID = udSetting.read(key: .uuid) as String
//        let uuid = userInfo?["uuid"] as? String
//        
//        var matchList = myInfo["matched"] as? [String]
//        
//        encounterList.append(uuid!)
//        myInfo["encounterd"] = encounterList
//        
//        switch direction {
//        case .right:
//            print("right")
//            //自分の情報の like list に追加
//            var likeList:[String]? = myInfo["liked"] as? [String]
//            likeList?.append(uuid!)
//            myInfo["liked"] = likeList
//            print("305:\(myInfo["liked"])")
//            //向こうもLikeなら、マッチイベントの発生
//            if let a:[String] = userInfo?["liked"] as? [String]{
//                if a.contains(myUUID){
//                    print("309:matched!!")
//                    messageableUserList.append(userInfo!)
//                    messageTableView.reloadData()
//                    self.view.bringSubview(toFront: self.matchingView)
//                    UIView.animate(withDuration: 2, animations: {
//                        self.matchingView.alpha = 1
//                    })
//                    //                    matchList.append(uuid!)
//                    //向こうのdataも更新してPOST?
//                    
//                }
//            }
//            
//            
//        case .left:
//            print("left")
//        }
//        
//        //スワイプの結果をサーバーに送って、DBの更新
//        //        let sc = ServerConnection()
//        //        sc.updateMyData(mydata: myInfo)
//    }
    
    
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
//        updateCard(targetCard: swipedView)
    }
    
    //カード情報の更新※スワイプされときに実行
//    func updateCard(targetCard:UserCard){
//        var nameLabel:UILabel = UILabel()
//        
//        switch targetCard {
//        case cardView01:
//            nameLabel = card01NameLabel
//        case cardView02:
//            nameLabel = card02NameLabel
//        default:
//            break
//        }
//        addTag(user: cardList[targetCard.numberOfOage] as! [String:Any],card: targetCard)
//        addTreat(user: cardList[targetCard.numberOfOage] as! [String:Any] , cardView: targetCard)
//        let list = cardList[targetCard.numberOfOage] as! [String:Any]
//        nameLabel.text = list["username"] as? String
//        self.setImage(targetCard: targetCard)
//    }
    
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.view.sendSubview(toBack: self.userDetailView)
        self.view.sendSubview(toBack: self.judgeButton)
        UIView.animate(withDuration: 0.3) {
            self.userDetailView.transform = CGAffineTransform(translationX: 0, y: 0)
            
        }
        defer {
            self.userDetailView.isHidden = true
            judgeButton.isHidden = true
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
