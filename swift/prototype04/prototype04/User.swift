//
//  User.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/08/13.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import Foundation

class User {
    
    var property:[String:Any?]
    init() {
        let a = studentPropety.self
        
        property = [a.uuid.getString():nil,
                    a.name.getString():nil,
                    a.birth.getString():nil,
                    a.education.getString():nil]
    }
    
}
