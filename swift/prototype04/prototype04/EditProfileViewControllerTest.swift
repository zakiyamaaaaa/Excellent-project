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
    var interestingTagList:[String]?
    var skillList:[String]?
    var appealText:String?
    var goodPointString:String?
    var badPointString:String?
    var selfIntroText:String?
    var interestingCellHeihgt:CGFloat = 50
    var educationArray:[Any]?
    var selectedImage:UIImage?
    var belonging:[String]?
    
    let ud = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myTableView.delegate = self
        myTableView.dataSource = self
        
        let documentDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let imgFileName = "userimg.png"
        var tmp = UIImage(contentsOfFile: "\(documentDir)/\(imgFileName)")
        if tmp == nil{
            tmp = #imageLiteral(resourceName: "anonymous")
        }
        myPhotoImageView.image = tmp
        let a = studentPropety.self
        selfIntroText = app.myInfoDelegate?[a.introduction.rawValue] as? String
        interestingTagList = app.myInfoDelegate?[a.interesting.rawValue] as? [String]
        educationArray = app.myInfoDelegate?[a.education.rawValue] as? [Any]
        appealText = app.myInfoDelegate?[a.message.rawValue] as? String
        goodPointString = app.myInfoDelegate?[a.goodpoint.rawValue] as? String
        badPointString = app.myInfoDelegate?[a.badpoint.rawValue] as? String
        skillList = app.myInfoDelegate?[a.skill.rawValue] as? [String]
        belonging = app.myInfoDelegate?[a.belonging.rawValue] as? [String]
        
        nameLabel.text = app.myInfoDelegate?[a.name.rawValue] as? String
        
        if let dateString:String = app.myInfoDelegate?[a.birth.rawValue] as? String{
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
        
        if section == sectionTitleList.count - 1{
            
            return 2
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitleList[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let app:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let nilCell = UITableViewCell()
        nilCell.textLabel?.text = "編集する"
        nilCell.textLabel?.textColor = UIColor.gray
        nilCell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        let basicCell = UITableViewCell()
        basicCell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        basicCell.textLabel?.numberOfLines = 0
        
        switch indexPath.section {
        case 0:
            
            if selfIntroText == nil || selfIntroText!.isEmpty{
                return nilCell
            }
            
            basicCell.textLabel?.text = selfIntroText
            
            return basicCell
        case 1:
            
            
            if interestingTagList != nil{
                pasteTag(forView: basicCell, forTagList: interestingTagList!)
                
                return basicCell
            }else{
                return nilCell
            }
            
        case 2:
            
            if educationArray == nil{
                return nilCell
            }
            
            let cell = myTableView.dequeueReusableCell(withIdentifier: "educationCell") as! EducationTableViewCell
            cell.schooNameLabel.text = educationArray?[0] as? String
            cell.facultyLabel.text = educationArray?[1] as? String
            cell.graduationYearLabel.text = String(describing: educationArray![2]) + "年卒業"
            return cell
        case 3:
            
            if appealText == nil || appealText!.isEmpty{
                return nilCell
            }
            
            basicCell.textLabel?.text = appealText
            
            return basicCell
        case 4:
            
            if goodPointString == nil || goodPointString!.isEmpty{
                
                return nilCell
            }
            
            basicCell.textLabel?.text = goodPointString
            
            return basicCell
        case 5:
            
            if badPointString == nil || badPointString!.isEmpty{
                
                return nilCell
            }
            
            basicCell.textLabel?.text = badPointString
            
            return basicCell
        case 6:
            
            if skillList == nil {
                return nilCell
            }
            
            var str = ""
            
            for item in skillList! {
                if item != skillList!.last{
                
                str.append(item)
                str.append("/")
                continue
                    
                }
                
                str.append(item)
            }

            basicCell.textLabel?.text = str
            
            return basicCell
            
        case 7:
            
//            let belonging = app.myInfoDelegate?["belonging_group"] as? [String]
            if belonging == nil{
                return nilCell
            }
            
            myTableView.separatorStyle = .none
            
            
            switch indexPath.row {
            case 0:
                basicCell.textLabel?.text = belonging?[0]
            case 1:
                basicCell.textLabel?.text = belonging?[1]
            default:
                break
            }
            
            return basicCell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            performSegue(withIdentifier: "selfIntroSegue", sender: nil)
        case 1:
            performSegue(withIdentifier: "interestingSegue", sender: nil)
        case 2:
            performSegue(withIdentifier: "educationSegue", sender: nil)
        case 3:
            performSegue(withIdentifier: "appealSegue", sender: nil)
        case 4:
            performSegue(withIdentifier: "goodPointSegue", sender: nil)
        case 5:
            performSegue(withIdentifier: "badPointSegue", sender: nil)
        case 6:
            performSegue(withIdentifier: "skillSegue", sender: nil)
        case 7:
            performSegue(withIdentifier: "belongingSegue", sender: nil)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return UITableViewAutomaticDimension
        case 1:
            return interestingCellHeihgt
        default:
            return UITableViewAutomaticDimension
        }
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
            let vc = segue.destination as! EducationEditViewController
            vc.schoolNameTextEdited = educationArray?[0] as! String
            vc.facultyTextEdited = educationArray?[1] as! String
            vc.graduationNameNumEdited = educationArray?[2] as! Int
            
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
        app.myInfoDelegate?[a.introduction.rawValue] = selfIntroText
        app.myInfoDelegate?[a.interesting.rawValue] = interestingTagList
        app.myInfoDelegate?[a.education.rawValue] = educationArray
        app.myInfoDelegate?[a.goodpoint.rawValue] = goodPointString
        app.myInfoDelegate?[a.badpoint.rawValue] = badPointString
        app.myInfoDelegate?[a.skill.rawValue] = skillList
        app.myInfoDelegate?[a.belonging.rawValue] = belonging
        
        
        
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
        
        
        let sc = ServerConnection()
        sc.updateMyData(postImage: postImage)
        self.dismiss(animated: true, completion: nil)
        
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
