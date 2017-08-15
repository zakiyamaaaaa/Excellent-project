//
//  my.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/08/12.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import Foundation

enum studentPropety{
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
    
    func getString()->String{
        switch self {
        case .uuid:
            return "uuid"
        case .name:
            return "name"
        case .birth:
            return "birth"
        case .status:
            return "status"
        case .encounterd:
            return "encounterd"
        case .liked:
            return "liked"
        case .matched:
            return "matched"
        case .goodpoint:
            return "my_goodpoint"
        case .badpoint:
            return "my_badpoint"
        case .education:
            return "education"
        case .interesting:
            return "interesting"
        case .skill:
            return "skill"
        case .belonging:
            return "belonging"
        case .message:
            return "message"
        case .introduction:
            return "introduction"
        }
    }
}

enum recruiterPropety{
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
    case goodpoint
    case badpoint
    case belonging
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
    
    func getString()->String{
        switch self {
        case .uuid:
            return "uuid"
        case .name:
            return "name"
        case .birth:
            return "birth"
        case .status:
            return "status"
        case .encounterd:
            return "encounterd"
        case .liked:
            return "liked"
        case .matched:
            return "matched"
        case .goodpoint:
            return "my_goodpoint"
        case .badpoint:
            return "my_badpoint"
        case .education:
            return "education"
        case .interesting:
            return "interesting"
        case .skill:
            return "skill"
        case .ogori:
            return "ogori"
        case .belonging:
            return "belonging"
        case .position:
            return "position"
        case .message:
            return "message"
        case .introduction:
            return "introduction"
        case .career:
            return "career"
        case .company_id:
            return "company_id"
        case .company_link:
            return "company_link"
        case .company_id:
            return "company_id"
        case .company_name:
            return "company_name"
        case .company_population:
            return "company_population"
        case .company_industry:
            return "company_industry"
        case .company_introduction:
            return "company_introduction"
        case .company_feature:
            return "company_feature"
        case .company_recruitment:
            return "company_recruitment"
            
        }
    }
}

enum recruiterPropety2:String{
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
    case goodpoint
    case badpoint
    case belonging
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

struct my {
    let ud = UserDefaults.standard
    var name:String? = UserDefaults.standard.string(forKey: studentPropety.name.getString())
    var birth:String? = UserDefaults.standard.string(forKey: studentPropety.birth.getString())
    var education:[Any]? = UserDefaults.standard.array(forKey: studentPropety.education.getString())
    var interesting:[Any]? = UserDefaults.standard.stringArray(forKey: studentPropety.interesting.getString())
    var skill:[Any]? = UserDefaults.standard.stringArray(forKey: studentPropety.skill.getString())
    var belonging:[String]? = UserDefaults.standard.stringArray(forKey: studentPropety.belonging.getString())
    var goodpoint:String? = UserDefaults.standard.string(forKey: studentPropety.goodpoint.getString())
    var badpoint:String? = UserDefaults.standard.string(forKey: studentPropety.badpoint.getString())
    var encountered:[String]? = UserDefaults.standard.stringArray(forKey: studentPropety.encounterd.getString())
    var liked:[String]? = UserDefaults.standard.stringArray(forKey: studentPropety.liked.getString())
    var matched:[Any]? = UserDefaults.standard.array(forKey: studentPropety.matched.getString())
    var status:Int? = UserDefaults.standard.integer(forKey: studentPropety.interesting.getString())
    var message:String? = UserDefaults.standard.string(forKey: studentPropety.message.getString())
    var introduction:String? = UserDefaults.standard.string(forKey: studentPropety.introduction.getString())
    var uuid:String? = UserDefaults.standard.string(forKey: studentPropety.uuid.getString())
    var all:[String:Any?]
    
    init() {
        
        
        let a = studentPropety.self
        
        all = [a.uuid.getString():uuid,
               a.name.getString():name,
               a.birth.getString():birth,
               a.education.getString():education,
               a.interesting.getString():interesting,
               a.skill.getString():skill,
               a.belonging.getString():belonging,
               a.encounterd.getString():encountered,
               a.liked.getString():liked,
               a.matched.getString():matched,
               a.message.getString():message,
               a.introduction.getString():introduction]
        if all[a.name.getString()] != nil{
            name = name!
        }
        print("my:\(all)")
    }
    
    
    
    mutating func register(key:studentPropety,value:Any){
        
        ud.set(value, forKey: key.getString())
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
        
        all = [key.getString():value]
        
    }
    
    func getValue(key:studentPropety)->Any?{
        
        switch key {
        case .uuid:
            
//            uuid = ud.string(forKey: key.getString())
            return uuid
        case .name:
//            name = ud.string(forKey: key.getString())
            return name
        case .birth:
//            birth = ud.string(forKey: key.getString())
            return birth
        case .encounterd:
//            encountered = ud.stringArray(forKey: key.getString())
            return encountered
        case .liked:
//            liked = ud.stringArray(forKey: key.getString())
            return liked
        case .matched:
//            matched = ud.array(forKey: key.getString())
            return matched
        case .education:
//            education = ud.array(forKey: key.getString())
            return education
        case .interesting:
//            interesting = ud.stringArray(forKey: key.getString())
            return interesting
        case .skill:
//            skill = ud.stringArray(forKey: key.getString())
            return skill
        case .belonging:
//            belonging = ud.stringArray(forKey: key.getString())
            return belonging
        case .message:
//            message = ud.string(forKey: key.getString())
            return message
        case .status:
            return status
        case .introduction:
//            introduction = ud.string(forKey: key.getString())
            return introduction
        case .goodpoint:
            return goodpoint
        case .badpoint:
            return badpoint
        }
    }
}
