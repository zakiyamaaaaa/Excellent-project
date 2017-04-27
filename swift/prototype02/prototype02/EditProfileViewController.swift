//
//  EditProfileViewController.swift
//  prototype02
//
//  Created by shoichiyamazaki on 2017/04/26.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController,UITextFieldDelegate {

    var myImageView:UIImageView!
    
    var mynameLabel:UILabel!
    var rankLabel:UILabel!
    var oneMessageLabel:UILabel!
    
    var facultyLabel:UILabel!
    var schoolLabel:UILabel!
    var schoolYearLabel:UILabel!
    var favoriteFoodLabel:UILabel!
    var unFavoriteFoodLabel:UILabel!
    
    var facultyField:UITextField!
    var schoolField:UITextField!
    var schoolYearField:UITextField!
    var favoriteFoodField:UITextField!
    var unFavoriteFoodField:UITextField!
    
    
    var myname:String?
    var myFaculty:String?
    var mySchool:String?
    var mySchoolYear:String?
    var myFavariteFood:String?
    var myUnfavariteFood:String?
    
    var newmyFaculty:String?
    var newmySchool:String?
    var newmySchoolYear:String?
    var newmyFavariteFood:String?
    var newmyUnfavariteFood:String?
    
    var saveButton:UIButton = UIButton()
    var cancelButton:UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ud = UserDefaults.standard
        myname = ud.string(forKey: "username")
        mySchool = ud.string(forKey: "school")
        myFaculty = ud.string(forKey: "faculty")
        mySchoolYear = ud.string(forKey: "schoolyear")
        myFavariteFood = ud.string(forKey: "favaritefood")
        myUnfavariteFood = ud.string(forKey: "unfavaritefood")
        
        newmyFaculty = myFaculty
        newmySchool = mySchool
        newmySchoolYear = mySchoolYear
        newmyFavariteFood = myFavariteFood
        newmyUnfavariteFood = myUnfavariteFood
        
        
        let imgWidth:CGFloat = self.view.frame.maxX/3*1
        let imgHeight:CGFloat = self.view.frame.maxX/3*1
        myImageView = UIImageView(frame: CGRect(x: (self.view.frame.maxX - imgWidth)/2, y: 50, width: imgWidth, height: imgHeight))
//        myImageView.layer.cornerRadius = imgWidth/2
        myImageView.layer.masksToBounds = true
        myImageView.image = UIImage(named: "myimg")
        myImageView.layer.borderWidth = 1
        self.view.addSubview(myImageView)
        
        let nameLabelY:CGFloat = 80+imgHeight
        let nameLabelHeight:CGFloat = 30
        let profileDetailWidth:CGFloat = self.view.frame.maxX/3*2
        let profileLabelPadding:CGFloat = 50
        
        mynameLabel = UILabelBtmBorder(frame: CGRect(x: (self.view.frame.maxX - profileDetailWidth)/2, y: nameLabelY, width: profileDetailWidth, height: nameLabelHeight))
        mynameLabel.textAlignment = NSTextAlignment.center
        mynameLabel.font = UIFont.systemFont(ofSize: 30)
        mynameLabel.text = myname
        
        oneMessageLabel = UILabel(frame: CGRect(x:0, y: nameLabelHeight*2, width: imgWidth, height: nameLabelHeight*3))
        oneMessageLabel.backgroundColor = UIColor.darkGray
        
        
        //Label :School,:Facluty,:Years ,:Favorite food, :Unfavorite food
        let aY:CGFloat = 300
        schoolField = UITextFieldBtmBorder(frame: CGRect(x: (self.view.frame.maxX - profileDetailWidth)/2, y: aY, width: profileDetailWidth, height: nameLabelHeight))
        facultyField = UITextFieldBtmBorder(frame: CGRect(x: 100, y: aY+profileLabelPadding, width: profileDetailWidth - 100 + (self.view.frame.maxX - profileDetailWidth)/2, height: nameLabelHeight))
        schoolYearField = UITextFieldBtmBorder(frame: CGRect(x: 100, y: aY+profileLabelPadding*2, width: profileDetailWidth - 100 + (self.view.frame.maxX - profileDetailWidth)/2, height: nameLabelHeight))
        favoriteFoodField = UITextFieldBtmBorder(frame: CGRect(x: (self.view.frame.maxX - profileDetailWidth)/2, y: aY+profileLabelPadding*3, width: profileDetailWidth, height: nameLabelHeight))
        unFavoriteFoodField = UITextFieldBtmBorder(frame: CGRect(x: (self.view.frame.maxX - profileDetailWidth)/2, y: aY+profileLabelPadding*4, width: profileDetailWidth, height: nameLabelHeight))
        
        schoolField.tag = 0
        facultyField.tag = 1
        schoolYearField.tag = 2
        favoriteFoodField.tag = 3
        unFavoriteFoodField.tag = 4
        
        schoolField.placeholder = mySchool
        facultyField.placeholder = myFaculty
        schoolYearField.placeholder = mySchoolYear
        favoriteFoodField.placeholder = myFavariteFood
        unFavoriteFoodField.placeholder = myUnfavariteFood
        
        schoolField.delegate = self
        facultyField.delegate = self
        schoolYearField.delegate = self
        favoriteFoodField.delegate = self
        unFavoriteFoodField.delegate = self
        

        self.view.addSubview(unFavoriteFoodField)
        self.view.addSubview(favoriteFoodField)
        self.view.addSubview(schoolYearField)
        self.view.addSubview(facultyField)
        self.view.addSubview(schoolField)
        self.view.addSubview(mynameLabel)
        
        //Button Setting
        let screenHeight = self.view.frame.height
        let screenWidth = self.view.frame.width
        
        
        saveButton = UIButton(frame: CGRect(x: screenWidth - 100, y: screenHeight-150, width: 100, height: 100))
        saveButton.layer.cornerRadius = 50
        saveButton.setTitle("Save", for: UIControlState.normal)
        saveButton.backgroundColor = UIColor.blue.withAlphaComponent(0.8)
        saveButton.addTarget(self, action: #selector(self.saveProfile(sender:)), for: UIControlEvents.touchUpInside)
        
        cancelButton = UIButton(frame: CGRect(x: 0, y: screenHeight-150, width: 100, height: 100))
        cancelButton.layer.cornerRadius = 50
        cancelButton.setTitle("Cancel", for: UIControlState.normal)
        cancelButton.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
        cancelButton.addTarget(self, action: #selector(self.cancelProfile(sender:)), for: UIControlEvents.touchUpInside)
        
        self.view.addSubview(saveButton)
        self.view.addSubview(cancelButton)
        // Do any additional setup after loading the view.
    }
    
    func saveProfile(sender:UIButton){
        //profile入力情報を保存→サーバーにPOSTして更新
        
        let ud = UserDefaults.standard
        ud.set(newmySchool, forKey: "school")
        ud.set(newmyFaculty, forKey: "faculty")
        ud.set(newmySchoolYear, forKey: "schoolyear")
        ud.set(newmyFavariteFood, forKey: "favaritefood")
        ud.set(newmyUnfavariteFood, forKey: "unfavaritefood")
        ud.synchronize()
        dismiss(animated: true, completion: nil)
    }
    
    func cancelProfile(sender:UIButton){
        
        dismiss(animated: true, completion: nil)
    }
//    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
//        print("aaa")
//    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 0:
            print("school field Changed")
            print(textField.text!)
            newmySchool = textField.text!
        case 1:
            print("faculty field Changed")
            newmyFaculty = textField.text!
        case 2:
            print("schooyear field Changed")
            newmySchoolYear = textField.text!
        case 3:
            print("favarite field Changed")
            newmyFavariteFood = textField.text!
        case 4:
            print("unfavarite field Changed")
            newmyUnfavariteFood = textField.text!
        default:
            print("default")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        switch textField.tag {
        case 0:
            print("school field")
        case 1:
            print("faculty field")
        case 2:
            print("schooyear field")
        case 3:
            print("favarite field")
        case 4:
            print("unfavarite field")
        default:
            print("default")
        }
        
        return true
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
