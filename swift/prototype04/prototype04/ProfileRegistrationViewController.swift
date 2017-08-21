
//
//  ProfileRegistrationViewController.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/08/12.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class ProfileRegistrationViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPickerViewDelegate{

    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myNameLabel: UILabel!
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var myBirthLabel: UILabel!
    @IBOutlet weak var facultyLabel: UILabel!
    @IBOutlet weak var graduationYearLabel: UILabel!
    var selectedImage:UIImage?
    var nameText:String?
    var birthText:String?
    var schoolNameText:String?
    var facultyText:String?
    var graduationText:String?
    var myStatus = 0
    
    @IBOutlet weak var sectionImageView: UIImageView!
    @IBOutlet weak var anonymousLabel: UILabel!
    @IBOutlet weak var sectionTitleLabel: UILabel!
    @IBOutlet weak var anonymousSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let a = my()
        nameText = a.getValue(key: .name) as? String
        birthText = a.getValue(key: .birth) as? String
        
        let documentDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let imgFileName = "userimg.png"
        let tmp = UIImage(contentsOfFile: "\(documentDir)/\(imgFileName)")
        myImageView.image = tmp
        
        if let status = User().status{
            myStatus = status
        }
        
        switch myStatus {
        case 1:
            title = "所属企業について"
//            var careerArray:[Any] = a.getValue(key: .ca) as! [Any]
            schoolNameText = Recruiter().company_name
            facultyText = Recruiter().position
            

            sectionImageView.image = #imageLiteral(resourceName: "register_recruiter")
            
            //anonymousがtrueだったら、会社の情報を非公開にする
            if Recruiter().anonymous == true{
                graduationYearLabel.isHidden = false
                graduationYearLabel.text = "企業情報を非公開に設定しています。"
            }else{
                graduationYearLabel.isHidden = true
            }
            
        case 2:
            title = "学校"
            graduationYearLabel.isHidden = false
            var educationArray:[Any] = a.getValue(key: .education) as! [Any]
            schoolNameText = educationArray[0] as? String
            facultyText = educationArray[1] as? String
            if let year = educationArray[2] as? Int{
                graduationYearLabel.text = String(describing: year)
                graduationText = String(describing: year)
            }
            
            
        default:
            break
        }
        sectionTitleLabel.text = title
        
        
    }
    var birthDate:String? = User().birth
    override func viewWillAppear(_ animated: Bool) {
        myNameLabel.text =  nameText
        
        if let dateString = User().birth{
            let date = DateUtils.date(dateString, format: "YYYY-MM-dd")
            let year = NSCalendar.current.component(.year, from: date)
            let month = NSCalendar.current.component(.month, from: date)
            let day = NSCalendar.current.component(.day, from: date)
            birthText = "生年月日 " + String(year) + "年" + String(month) + "月" + String(day) + "日"
        }
        myBirthLabel.text = birthText
        
        //ステータスによって、ラベルに表示する情報を変える
        schoolNameLabel.text = schoolNameText
        facultyLabel.text = facultyText
        if graduationText?.isEmpty == false{
            graduationYearLabel.text = graduationText! + "年卒業"
        }
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        
        //tagを使うところは、そこの高さの変数を返す。
        return UITableViewAutomaticDimension
    }
    override func viewDidAppear(_ animated: Bool) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { 
            
        }
        
    }
    
    @IBAction func uploadButtonTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "メディアの選択", message: nil, preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
            let cameraAction = UIAlertAction(title: "カメラ", style: .default, handler: {(action:UIAlertAction) in
                let ipc = UIImagePickerController()
                ipc.sourceType = .camera
                ipc.delegate = self
                self.present(ipc, animated:true, completion: nil)
                
            })
            alertController.addAction(cameraAction)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let photoLibraryAction = UIAlertAction(title: "フォトライブラリ", style: .default, handler: {(actioin:UIAlertAction) in
                
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

    @IBAction func editEducationInfo(_ sender: Any) {
        guard let status = my().status else { return }
        
        switch status {
        case 1:
            performSegue(withIdentifier: "editCompanyInfoSegue", sender: nil)
        case 2:
            performSegue(withIdentifier: "editEducationInfoSegue", sender: nil)
        default:
            break
        }
    }
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func editBasicInfo(_ sender: Any) {
        performSegue(withIdentifier: "basicInfoSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "basicInfoSegue"{
            let vc = segue.destination as! RegisterBasicInfoViewController
            vc.namaText = nameText
            vc.birthText = birthText
        }
        
        if segue.identifier == "editEducationInfoSegue"{
            let vc = segue.destination as! RegisterEducationViewController
            vc.schoolNameText = schoolNameText
            vc.facultyText = facultyText
            vc.graduationYearText = graduationText
        }
        
        if segue.identifier == "cropImageSegue"{
            let vc = segue.destination as! CropEditViewController
            vc.originalImage = selectedImage
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Crop画面から戻ってきたときに、クロップで切り取った画像を引っ張ってくる
    @IBAction func returnToTop(segue: UIStoryboardSegue) {
        
        if segue.identifier  == "unwindCrop"{
            
            let vc = segue.source as! CropEditViewController
            myImageView.image = vc.maskedImage
        }
    }
    
    
    @IBAction func updateUser(_ sender: Any) {
        
        var user = my()
        
        
        user.register(key: .name, value: nameText)
//        user.register(key: .birth, value: birthText)
        
        switch myStatus {
        case 1:
            var recruiter = Recruiter()
            if let position = facultyText{
                recruiter.register(key: .position, value: position)
            }
            
            if let companyName = schoolNameText{
                recruiter.register(key: .company_name, value: companyName)
            }
            
        case 2:
            if let schoolname = schoolNameText,let faculty = facultyText,let year = graduationText{
                
                let numYear = Int(year)
                user.register(key: .education, value: [schoolname,faculty,numYear])
            }
        default:
            break
        }
        
        self.updateBeforeValid(postImage: selectedImage)
        
    }
    
    func updateBeforeValid(postImage:UIImage?){
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
            
            let requestURL = URL(string: "http://localhost:8888/test/updateBeforeValid.php")
            var request = URLRequest(url: requestURL!)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            do{
                request.httpBody = try JSONSerialization.data(withJSONObject: postData, options: .prettyPrinted)
                let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
                    print("register my data")
                    let str = String(data:data!,encoding:.utf8)
                    print(str)
                    if str! == "hoge" {
//                        self.performSegue(withIdentifier: "goSegue", sender: nil)
                        let alert = UIAlertController(title: "プロフィールを更新しました", message: nil, preferredStyle: .alert)
                        
                        
                        self.present(alert, animated: true, completion: {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute:
                                {
                                    alert.dismiss(animated: true, completion: {
                                        self.dismiss(animated: true, completion: nil)
                                    })
                            }
                                
                            )
                        })
                    }else{
                        let alert = UIAlertController(title: "プロフィール更新失敗", message: "更新が失敗しました。時間をとって再度行ってください", preferredStyle: .alert)
                        
                        
                        self.present(alert, animated: true, completion: {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute:
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
                    print(str)
                    if str! == "hoge" {
                        //                        self.performSegue(withIdentifier: "goSegue", sender: nil)
                        let alert = UIAlertController(title: "プロフィールを更新しました", message: nil, preferredStyle: .alert)
                        
                        
                        self.present(alert, animated: true, completion: {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute:
                                {
                                    alert.dismiss(animated: true, completion: {
                                        self.dismiss(animated: true, completion: nil)
                                    })
                            }
                                
                            )
                        })
                    }else{
                        let alert = UIAlertController(title: "プロフィール更新失敗", message: "更新が失敗しました。時間をとって再度行ってください", preferredStyle: .alert)
                        
                        
                        self.present(alert, animated: true, completion: {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute:
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
