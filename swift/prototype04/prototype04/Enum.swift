//
//  jobTagType.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/05/19.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import Foundation

enum jobTagType {
    case industry
    case occupation
}

enum direction {
    case right
    case left
}

enum userDefautlsKeyList:String{
    case username =  "username"
    case job = "job"
    case background = "background"
    case qualification = "qualification"
    case uuid = "uuid"
    
    static func countCase()->Int{
        return self.uuid.hashValue + 1
    }
    
    static func maxHashValue()->Int{
        return self.uuid.hashValue
    }
}
