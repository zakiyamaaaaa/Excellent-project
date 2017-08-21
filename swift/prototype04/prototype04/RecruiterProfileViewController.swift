//
//  RecruiterProfileViewController.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/08/16.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class RecruiterProfileViewController: UIViewController,UITableViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource, UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate{

    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthLabel: UILabel!
    
    @IBOutlet weak var myTableView: UITableView!
    
    let sectionTitle = ["自己紹介","会社情報"]
    let titleOfSection1 = ["何をやっているか","職種","スキル・経験","OGORI","学歴","メッセージ"]
    let titleOfSection2 = ["会社名","規模","業界","特徴","採用"]
    
//    var myData:[String:Any]!
    
    var introText = Recruiter().introduction
    var skillList = Recruiter().skill
    var ogoriList = Recruiter().ogori
    var position = Recruiter().position
    var educationList = Recruiter().education
    var companyName = Recruiter().company_name
    var companyLink = Recruiter().company_link
    var copmpanyPopulation = Recruiter().company_population
    var companyIndustry = Recruiter().company_industry
    var recruitmentList = Recruiter().company_recruitment
    var featureList = Recruiter().company_feature
    var messegae = Recruiter().message
    var selectedImage:UIImage?
    var postImage:UIImage?
    var pickerText:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.estimatedRowHeight = 90
        
        nameLabel.text = User().name
        birthLabel.text = User().birth
        
        if let dateString = User().birth{
            let date = DateUtils.date(dateString, format: "YYYY-MM-dd")
            let year = NSCalendar.current.component(.year, from: date)
            let month = NSCalendar.current.component(.month, from: date)
            let day = NSCalendar.current.component(.day, from: date)
            birthLabel.text = "生年月日 " + String(year) + "年" + String(month) + "月" + String(day) + "日"
        }
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        let app:AppDelegate = UIApplication.shared.delegate as! AppDelegate
//        
//        myData = app.myInfoDelegate
        
        let documentDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let imgFileName = "userimg.png"
        var tmp = UIImage(contentsOfFile: "\(documentDir)/\(imgFileName)")
        if tmp == nil{
            tmp = #imageLiteral(resourceName: "anonymous_43")
        }
        myImageView.image = tmp
        
//        if let populocation = Recruiter().company_population{
//            pickerText = pickerValue[populocation]
//        }
        
        
        myTableView.reloadData()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return titleOfSection1.count
        case 1:
            return titleOfSection2.count
        default:
            return 0
        }
    }
    
    //セルの高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {        
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "titleAndContentCell") as! TitleAndContentTableViewCell
        cell.contentLabel.text = "未入力"
        cell.editButton.addTarget(self, action: #selector(self.editButtonTapped(sender:)), for: .touchUpInside)
        
        switch indexPath.section {
        case 0:
            //自己紹介
            cell.titleLabel.text = titleOfSection1[indexPath.row]
            for view in cell.subviews{
                if view is TagLabel{
                    view.removeFromSuperview()
                }
            }
            
            switch indexPath.row {
            case 0:
                //何をやっているのか
                cell.editButton.tag = 0
                if introText != nil{
                        cell.contentLabel.text = introText
                }
            case 1:
                cell.editButton.tag = 10
                if position != nil && position?.isEmpty == false{
                    cell.contentLabel.text = position
                }else{
                    cell.contentLabel.text = "未入力"
                }
                
                
            case 2:
                //スキル・経験
                
                cell.editButton.tag = 1
                
                if skillList != nil{
                    var str = ""
                    for text in skillList!{
                        if text == skillList?.last{
                            str += text
                            continue
                        }
                        str += text + "／"
                    }
                    cell.contentLabel.text = str
                    
//                    self.pasteTag(forView: cell, forTagList: skillList!, originY: cell.contentLabel.layer.position.y)
//                    cell.contentLabel.alpha = 0
//                    return cell
                }else{
                    cell.contentLabel.alpha = 1
                }
                
                
                
            case 3:
                //OGORI
                cell.editButton.tag = 2
                if ogoriList != nil && indexPath.section == 0{
                    var str = ""
                    for num in ogoriList!{
                        var text = ""
                        switch num {
                        case 0:
                            text = "カフェ"
                        case 1:
                            text = "朝食"
                        case 2:
                            text = "昼食"
                        case 3:
                            text = "夕食"
                            
                        default:
                            break
                        }
                        
                        if num == ogoriList?.last{
                            str += text
                            continue
                        }
                        str += text + "／"
                    }
                    cell.contentLabel.text = str
                    
//                    self.pasteOgori(targetView: cell, list: ogoriList!, height: cell.contentLabel.layer.position.y)
//                    cell.contentLabel.alpha = 0
//                    return cell
                }else{
                    cell.contentLabel.alpha = 1
                }

            case 4:
                //学歴
                cell.editButton.tag = 3
                if  let content = educationList{
                    let schoolName = content[0] as! String
                    let faculty = content[1] as! String
                    let year = content[2] as! Int
                    cell.contentLabel.text = schoolName + " " + faculty + " " + String(describing: year) + "年卒業"
                
                }else{
                    cell.contentLabel.text = "未入力"
                }
                
            case 5:
                //Message
                cell.editButton.tag = 9
                if messegae != nil{
                    cell.contentLabel.text = messegae
                }else{
                    cell.contentLabel.text = "未入力"
                }
                
            default:
                break
            }
            
            return cell
        case 1:
            //会社紹介
            
            cell.titleLabel.text = titleOfSection2[indexPath.row]
//            for view in cell.subviews{
//                if view is TagLabel || view is UIImageView{
//                    view.removeFromSuperview()
//                }
//            }
            switch indexPath.row {
            case 0:
                //会社名
                cell.editButton.tag = 4
                if companyName != nil{
                    
                    cell.contentLabel.text = companyName
                
                }else{
                    cell.contentLabel.text = "未入力"
                }
                
            case 1:
                //規模
                
                
                cell.editButton.tag = 5
                if copmpanyPopulation != nil{
                    cell.contentLabel.text = pickerValue[copmpanyPopulation!]
                }else{
                    cell.contentLabel.text = "未入力"
                }
            
                
                
            case 2:
                //業界
                
                
                cell.editButton.tag = 6
                if companyIndustry != nil{
                    cell.contentLabel.text = companyIndustry
                }else{
                    cell.contentLabel.text = "未入力"
                }
                
                
            //                cell.contentLabel.text =
            case 3:
            //特徴
                cell.editButton.tag = 7
                if featureList != nil{
                    var str = ""
                    for text in featureList!{
                        if text == featureList?.last{
                            str += text
                            continue
                        }
                        str += text + "／"
                    }
                    cell.contentLabel.text = str
                }else{
                    cell.contentLabel.text = "未入力"
                }
                
            case 4:
                cell.editButton.tag = 8
                //採用
                if recruitmentList != nil{
                    var str = ""
                    for text in recruitmentList!{
                        if text == recruitmentList?.last{
                            str += text
                            continue
                        }
                        str += text + "／"
                    }
                    cell.contentLabel.text = str
                }else{
                    cell.contentLabel.text = "未入力"
                }
            //                cell.contentLabel.text =
            default:
                break
            }
            return cell
        default:
            break
        }
        
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ogoriSegue"{
            let vc = segue.destination as! OgoriViewController
            if let list  = ogoriList{
                vc.checkList = list
            }
        }
        
        if segue.identifier == "educationSegue"{
            let vc = segue.destination as! RegisterEducationViewController
            
            if let education = educationList{
                vc.schoolNameText = education[0] as? String
                vc.facultyText = education[1] as? String
                vc.graduationYearText = String(describing: education[2] as! Int)
                vc.selectYears = education[2] as? Int
            }
            
        }
        
        if segue.identifier == "textViewSegue"{
            let vc = segue.destination as! SelfIntroEditViewController
            vc.selfIntroText = introText
        }
        
        if segue.identifier == "tagViewSegue"{
            let vc = segue.destination as! InterestingViewController
            vc.interestingTagList = skillList
        }
        
        if segue.identifier == "recruitmentSegue"{
            let vc = segue.destination as! SkillEditViewController
            vc.tagList = recruitmentList
            vc.type = recruiterPropety.company_recruitment
            vc.explainText = "採用したい職種、人物を入力して追加（複数可）"
        }
        
        if segue.identifier == "featureSegue"{
            let vc = segue.destination as! SkillEditViewController
            vc.tagList = featureList
            vc.type = recruiterPropety.company_feature
            vc.explainText = "企業の特徴を入力してください（複数可）"
        }
        
        
    }
    
    func editButtonTapped(sender:UIButton){
        switch sender.tag {
        case 0:
            //何をやってるかの編集画面へ
            performSegue(withIdentifier: "textViewSegue", sender: nil)
        case 1:
            //スキルの編集画面へ
            performSegue(withIdentifier: "tagViewSegue", sender: nil)
        case 2:
            //ogori
            performSegue(withIdentifier: "ogoriSegue", sender: nil)
        case 3:
            //学歴
            performSegue(withIdentifier: "educationSegue", sender: nil)
        case 4:
            //会社名
            //アラートの中に表示
            let alert = UIAlertController(title: "会社名変更", message: nil, preferredStyle: .alert)
            alert.addTextField(configurationHandler: { (UITextField) in
                UITextField.placeholder = "会社名を入力してください"
                if let companyName = Recruiter().company_name{
                    UITextField.text = companyName
                }
                
            })
            alert.addTextField(configurationHandler: { (UITextField) in
                UITextField.placeholder = "URL(任意)"
                if let link = Recruiter().company_link{
                    UITextField.text = link
                }
                
            })
            
            
            let okAction:UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                let textField = alert.textFields![0] as UITextField
                let linkTextField = alert.textFields![1] as UITextField
                
                if textField.text != nil{
                    self.companyName = textField.text
                    self.companyLink = linkTextField.text
                    
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
        case 5:
            //会社の規模
            let vc = UIViewController()
            let screenWidth = self.view.frame.width
            vc.preferredContentSize = CGSize(width: screenWidth,height: 150)
            let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 150))
            
            pickerView.delegate = self
            pickerView.dataSource = self
            vc.view.addSubview(pickerView)
            
            let editRadiusAlert = UIAlertController(title: "会社の業態", message: "企業の業態を選択してください", preferredStyle: UIAlertControllerStyle.actionSheet)
            editRadiusAlert.setValue(vc, forKey: "contentViewController")
            editRadiusAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                self.copmpanyPopulation = self.selectRow
                self.myTableView.reloadData()
            }))
                
            editRadiusAlert.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
            self.present(editRadiusAlert, animated: true)
            
            
        case 6:
            let alert = UIAlertController(title: "業種", message: nil, preferredStyle: .alert)
            alert.addTextField(configurationHandler: { (UITextField) in
                UITextField.placeholder = "企業の業種を入力してください"
                if let industry = Recruiter().company_industry{
                    UITextField.text = industry
                }
                
            })
            
            
            let okAction:UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                let textField = alert.textFields![0] as UITextField
                if textField.text != nil && textField.text?.isEmpty == false{
                    self.companyIndustry = textField.text
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
        case 7:
            performSegue(withIdentifier: "featureSegue", sender: nil)
        case 8:
            performSegue(withIdentifier: "recruitmentSegue", sender: nil)
            
        case 9:
            let alert = UIAlertController(title: "メッセージ", message: nil, preferredStyle: .alert)
            alert.addTextField(configurationHandler: { (UITextField) in
                UITextField.placeholder = "相手側へのメッセージを入力してください"
                if let messeage2 = Recruiter().message{
                    UITextField.text = messeage2
                }
                
            })
            
            
            let okAction:UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                let textField = alert.textFields![0] as UITextField
                if textField.text != nil{
                    self.messegae = textField.text
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
        case 10:
            //ポジション
            let alert = UIAlertController(title: "ポジション", message: nil, preferredStyle: .alert)
            alert.addTextField(configurationHandler: { (UITextField) in
                UITextField.placeholder = "現在の企業での職種を教えて下さい"
                if let position2 = Recruiter().position{
                    UITextField.text = position2
                }
                
            })
            
            
            let okAction:UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                let textField = alert.textFields![0] as UITextField
                if textField.text != nil {
                    self.position = textField.text
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
    }
    let pickerValue = ["スタートアップ","中小企業","大企業","官公庁","その他"]
    var selectRow:Int? = 0
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectRow = row
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerValue[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerValue.count
    }
    
    func pasteOgori(targetView:UIView, list:[Int]?,height:CGFloat){
        guard let ogoriList = list else { return }
        
        let originX:CGFloat = 20
        let originY:CGFloat = 40
        var i:CGFloat = 0
        let length:CGFloat = 30
        
        for subview in targetView.subviews{
            if subview == targetView.subviews.first{
                continue
            }
            subview.removeFromSuperview()
        }
        
        for item in ogoriList{
            
            let imageView = UIImageView(frame: CGRect(x: originX + length*i, y: originY, width: length, height: length))
            switch item {
            case 0:
                imageView.image = #imageLiteral(resourceName: "cafe_rect")
            case 1:
                imageView.image = #imageLiteral(resourceName: "morning_rect")
            case 2:
                imageView.image = #imageLiteral(resourceName: "lunch_rect")
            case 3:
                imageView.image = #imageLiteral(resourceName: "dinner_rect")
            default:
                break
            }
            targetView.addSubview(imageView)
            i += 1
        }
    }
    
    
    func pasteTag(forView targetView:UITableViewCell,forTagList TagList:[String],originY:CGFloat){
        
        var pointX:CGFloat = 20
        var pointY:CGFloat = originY
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
        
        cellHeihgt = lastHeight + 10
        //        heightConstraint.constant = lastHeight + 10
    }
    
    var cellHeihgt:CGFloat = 90
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
        //サーバーへデータを更新リクエスト
        var recruiter = Recruiter()
        
        if let value = introText{
            recruiter.register(key: .introduction, value: value)
        }
        if let value = skillList{
            recruiter.register(key: .skill, value: value)
        }
        if let value = educationList{
            recruiter.register(key: .education, value: value)
        }
        if let value = companyName{
            recruiter.register(key: .company_name, value: value)
        }
        if let value = companyIndustry{
            recruiter.register(key: .company_industry, value: value)
        }
        if let value = recruitmentList{
            recruiter.register(key: .company_recruitment, value: value)
        }
        
        if let value = featureList{
            recruiter.register(key: .company_feature, value: value)
        }
        
        if let value = messegae{
            recruiter.register(key: .message, value: value)
        }
        
        if let value = companyLink{
            recruiter.register(key: .company_link, value: value)
        }
        
        if let value = copmpanyPopulation{
            recruiter.register(key: .company_population, value: value)
        }
        
        if let value = ogoriList{
            recruiter.register(key: .ogori, value: value)
        }
        
        updateMyData(postImage: postImage)
        
    }
    
    @IBAction func uploadPhoto(_ sender: Any) {
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
        let cancelAction = UIAlertAction(title: "キャンセル", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController,animated: true,completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        dismiss(animated: true) {
            self.performSegue(withIdentifier: "cropImageSegue", sender: self.selectedImage)
        }
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
            self.dismiss(animated: true, completion: nil)
    }

    @IBAction func returnToTop(segue: UIStoryboardSegue) {
        
        if segue.identifier  == "unwindCrop"{
            
            let vc = segue.source as! CropEditViewController
            myImageView.image = vc.maskedImage
            postImage = vc.maskedImage
        }
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
            
            let requestURL = URL(string: "http://localhost:8888/test/updateBeforeValid.php")
            var request = URLRequest(url: requestURL!)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            do{
                request.httpBody = try JSONSerialization.data(withJSONObject: postData, options: .prettyPrinted)
                let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
                    print("register my data")
                    let str = String(data:data!,encoding:.utf8)
                    print(str!)
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
