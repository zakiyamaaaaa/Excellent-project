//
//  User.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/08/13.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import Foundation

class User {
    
    var name:String? = UserDefaults.standard.string(forKey: userPropety.name.rawValue)
    var birth:String? = UserDefaults.standard.string(forKey: userPropety.birth.rawValue)
    var uuid:String? = UserDefaults.standard.string(forKey: userPropety.uuid.rawValue)
    var status:Int? = UserDefaults.standard.integer(forKey: userPropety.status.rawValue)
    var encounterd:[String]?
    var liked:[String]?
    var matched:[Any]?
}

class student:User{
    var education:[String]?
    var interesting:[String]?
    var goodPoint:String?
    var badPoint:String?
    var introduction:String?
    var messeage:String?
    var skill:[String]?
    var belonging:[String]?
}
