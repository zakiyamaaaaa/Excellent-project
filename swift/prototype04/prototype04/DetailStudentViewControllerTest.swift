//
//  DetailStudentViewControllerTest.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/08/17.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class DetailStudentViewControllerTest: UIViewController,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var myTableView: UITableView!
    
    let sectionTitle = ["","自己紹介","所属団体・サークル"]
    let titleOfSection1 = ["自分について","長所","短所","資格・スキル"]
    let imageOfSection1 = [#imageLiteral(resourceName: "cafe_mono"),#imageLiteral(resourceName: "morning_mono"),#imageLiteral(resourceName: "lunchIconColored"),#imageLiteral(resourceName: "dinnerIconColored")]
    let titleOfSection2 = ["団体名","役割"]
    let imageOfSection2 = [#imageLiteral(resourceName: "camera"),#imageLiteral(resourceName: "education")]
    
    let dummyUser:[String:Any?] = [
        studentPropety.uuid.rawValue:"hoge",
        studentPropety.name.rawValue:"山田たかし",
        studentPropety.birth.rawValue:"1990-01-11",
        studentPropety.education.rawValue:["駒沢大学","文学部",2020],
        studentPropety.message.rawValue:"がんばります",
        studentPropety.interesting.rawValue:["金融","経済","ほげほｇほえｈごえおごえげｇ","インターナショナル"],
        studentPropety.introduction.rawValue:"ないににあにゔぃふぁｖみさゔぃっｖ",
        studentPropety.goodpoint.rawValue:"顔が長い",
        studentPropety.badpoint.rawValue:"不器用",
        studentPropety.skill.rawValue:["英検３級","走り幅跳び"],
        studentPropety.belonging.rawValue:["環境ロドリゲス","幹事長"]
        ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.delegate = self
        myTableView.dataSource = self
        // Do any additional setup after loading the view.
        
        
        
        myTableView.estimatedRowHeight = 90
    }
    
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return titleOfSection1.count
        case 2:
            return titleOfSection2.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "detailCell") as! DetailTableViewCell
        
        switch indexPath.section {
        case 0:
            let cell = myTableView.dequeueReusableCell(withIdentifier: "basicUserCell") as! BasicUserTableViewCell
            cell.labelImageView.image = #imageLiteral(resourceName: "shinsotsu-label")
            
            if let uuid = dummyUser[studentPropety.uuid.rawValue] as? String{
                let image = getImage(uuid: uuid)
                cell.userImageView.image = image
                
            }
            
            if cell.userImageView.image == nil{
                cell.userImageView.image = #imageLiteral(resourceName: "anonymous")
            }

            if let value = dummyUser[studentPropety.name.rawValue] as? String{
                cell.nameLabel.text = value
                
            }else{
                cell.nameLabel.text = "-"
            }
            
            if let value = dummyUser[studentPropety.birth.rawValue] as? String{
                let birthDate = DateUtils.date(value, format:"yyyy-MM-dd" )
                let age = DateUtils.age(byBirthDate: birthDate)
                cell.ageLabel.text = "(" + String(describing:age) + ")"
            }
            
            if let array = dummyUser[studentPropety.education.rawValue] as? [Any]{
                if let schoolName = array[0] as? String, let faculty = array[1] as? String,let year = array[2] as? Int{
                    cell.positionLabel.text = schoolName + faculty + " " + String(describing: year) + "年卒"
                }else{
                    cell.positionLabel.text = "-"
                }
                
            }
            
            if let interesting = dummyUser[studentPropety.interesting.rawValue] as? [String]{
                pasteTag(forView: cell.experienceTagView, forTagList: interesting, heightConstraint: cell.tagViewHeightConstraint)
                
            }
            
            if let message = dummyUser[studentPropety.message.rawValue] as? String{
                cell.messageLabel.text = message
            }else{
                cell.messageLabel.text = "-"
            }
            
            
            
            return cell
        case 1:
            cell.titleLabel.text = titleOfSection1[indexPath.row]
            cell.titleImageView.image = imageOfSection1[indexPath.row]
            
            switch indexPath.row {
            case 0:
                //自己紹介
                
                if let introduction = dummyUser[studentPropety.introduction.rawValue] as? String{
                    cell.conetntLabel.text = introduction
                }else{
                    cell.conetntLabel.text = "-"
                }
                
            case 1:
                //いいところ
                
                if let goodPoint = dummyUser[studentPropety.goodpoint.rawValue] as? String{
                    cell.conetntLabel.text = goodPoint
                }else{
                    cell.conetntLabel.text = "-"
                }
                
            case 2:
                //悪いところ
                if let badPoint = dummyUser[studentPropety.badpoint.rawValue] as? String{
                    cell.conetntLabel.text = badPoint
                }else{
                    cell.conetntLabel.text = "-"
                }
            case 3:
                //資格・スキル
                
                if let skill = dummyUser[studentPropety.skill.rawValue] as? [String]{
                    var str = ""
                    for value in skill{
                        if value == skill.last{
                            str += value
                            continue
                        }
                        str += value + "/"
                    }
                    cell.conetntLabel.text = str
                }else{
                    cell.conetntLabel.text = "-"
                }
                
            default:
                break
            }
        case 2:
            cell.titleLabel.text = titleOfSection2[indexPath.row]
            cell.titleImageView.image = imageOfSection2[indexPath.row]
            
            switch indexPath.row {
            case 0:
                if let belonging = dummyUser[studentPropety.belonging.rawValue] as? [String]{
                    cell.conetntLabel.text = belonging[0]
                }
            case 1:
                if let belonging = dummyUser[studentPropety.belonging.rawValue] as? [String]{
                    
                    cell.conetntLabel.text = belonging[1]
                }
                
            default:
                break
            }
        default:
            break
        }
        return cell
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
