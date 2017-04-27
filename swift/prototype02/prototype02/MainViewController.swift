//
//  MainViewController.swift
//  prototype02
//
//  Created by shoichiyamazaki on 2017/04/24.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var userData:[[String:Any]]?
    
    var user1:NearUserView!
    var user2:NearUserView!
    
    var screenWidth:CGFloat!
    var screenHeight:CGFloat!
    
    var navigationBar:UIView!
    
    var snapAnimator:UIDynamicAnimator!
    var pushAnimator:UIDynamicAnimator!
    var pushBehavior:UIPushBehavior!
    var snapBehavior:UISnapBehavior!
    
    var contentView:UIView!
    var mainView:UIView!
    var profileView:UIScrollView!
    var messageView:UIView!
    var profileView02:ProfileView!
    
    var userViewDefaultLocation:CGPoint!
    
    var locationBySnap:CGPoint!
    
    var numberOfOrder:Int = 0
    
    var userMessageUserItem:[[String:Any]] = []
    
    enum direction{
        case right
        case left
    }
    
    var currentPageNumber:Int = 1 //profile:0, main:1,message:2最初はmain
    
    
    //UserDefault関係
    var myUUID:String!
    var myname:String!
    var mySchool:String?
    var myFaculty:String?
    var mySchoolYear:String?
    var myFavariteFood:String?
    var myUnFavariteFood:String?
    
    
    
    var tabBarItemTransitionValue:CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(userData)
        
        let ud = UserDefaults.standard
        myUUID = ud.string(forKey: "uuid")
        myname = ud.string(forKey: "username")
        
        ud.register(defaults: ["school" : "school: default"])
        ud.register(defaults: ["faculty" : "faculty: default"])
        ud.register(defaults: ["schoolyear" : "school year: default"])
        ud.register(defaults: ["favaritefood" : "favarite food: default"])
        ud.register(defaults: ["unfavaritefood" : "unfavarite food: default"])
        
        mySchool = ud.string(forKey: "school")
        myFaculty = ud.string(forKey: "faculty")
        mySchoolYear = ud.string(forKey: "schoolyear")
        myFavariteFood = ud.string(forKey: "favaritefood")
        myUnFavariteFood = ud.string(forKey: "unfavaritefood")
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        screenWidth = self.view.frame.maxX
        screenHeight = self.view.frame.maxY
        
        let navigationBarHeight:CGFloat = 100 + statusBarHeight
        let navigationBarWidth:CGFloat = screenWidth*2
        
        navigationBar = UIView(frame: CGRect(x: -screenWidth/2, y: 0, width: navigationBarWidth, height: navigationBarHeight))
        navigationBar.backgroundColor = UIColor.cyan.withAlphaComponent(0.8)
        
        
        //UserView setting--------------------------------------------------------
        let contentViewHeight = screenHeight - navigationBarHeight
        
        contentView = UIView(frame: CGRect(x: -screenWidth, y: navigationBarHeight, width: screenWidth*3, height: contentViewHeight))
        mainView = UIView(frame: CGRect(x: screenWidth, y: 0, width: screenWidth, height: contentViewHeight))
        messageView = UIView(frame: CGRect(x: screenWidth*2, y: 0, width: screenWidth, height: contentViewHeight))
//        profileView = UIScrollView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: contentViewHeight))
//        profileView.contentSize = CGSize(width: screenWidth, height: screenHeight*2)
        profileView02 = ProfileView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: contentViewHeight))
        profileView02.mynameLabel.text = myname
        profileView02.schoolLabel.text = mySchool
        profileView02.schoolYearLabel.text = mySchoolYear
        profileView02.facultyLabel.text = myFaculty
        profileView02.favoriteFoodLabel.text = myFavariteFood
        profileView02.unFavoriteFoodLabel.text = myUnFavariteFood
        
        profileView02.profileEditButton?.addTarget(self, action: #selector(self.segueToEditProfileVC(sender:)), for: UIControlEvents.touchUpInside)
        
        
        
        print("myname:\(myname)")
        
        messageView.backgroundColor = UIColor.darkGray
//        profileView.backgroundColor = UIColor.green
        mainView.backgroundColor = UIColor.lightGray
        
        contentView.addSubview(mainView)
        contentView.addSubview(profileView02)
//        contentView.addSubview(profileView)
        contentView.addSubview(messageView)
        
        let userViewHeight = screenHeight/3*2
        let userViewWidth = screenWidth/6*5
        
        let userViewFrame = CGRect(x: (screenWidth-userViewWidth)/2, y: 10, width: userViewWidth, height: userViewHeight)
        user1 = NearUserView(frame: userViewFrame, page: 0)
        user2 = NearUserView(frame: userViewFrame, page: 1)
        user1.myView.tag = 1
        user2.myView.tag = 2
        
        if userData == nil{ return }
        
        user1.userInfoNameLabel.text = userData![0]["username"] as? String
        user2.userInfoNameLabel.text = userData![1]["username"] as? String
        
        let user1uuid:String = userData![0]["uuid"] as! String
        let user2uuid:String = userData![1]["uuid"] as! String
        
        setImage(uuid: user1uuid, flag: user1.myView.tag)
        setImage(uuid: user2uuid, flag: user2.myView.tag)
        
        mainView.addSubview(user2.myView)
        mainView.addSubview(user1.myView)
        
        
        
        //Button setting--------------------------------------------------------
        let iconLength = navigationBarHeight/4*3
        let messageButton = NavScrollButton(frame: CGRect(x: screenWidth*3/2-iconLength, y: (navigationBarHeight-iconLength)/2, width: iconLength, height: iconLength))
        let mainButton = NavScrollButton(frame: CGRect(x: (navigationBarWidth-iconLength)/2, y: (navigationBarHeight-iconLength)/2, width: iconLength, height: iconLength))
        let profileButton = NavScrollButton(frame: CGRect(x: screenWidth/2, y: (navigationBarHeight-iconLength)/2, width: iconLength, height: iconLength))
        messageButton.addTarget(self, action: #selector(self.scrollToMessage(sender:)), for: .touchUpInside)
        mainButton.addTarget(self, action: #selector(self.scrollToMain(sender:)), for: .touchUpInside)
        profileButton.addTarget(self, action: #selector(self.scrollToProfile(sender:)), for: .touchUpInside)
        
        
        
        //Snap Gesture--------------------------------------------------------
        userViewDefaultLocation = CGPoint(x: user1.myView.center.x, y: user1.myView.center.y)
        locationBySnap = CGPoint(x: user1.myView.center.x, y: user1.myView.center.y + navigationBarHeight)
        
        let choiceGestureRecogizer = UIPanGestureRecognizer(target: self, action: #selector(self.choiceGesture(sender:)))
        user1.myView.isUserInteractionEnabled = true
        user1.myView.addGestureRecognizer(choiceGestureRecogizer)
        snapAnimator = UIDynamicAnimator(referenceView: self.view)
        pushAnimator = UIDynamicAnimator(referenceView: self.view)
        pushBehavior = UIPushBehavior(items: [user1.myView], mode: UIPushBehaviorMode.continuous)
        
        self.view.sendSubview(toBack: user2.myView)
        UIView.animate(withDuration: 0) { 
            self.user2.myView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
        
        navigationBar.addSubview(messageButton)
        navigationBar.addSubview(mainButton)
        navigationBar.addSubview(profileButton)
        self.view.addSubview(contentView)
        self.view.addSubview(navigationBar)
//        self.view.addSubview(profileEditButton)
        
        
        tabBarItemTransitionValue = (screenWidth - iconLength)/2
        
        // Do any additional setup after loading the view.
    }
    
    func segueToEditProfileVC(sender:UIButton){
        performSegue(withIdentifier: "segueProfileEdit", sender: nil)
//        self.navigationController?.pushViewController(EditProfileViewController(), animated: true)
        
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditProfile")
//        self.navigationController?.pushViewController(vc!, animated: true)
        
//        let vc = EditProfileViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Scroll Button Transition
    //page = 0
    
    func scrollToMessage(sender:UIButton){
        if currentPageNumber != 0{
            UIView.animate(withDuration: 0.5, animations: { 
                self.navigationBar.transform = CGAffineTransform.init(translationX: -self.tabBarItemTransitionValue, y: 0)
                self.contentView.transform = CGAffineTransform.init(translationX: -self.screenWidth, y: 0)
                self.currentPageNumber = 0
            })
        }
    }
    //page = 1
    func scrollToMain(sender:UIButton){
        if currentPageNumber != 1{
            UIView.animate(withDuration: 0.5, animations: {
                self.navigationBar.transform = CGAffineTransform.init(translationX: 0, y: 0)
                self.contentView.transform = CGAffineTransform.init(translationX: 0, y: 0)
                self.currentPageNumber = 1
            })
        }
    }
    //page = 2
    func scrollToProfile(sender:UIButton){
        if currentPageNumber != 2{
            UIView.animate(withDuration: 0.5, animations: {
                self.navigationBar.transform = CGAffineTransform.init(translationX: self.tabBarItemTransitionValue, y: 0)
                self.contentView.transform = CGAffineTransform.init(translationX: self.screenWidth, y: 0)
                self.currentPageNumber = 2
            })
        }
    }
    

    override func viewWillAppear(_ animated: Bool) {
        
        if let controller = self.presentedViewController{
            if controller.isKind(of: EditProfileViewController.self){
                print("sucess")
                let ud = UserDefaults.standard
                ud.synchronize()
                
                mySchool = ud.string(forKey: "school")
                myFaculty = ud.string(forKey: "faculty")
                mySchoolYear = ud.string(forKey: "schoolyear")
                myFavariteFood = ud.string(forKey: "favaritefood")
                myUnFavariteFood = ud.string(forKey: "unfavaritefood")
                
                
                
                profileView02.schoolLabel.text = "school: \(mySchool!)"
                profileView02.schoolYearLabel.text = "school year: \(mySchoolYear!)"
                profileView02.facultyLabel.text = "faculty: \(myFaculty!)"
                profileView02.favoriteFoodLabel.text = "favarite food: \(myFavariteFood!)"
                profileView02.unFavoriteFoodLabel.text = "unfavarite food: \(myUnFavariteFood!)"
                
            }
        }
    }
    
    func getNumOfPage(swipedViewTag:Int)->Int{
        var returnNum:Int = 0
        switch swipedViewTag {
        case 1:
            returnNum = user1.numberOfPage
        case 2:
            returnNum = user2.numberOfPage
        default:
            print("default")
        }
        return returnNum
    }
    
    func setImage(uuid:String, flag:Int){
        var target:NearUserView!
        switch flag {
        case 1:
            target = user1
        case 2:
            target = user2
        default:
            print("error")
        }
        
        guard let imgFilePath = URL(string: "http://localhost:8888/test/img/\(uuid)/userimg.jpg") else { return }
        do{
            let data = try Data(contentsOf: imgFilePath)
            target.myImageView.image = UIImage(data: data)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func getImage(numberOfpage:Int)->UIImage{
        let uuid = userData?[numberOfpage]["uuid"] as! String
        var returnImage:UIImage = UIImage()
        
        let imgFilePath = URL(string: "http://localhost:8888/test/img/\(uuid)/userimg.jpg")
        do{
            let data = try Data(contentsOf: imgFilePath!)
            returnImage = UIImage(data: data)!
        }catch{
            print(error.localizedDescription)
        }
        
        return returnImage
    }
    
    func getImage(uuid:String)->UIImage{
        
        var returnImage:UIImage = UIImage()
        
        let imgFilePath = URL(string: "http://localhost:8888/test/img/\(uuid)/userimg.jpg")
        do{
            let data = try Data(contentsOf: imgFilePath!)
            returnImage = UIImage(data: data)!
        }catch{
            print(error.localizedDescription)
        }
        
        return returnImage
    }
    
    func choiceGesture(sender:UIPanGestureRecognizer){
        switch sender.state {
        case .began:
            print("began")
        case .changed:
            print("change")
            
            let moveValue:CGPoint = sender.translation(in: view)
            sender.view!.center.x += moveValue.x
            sender.view!.center.y += moveValue.y
            sender.setTranslation(CGPoint.zero, in: view)
            
        case .cancelled:
            print("canceled")
        case .ended:
            print("end")
            
            if fabs(sender.velocity(in: view).x) > 500{
                let velX = sender.velocity(in: view).x
                let velY = sender.velocity(in: view).y
                
                pushBehavior.pushDirection = CGVector(dx: velX, dy: velY)
                pushAnimator.addBehavior(pushBehavior)
                
                let swipeDirection:direction
                if sender.velocity(in: view).x > 0{
                    swipeDirection = direction.right
                }else{
                    swipeDirection = direction.left
                }
                
                sender.setTranslation(CGPoint.zero, in: view)
                guard let tag = sender.view?.tag else { return }
                let num = getNumOfPage(swipedViewTag: tag)
                swipeDirectionHandler(numberOfPage: num, swipeDirection: swipeDirection)
                swipeHandler(swipedViewTag: tag, swipeFlag: swipeDirection)
                return
            }else{
            
            snapAnimator.removeAllBehaviors()
            snapBehavior = UISnapBehavior(item: sender.view!, snapTo: locationBySnap!)
            snapAnimator.addBehavior(snapBehavior!)
            }
        default:
            print("default")
        }
    }
    
    func swipeHandler(swipedViewTag:Int,swipeFlag:direction){
        numberOfOrder += 1
        switch swipedViewTag {
        case 1:
            self.switchViewTransition(ViewFront: user2, ViewtoBack: user1)
        case 2:
            self.switchViewTransition(ViewFront: user1, ViewtoBack: user2)
        default:
            print("default")
        }
    }
    
    func switchViewTransition(ViewFront:NearUserView,ViewtoBack:NearUserView){
        let toFrontView = ViewFront.myView
        let toBackView = ViewtoBack.myView
        
        UIView.animate(withDuration: 0) { 
            toBackView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
        
        pushBehavior.removeItem(toBackView)
        pushBehavior = UIPushBehavior(items: [toFrontView], mode: UIPushBehaviorMode.continuous)
        let choicePanRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.choiceGesture(sender:)))
        toFrontView.isUserInteractionEnabled = true
        toBackView.isUserInteractionEnabled = false
        toFrontView.addGestureRecognizer(choicePanRecognizer)
        mainView.bringSubview(toFront: toFrontView)
        UIView.animate(withDuration: 1.0) { 
            toFrontView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
        toBackView.layer.position = userViewDefaultLocation!
        updateUser(userView: ViewtoBack)
    }
    
    func updateUser(userView:NearUserView){
        userView.numberOfPage += 2
        //データを表示仕切ったあとの処理がまだ書かれていない。
        let uuid = userData![userView.numberOfPage]["uuid"] as! String
        setImage(uuid: uuid, flag: userView.myView.tag)
        userView.userInfoNameLabel.text = userData![userView.numberOfPage]["username"] as? String
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "matchSegue"{
            let vc = segue.destination as! MatchViewController
            vc.matchedUUID = userData![numberOfOrder]["uuid"] as! String
        }
        
        if segue.identifier == "segueProfileEdit"{
//            let vc = segue.destination as! EditProfileViewController
//            let vc01 = segue.destination
//            vc01.navigationController?.pushViewController(EditProfileViewController(), animated: true)
//            print("vc(\(vc))")
//            print("vc01\(vc01)")
//            vc.mynameLabel.text = "aaaa"
            //最初は値を引き継ごうとしたが、うまくできなかったので、当面userDefaultで読み書きすることに。
        }
        

    }
    
    func swipeDirectionHandler(numberOfPage:Int,swipeDirection:direction){
        let swipedData = userData![numberOfPage]
        let swipedDataLiked:[String] = swipedData["liked"] as? [String] ?? [""]
        
        switch swipeDirection {
        case .right:
            if swipedDataLiked.contains(myUUID){
                let str = userData![numberOfOrder]["uuid"] as! String
                userMessageUserItem.append(["uuid" : str])
                performSegue(withIdentifier: "matchSegue", sender: nil)
            }
        case .left:
            print("left")
        default:
            print("default")
        }
        //相手と自分のdataをpostして更新
        //uuid,encounterd,liked,matched
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
