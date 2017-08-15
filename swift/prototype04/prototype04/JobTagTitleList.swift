//
//  test.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/05/19.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import Foundation

struct jobTagTitleList {
    var industry = ["メーカー","商社","流通","小売","インフラ","官公庁","サービス","IT","広告","マスコミ","不動産","金融","建築","教育","コンサル","保育士","医療","サービス"]
    var occupation = ["総務","経理","人事","経営企画","MR","営業","教師","公務員","デザイナー","プログラマー","PR","秘書","カスタマーサポート","研究"]
    
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
