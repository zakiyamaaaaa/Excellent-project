//
//  UserDefaultSetting.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/05/19.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import Foundation

struct UserDefaultSetting {
    let ud = UserDefaults.standard
    var key:userDefautlsKeyList?
    
    //keylist
    //case username =  "username" string
    //case job = "job" [string]
    //case background = "background" string
    //case qualification = "qualification" string
    //uuid 
    
    init() {
        ud.register(defaults: [userDefautlsKeyList.username.rawValue : ""])
        ud.register(defaults: [userDefautlsKeyList.job.rawValue : [""]])
        ud.register(defaults: [userDefautlsKeyList.background.rawValue : ""])
        ud.register(defaults: [userDefautlsKeyList.qualification.rawValue : ""])
        ud.register(defaults: [userDefautlsKeyList.uuid.rawValue : ""])
    }
    
    func initialize(){
        ud.set("", forKey: userDefautlsKeyList.username.rawValue)
        ud.set("", forKey: userDefautlsKeyList.background.rawValue)
        ud.set("", forKey: userDefautlsKeyList.qualification.rawValue)
        ud.set("", forKey: userDefautlsKeyList.uuid.rawValue)
        ud.set([""], forKey: userDefautlsKeyList.job.rawValue)
    }
    
    func save(key:userDefautlsKeyList,value:String){
        
        if key == .job{
            print("Error:invalid Type Value Set")
        }
        
        ud.set(value, forKey: key.rawValue)
        print("userdefaultSave\nkey:\(key.rawValue)\nvalue:\(value)\n")
    }
    
    let jobIndustryList = jobTagTitleList.init().industry
    let jobOccupationList = jobTagTitleList.init().occupation
    //Job Fieldの保存
    func save(key:userDefautlsKeyList,value:[String]){
        
        if key != .job{
            print("Error:invalid Type Value Set")
        }
        
        for jobItem in value{
            if jobIndustryList.contains(jobItem) == false && jobOccupationList.contains(jobItem) == false{
                print("Error:Input List is Invalid")
                return
            }
        }
        
        ud.set(value, forKey: key.rawValue)
        print("userdefaultSave\nkey:\(key.rawValue)\nvalue:\(value)\n")
    }
    
    func read(key:userDefautlsKeyList)->String{
        let keyStr = key.rawValue
        print("userdefaultRead::key:\(keyStr),value:\(ud.string(forKey: keyStr)!)")
        switch key {
        case .username:
            
            return ud.string(forKey: keyStr)!
        case .background:
            return ud.string(forKey: keyStr)!
            
        case .qualification:
            return ud.string(forKey: keyStr)!
        case .uuid:
            return ud.string(forKey: keyStr)!
        default:
            print("default")
            return "default"
        }
        
    }
    
    func read(key:userDefautlsKeyList)->[String]{
        return ud.array(forKey: key.rawValue) as! [String]
    }
    
    func returnSetValue()->[String:Any]{
        var list:[String:Any] = [String:Any]()
        list[userDefautlsKeyList.username.rawValue] = ud.string(forKey: userDefautlsKeyList.username.rawValue)
        list[userDefautlsKeyList.background.rawValue] = ud.string(forKey: userDefautlsKeyList.background.rawValue)
        list[userDefautlsKeyList.qualification.rawValue] = ud.string(forKey: userDefautlsKeyList.qualification.rawValue)
        list[userDefautlsKeyList.job.rawValue] = ud.array(forKey: userDefautlsKeyList.job.rawValue)
        list[userDefautlsKeyList.uuid.rawValue] = ud.array(forKey: userDefautlsKeyList.uuid.rawValue)
        print("list:\(list)")
        return list
    }
}

struct UserDefaultSetting02 {
    let ud = UserDefaults.standard
    var key:userDefautlsKeyList02?
    
    //keylist
//    case username =  "username"
//    case job = "job"
//    case sex = "sex"
//    case age = "age"
//    case belonging = "belonging"
//    case appeal = "appeal"
//    case uuid = "uuid"
    
    init() {
        ud.register(defaults: [userDefautlsKeyList02.username.rawValue : ""])
        ud.register(defaults: [userDefautlsKeyList02.job.rawValue : [""]])
        ud.register(defaults: [userDefautlsKeyList02.sex.rawValue : ""])
        ud.register(defaults: [userDefautlsKeyList02.age.rawValue : ""])
        ud.register(defaults: [userDefautlsKeyList02.belonging.rawValue : ""])
        ud.register(defaults: [userDefautlsKeyList02.appeal.rawValue : ""])
        ud.register(defaults: [userDefautlsKeyList02.uuid.rawValue : ""])
    }
    
    func initialize(){
        ud.set("", forKey: userDefautlsKeyList02.username.rawValue)
        ud.set("", forKey: userDefautlsKeyList02.job.rawValue)
        ud.set("", forKey: userDefautlsKeyList02.sex.rawValue)
        ud.set("", forKey: userDefautlsKeyList02.age.rawValue)
        ud.set("", forKey: userDefautlsKeyList02.uuid.rawValue)
        ud.set("", forKey: userDefautlsKeyList02.appeal.rawValue)
        ud.set("", forKey: userDefautlsKeyList02.belonging.rawValue)
    }
    
    func save(key:userDefautlsKeyList02,value:String){
        
        if key == .job{
            print("Error:invalid Type Value Set")
        }
        
        ud.set(value, forKey: key.rawValue)
        print("userdefaultSave\nkey:\(key.rawValue)\nvalue:\(value)\n")
    }
    
    let jobIndustryList = jobTagTitleList.init().industry
    let jobOccupationList = jobTagTitleList.init().occupation
    
    //Job Fieldの保存
    func save(key:userDefautlsKeyList02,value:[String]){
        
        if key != .job{
            print("Error:invalid Type Value Set")
        }
        
        for jobItem in value{
            if jobIndustryList.contains(jobItem) == false && jobOccupationList.contains(jobItem) == false{
                print("Error:Input List is Invalid")
                return
            }
        }
        
        ud.set(value, forKey: key.rawValue)
        print("userdefaultSave\nkey:\(key.rawValue)\nvalue:\(value)\n")
    }
    
    func read(key:userDefautlsKeyList02)->String{
        let keyStr = key.rawValue
        print("userdefaultRead::key:\(keyStr),value:\(ud.string(forKey: keyStr))")
        switch key {
        case .username:
            return ud.string(forKey: keyStr)!
        case .sex:
            return ud.string(forKey: keyStr)!
        case .belonging:
            return ud.string(forKey: keyStr)!
        case .age:
            return ud.string(forKey: keyStr)!
        case .appeal:
            return ud.string(forKey: keyStr)!
        case .uuid:
            return ud.string(forKey: keyStr)!
        default:
            return "Error"
        }
        
    }
    //jobをよみこむ
    func read(key:userDefautlsKeyList02)->[String]{
        let keyStr = key.rawValue
        print("userdefaultRead::key:\(keyStr),value:\(ud.array(forKey: keyStr))")
        return ud.array(forKey: key.rawValue) as! [String]
        
    }
    
    func returnSetValue()->[String:Any]{
        var list:[String:Any] = [String:Any]()
        list[userDefautlsKeyList02.username.rawValue] = ud.string(forKey: userDefautlsKeyList02.username.rawValue)
        list[userDefautlsKeyList02.job.rawValue] = ud.array(forKey: userDefautlsKeyList02.job.rawValue)
        list[userDefautlsKeyList02.sex.rawValue] = ud.string(forKey: userDefautlsKeyList02.sex.rawValue)
        list[userDefautlsKeyList02.belonging.rawValue] = ud.string(forKey: userDefautlsKeyList02.belonging.rawValue)
        list[userDefautlsKeyList02.age.rawValue] = ud.string(forKey: userDefautlsKeyList02.age.rawValue)
        list[userDefautlsKeyList02.appeal.rawValue] = ud.string(forKey: userDefautlsKeyList02.appeal.rawValue)
        list[userDefautlsKeyList02.uuid.rawValue] = ud.array(forKey: userDefautlsKeyList02.uuid.rawValue)
        return list
    }
}

