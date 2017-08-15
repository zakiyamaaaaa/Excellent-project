//
//  MessageViewControllerTest.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/06/26.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class MessageViewControllerTest: UIViewController,UITableViewDataSource,UITableViewDelegate,UIPopoverPresentationControllerDelegate{
    @IBOutlet weak var noMatchingUserImageView: UIImageView!

    let ud = UserDefaults.standard
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
        #imageLiteral(resourceName: "dinnerIconColored"),
        #imageLiteral(resourceName: "gsacademy"),
        "2017/7/8"]
    
    let tamura:[Any] = [
        "田村　悠里", //0
        31,//1
        #imageLiteral(resourceName: "middle-label"),//2
        "人事部",//3
        "中途７年目",//4
        ["ディレクター","人事","動画メディア"],//5
        "スモーアカデミー",//6
        "http://sumoacademy.com",//7
        #imageLiteral(resourceName: "tamura-2"),//8
        "アナログハリウッド",//9
        #imageLiteral(resourceName: "caffeIconColored"),//10
        #imageLiteral(resourceName: "sumoacademy-icon"),
        "2017/7/10"]//11
    
    var cardList:[[Any]] = []
    @IBOutlet weak var myTableView: UITableView!
    var strList:[String] = ["vsda","vasddasd","vfvsava","zfvdfvd"]
    var messageList:[Any] = []
    var selectedTag:Int = 0
    var cardList2:[Any]?
    let app:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var myMatchingList:[[String]]?
    let propetyName = recruiterPropety2.self
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cardList.append(tamura)
        cardList.append(kuri)
        
        myMatchingList = app.myInfoDelegate?["matched"] as? [[String]]
        
        
        // Do any additional setup after loading the view.
    }
    
    func hoge(){
        print("hoge")
    }

    override func viewWillAppear(_ animated: Bool) {
        print("message table appear")
        let app:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        cardList2 = app.messageList
        
        if cardList2 != nil{
            noMatchingUserImageView.isHidden = true
        }
        
        let parentVC = self.navigationController?.parent as! ContainerViewControllerTest
        parentVC.navigationView.isHidden = false
        self.navigationController?.navigationBar.isHidden = true
        myTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //tableviewメソッド
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! MessageTableViewCellDemo
//        let userInfo:[Any] = cardList[indexPath.row]
        
        
//        cell.userNameLabel.text = userInfo[0] as? String
//        cell.AgeLabel.text = "(" + String(describing: userInfo[1]) + ")"
//        cell.YeartoWorkLabel.text = userInfo[4] as? String
//        cell.companyNameLabel.text = userInfo[6] as? String
//        cell.labelImageView.image = userInfo[2] as? UIImage
//        cell.companyImageView.image = userInfo[11] as? UIImage
//        cell.userJobLabel.text = userInfo[3] as? String
        
        
        
        if let userInfo2:[String:Any] = cardList2?[indexPath.row] as? [String : Any] {
            
            cell.userNameLabel.text = userInfo2[propetyName.name.rawValue] as? String
            cell.userImageButton.setImage(getImage(uuid: userInfo2[propetyName.uuid.rawValue] as! String), for: .normal)
            cell.userImageButton.addTarget(self, action: #selector(self.goToDetailView(sender:)), for: .touchUpInside)
            cell.userImageButton.tag = indexPath.row
            cell.companyNameLabel.text = userInfo2[propetyName.company_name.rawValue] as? String
            cell.userJobLabel.text = userInfo2[propetyName.position.rawValue] as? String
            
            var count:CGFloat = 0
            let ogoriRect = CGRect(x: 0, y: 0, width: cell.ogoriView.frame.height, height: cell.ogoriView.frame.height)
            let ogoriPadding:CGFloat = 5
            if userInfo2["ogori"] != nil{
                for ogori in userInfo2["ogori"] as! [Int]{
                    let ogoriImageView = UIImageView(frame: ogoriRect)
                    cell.ogoriView.addSubview(ogoriImageView)
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
        }
        
        return cell
    }
    
    func goToDetailView(sender:UIButton){
        selectedTag = sender.tag
        performSegue(withIdentifier: "userDetailSegue", sender: nil)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if cardList2 == nil {
            return 0
        }
        
        return cardList2!.count
    }
    
    var selectedUserName:String = ""
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
        let parentVC = self.navigationController?.parent as! ContainerViewControllerTest
        parentVC.navigationView.isHidden = true
        selectedTag = indexPath.row
        performSegue(withIdentifier: "segueChat", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueChat"{
            let vc = segue.destination as! ChatViewController
            let user = cardList2![selectedTag] as! [String:Any]
            vc.navigationTitle = user[propetyName.name.rawValue] as! String
            vc.senderId = app.myInfoDelegate?[propetyName.uuid.rawValue] as! String
            vc.recieverId = user[propetyName.uuid.rawValue] as? String
            vc.senderDisplayName = user[propetyName.name.rawValue] as! String
            
            for matchingUser in myMatchingList!{
                if matchingUser[0].contains(user[propetyName.uuid.rawValue] as! String){
                    vc.roomKey = matchingUser[1]
                    print(matchingUser)
                }
            }
        }
        
        if segue.identifier == "userDetailSegue"{
            
            let vc = segue.destination as! MessageUserDetailViewController
            vc.userDic = cardList2![selectedTag] as! [String : Any]
        }
    }
    
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
        return img!
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
