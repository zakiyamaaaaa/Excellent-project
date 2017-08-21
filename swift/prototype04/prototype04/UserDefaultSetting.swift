//
//  UserDefaultSetting.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/05/19.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import Foundation

//新しいやつ
struct UserDefaultSetting{
    let ud = UserDefaults.standard
    
    
    //keylist
//    case username =  "username"
//    case job = "job"
//    case sex = "sex"
//    case age = "age"
//    case belonging = "belonging"
//    case appeal = "appeal"
//    case uuid = "uuid"
    
//    init() {
//        ud.register(defaults: [userDefautlsKeyList.username.rawValue : ""])
//        ud.register(defaults: [userDefautlsKeyList.job.rawValue : [""]])
//        ud.register(defaults: [userDefautlsKeyList.sex.rawValue : ""])
//        ud.register(defaults: [userDefautlsKeyList.age.rawValue : ""])
//        ud.register(defaults: [userDefautlsKeyList.belonging.rawValue : ""])
//        ud.register(defaults: [userDefautlsKeyList.appeal.rawValue : ""])
//        ud.register(defaults: [userDefautlsKeyList.uuid.rawValue : ""])
//    }
//    
//    func initialize(){
//        ud.set("", forKey: userDefautlsKeyList.username.rawValue)
//        ud.set("", forKey: userDefautlsKeyList.job.rawValue)
//        ud.set("", forKey: userDefautlsKeyList.sex.rawValue)
//        ud.set("", forKey: userDefautlsKeyList.age.rawValue)
//        ud.set("", forKey: userDefautlsKeyList.uuid.rawValue)
//        ud.set("", forKey: userDefautlsKeyList.appeal.rawValue)
//        ud.set("", forKey: userDefautlsKeyList.belonging.rawValue)
//    }
//    
//    //job以外を書き込み
//    func write(key:userDefautlsKeyList,value:String){
//        
//        if key == .job{
//            print("Error:invalid Type Value Set")
//            return
//        }
//        
//        ud.set(value, forKey: key.rawValue)
//        print("userdefaultSave\nkey:\(key.rawValue)\nvalue:\(value)\n")
//    }
//    
//    let jobIndustryList = jobTagTitleList.init().industry
//    let jobOccupationList = jobTagTitleList.init().occupation
//    
//    //Job Fieldの保存
//    func write(key:userDefautlsKeyList,value:[String]){
//        
//        if key != .job{
//            print("Error:invalid Type Value Set")
//        }
//        
//        for jobItem in value{
//            if jobIndustryList.contains(jobItem) == false && jobOccupationList.contains(jobItem) == false{
//                print("Error:Input List is Invalid")
//                return
//            }
//        }
//        
//        ud.set(value, forKey: key.rawValue)
//        print("userdefaultSave\nkey:\(key.rawValue)\nvalue:\(value)\n")
//    }
//    
//    func read(key:userDefautlsKeyList)->String{
//        let keyStr = key.rawValue
//        print("userdefaultRead::key:\(keyStr),value:\(ud.string(forKey: keyStr))")
//        switch key {
//        case .username:
//            return ud.string(forKey: keyStr)!
//        case .sex:
//            return ud.string(forKey: keyStr)!
//        case .belonging:
//            return ud.string(forKey: keyStr)!
//        case .age:
//            return ud.string(forKey: keyStr)!
//        case .appeal:
//            return ud.string(forKey: keyStr)!
//        case .uuid:
//            return ud.string(forKey: keyStr)!
//        default:
//            return "Error"
//        }
//        
//    }
//    //jobをよみこむ
//    func read(key:userDefautlsKeyList)->[String]{
//        let keyStr = key.rawValue
//        print("userdefaultRead::key:\(keyStr),value:\(ud.array(forKey: keyStr))")
//        
//        if ud.array(forKey: key.rawValue) == nil{
//            return [""]
//        }
//        
//        return ud.array(forKey: key.rawValue) as! [String]
//    }
//    
//    func returnSetValue()->[String:Any]{
//        var list:[String:Any] = [String:Any]()
//        list[userDefautlsKeyList.username.rawValue] = ud.string(forKey: userDefautlsKeyList.username.rawValue)
//        list[userDefautlsKeyList.job.rawValue] = ud.array(forKey: userDefautlsKeyList.job.rawValue)
//        list[userDefautlsKeyList.sex.rawValue] = ud.string(forKey: userDefautlsKeyList.sex.rawValue)
//        list[userDefautlsKeyList.belonging.rawValue] = ud.string(forKey: userDefautlsKeyList.belonging.rawValue)
//        list[userDefautlsKeyList.age.rawValue] = ud.string(forKey: userDefautlsKeyList.age.rawValue)
//        list[userDefautlsKeyList.appeal.rawValue] = ud.string(forKey: userDefautlsKeyList.appeal.rawValue)
//        list[userDefautlsKeyList.uuid.rawValue] = ud.array(forKey: userDefautlsKeyList.uuid.rawValue)
//        return list
//    }
}

