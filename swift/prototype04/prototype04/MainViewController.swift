//
//  MainViewController.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/05/09.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet weak var messageTableView: UITableView!
    @IBOutlet weak var blurVIew: UIView!
    @IBOutlet weak var cardView01: UserCard!
    @IBOutlet weak var cardView02: UserCard!
    @IBOutlet weak var card01NameLabel: UILabel!
    @IBOutlet weak var card02NameLabel: UILabel!
    @IBOutlet weak var card01ImageView: UIImageView!
    @IBOutlet weak var card02ImageView: UIImageView!
    @IBOutlet weak var matchingView: UIView!
    @IBOutlet weak var footerNav: UIView!
    @IBOutlet weak var profileItem: UIButton!
    @IBOutlet weak var mainItem: UIButton!
    @IBOutlet weak var mailItem: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var treatView01: UIView!
    @IBOutlet weak var card02JobTagView: UIView!
    @IBOutlet weak var cardFrontView: UIView!
    @IBOutlet weak var profileCircleBackImageView: UIView!
    @IBOutlet weak var profileContentView: UIView!
    
    @IBOutlet weak var card01TreatView: UIView!
    @IBOutlet weak var card02TreatView: UIView!
    @IBOutlet weak var card02CompanyNameLabel: UILabel!
    @IBOutlet weak var card01CompanyNameLabel: UILabel!
    
    @IBOutlet weak var card01JobTagView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var myNameLabel: UILabel!
    @IBOutlet weak var profileTableView: UITableView!
    
    @IBOutlet weak var matchingUserImageView: UIImageView!
    @IBOutlet weak var matchingMyImageView: UIImageView!
    
    
//    var sectionList = ["Job","Food","Background"]
    var sectionList02 = ["Job","Background"]
    var jobItems = ["気になる職種","気になる業界"]
//    var foodItems = ["好きな食べ物","嫌いな食べ物"]
    var backgroundItems = ["学校","資格"]
    var messageableUserList:[[String:Any]] = [[String:Any]]()
    let jobCategoryList:[String] = jobTagTitleList.init().industry
    let jobTypeList:[String] = jobTagTitleList.init().occupation
    var jobCellHeight:[jobTagType:CGFloat] = [:]
    var snapAnimator:UIDynamicAnimator!
    var pushAnimator:UIDynamicAnimator!
    var pushBehavior:UIPushBehavior!
    var snapBehavior:UISnapBehavior!
    
    var locationBySnap:CGPoint!
    var userViewDefaultLocation:CGPoint!
    
    var footerNavOriginY:CGFloat!
    var UDSetting:UserDefaultSetting = UserDefaultSetting()
    
    var userSettingList:[String:Any]?
    let selectedItemTintColor = UIColor.white
    
    //user data field
    // username,uuid,encounterd,likeflag,matchflag(prototype02)
    // + companyname,job,url,suggestion,intro
    
    var cardList:[[String:Any]] = []
    var cardList02:[Any] = []
    var myInfo:[String:Any] = [:]
    
    
    
    var selectedCardGesture:UITapGestureRecognizer = UITapGestureRecognizer()
    var flipedCardGesture:UITapGestureRecognizer = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        cardFrontView.alpha = 0
        
        profileCircleBackImageView.layer.borderWidth = 2
        profileCircleBackImageView.layer.masksToBounds = true
        profileCircleBackImageView.layer.cornerRadius = profileCircleBackImageView.frame.width/2
        
        
        editButton.backgroundColor = UIColor.white
        editButton.layer.masksToBounds = true
        editButton.layer.cornerRadius = 20
        editButton.layer.borderWidth = 2
        editButton.setTitle("EDIT", for: UIControlState.normal)
        editButton.titleLabel?.font = UIFont(name: "Georgia-Bold", size: 14)
        editButton.setTitleColor(UIColor.black, for: .normal)
        
        matchingUserImageView.layer.masksToBounds = true
        matchingUserImageView.layer.cornerRadius = matchingUserImageView.frame.width/2
        matchingMyImageView.layer.masksToBounds = true
        matchingMyImageView.layer.cornerRadius = matchingMyImageView.frame.width/2
        
        
        // ブラーエフェクトからエフェクトビューを生成
        let blurEffect = UIBlurEffect(style: .dark)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        let visualEffectView02 = UIVisualEffectView(effect: blurEffect)
        visualEffectView.alpha = 1
        
        // エフェクトビューのサイズを指定（オリジナル画像と同じサイズにする）
        visualEffectView.frame = matchingView.bounds
        visualEffectView02.frame = profileContentView.bounds
        profileContentView.insertSubview(visualEffectView02, at: 0)
        
        blurVIew.addSubview(visualEffectView)
        matchingView.alpha = 0
        self.view.sendSubview(toBack: matchingView)
        
        
        let app:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let myUUID = "hoge"//Dummy
        let sc:ServerConnection = ServerConnection()
        myInfo = sc.getMyData(uuid: myUUID)
        cardList02 = app.cardListDelegate!
        
        messageTableView.delegate = self
        messageTableView.dataSource = self
        
        
        card01JobTagView.layer.masksToBounds = true
        card01JobTagView.layer.cornerRadius = 10
        
        card02JobTagView.layer.masksToBounds = true
        card02JobTagView.layer.cornerRadius = 10
        
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.frame.width/2
        
        myNameLabel.text = userSettingList?[userDefautlsKeyList.username.rawValue] as? String

        editButton.layer.masksToBounds = true
        editButton.layer.cornerRadius = 5
        
        footerNavOriginY = footerNav.bounds.origin.y
        
        selectedCardGesture = UITapGestureRecognizer(target: self, action: #selector(self.selectCard(sender:)))
        flipedCardGesture = UITapGestureRecognizer(target: self, action: #selector(self.selectCard(sender:)))
        
        
        cardView01.addGestureRecognizer(selectedCardGesture)
        
        
        cardFrontView.addGestureRecognizer(flipedCardGesture)
        cardFrontView.layer.borderWidth = 2
        
        
        
        //Header関係--------------------------------------------------------------------------
        let navHeaderImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))

        navHeaderImageView.image = UIImage(named: "sketch-symbol-transparent")
        self.navigationItem.titleView = navHeaderImageView
        self.navigationItem.titleView?.contentMode = .scaleAspectFit
        
        let navigationGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.touchedCenterNavigationItem(sender:)))
        navHeaderImageView.addGestureRecognizer(navigationGestureRecognizer)
        navHeaderImageView.isUserInteractionEnabled = true
        
        //ViewのSnap動き関係-------------------------------------------------------------------
        userViewDefaultLocation = CGPoint(x: cardView01.center.x, y: cardView01.center.y)
        locationBySnap = CGPoint(x: self.view.center.x, y: self.view.center.y)

        let choiceGestureRecogizer = UIPanGestureRecognizer(target: self, action: #selector(self.choiceGesture(sender:)))
        cardView01.isUserInteractionEnabled = true
        cardView01.addGestureRecognizer(choiceGestureRecogizer)
        snapAnimator = UIDynamicAnimator(referenceView: self.view)
        pushAnimator = UIDynamicAnimator(referenceView: self.view)
        pushBehavior = UIPushBehavior(items: [cardView01], mode: UIPushBehaviorMode.continuous)
        
        
        cardView01.numberOfOage = 0
        cardView02.numberOfOage = 1
        
        updateCard(targetCard: cardView01)
        updateCard(targetCard: cardView02)
        
        
        
        
        //Footer関係----------------------------------------------------------
        let profileItemImage = UIImage(named: "footer_user_icon")
        profileItem.setImage(profileItemImage, for: UIControlState.normal)
        
        let mainItemImage = UIImage(named: "footer_main_icon")
        mainItem.setImage(mainItemImage, for: UIControlState.normal)
        mainItem.tintColor = selectedItemTintColor
        
        let mailItemImage = UIImage(named: "footer_message_icon")
        mailItem.setImage(mailItemImage, for: UIControlState.normal)
        
        UIView.animate(withDuration: 0) { 
            self.cardView02.transform = CGAffineTransform.init(scaleX: 0.8, y: 0.8)
        }
        
        
        //ProfileTableViewの情報---------------------------------------------------------------------
        profileTableView.dataSource = self
        profileTableView.delegate = self
        profileTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "myCell")
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    var touchFlag:Bool = false
    func selectCard(sender:UITapGestureRecognizer){
        
        var transitionCard = UIView()
        var transitionedCard = UIView()
        
        switch touchFlag {
        case true:
            transitionCard = cardView01
            transitionedCard = cardFrontView
        case false:
            transitionCard = cardFrontView
            transitionedCard = cardView01
        }
        
//        UIView.transition(with: cardView01, duration: 1, options: [.transitionFlipFromLeft], animations: nil, completion: nil)
        UIView.transition(with: transitionedCard, duration: 1, options: [.transitionFlipFromLeft], animations: {
//            self.cardFrontView.alpha = 1
            transitionedCard.alpha = 0
            transitionCard.alpha = 1
        }, completion: nil)
        
        touchFlag = !touchFlag
        
//        var fromView:UIView = UIView()
//        var toView:UIView = UIView()
//        flipedCard.isHidden = false
//        switch sender {
//        case selectedCardGesture:
//            fromView = cardView01
//            toView = flipedCard
//            
//        case flipedCardGesture:
//            fromView = flipedCard
//            toView = cardView01
//            
////            flipedCard.removeFromSuperview()
//        default:
//            break
//        }
//        
//        
//        UIView.transition(from: fromView, to: toView, duration: 1, options: [.transitionFlipFromLeft]) { (Bool) in
//            print("lll")
//        }
    }
    
    //navigationBarのセンターをタッチしたときの挙動
    func touchedCenterNavigationItem(sender:Any){
        print("touched")
    }
    
    //★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
    //view--------------------------------------------------------------
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        userSettingList = UDSetting.returnSetValue()
        profileTableView.reloadData()
        
        
        let documentDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let imgFileName = "sample.png"
        let tmp = UIImage(contentsOfFile: "\(documentDir)/\(imgFileName)")
        profileImageView.image = tmp
        matchingMyImageView.image = tmp
    }
    
    //メッセージテーブルにタッチして、チャット画面に遷移するときのイベント
    //遷移先へユーザー情報を渡している。
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueMessage"{
            let vc = segue.destination as! MessageViewController
            vc.userInfo = selectedUser
        }
        
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
            
            UIView.animate(withDuration: 1, animations: {
                self.footerNav.transform = CGAffineTransform.init(translationX: 0, y: 100)
            })
            
            
        case .ended:
            print("ended")
            
            UIView.animate(withDuration: 1, animations: {
                self.footerNav.transform = CGAffineTransform.init(translationX: 0, y: 0)
            })
            
            
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
                    self.swipeHandler(swipedView: sender.view as! UserCard, direction: swipeDirection)
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

    
    func swipeHandler(swipedView:UserCard,direction:direction){
        let userInfo = cardList02[swipedView.numberOfOage] as? [String:Any]
        
        var encounterList:[String] = myInfo["encounterd"] as! [String]
        
        let myUUID = UDSetting.read(key: .uuid) as String
        let uuid = userInfo?["uuid"] as? String
        
        var matchList = myInfo["matched"] as? [String]
        
        encounterList.append(uuid!)
        myInfo["encounterd"] = encounterList
        
        switch direction {
        case .right:
            print("right")
            //自分の情報の like list に追加
            var likeList:[String]? = myInfo["liked"] as? [String]
            likeList?.append(uuid!)
            myInfo["liked"] = likeList
            print("305:\(myInfo["liked"])")
            //向こうもLikeなら、マッチイベントの発生
            if let a:[String] = userInfo?["liked"] as? [String]{
                if a.contains(myUUID){
                    print("309:matched!!")
                    messageableUserList.append(userInfo!)
                    messageTableView.reloadData()
                    self.view.bringSubview(toFront: self.matchingView)
                    UIView.animate(withDuration: 2, animations: { 
                        self.matchingView.alpha = 1
                    })
//                    matchList.append(uuid!)
                    //向こうのdataも更新してPOST?
                    
                }
            }
            
            
        case .left:
            print("left")
        }
        
        //スワイプの結果をサーバーに送って、DBの更新
//        let sc = ServerConnection()
//        sc.updateMyData(mydata: myInfo)
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
        
        UIView.animate(withDuration: 0) { 
            toBackView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
        
        pushBehavior.removeItem(toBackView)
        pushBehavior = UIPushBehavior(items: [toFrontView], mode: UIPushBehaviorMode.continuous)
        let choicePanRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.choiceGesture(sender:)))
        toFrontView.isUserInteractionEnabled = true
        toBackView.isUserInteractionEnabled = false
        toFrontView.addGestureRecognizer(choicePanRecognizer)
        mainView.bringSubview(toFront: toFrontView)
        UIView.animate(withDuration: 1) { 
            toFrontView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        toBackView.layer.position = userViewDefaultLocation
        updateCard(targetCard: swipedView)
    }
    
    //カード情報の更新※スワイプされときに実行
    func updateCard(targetCard:UserCard){
        var nameLabel:UILabel = UILabel()
        
        switch targetCard {
        case cardView01:
            nameLabel = card01NameLabel
        case cardView02:
            nameLabel = card02NameLabel
        default:
            print("default")
        }
        addTag(user: cardList02[targetCard.numberOfOage] as! [String:Any],card: targetCard)
        addTreat(user: cardList02[targetCard.numberOfOage] as! [String:Any] , cardView: targetCard)
        let list = cardList02[targetCard.numberOfOage] as! [String:Any]
        nameLabel.text = list["username"] as? String
        self.setImage(targetCard: targetCard)
    }
    
    func setImage(targetCard:UserCard){
        let list = cardList02[targetCard.numberOfOage] as! [String:Any]
        
        
        // as? にすると、Optional()がつくので、urlがきちんととれない
        let uuid = list["uuid"] as! String
        guard let imgFilePath = URL(string: "http://52.163.126.71/test/img/\(uuid)/userimg.jpg") else { return }
        
        
        do{
            let data = try Data(contentsOf: imgFilePath)
            
            switch targetCard {
            case cardView01:
                matchingUserImageView.image = card01ImageView.image
                card01ImageView.image = UIImage(data: data)
            case cardView02:
                matchingUserImageView.image = card02ImageView.image
                card02ImageView.image = UIImage(data: data)
            default:
                print("hoge")
            }
        }catch{
            print("error:\(error.localizedDescription)")
        }
    }
    
    //uuidもらって画像を返す
    func getImage(uuid:String)->UIImage?{
        guard let imgFilePath = URL(string: "http://52.163.126.71/test/img/\(uuid)/userimg.jpg") else { return nil}
        var img:UIImage?
        
        do{
            let data = try Data(contentsOf: imgFilePath)
            img = UIImage(data: data)
        }catch{
            print("error:\(error.localizedDescription)")
        }
        return img
    }
    
    
    
    //★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
    //tableViewの関数--------------------------------------------------------------
    
    //sectionの数
    func numberOfSections(in tableView: UITableView) -> Int {
        
        switch tableView {
        case profileTableView:
            return sectionList02.count
        case messageTableView:
            
            return 1
        default:
            return 0
        }
        
    }
    
    //Sectionのリストを設定
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch tableView {
        case profileTableView:
            return sectionList02[section]
        case messageTableView:
            return nil
        default:
            return nil
        }
        
    }
    
    //Sectionごとのセルの数を設定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch tableView {
        case profileTableView:
            switch section {
            case 0:
                return jobItems.count
            case 1:
                return backgroundItems.count
            default:
                return 0
            }
        case messageTableView:
            return messageableUserList.count
        default:
            return 0
        }
        
        
    }
    
    //テーブルのセルがタッチしたユーザーを格納する変数
    var selectedUser:[String:Any]!
    
    //テーブルがタッチされたときの挙動
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case profileTableView:
            print("profile view touched")
        case messageTableView:
            print("message view touched")
            
            //チャット画面へ移動
            selectedUser = messageableUserList[indexPath.row]
            performSegue(withIdentifier: "segueMessage", sender: nil)
        default:
            print("default")
        }
    }
    
    
    
    //セルに表示する中身
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tableView {
        case profileTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! CustomTableViewCell
            let titleLabelEdge = cell.titleLabel.frame.width + cell.titleLabel.frame.origin.x
            switch indexPath.section {
            case 0:
                cell.titleLabel.text = jobItems[indexPath.row]
                cell.titleLabel.font = UIFont.init(name: "BodoniSvtyTwoITCTT-Book", size: 15)
                
                for view in cell.subviews{
                    view.removeFromSuperview()
                }
                
                var type:jobTagType
                switch indexPath.row {
                case 0://業界
                    type = .industry
                default://職種
                    type = .occupation
                }
                addTag(targetCell: cell, originX: titleLabelEdge, type: type)
                cell.addSubview(cell.titleLabel)
                
            case 1:
                cell.titleLabel.text = backgroundItems[indexPath.row]
                switch backgroundItems[indexPath.row] {
                case "学校":
                    cell.myLabel.text = userSettingList?[userDefautlsKeyList.background.rawValue] as? String
                    cell.myLabel.frame.origin.x = titleLabelEdge + 10
                case "資格":
                    cell.myLabel.text = userSettingList?[userDefautlsKeyList.qualification.rawValue] as? String
                    cell.myLabel.frame.origin.x = titleLabelEdge + 10
                default:
                    print("hoge")
                }
            default:
                print("default selected")
            }
            cell.myLabel.sizeToFit()
            cell.myLabel.frame.size = CGSize(width: cell.myLabel.frame.width + 20, height: cell.myLabel.frame.height)
            return cell
        case messageTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! messageTableViewCell
            let user = messageableUserList[indexPath.row] as [String:Any]
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            cell.userNameLabel.text = user["username"] as? String

            cell.userCompayLabel.text = "hoge\(indexPath.row)"
            let userImg = getImage(uuid: user["uuid"] as! String)
            cell.messageUserImageView.image = userImg
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    //セルごとの高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = tableView.rowHeight
        
        switch tableView {
        case profileTableView:
            if indexPath.section == 0{
                switch indexPath.row {
                case 0:
                    if jobCellHeight[.industry] != nil{
                        height = jobCellHeight[jobTagType.industry]!
                    }
                    return height + 10
                case 1:
                    if jobCellHeight[.occupation] != nil{
                        height = jobCellHeight[jobTagType.occupation]!
                    }
                    return height + 10
                default:
                    return height + 10
                }
            }
            
            return tableView.rowHeight
        case messageTableView:
            return 90
        default:
            return 30
        }
        
        
    }
    
    //★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
    //タグの追加
    
    //プロフィールのタグ付け
    func addTag(targetCell:CustomTableViewCell,originX:CGFloat,type:jobTagType){
        let dummyJobData = UDSetting.read(key: .job) as [String]
        var pointX:CGFloat = originX + 10
        var pointY:CGFloat =  10
        var lastHeight:CGFloat = 0
        let width = targetCell.frame.width
        
        
        for data in dummyJobData{
            var tag:jobTagType
            if jobCategoryList.contains(data){
                tag = jobTagType.industry
            }else{
                tag = jobTagType.occupation
            }
            
            if type != tag {
                continue
            }
            
            
            let button = flagButton(frame: CGRect.zero,title: data,Tagtype:tag)
            button.sizeToFit()
            
            button.frame.size = CGSize(width: button.frame.width + 20, height: button.frame.height)
            targetCell.addSubview(button)
            
            button.frame.origin = CGPoint(x: pointX, y: pointY)
            pointY = button.frame.origin.y
            pointX = button.frame.origin.x + button.frame.width
            
            
            if pointX > width{
                button.frame.origin.x = originX + 10
                button.frame.origin.y = pointY + button.frame.height + 6
                
            }
            
            
            pointX = button.frame.origin.x + button.frame.width + 10
            pointY = button.frame.origin.y
            
            if lastHeight < pointY + button.frame.height{
                lastHeight = pointY + button.frame.height
            }
        }
        guard let lastbutton = targetCell.subviews.last else { return }
        jobCellHeight[type] = lastbutton.frame.height + lastbutton.frame.origin.y
    }
    
    //カードのタグ付け
    func addTag(user:[String:Any],card:UserCard){
        var jobTagView = UIView()
        switch card {
        case cardView01:
            jobTagView = card01JobTagView
        case cardView02:
            jobTagView = card02JobTagView
        default:
            break
        }
        
        let userIndustry = user["industry"] as? [String]
        let userOccupation = user["occupation"] as? [String]
        let width = jobTagView.frame.width
        var pointX:CGFloat = 10
        var pointY:CGFloat = 10
        
        for view in jobTagView.subviews{
            view.removeFromSuperview()
        }
        
        
        var tagList:[String] = [String]()
        
        if let tag = userIndustry{
            
            tagList += tag
        }
        
        if let tag = userOccupation{
            tagList += tag
        }
        
        
        for tag in tagList{
            var tagType:jobTagType = .industry
            if jobTagTitleList.init().industry.contains(tag){
                tagType = .industry
            }
            if jobTagTitleList.init().occupation.contains(tag){
                tagType = .occupation
            }

            let label = flagButton(frame: CGRect.zero, title: tag, Tagtype: tagType)

            label.sizeToFit()
            label.frame.size = CGSize(width: label.frame.width + 14, height: label.frame.height)


            
            label.frame.origin = CGPoint(x: pointX, y: pointY)
            pointY = label.frame.origin.y
            pointX = label.frame.origin.x + label.frame.width
            
            
            if pointX > width{
                label.frame.origin.x = 10
                label.frame.origin.y = pointY + label.frame.height + 6
            }
            
            
            pointX = label.frame.origin.x + label.frame.width + 10
            pointY = label.frame.origin.y
            
            jobTagView.addSubview(label)
        }
        
    }
    
    //Treat
    func addTreat(user:[String:Any],cardView:UserCard){
        var treatView = UIView()
        
        switch cardView {
        case cardView01:
            treatView = card01TreatView
        case cardView02:
            treatView = card02TreatView
        default:
            break
        }
        
        
        guard let treatList = user["treat"] as? [String] else {
            for view in treatView.subviews{
                view.removeFromSuperview()
            }
            return}

        
        let width = treatView.frame.width
        var pointX:CGFloat = width
        
        for item in treatList{
            let itemImgView = UIImageView(frame: CGRect.zero)
            itemImgView.frame.size = CGSize(width: 40, height: 40)
            itemImgView.layer.borderWidth = 1
            itemImgView.layer.masksToBounds = true
            itemImgView.layer.cornerRadius = 20
            var itemImgstr:String = ""
            switch item {
            case "cafe":
                itemImgstr = "cafe_icon"
            case "morning":
                itemImgstr = "morning_icon"
            case "lunch":
                itemImgstr = "lunch_icon"
            case "dinner":
                itemImgstr = "dinner_icon"
            default:
                break
            }
            itemImgView.image = UIImage(named: itemImgstr)
            
            itemImgView.frame.origin = CGPoint(x: pointX - itemImgView.frame.width, y: 0)
            treatView.addSubview(itemImgView)
            
            pointX -= 50
            
        }
    }
    
    //★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
    //FooterNavigation の関数--------------------------------------------------------------
    @IBAction func scrollToProfile(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) { 
            self.contentView.transform = CGAffineTransform.init(translationX: self.view.frame.width, y: 0)
            self.profileItem.tintColor = self.selectedItemTintColor
            self.mainItem.tintColor = UIColor.gray
            self.mailItem.tintColor = UIColor.gray
            
        }
    }
    @IBAction func scrollToMain(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) {
            self.contentView.transform = CGAffineTransform.init(translationX: 0, y: 0)
            self.profileItem.tintColor = UIColor.gray
            self.mainItem.tintColor = self.selectedItemTintColor
            self.mailItem.tintColor = UIColor.gray
        }
    }

    @IBAction func scrollToMail(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) {
            self.contentView.transform = CGAffineTransform.init(translationX: -self.view.frame.width, y: 0)
            self.profileItem.tintColor = UIColor.gray
            self.mainItem.tintColor = UIColor.gray
            self.mailItem.tintColor = self.selectedItemTintColor
        }
    }

    //マッチングしたときのビューが表示されて、そこにある「前の画面へ戻る」ボタンを押すと発動
    @IBAction func backToMainView(_ sender: Any) {
        
        UIView.animate(withDuration: 3) { 
            self.matchingView.alpha = 0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.view.sendSubview(toBack: self.matchingView)
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
