//
//  MainViewControllerTest.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/07/28.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class MainViewControllerTest: UIViewController {
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
    @IBOutlet weak var card1OgoriView: UIView!
    @IBOutlet weak var card1MessageLabel: UILabel!
    
    @IBOutlet weak var card2experienceTagViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var card2FormerJobLabel: UILabel!
    @IBOutlet weak var card2MessageLabel: UILabel!
    @IBOutlet weak var card2CompanyLink: ClickableTextView!
    @IBOutlet weak var card2CompanyNameLabel: UILabel!
    @IBOutlet weak var card2UserImageView: UIImageView!
    
    @IBOutlet weak var card2LabelImageView: UIImageView!
    
    @IBOutlet weak var card2OgoriView: UIView!
    @IBOutlet weak var card2AgeLabel: UILabel!
    @IBOutlet weak var card2UserNameLabel: UILabel!
    @IBOutlet weak var card2CompanyLogoImageView: UIImageView!
    @IBOutlet weak var card2UserJobLabel: UILabel!
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var matcingView: UIView!
    @IBOutlet weak var user1ImageView: UIImageView!
    
    @IBOutlet weak var ogoriView: UIView!
    //Main---------------------------------------------------------------------
    var locationBySnap:CGPoint!
    var userViewDefaultLocation:CGPoint!
    
    
    @IBOutlet weak var throwButton: UIButton!
    @IBOutlet weak var interstingButton: UIButton!
    
    
    @IBOutlet weak var cardView02: UserCard!
    
    @IBOutlet weak var judgeButton: UIView!
    

    @IBOutlet weak var card1ExperienceTagView: RectView!
    
    @IBOutlet weak var card2ExperienceTagView: RectView!
    
    var currentShowUserData:userData!
    
    var snapAnimator:UIDynamicAnimator!
    var pushAnimator:UIDynamicAnimator!
    var pushBehavior:UIPushBehavior!
    var snapBehavior:UISnapBehavior!
    
    var cardList:[[Any]] = []
    let properthName = recruiterPropety.self
//    Id/String
//    名前/String
//    生年月日/Date
//    会社名/String
//    役職/String
//    スキル/[String]
//    おごり/[Int]
//    メッセージ/String
//    自己紹介文/String
//    会社人数/Int
//    会社業界/String
//    経歴/[[String,String,Date,Date]]
//    会社紹介/String
//    会社の特徴/[String]
//    募集求人/[String]
//    会社ID/String
    
    @IBOutlet weak var interestingButton: RectButton!
    @IBOutlet weak var cancelButton: RectButton!
    
    
    var cardList2:[Any] = []
    
    var myStatus = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if User().status != nil{
            myStatus = User().status!
        }
        
        //マッチングしたときのビュー、透過してる
        let blurEffect = UIBlurEffect(style: .dark)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.alpha = 1
        visualEffectView.frame = self.matcingView.bounds
        self.blurView.addSubview(visualEffectView)
        
        //LocationViewで取得したcardList
        //ここにいれたものが表示される
        let app:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        cardList2 = app.cardListDelegate!
        
        
        let tappedImageGesrute1 = UITapGestureRecognizer(target: self, action: #selector(self.tappedCard(gestureRecognizer:)))
        let tappedImageGesrute2 = UITapGestureRecognizer(target: self, action: #selector(self.tappedCard(gestureRecognizer:)))
        cardView01.addGestureRecognizer(tappedImageGesrute1)
        cardView02.addGestureRecognizer(tappedImageGesrute2)
        card1CompanyLogoImageView.layer.borderWidth = 0.5
        card2CompanyLogoImageView.layer.borderWidth = 0.5
        
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
        currentCard = cardView01
        
        self.view.sendSubview(toBack: self.cardView02)
        cardView02.transform = CGAffineTransform.init(scaleX: 0.8, y: 0.8)
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if countProfileRatio() < 30 {
            performSegue(withIdentifier: "popProfileSegue", sender: nil)
        }
        
        if cardList2.isEmpty == true{
            performSegue(withIdentifier: "noUserSegue", sender: nil)
        }
    }
    
    func countProfileRatio()->Int{
        let app:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        var count = 0
        var valueCount = 0
        
        
        switch myStatus {
        case 1:
            let message:String? = app.myInfoDelegate?[recruiterPropety.message.rawValue] as? String
            if message != nil && message?.isEmpty == false{
                count += 1
            }
            valueCount += 1
            
            let education:[Any]? = app.myInfoDelegate?[recruiterPropety.education.rawValue] as? [Any]
            if education != nil && education?.isEmpty == false{
                count += 1
            }
            valueCount += 1
            
            //未
            let company_intro:String? = app.myInfoDelegate?[recruiterPropety.company_introduction.rawValue] as? String
            if company_intro != nil && company_intro?.isEmpty == false{
                count += 1
            }
            valueCount += 1
            
            let company_feature:String? = app.myInfoDelegate?[recruiterPropety.company_feature.rawValue] as? String
            if company_feature != nil && company_feature?.isEmpty == false{
                count += 1
            }
            valueCount += 1
            
            let company_recruit:[String]? = app.myInfoDelegate?[recruiterPropety.company_recruitment.rawValue] as? [String]
            if company_recruit != nil && company_recruit?.isEmpty == false{
                count += 1
            }
            valueCount += 1
            
//            let belonging:[Any]? = app.myInfoDelegate?[studentPropety.belonging.rawValue] as? [Any]
//            if belonging != nil && belonging?.isEmpty == false{
//                count += 1
//            }
//            valueCount += 1
//            
//            let interesting:[Any]? = app.myInfoDelegate?[studentPropety.interesting.rawValue] as? [Any]
//            if interesting != nil && interesting?.isEmpty == false{
//                count += 1
//            }
        case 2:
            let message:String? = app.myInfoDelegate?[studentPropety.message.rawValue] as? String
            if message != nil && message?.isEmpty == false{
                count += 1
            }
            valueCount += 1
            
            let education:[Any]? = app.myInfoDelegate?[studentPropety.education.rawValue] as? [Any]
            if education != nil && education?.isEmpty == false{
                count += 1
            }
            valueCount += 1
            
            let goodpoint:String? = app.myInfoDelegate?[studentPropety.goodpoint.rawValue] as? String
            if goodpoint != nil && goodpoint?.isEmpty == false{
                count += 1
            }
            valueCount += 1
            
            let badpoint:String? = app.myInfoDelegate?[studentPropety.badpoint.rawValue] as? String
            if badpoint != nil && goodpoint?.isEmpty == false{
                count += 1
            }
            valueCount += 1
            
            let introduction:String? = app.myInfoDelegate?[studentPropety.introduction.rawValue] as? String
            if introduction != nil && introduction?.isEmpty == false{
                count += 1
            }
            valueCount += 1
            
            let belonging:[Any]? = app.myInfoDelegate?[studentPropety.belonging.rawValue] as? [Any]
            if belonging != nil && belonging?.isEmpty == false{
                count += 1
            }
            valueCount += 1
            
            let interesting:[Any]? = app.myInfoDelegate?[studentPropety.interesting.rawValue] as? [Any]
            if interesting != nil && interesting?.isEmpty == false{
                count += 1
            }
        default:
            break
        }
        
        
        valueCount += 1
        
        let ratio = count*100/valueCount
        
        
        return ratio
    }
    
    func tappedCard(gestureRecognizer:UITapGestureRecognizer){
        
        performSegue(withIdentifier: "showDetailSegue", sender: nil)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailSegue"{
            let vc = segue.destination as! MainUserDetailViewController
            let list = cardList2[currentPage] as! [String:Any]
            let uuid = list[properthName.uuid.rawValue] as! String
            vc.userDic = list
            
        }
        
        if segue.identifier == "matchingSegue"{
            let userInfo = cardList2[currentPage] as! [String:Any]
            let vc = segue.destination as! MatchingViewController
            vc.image2 = getImage(uuid: userInfo[properthName.uuid.rawValue] as! String)
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
                
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                    //                    self.swipeHandler(swipedView: sender.view as! UserCard, direction: swipeDirection)
                    
                    self.swipedEvent(sender: sender.view as! UserCard, direction: swipeDirection)
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
    let app:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
    func swipedEvent(sender:UserCard,direction:direction){
        
        let ud = UserDefaultSetting()
        let myID = ud.read(key: .uuid) as String
        let cardInfo:[String:Any] = cardList2[currentPage] as! [String:Any]
        
        if direction == .right{
            var myLikeList:[String]? = app.myInfoDelegate?[properthName.liked.rawValue] as? [String]
            myLikeList?.append(cardInfo[properthName.uuid.rawValue] as! String)
            
            let likedList:[String]? = cardInfo[properthName.liked.rawValue] as? [String]
            
            
            //Likeリストに追加
            if app.myInfoDelegate![recruiterPropety.liked.rawValue] != nil{
                
                let uid = cardInfo[properthName.uuid.rawValue] as! String
                var list:[String] = app.myInfoDelegate?[properthName.liked.rawValue] as! [String]
                list.append(uid)
                app.myInfoDelegate![recruiterPropety.liked.rawValue] = list
                
            }else{
                app.myInfoDelegate?[recruiterPropety.liked.rawValue] = cardInfo[properthName.uuid.rawValue]
            }
            
            
            if likedList != nil && likedList!.contains(myID){
                //マッチング
                //マッチングしたら、自分のmatchedのところに、マッチングした相手、ルームID、マッチング時刻の情報を格納する。
                
                var myMathingList:[[String]]? =  app.myInfoDelegate?[properthName.matched.rawValue] as? [[String]]
                let roomKey = NSUUID.init().uuidString
                let now = Date()
                
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                
                let dateString = formatter.string(from: now)
                
                let matchingUser:[String] = [cardInfo[properthName.uuid.rawValue] as! String,roomKey,dateString]

                if app.myInfoDelegate![recruiterPropety.matched.rawValue] != nil{
                    
//                    let uid = cardInfo[properthName.uuid.rawValue] as! String
                    var list:[[String]] = app.myInfoDelegate?[properthName.matched.rawValue] as! [[String]]
                    list.append(matchingUser)
                    app.myInfoDelegate![recruiterPropety.matched.rawValue] = list
                    
                }else{
                    app.myInfoDelegate?[recruiterPropety.matched.rawValue] = cardInfo[properthName.uuid.rawValue]
                }
                
//                myMathingList?.append(matchingUser)
                app.messageList?.insert(cardInfo, at: 0)
                
//                let vc = self.parent as! ContainerViewControllerTest
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                    
                    self.performSegue(withIdentifier: "matchingSegue", sender: nil)

                })
                
            }
        }
        
//        var encounterdList:[String]? = app.myInfoDelegate?[recruiterPropety2.encounterd.rawValue] as? [String]
//        encounterdList?.append(cardInfo[properthName.uuid.rawValue] as! String)
//        
//        if encounterdList == nil || encounterdList?.isEmpty == true{
//            app.myInfoDelegate?[recruiterPropety2.encounterd.rawValue] = cardInfo[properthName.uuid.rawValue]
//            encounterdList = [cardInfo[properthName.uuid.rawValue] as! String]
//        }
        
        if app.myInfoDelegate![recruiterPropety.encounterd.rawValue] != nil{
            
            let uid = cardInfo[properthName.uuid.rawValue] as! String
            var list:[String] = app.myInfoDelegate?[properthName.encounterd.rawValue] as! [String]
            list.append(uid)
            app.myInfoDelegate![recruiterPropety.encounterd.rawValue] = list
            
        }else{
            app.myInfoDelegate?[recruiterPropety.encounterd.rawValue] = cardInfo[properthName.uuid.rawValue]
        }
//
//        if encounterdList == nil || encounterdList?.isEmpty == true{
//           app.myInfoDelegate?[recruiterPropety2.encounterd.rawValue] = cardInfo[properthName.uuid.rawValue]
//           encounterdList = [cardInfo[properthName.uuid.rawValue] as! String]
//           
//        }else{
//            encounterdList?.append(cardInfo[properthName.uuid.rawValue] as! String)
//            app.myInfoDelegate?[recruiterPropety2.encounterd.rawValue] = encounterdList
//            
//        }
        
        
    }
    
    
    
    var currentPage:Int = 0
    //スワイプされたときのカードの入れ替え
    var currentCard:UserCard!
    
    func moveCard(swipedView:UserCard){
        
        currentPage += 1
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
        
        currentCard = toFrontView
        
        toBackView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        pushBehavior.removeItem(toBackView)
        pushBehavior = UIPushBehavior(items: [toFrontView], mode: UIPushBehaviorMode.continuous)
        let choicePanRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.choiceGesture(sender:)))
        toFrontView.isUserInteractionEnabled = true
        toBackView.isUserInteractionEnabled = false
        toFrontView.addGestureRecognizer(choicePanRecognizer)
        self.view.bringSubview(toFront: toFrontView)
        self.view.bringSubview(toFront: cancelButton)
        self.view.bringSubview(toFront: interestingButton)
        
        UIView.animate(withDuration: 1) {
            toFrontView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        
        toBackView.layer.position = userViewDefaultLocation
        updateDetailCardTag(targetView: toFrontView)
        updateCard(target: swipedView)
    }
    
    
    func updateCard(target:UserCard){
        
        
        //numberofpageがoutofrangeになったら、やめる
        if target.numberOfOage == cardList2.endIndex{
            
            target.isHidden = true
            return
        }
        
        if target.numberOfOage > cardList2.endIndex{
            performSegue(withIdentifier: "noUserSegue", sender: nil)
            return
        }
        
        
        guard let userInfo:[String:Any] = cardList2[target.numberOfOage] as? [String : Any] else { return }
        let list = cardList2[target.numberOfOage] as! [String:Any]
        
        let ogoriRect = CGRect(x: 0, y: 0, width: card1OgoriView.frame.height, height: card1OgoriView.frame.height)
        let ogoriPadding:CGFloat = 5
        
        switch target {
        case cardView01:
            card1UserNameLabel.text = userInfo[properthName.name.rawValue] as? String
            card1UserImageView.image = getImage(uuid: userInfo[properthName.uuid.rawValue] as! String)
            let birthDate = DateUtils.date(userInfo[properthName.birth.rawValue] as! String, format:"yyyy-MM-dd" )
            card1MessageLabel.text = userInfo[properthName.message.rawValue] as? String
            removeFromAllChildView(parentView: card1OgoriView)
            
            switch myStatus {
            case 1:
                card1LabelImageView.image = #imageLiteral(resourceName: "shinsotsu-label")
                card1CompanyLink.isHidden = true
                card1CompanyNameLabel.isHidden = true
                
                if let education:[Any] = userInfo[studentPropety.education.rawValue] as? [Any]{
                    if let schoolName = education[0] as? String{
                        card1UserJobLabel.text = schoolName + "\nあ\nあ"
                        if let faculty = education[1] as? String{
                            
                            card1UserJobLabel.text = schoolName + "\n" + faculty
                            
                            if let graduation = education[2] as? Int{
                                
                                card1UserJobLabel.text = schoolName + "\n" + faculty + "\n" + String(describing: graduation) + "年卒"
                                
                            }
                            
                        }
                    }
                    
                    
                }
                
                if let interesting = userInfo[studentPropety.interesting.rawValue]{
                pasteTag(forView: card1ExperienceTagView, forTagList: interesting as! [String], heightConstraint: card1experienceTagViewHeightConstraint)
                }
                
            case 2:
                let age = DateUtils.age(byBirthDate: birthDate)
                card1AgeLabel.text = "(" + String(age) + ")"
                switch age {
                case 0..<30:
                    card1LabelImageView.image = #imageLiteral(resourceName: "wakate-label")
                case 30..<45:
                    card1LabelImageView.image = #imageLiteral(resourceName: "middle-label")
                default:
                    card1LabelImageView.image = #imageLiteral(resourceName: "beteran-label")
                }
                card1CompanyNameLabel.text = userInfo[recruiterPropety.company_name.rawValue] as? String
                card1UserJobLabel.text = userInfo[recruiterPropety.position.rawValue] as? String
                card1CompanyLink.text = userInfo[recruiterPropety.company_link.rawValue] as? String
                
                pasteTag(forView: card1ExperienceTagView, forTagList: userInfo[recruiterPropety.skill.rawValue] as! [String], heightConstraint: card1experienceTagViewHeightConstraint)
                var count:CGFloat = 0
                
                if userInfo[recruiterPropety.ogori.rawValue] != nil{
                    for ogori in userInfo[recruiterPropety.ogori.rawValue] as! [Int]{
                        let ogoriImageView = UIImageView(frame: ogoriRect)
                        card1OgoriView.addSubview(ogoriImageView)
                        switch ogori {
                        case 0:
                            ogoriImageView.image = #imageLiteral(resourceName: "morning_char_icon")
                        case 1:
                            ogoriImageView.image = #imageLiteral(resourceName: "lunch_char_icon")
                        case 2:
                            ogoriImageView.image = #imageLiteral(resourceName: "dinner_char_icon")
                        case 3:
                            ogoriImageView.image = #imageLiteral(resourceName: "cafe_char_icon")
                        default:
                            break
                        }
                        
                        if count == 0{
                            ogoriImageView.layer.position.x = ogoriRect.height/2
                        }else{
                            ogoriImageView.layer.position.x = count*ogoriRect.height + ogoriRect.height/2 + ogoriPadding
                        }
                        
                        count += 1
                    }
                }
            default:
                break
            }
            
        case cardView02:
            card2UserNameLabel.text = userInfo[properthName.name.rawValue] as? String
            card2UserImageView.image = getImage(uuid: userInfo[properthName.uuid.rawValue] as! String)
            let birthDate = DateUtils.date(userInfo[properthName.birth.rawValue] as! String, format:"yyyy-MM-dd" )
            card2MessageLabel.text = userInfo[properthName.message.rawValue] as? String
            removeFromAllChildView(parentView: card2OgoriView)
            
            switch myStatus {
            case 1:
                card2LabelImageView.image = #imageLiteral(resourceName: "shinsotsu-label")
                card2CompanyLink.isHidden = true
                card2CompanyNameLabel.isHidden = true
                
                if let interesting = userInfo[studentPropety.interesting.rawValue]{
                    pasteTag(forView: card2ExperienceTagView, forTagList: interesting as! [String], heightConstraint: card2experienceTagViewHeightConstraint)
                }
                
            case 2:
                let age = DateUtils.age(byBirthDate: birthDate)
                card1AgeLabel.text = "(" + String(age) + ")"
                switch age {
                case 0..<30:
                    card1LabelImageView.image = #imageLiteral(resourceName: "wakate-label")
                case 30..<45:
                    card1LabelImageView.image = #imageLiteral(resourceName: "middle-label")
                default:
                    card1LabelImageView.image = #imageLiteral(resourceName: "beteran-label")
                }
                card2CompanyNameLabel.text = userInfo[recruiterPropety.company_name.rawValue] as? String
                card2UserJobLabel.text = userInfo[recruiterPropety.position.rawValue] as? String
                card2CompanyLink.text = userInfo[recruiterPropety.company_link.rawValue] as? String
                
                pasteTag(forView: card2ExperienceTagView, forTagList: userInfo[recruiterPropety.skill.rawValue] as! [String], heightConstraint: card2experienceTagViewHeightConstraint)
                var count:CGFloat = 0
                
                if userInfo[recruiterPropety.ogori.rawValue] != nil{
                    for ogori in userInfo[recruiterPropety.ogori.rawValue] as! [Int]{
                        let ogoriImageView = UIImageView(frame: ogoriRect)
                        card2OgoriView.addSubview(ogoriImageView)
                        switch ogori {
                        case 0:
                            ogoriImageView.image = #imageLiteral(resourceName: "morning_char_icon")
                        case 1:
                            ogoriImageView.image = #imageLiteral(resourceName: "lunch_char_icon")
                        case 2:
                            ogoriImageView.image = #imageLiteral(resourceName: "dinner_char_icon")
                        case 3:
                            ogoriImageView.image = #imageLiteral(resourceName: "cafe_char_icon")
                        default:
                            break
                        }
                        
                        if count == 0{
                            ogoriImageView.layer.position.x = ogoriRect.height/2
                        }else{
                            ogoriImageView.layer.position.x = count*ogoriRect.height + ogoriRect.height/2 + ogoriPadding
                        }
                        
                        count += 1
                    }
                }
            default:
                break
            }
        default:
            break
        }
    }
    
    func removeFromAllChildView(parentView:UIView){
        for subview in parentView.subviews{
            subview.removeFromSuperview()
        }
    }
    
    func updateDetailCardTag(targetView:UserCard){
        
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
    
    //uuidを指定して、画像を取得
    func getImage(uuid:String)->UIImage?{
        guard let imgFilePath = URL(string: "http://localhost:8888/test/img/\(uuid)/userimg.jpg") else { return nil}
        var img:UIImage?
        
        do{
            let data = try Data(contentsOf: imgFilePath)
            img = UIImage(data: data)
        }catch{
            print("error:\(error.localizedDescription)")
        }
        return img
    }
    
    @IBAction func cancelButtonTapped(_ sender: RectButton) {
        let velX = -300
        let velY = 0
        
        pushBehavior.pushDirection = CGVector(dx: velX, dy: velY)
        pushAnimator.addBehavior(pushBehavior)
        
        //左スワイプなら画面もどる
        //右スワイプなら、アプリをスタートする
        
        
        var swipeDirection:direction
        
        swipeDirection = .left
        print("left swipe")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8, execute: {
            //                    self.swipeHandler(swipedView: sender.view as! UserCard, direction: swipeDirection)
            self.swipedEvent(sender: self.currentCard, direction: .left)
            self.moveCard(swipedView: self.currentCard)
        })
    }
    
    @IBAction func interestingButtonTapped(_ sender: RectButton) {
        
        let velX = 300
        let velY = 0
        
        pushBehavior.pushDirection = CGVector(dx: velX, dy: velY)
        pushAnimator.addBehavior(pushBehavior)
        
        //左スワイプなら画面もどる
        //右スワイプなら、アプリをスタートする
        
        
        var swipeDirection:direction
        
        swipeDirection = .right
        print("right swipe")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8, execute: {
            //                    self.swipeHandler(swipedView: sender.view as! UserCard, direction: swipeDirection)
            self.swipedEvent(sender: self.currentCard, direction: .right)
            self.moveCard(swipedView: self.currentCard)
        
        })
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
