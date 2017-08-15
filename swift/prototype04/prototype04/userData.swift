//
//  userData.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/07/28.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import Foundation

class userData{
    
    var setId:String
    var setName:String?
    var setDate:Date?
    var setCompanyName:String?
    var setPosition:String?
    var setSkill:[String]?
    var setOgori:[Int]?
    var setMessage:String?
    var setSelfIntro:String?
    var setCompanyId:String?
    var setNumberOfCompany:Int?
    var setIndustry:String?
    var setCareer:[Any]?
    var setCompanyIntro:String?
    var setCompanyFeature:[String]?
    var setRecruitment:[String]?
    
    init(id:String,//0
         name:String,//1
         birth:Date,//2
         companyName:String?,//3
         positioin:String?,//4
         skill:[String]?,//5
         ogori:[Int]?,//6
         message:String?,//7
         selfIntro:String?,//8
         companyId:String?,//9
         numberOfCompany:Int?,//10
         industry:String?,//11
         career:[Any]?,//12
         companyIntro:String?,//13
         companyFeature:[String]?,//14
         recruitment:[String]?//15
        ) {
        
        setId = id
        setName = name
        setDate = birth
        setCompanyName = companyName
        setPosition = positioin
        setSkill = skill
        setOgori = ogori
        setMessage = message
        setIndustry = industry
        setSelfIntro = selfIntro
        setNumberOfCompany = numberOfCompany
        setCompanyId = companyId
        setCareer = career
        setCompanyIntro = companyIntro
        setCompanyFeature = companyFeature
        setRecruitment = recruitment
        
    }
    
}
