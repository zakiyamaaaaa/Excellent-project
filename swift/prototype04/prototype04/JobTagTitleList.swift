//
//  test.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/05/19.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import Foundation

struct jobTagTitleList {
    var industry = ["メーカー","商社","流通","小売","インフラ","官公庁","サービス","IT","広告","マスコミ","不動産","金融","建築","教育"]
    var occupation = ["総務","経理","人事","経営企画","MR","経営コンサル","営業","保育士","教師","国家公務員","映像デザイナー","プログラマー",
                       "PR","接客","栄養士","秘書"]
    
    //リストを返す
    func getList(type:jobTagType)->[String]{
        switch type {
        case .industry:
            return industry
        case .occupation:
            return occupation
        }
    }
}
