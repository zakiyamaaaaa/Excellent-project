//
//  jobTagType.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/05/19.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//


//Enum で定義している型をまとめたファイル


import Foundation

//job tagに使用
enum jobTagType {
    case industry
    case occupation
}

//swipeの方向に使用
enum direction {
    case right
    case left
}

//前のユーザのキーリスト
//enum userDefautlsKeyList:String{
//    case username =  "username"
//    case job = "job"
//    case background = "background"
//    case qualification = "qualification"
//    case uuid = "uuid"
//    
//    static func countCase()->Int{
//        return self.uuid.hashValue + 1
//    }
//    
//    static func maxHashValue()->Int{
//        return self.uuid.hashValue
//    }
//}

//いまのユーザのキーリスト
enum userDefautlsKeyList:String{
    case username =  "username"
    case job = "job"
    case sex = "sex"
    case age = "age"
    case belonging = "belonging"
    case appeal = "appeal"
    case uuid = "uuid"
    
    static func countCase()->Int{
        return self.uuid.hashValue + 1
    }
    
    static func maxHashValue()->Int{
        return self.uuid.hashValue
    }
}
