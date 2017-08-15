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

    @IBOutlet weak var cardView01: UserCard!
    
    @IBOutlet weak var card1UserYeartoWorkLabel: UILabel!
    @IBOutlet weak var card1UserNameLabel: UILabel!
    @IBOutlet weak var card1UserJobLabel: UILabel!
    @IBOutlet weak var card1CompanyLogoImageView: UIImageView!
    @IBOutlet weak var card1experienceTagViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var card1CompanyLink: ClickableTextView!
    @IBOutlet weak var card1CompanyNameLabel: UILabel!
    @IBOutlet weak var card1AgeLabel: UILabel!
    @IBOutlet weak var card1LabelImageView: UIImageView!
    @IBOutlet weak var card1UserImageView: UIImageView!
    @IBOutlet weak var card1FormerJobLabel: UILabel!
    @IBOutlet weak var card2UserYeartoWorkLabel: UILabel!
    @IBOutlet weak var user2ImageView: UIImageView!
    
    @IBOutlet weak var card2experienceTagViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var card2FormerJobLabel: UILabel!
    @IBOutlet weak var card2CompanyLink: ClickableTextView!
    @IBOutlet weak var card2CompanyNameLabel: UILabel!
    @IBOutlet weak var card2UserImageView: UIImageView!
    
    @IBOutlet weak var card2LabelImageView: UIImageView!
    
    @IBOutlet weak var card2AgeLabel: UILabel!
    @IBOutlet weak var card2UserNameLabel: UILabel!
    @IBOutlet weak var card2CompanyLogoImageView: UIImageView!
    @IBOutlet weak var card2UserJobLabel: UILabel!
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var matcingView: UIView!
    @IBOutlet weak var user1ImageView: UIImageView!
    
    //Main---------------------------------------------------------------------
    var locationBySnap:CGPoint!
    var userViewDefaultLocation:CGPoint!
    
    var recruiterVCDelegate:RecruiterDelegate?
    
    @IBOutlet weak var throwButton: UIButton!
    @IBOutlet weak var interstingButton: UIButton!
    
    
    @IBOutlet weak var cardView02: UserCard!
    
    @IBOutlet weak var judgeButton: UIView!
    
    @IBOutlet weak var navBar: UIView!
    @IBOutlet weak var userDetailView: UIScrollView!
    @IBOutlet weak var segmentScrollView: UIScrollView!
    @IBOutlet weak var scrollBar: UIView!
    @IBOutlet weak var card1ExperienceTagView: RectView!
    
    @IBOutlet weak var card2ExperienceTagView: RectView!
    @IBOutlet weak var closeButton: UIButton!
    var recruiterTagList:[String] = [String]()
    
    @IBOutlet weak var experienceTagView2: RectView!
    @IBOutlet weak var experienceTagView2HeightConstraint: NSLayoutConstraint!
    
    
    var snapAnimator:UIDynamicAnimator!
    var pushAnimator:UIDynamicAnimator!
    var pushBehavior:UIPushBehavior!
    var snapBehavior:UISnapBehavior!
    
    var cardList:[[Any]]!
    let kimura:[Any] = [
        "木村　よしお",
        26,
        #imageLiteral(resourceName: "wakate-label"),
        "ディレクター",
        "中途２年目",
        ["営業","教育","ディレクター"],
        "G's Academy",
        "http://gsacademy.tokyo/",
        #imageLiteral(resourceName: "kimura"),
        "tableForTwo",
        #imageLiteral(resourceName: "dinnerIconColored"),
        #imageLiteral(resourceName: "gsacademy")]
    
    let ranko:[Any] = [
        "神山　蘭子",
        34,
        #imageLiteral(resourceName: "middle-label"),
        "一般職",
        "中途３年目",
        ["受付","事務","経理"],
        "G's Academy",
        "http://gsacademy.tokyo/",
        #imageLiteral(resourceName: "ranko"),
        "縁ジャパン",
        #imageLiteral(resourceName: "morning_icon"),
        #imageLiteral(resourceName: "gsacademy")]
    
    let kuri:[Any] = [
        "栗林　緒",
        35,
        #imageLiteral(resourceName: "middle-label"),
        "エンジニア",
        "中途２年目",
        ["ギタリスト","Javascript","Node.js","React"],
        "G's Academy",
        "http://gsacademy.tokyo/",
        #imageLiteral(resourceName: "kuri"),
        "Jazzギタリスト",
        #imageLiteral(resourceName: "caffeIconColored"),
        #imageLiteral(resourceName: "gsacademy")]
    
    let tamura:[Any] = [
        "田村　悠里",
        31,
        #imageLiteral(resourceName: "middle-label"),
        "人事部",
        "中途７年目",
        ["ディレクター","人事","動画メディア"],
        "スモーアカデミー",
        "http://localhost:8888/sumo/",
        #imageLiteral(resourceName: "tamura-2"),
        "アナログハリウッド",
        #imageLiteral(resourceName: "caffeIconColored"),
        #imageLiteral(resourceName: "sumoacademy-icon")]
    
    var cardList2:[Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //マッチングしたときのビュー、透過してる
        let blurEffect = UIBlurEffect(style: .dark)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.alpha = 1
        visualEffectView.frame = self.matcingView.bounds
        self.blurView.addSubview(visualEffectView)
        
        cardList = []
        cardList.append(tamura)
        cardList.append(kimura)
        cardList.append(ranko)
        cardList.append(kuri)
        
        let app:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        cardList2.append(app.cardListDelegate)
        
        print("aaa:\(app.cardListDelegate)")
        
        segmentScrollView.delegate = self
        userDetailView.delegate = self
        
        closeButton.layer.masksToBounds = true
        closeButton.layer.cornerRadius = closeButton.frame.width/2
        
        user1ImageView.layer.masksToBounds = true
        user2ImageView.layer.masksToBounds = true
        
        user1ImageView.layer.cornerRadius = user1ImageView.frame.width/2
        user2ImageView.layer.cornerRadius = user2ImageView.frame.width/2
        
        let data:dummyData = dummyData()
        recruiterTagList = data.experienceList + data.skillList
        
        
        let tappedImageGesrute1 = UITapGestureRecognizer(target: self, action: #selector(self.tappedCard(gestureRecognizer:)))
        let tappedImageGesrute2 = UITapGestureRecognizer(target: self, action: #selector(self.tappedCard(gestureRecognizer:)))
        cardView01.addGestureRecognizer(tappedImageGesrute1)
        cardView02.addGestureRecognizer(tappedImageGesrute2)
        
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
        updateDetailCardTag(targetView: cardView01)
        
        self.view.sendSubview(toBack: self.cardView02)
        cardView02.transform = CGAffineTransform.init(scaleX: 0.8, y: 0.8)
        
        
        // Do any additional setup after loading the view.
    }
    
    
    func tappedCard(gestureRecognizer:UITapGestureRecognizer){
        
//        recruiterVCDelegate?.hiddenBar()
        
        let vc = self.parent as! ContainerViewControllerTest
        vc.navigationView.isHidden = true
//        let messageVC = vc.childViewControllers.last as! MessageViewControllerTest
//        messageVC.strList.append("hogehoge")
//        messageVC.myTableView.reloadData()
        
        
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
            
            
            if fabs(sender.velocity(in: view).x) > 300{
                
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
                    if swipeDirection == direction.right{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: { 
                            self.matchingEvent()
                        })
                        
                    }
                    
                })
                
            }else{
                snapBehavior = UISnapBehavior(item: sender.view!, snapTo: locationBySnap!)
                snapAnimator.addBehavior(snapBehavior!)
            }
        default:
            print("default")
        }
        
    }

    func matchingEvent(){
        let vc = self.parent as! ContainerViewControllerTest
        vc.navigationView.isHidden = true
        self.view.bringSubview(toFront: self.matcingView)
        self.matcingView.isHidden = false
        UIView.animate(withDuration: 0.3) { 
            self.matcingView.alpha = 1
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
        updateDetailCardTag(targetView: toFrontView)
        updateCard(target: swipedView)
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
    
    func updateCard(target:UserCard){
        
        let userInfo:[Any] = cardList[target.numberOfOage]
        
        switch target {
        case cardView01:
            card1UserNameLabel.text = userInfo[0] as? String
            card1AgeLabel.text = "(" + String(describing: userInfo[1]) + ")"
            card1CompanyLink.text = userInfo[7] as! String
            card1CompanyNameLabel.text = userInfo[6] as? String
            card1UserJobLabel.text = userInfo[3] as? String
            card1FormerJobLabel.text = userInfo[9] as? String
            card1UserYeartoWorkLabel.text = userInfo[4] as? String
            card1UserImageView.image = userInfo[8] as? UIImage
            card1LabelImageView.image = userInfo[2] as? UIImage
            card1CompanyLogoImageView.image = userInfo[11] as? UIImage
            pasteTag(forView: card1ExperienceTagView, forTagList: userInfo[5] as! [String], heightConstraint: card1experienceTagViewHeightConstraint)
            
            
        case cardView02:
            card2UserNameLabel.text = userInfo[0] as? String
            card2AgeLabel.text = "(" + String(describing: userInfo[1]) + ")"
            card2CompanyLink.text = userInfo[7] as! String
            card2CompanyNameLabel.text = userInfo[6] as? String
            card2UserJobLabel.text = userInfo[3] as? String
            card2FormerJobLabel.text = userInfo[9] as? String
            card2UserYeartoWorkLabel.text = userInfo[4] as? String
            card2UserImageView.image = userInfo[8] as? UIImage
            card2LabelImageView.image = userInfo[2] as? UIImage
            card2CompanyLogoImageView.image = userInfo[11] as? UIImage
            pasteTag(forView: card2ExperienceTagView, forTagList: userInfo[5] as! [String], heightConstraint: card2experienceTagViewHeightConstraint)
        default:
            break
        }
    }
    
    func updateDetailCardTag(targetView:UserCard){
        let userInfo:[Any] = cardList[targetView.numberOfOage]
        pasteTag(forView: experienceTagView2, forTagList: userInfo[5] as! [String], heightConstraint: experienceTagView2HeightConstraint)
    }
    
    @IBAction func closeMatcingView(_ sender: Any) {
        UIView.animate(withDuration: 0.3) { 
            self.matcingView.alpha = 0
            
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { 
            let vc = self.parent as! ContainerViewControllerTest
            vc.navigationView.isHidden = false
            self.matcingView.isHidden = true
        }
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.view.sendSubview(toBack: self.userDetailView)
        self.view.sendSubview(toBack: self.judgeButton)
        
        let vc = self.parent as! ContainerViewControllerTest
        vc.navigationView.isHidden = false
        
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
