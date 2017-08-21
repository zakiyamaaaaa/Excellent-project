//
//  EditProfileViewControllerTest.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/07/27.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class EditProfileViewControllerTest: UIViewController,UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate {

    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var myPhotoImageView: UIImageView!
    
    let sectionTitleList = ["自己紹介","興味がある職種・業種","学歴","ひとことアピール","自分の長所","自分の短所","資格・スキル","所属団体・サークル"]
    
    let sectionTitleList2 = ["自己紹介","所属団体・サークル"]
    let titleOfSection1Title = ["何をやっているか","学歴","長所","短所","資格・スキル","興味・関心","メッセージ"]
    let titleOfSection2Title = ["団体名","自分の役割"]
    
    var interestingTagList = my().interesting
    var skillList = my().skill
    var appealText = my().message
    var goodPointString = my().goodpoint
    var badPointString = my().badpoint
    var selfIntroText = my().introduction
    var interestingCellHeihgt:CGFloat = 50
    var educationArray = my().education
    var selectedImage:UIImage?
    var belonging = my().belonging
    
    let ud = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myTableView.delegate = self
        myTableView.dataSource = self
        
        let documentDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let imgFileName = "userimg.png"
        var tmp = UIImage(contentsOfFile: "\(documentDir)/\(imgFileName)")
        if tmp == nil{
            tmp = #imageLiteral(resourceName: "anonymous_43")
        }
        myPhotoImageView.image = tmp
        let a = studentPropety.self
//        selfIntroText = app.myInfoDelegate?[a.introduction.rawValue] as? String
//        interestingTagList = app.myInfoDelegate?[a.interesting.rawValue] as? [String]
//        educationArray = app.myInfoDelegate?[a.education.rawValue] as? [Any]
//        appealText = app.myInfoDelegate?[a.message.rawValue] as? String
//        goodPointString = app.myInfoDelegate?[a.goodpoint.rawValue] as? String
//        badPointString = app.myInfoDelegate?[a.badpoint.rawValue] as? String
//        skillList = app.myInfoDelegate?[a.skill.rawValue] as? [String]
//        belonging = app.myInfoDelegate?[a.belonging.rawValue] as? [String]
        
        nameLabel.text = my().name
        
        if let dateString:String = User().birth{
            let date = DateUtils.date(dateString, format: "YYYY-MM-dd")
            let year = NSCalendar.current.component(.year, from: date)
            let month = NSCalendar.current.component(.month, from: date)
            let day = NSCalendar.current.component(.day, from: date)
            birthLabel.text = String(year) + "年" + String(month) + "月" + String(day) + "日 生まれ"
        }
        
        // Do any additional setup after loading the view.
    }
    
    let app:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewWillAppear(_ animated: Bool) {
        
        myTableView.estimatedRowHeight = 90
        myTableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return titleOfSection1Title.count
        case 1:
            if belonging == nil || belonging!.isEmpty{
                return 1
            }
            
            return titleOfSection2Title.count
        default:
            return 0
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitleList2[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitleList2.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = myTableView.dequeueReusableCell(withIdentifier: "detailCell") as! DetailTableViewCell
        
        
        
        switch indexPath.section {
        case 0:
            cell.titleLabel.text = titleOfSection1Title[indexPath.row]
            cell.conetntLabel.text = "aaa"
            
            
            switch indexPath.row {
            case 0:
                if selfIntroText == nil || selfIntroText!.isEmpty{
                    cell.conetntLabel.text = "未入力"
                }else{
                    cell.conetntLabel.text = selfIntroText
                }
                
            
            case 1:
                if educationArray == nil || educationArray!.isEmpty{
                    cell.conetntLabel.text = "未入力"
                }else{
                    let schoolName = educationArray?[0] as! String
                    let faculty = educationArray?[1] as! String
                    let year = educationArray?[2] as! Int
                    cell.conetntLabel.text = schoolName + " " + faculty + " " + String(describing: year) + "年卒業"
                }
                
            
            case 2:
                if goodPointString == nil || goodPointString!.isEmpty{
                    cell.conetntLabel.text = "未入力"
                }else{
                    cell.conetntLabel.text = goodPointString
                }
                
            case 3:
                if badPointString == nil || badPointString!.isEmpty{
                    cell.conetntLabel.text = "未入力"
                }else{
                    cell.conetntLabel.text = badPointString
                }
                
            case 4:
                if skillList == nil || skillList!.isEmpty{
                    cell.conetntLabel.text = "未入力"
                }else{
                    var str = ""
                    for text in skillList!{
                        if text == skillList?.last{
                            str += text
                            continue
                        }
                        str += text + "／"
                    }
                    
                    cell.conetntLabel.text = str
                }
                
            case 5:
                if interestingTagList == nil || interestingTagList!.isEmpty{
                    cell.conetntLabel.text = "未入力"
                }else{
                    var str = ""
                    for text in interestingTagList!{
                        if text == interestingTagList?.last{
                            str += text
                            continue
                        }
                        str += text + "／"
                    }
                    
                    cell.conetntLabel.text = str
                    
                }
                
            case 6:
                if appealText == nil || appealText!.isEmpty{
                    cell.conetntLabel.text = "未入力"
                }else{
                    cell.conetntLabel.text = appealText
                }
                
                
            default:
                break
            }
        case 1:
            cell.titleLabel.text = titleOfSection2Title[indexPath.row]
            cell.separatorInset = .zero
            switch indexPath.row {
            case 0:
                if belonging == nil || belonging!.isEmpty{
                    cell.conetntLabel.text = "未入力"
                }else{
                    cell.conetntLabel.text = belonging?.first
                }
                
            case 1:
                cell.conetntLabel.text = belonging?.last
            default:
                break
            }
        default:
            break
        }
        
        
        return cell
        
//        let app:AppDelegate = UIApplication.shared.delegate as! AppDelegate
//        let nilCell = UITableViewCell()
//        nilCell.textLabel?.text = "編集する"
//        nilCell.textLabel?.textColor = UIColor.gray
//        nilCell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
//        
//        let basicCell = UITableViewCell()
//        basicCell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
//        basicCell.textLabel?.numberOfLines = 0
//        
//        switch indexPath.section {
//        case 0:
//            
//            if selfIntroText == nil || selfIntroText!.isEmpty{
//                return nilCell
//            }
//            
//            basicCell.textLabel?.text = selfIntroText
//            
//            return basicCell
//        case 1:
//            
//            
//            if interestingTagList != nil{
//                pasteTag(forView: basicCell, forTagList: interestingTagList!)
//                
//                return basicCell
//            }else{
//                return nilCell
//            }
//            
//        case 2:
//            
//            if educationArray == nil{
//                return nilCell
//            }
//            
//            let cell = myTableView.dequeueReusableCell(withIdentifier: "educationCell") as! EducationTableViewCell
//            cell.schooNameLabel.text = educationArray?[0] as? String
//            cell.facultyLabel.text = educationArray?[1] as? String
//            cell.graduationYearLabel.text = String(describing: educationArray![2]) + "年卒業"
//            return cell
//        case 3:
//            
//            if appealText == nil || appealText!.isEmpty{
//                return nilCell
//            }
//            
//            basicCell.textLabel?.text = appealText
//            
//            return basicCell
//        case 4:
//            
//            if goodPointString == nil || goodPointString!.isEmpty{
//                
//                return nilCell
//            }
//            
//            basicCell.textLabel?.text = goodPointString
//            
//            return basicCell
//        case 5:
//            
//            if badPointString == nil || badPointString!.isEmpty{
//                
//                return nilCell
//            }
//            
//            basicCell.textLabel?.text = badPointString
//            
//            return basicCell
//        case 6:
//            
//            if skillList == nil {
//                return nilCell
//            }
//            
//            var str = ""
//            
//            for item in skillList! {
//                if item != skillList!.last{
//                
//                str.append(item)
//                str.append("/")
//                continue
//                    
//                }
//                
//                str.append(item)
//            }
//
//            basicCell.textLabel?.text = str
//            
//            return basicCell
//            
//        case 7:
//            
////            let belonging = app.myInfoDelegate?["belonging_group"] as? [String]
//            if belonging == nil{
//                return nilCell
//            }
//            
//            myTableView.separatorStyle = .none
//            
//            
//            switch indexPath.row {
//            case 0:
//                basicCell.textLabel?.text = belonging?[0]
//            case 1:
//                basicCell.textLabel?.text = belonging?[1]
//            default:
//                break
//            }
//            
//            return basicCell
//            
//        default:
//            return UITableViewCell()
//        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                performSegue(withIdentifier: "selfIntroSegue", sender: nil)
            case 1:
                performSegue(withIdentifier: "educationSegue", sender: nil)
            case 2:
                performSegue(withIdentifier: "goodPointSegue", sender: nil)
            case 3:
                performSegue(withIdentifier: "badPointSegue", sender: nil)
            case 4:
                performSegue(withIdentifier: "skillSegue", sender: nil)
            case 5:
                performSegue(withIdentifier: "interestingSegue", sender: nil)
            case 6:
//                performSegue(withIdentifier: "appealSegue", sender: nil)
                let alert = UIAlertController(title: "メッセージ", message: "相手に表示する一言メッセージを入力してください", preferredStyle: .alert)
                alert.addTextField(configurationHandler: { (UITextField) in
                    UITextField.placeholder = "相手側へのメッセージを入力してください"
                    if self.appealText != nil && self.appealText?.isEmpty == false{
                        UITextField.text = self.appealText
                    }
                    
                })
                
                let okAction:UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                    let textField = alert.textFields![0] as UITextField
                    if textField.text != nil{
                        self.appealText = textField.text
                        self.myTableView.reloadData()
                    }else{
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                })
                let cancelAction:UIAlertAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: { (UIAlertAction) in
                    
                })
                alert.addAction(okAction)
                alert.addAction(cancelAction)
                present(alert, animated: true, completion: nil)
                
            default:
                break
            }
        case 1:
            performSegue(withIdentifier: "belongingSegue", sender: nil)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selfIntroSegue"{
            let vc = segue.destination as! SelfIntroEditViewController
            
            if selfIntroText == nil{
                
            }else{
                vc.selfIntroText = selfIntroText!
            }
        }
        
        if segue.identifier == "educationSegue"{
            let vc = segue.destination as! RegisterEducationViewController

            if let education = educationArray {
                vc.schoolNameText = education[0] as? String
                vc.facultyText = education[1] as? String
                vc.graduationYearText = String(describing:education[2] as! Int)
            }
            
        }
        
        if segue.identifier == "appealSegue"{
            let vc = segue.destination as! AppealEditViewController
            
            if appealText != nil{
                vc.appealText = appealText
            }
        }
        
        if segue.identifier == "interestingSegue"{
            let vc = segue.destination as! InterestingViewController
            vc.interestingTagList = interestingTagList
            
        }
        
        if segue.identifier == "goodPointSegue"{
            let vc = segue.destination as! GoodPointEditViewController
            if goodPointString == nil{
                
            }else{
                vc.goodPointText = goodPointString!
            }
            
        }
        
        if segue.identifier == "badPointSegue"{
            let vc = segue.destination as! BadPointEditViewController
            if badPointString == nil{
                
            }else{
                vc.badPointText = badPointString!
            }
        }
        
        if segue.identifier == "photoCropSegue"{
            let vc = segue.destination as! CropEditViewController
            vc.originalImage = selectedImage
        }
        
        if segue.identifier == "skillSegue"{
            let vc = segue.destination as! SkillEditViewController
            vc.tagList = skillList
            vc.explainText = "得意なこと・資格を入力してください"
        }
        
        if segue.identifier == "belongingSegue"{
            let vc = segue.destination as! BelongingEditViewController
            if belonging == nil{
                
            }else{
                vc.belongingNameText = belonging?[0]
                vc.enrollmentText = belonging?[1]
            }
        }
        
    }
    
    
    func pasteTag(forView targetView:UIView,forTagList TagList:[String]){
        
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
            
            
            
            if pointX + tagLabel.frame.width > targetView.frame.width{
                pointX = 10
                pointY += 5 + tagLabel.frame.height
            }
            
            tagLabel.frame.origin = CGPoint(x: pointX, y: pointY)
            
            pointX += 5 + tagLabel.frame.width
            lastHeight = pointY + tagLabel.frame.height
        }
        
        interestingCellHeihgt = lastHeight + 10
        //        heightConstraint.constant = lastHeight + 10
    }
    
    @IBAction func uploadPhoto(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Confirmation", message: "Choose", preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            print("Available to camera")
            
            
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: {(action:UIAlertAction) in
                let ipc = UIImagePickerController()
                ipc.sourceType = .camera
                ipc.delegate = self
                self.present(ipc, animated:true, completion: nil)
                
            })
            alertController.addAction(cameraAction)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: {(actioin:UIAlertAction) in
                
                let ipc :UIImagePickerController = UIImagePickerController()
                ipc.sourceType = .photoLibrary
                ipc.delegate = self
                self.present(ipc, animated:true, completion: nil)
                
                
            })
            alertController.addAction(photoLibraryAction)
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController,animated: true,completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        dismiss(animated: true) {
            self.performSegue(withIdentifier: "photoCropSegue", sender: self.selectedImage)
        }
    }
    
    //cropVCから戻ってくるときに発動
    @IBAction func returnToTop(segue: UIStoryboardSegue) {
        
        if segue.identifier  == "unwindCrop"{
            
            let vc = segue.source as! CropEditViewController
            myPhotoImageView.image = vc.maskedImage
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        //各項目をlocalstorage保存かつサーバーにデータ更新
        let a = studentPropety.self
//        app.myInfoDelegate?[a.introduction.rawValue] = selfIntroText
//        app.myInfoDelegate?[a.interesting.rawValue] = interestingTagList
//        app.myInfoDelegate?[a.education.rawValue] = educationArray
//        app.myInfoDelegate?[a.goodpoint.rawValue] = goodPointString
//        app.myInfoDelegate?[a.badpoint.rawValue] = badPointString
//        app.myInfoDelegate?[a.skill.rawValue] = skillList
//        app.myInfoDelegate?[a.belonging.rawValue] = belonging
        
        
        
        let documentDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let imgFileName = "userimg.png"
        let postImage:UIImage? = myPhotoImageView.image
        
        if let image = myPhotoImageView.image {
            let pngData = UIImagePNGRepresentation(image)
            do{
                try pngData?.write(to: URL(fileURLWithPath: "\(documentDir)/\(imgFileName)"))
            }catch{
                print(error.localizedDescription)
            }
        }
        
        
//        let sc = ServerConnection()
//        sc.updateMyData(postImage: postImage)
//        self.dismiss(animated: true, completion: nil)
        var student = my()
        
        if let value = selfIntroText{
            student.register(key: .introduction, value: value)
        }
        if let value = educationArray{
            student.register(key: .education, value: value)
        }
        if let value = interestingTagList{
            student.register(key: .interesting, value: value)
        }
        if let value = goodPointString{
            student.register(key: .goodpoint, value: value)
        }
        if let value = badPointString{
            student.register(key: .badpoint, value: value)
        }
        if let value = belonging{
            student.register(key: .belonging, value: value)
        }
        if let value = appealText{
            student.register(key: .message, value: value)
        }
        if let value = skillList{
            student.register(key: .skill, value: value)
        }
        
        
        updateMyData(postImage: postImage)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func updateMyData(postImage:UIImage?){
        let user = User()
        guard let status = user.status else { return }
        
        switch status {
        case 1:
            
            var postData = Recruiter().all
            if let image = postImage{
                let pngImageData = UIImagePNGRepresentation(image)! as NSData
                let encodedImageData = pngImageData.base64EncodedString(options: [])
                postData["profileImage"] = encodedImageData
                
            }
            
            let requestURL = URL(string: "http://localhost:8888/test/updateMyData.php")
            var request = URLRequest(url: requestURL!)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            do{
                request.httpBody = try JSONSerialization.data(withJSONObject: postData, options: .prettyPrinted)
                let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
                    print("update my data")
                    let str = String(data:data!,encoding:.utf8)
                    print(str)
                    if str! == "hoge" {
                        
                        let alert = UIAlertController(title: "プロフィールが更新されました", message: nil, preferredStyle: .alert)
                        
                        
                        self.present(alert, animated: true, completion: {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:
                                {
                                    alert.dismiss(animated: true, completion: {
                                        self.dismiss(animated: true, completion: nil)
                                    })
                            }
                                
                            )
                        })
                    }
                    
                })
                task.resume()
                
                
            }catch{
                print("error:\(error.localizedDescription)")
                
            }
        case 2:
            
            var postData = my().all
            if let image = postImage{
                let pngImageData = UIImagePNGRepresentation(image)! as NSData
                let encodedImageData = pngImageData.base64EncodedString(options: [])
                postData["profileImage"] = encodedImageData
                
            }
            
            let requestURL = URL(string: "http://localhost:8888/test/updateMyData.php")
            var request = URLRequest(url: requestURL!)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            do{
                request.httpBody = try JSONSerialization.data(withJSONObject: postData, options: .prettyPrinted)
                let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
                    print("update my data")
                    let str = String(data:data!,encoding:.utf8)
                    print(str)
                    if str! == "hoge" {
                        
                        let alert = UIAlertController(title: "プロフィールが更新されました", message: nil, preferredStyle: .alert)
                        
                        
                        self.present(alert, animated: true, completion: {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:
                                {
                                    alert.dismiss(animated: true, completion: {
                                        self.dismiss(animated: true, completion: nil)
                                    })
                            }
                                
                            )
                        })
                    }
                    
                })
                task.resume()
                
                
            }catch{
                print("error:\(error.localizedDescription)")
                
            }
        default:
            break
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
