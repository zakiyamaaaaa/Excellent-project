//
//  UserInfo.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/06/08.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import Foundation

struct UserInfo {
    var userName:String
    var uuid:String
    var sex:String
    var age:String
    var belonging:String
    var qualificatioin:String?
    var selfAppeal:String?
    var favoriteJob:[String]?
    
    init() {
        userName = ""
        uuid = ""
        sex = ""
        age = ""
        belonging = ""
        
    }
    
    func checkValue()->Bool{
        print("username:\(userName)")
        print("uuid:\(uuid)")
        print("sex:\(sex)")
        print("age:\(age)")
        print("belonging:\(belonging)")
        
        
        if userName.isEmpty == false && uuid.isEmpty == false && sex.isEmpty == false && belonging.isEmpty == false && age.isEmpty == false{
            return true
        }
        print("足りない項目があります")
        return false
    }
    
    func checkJobValue()->Bool{
        print("job:\(favoriteJob)")
        print("appea:\(selfAppeal)")
        
        return false
    }
    
}
