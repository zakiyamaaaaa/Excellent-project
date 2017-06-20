//
//  UserInfo.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/06/08.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import Foundation

//自分の情報
struct UserInfo {
    var userName:String
    var uuid:String
    var sex:String
    var age:String
    var belonging:String
    var qualificatioin:String?
    var appeal:String?
    var favoriteJob:[String]?
    
    init() {
        userName = ""
        uuid = ""
        sex = ""
        age = ""
        belonging = ""
        
    }
    
    //最初の登録画面で使用
    //名前、ID、性別、年齢、所属に値が入っているかをチェック
    //すべて入っていたらtrue、入ってなかったらfalseを返す
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
    
    //使ってないけど、一応ある
    //お気に入りのしごと、アピールについて上の関数と同じ
    func checkJobValue()->Bool{
        print("job:\(String(describing: favoriteJob))")
        print("appeal:\(String(describing: appeal))")
        
        if favoriteJob?.isEmpty == false && appeal?.isEmpty == false{
            return true
        }
        
        return false
    }
    
}
