//
//  my.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/08/12.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import Foundation

enum studentPropety:String{
    case uuid
    case name
    case birth
    case status
    case encounterd
    case liked
    case matched
    case education
    case interesting
    case skill
    case goodpoint
    case badpoint
    case belonging
    case message
    case introduction
    
}


enum recruiterPropety:String{
    case uuid
    case name
    case birth
    case status
    case encounterd
    case liked
    case matched
    case education
    case interesting
    case skill
    case ogori
    case message
    case position
    case introduction
    case career
    case company_id
    case company_link
    case company_name
    case company_population
    case company_introduction
    case company_industry
    case company_feature
    case company_recruitment
    
}

enum userPropety:String{
    case uuid
    case name
    case birth
    case status
}

struct my {
    
    var name:String? = UserDefaults.standard.string(forKey: studentPropety.name.rawValue)
    var birth:String? = UserDefaults.standard.string(forKey: studentPropety.birth.rawValue)
    var education:[Any]? = UserDefaults.standard.array(forKey: studentPropety.education.rawValue)
    var interesting:[Any]? = UserDefaults.standard.stringArray(forKey: studentPropety.interesting.rawValue)
    var skill:[Any]? = UserDefaults.standard.stringArray(forKey: studentPropety.skill.rawValue)
    var belonging:[String]? = UserDefaults.standard.stringArray(forKey: studentPropety.belonging.rawValue)
    var goodpoint:String? = UserDefaults.standard.string(forKey: studentPropety.goodpoint.rawValue)
    var badpoint:String? = UserDefaults.standard.string(forKey: studentPropety.badpoint.rawValue)
    var encountered:[String]? = UserDefaults.standard.stringArray(forKey: studentPropety.encounterd.rawValue)
    var liked:[String]? = UserDefaults.standard.stringArray(forKey: studentPropety.liked.rawValue)
    var matched:[Any]? = UserDefaults.standard.array(forKey: studentPropety.matched.rawValue)
    var status:Int? = UserDefaults.standard.integer(forKey: studentPropety.status.rawValue)
    var message:String? = UserDefaults.standard.string(forKey: studentPropety.message.rawValue)
    var introduction:String? = UserDefaults.standard.string(forKey: studentPropety.introduction.rawValue)
    
    var uuid:String? = UserDefaults.standard.string(forKey: studentPropety.uuid.rawValue)
    var all:[String:Any?]
    
    init() {
        
        
        let a = studentPropety.self
        
        all = [a.uuid.rawValue:uuid,
               a.name.rawValue:name,
               a.birth.rawValue:birth,
               a.education.rawValue:education,
               a.interesting.rawValue:interesting,
               a.skill.rawValue:skill,
               a.belonging.rawValue:belonging,
               a.encounterd.rawValue:encountered,
               a.liked.rawValue:liked,
               a.status.rawValue:status,
               a.matched.rawValue:matched,
               a.message.rawValue:message,
               a.introduction.rawValue:introduction]
//        if all[a.name.rawValue] != nil{
//            name = name!
//        }
        print("my:\(all)")
    }
    
    mutating func register(key:studentPropety,value:Any?){
        
        
        UserDefaults.standard.set(value, forKey: key.rawValue)
        print("localにkey:\(key)value:\(value)を保存しました")
        
        switch key {
        case .name:
            name = value as? String
        case .birth:
            birth = value as? String
        case .uuid:
            uuid = value as? String
        case .education:
            education = value as? [Any]
        case .encounterd:
            encountered = value as? [String]
        case .liked:
            liked = value as? [String]
        case .matched:
            matched = value as? [String]
        case .belonging:
            belonging = value as? [String]
        case .message:
            message = value as? String
        case .goodpoint:
            goodpoint = value as? String
        case .badpoint:
            badpoint = value as? String
        case .introduction:
            introduction = value as? String
        case .interesting:
            interesting = value as? [String]
        case .skill:
            skill = value as? [String]
        case .status:
            status = value as? Int
        }
        
        all = [key.rawValue:value]
        
    }
    
    func getValue(key:studentPropety)->Any?{
        
        switch key {
        case .uuid:
            
//            uuid = ud.string(forKey: key.rawValue)
            return uuid
        case .name:
//            name = ud.string(forKey: key.rawValue)
            return name
        case .birth:
//            birth = ud.string(forKey: key.rawValue)
            return birth
        case .encounterd:
//            encountered = ud.stringArray(forKey: key.rawValue)
            return encountered
        case .liked:
//            liked = ud.stringArray(forKey: key.rawValue)
            return liked
        case .matched:
//            matched = ud.array(forKey: key.rawValue)
            return matched
        case .education:
//            education = ud.array(forKey: key.rawValue)
            return education
        case .interesting:
//            interesting = ud.stringArray(forKey: key.rawValue)
            return interesting
        case .skill:
//            skill = ud.stringArray(forKey: key.rawValue)
            return skill
        case .belonging:
//            belonging = ud.stringArray(forKey: key.rawValue)
            return belonging
        case .message:
//            message = ud.string(forKey: key.rawValue)
            return message
        case .status:
            return status
        case .introduction:
//            introduction = ud.string(forKey: key.rawValue)
            return introduction
        case .goodpoint:
            return goodpoint
        case .badpoint:
            return badpoint
        }
    }
}

struct Recruiter{
    
    var uuid:String? = UserDefaults.standard.string(forKey: studentPropety.uuid.rawValue)
    var name:String? = UserDefaults.standard.string(forKey: studentPropety.name.rawValue)
    var birth:String? = UserDefaults.standard.string(forKey: studentPropety.birth.rawValue)
    var education:[Any]? = UserDefaults.standard.array(forKey: studentPropety.education.rawValue)
    var interesting:[Any]? = UserDefaults.standard.stringArray(forKey: studentPropety.interesting.rawValue)
    var skill:[String]? = UserDefaults.standard.stringArray(forKey: studentPropety.skill.rawValue)
    var encountered:[String]? = UserDefaults.standard.stringArray(forKey: studentPropety.encounterd.rawValue)
    var liked:[String]? = UserDefaults.standard.stringArray(forKey: studentPropety.liked.rawValue)
    var matched:[Any]? = UserDefaults.standard.array(forKey: studentPropety.matched.rawValue)
    var status:Int? = UserDefaults.standard.integer(forKey: studentPropety.status.rawValue)
    var message:String? = UserDefaults.standard.string(forKey: studentPropety.message.rawValue)
    var introduction:String? = UserDefaults.standard.string(forKey: studentPropety.introduction.rawValue)
    
    var all:[String:Any?]
    var ogori:[Int]? = UserDefaults.standard.array(forKey: recruiterPropety.ogori.rawValue) as? [Int]
    var position:String? = UserDefaults.standard.string(forKey: recruiterPropety.position.rawValue)
    var career:[Any]? = UserDefaults.standard.array(forKey: recruiterPropety.career.rawValue)
    var company_id:String? =  UserDefaults.standard.string(forKey: recruiterPropety.company_id.rawValue)
    var company_link:String? =  UserDefaults.standard.string(forKey: recruiterPropety.company_link.rawValue)
    var company_name:String? = UserDefaults.standard.string(forKey: recruiterPropety.company_name.rawValue)
    var company_population:Int? =  UserDefaults.standard.integer(forKey: recruiterPropety.company_population.rawValue)
    var company_introduction:String? =  UserDefaults.standard.string(forKey: recruiterPropety.company_introduction.rawValue)
    var company_industry:String? =  UserDefaults.standard.string(forKey: recruiterPropety.company_industry.rawValue)
    var company_feature:[String]? =  UserDefaults.standard.stringArray(forKey: recruiterPropety.company_feature.rawValue)
    var company_recruitment:[String]? =  UserDefaults.standard.stringArray(forKey: recruiterPropety.company_recruitment.rawValue)
    
    init() {
        
        
        let a = recruiterPropety.self
        
        all = [a.uuid.rawValue:uuid,
               a.name.rawValue:name,
               a.birth.rawValue:birth,
               a.status.rawValue:status,
               a.skill.rawValue:skill,
               a.education.rawValue:education,
               a.interesting.rawValue:interesting,
               a.position.rawValue:position,
               a.ogori.rawValue:ogori,
               a.company_id.rawValue:company_id,
               a.company_feature.rawValue:company_feature,
               a.company_name.rawValue:company_name,
               a.company_link.rawValue:company_link,
               a.company_industry.rawValue:company_industry,
               a.company_recruitment.rawValue:company_recruitment,
               a.company_population.rawValue:company_population,
               a.encounterd.rawValue:encountered,
               a.liked.rawValue:liked,
               a.matched.rawValue:matched,
               a.message.rawValue:message,
               a.introduction.rawValue:introduction]
        
        print("my:\(all)")
    }
    
    mutating func register(key:recruiterPropety,value:Any){
        
        UserDefaults.standard.set(value, forKey: key.rawValue)
        print("localにkey:\(key)value:\(value)を保存しました")
        
//        switch key {
//        case .name:
//            name = value as? String
//        case .birth:
//            birth = value as? String
//        case .uuid:
//            uuid = value as? String
//        case .education:
//            education = value as? [Any]
//        case .encounterd:
//            encountered = value as? [String]
//        case .liked:
//            liked = value as? [String]
//        case .matched:
//            matched = value as? [String]
//        case .message:
//            message = value as? String
//        case .introduction:
//            introduction = value as? String
//        case .interesting:
//            interesting = value as? [String]
//        case .skill:
//            skill = value as? [String]
//        case .status:
//            status = value as? Int
//        }
//        
//        all = [key.rawValue:value]
        
    }
    
//    func getValue(key:studentPropety)->Any?{
//        
//        switch key {
//        case .uuid:
//            
//            //            uuid = ud.string(forKey: key.rawValue)
//            return uuid
//        case .name:
//            //            name = ud.string(forKey: key.rawValue)
//            return name
//        case .birth:
//            //            birth = ud.string(forKey: key.rawValue)
//            return birth
//        case .encounterd:
//            //            encountered = ud.stringArray(forKey: key.rawValue)
//            return encountered
//        case .liked:
//            //            liked = ud.stringArray(forKey: key.rawValue)
//            return liked
//        case .matched:
//            //            matched = ud.array(forKey: key.rawValue)
//            return matched
//        case .education:
//            //            education = ud.array(forKey: key.rawValue)
//            return education
//        case .interesting:
//            //            interesting = ud.stringArray(forKey: key.rawValue)
//            return interesting
//        case .skill:
//            //            skill = ud.stringArray(forKey: key.rawValue)
//            return skill
//        case .message:
//            //            message = ud.string(forKey: key.rawValue)
//            return message
//        case .status:
//            return status
//        case .introduction:
//            //            introduction = ud.string(forKey: key.rawValue)
//            return introduction
//        }
//    }
}

