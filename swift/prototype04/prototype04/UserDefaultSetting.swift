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


