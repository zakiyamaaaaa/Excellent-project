//
//  UIColor.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/05/11.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import Foundation
import UIKit


extension UIColor {
    
    // Twitterの水色を返します
    class func twitterColor()->UIColor{
        return UIColor.rgbColor(0x00ACED)
    }
    
    // Facebookの青色を返します
    class func facebookColor()->UIColor{
        return UIColor.rgbColor(0x305097)
    }
    
    // Lineの緑色を返します
    class func lineColor()->UIColor{
        return UIColor.rgbColor(0x5AE628)
    }
    
    // UIntからUIColorを返します　#FFFFFFのように色を指定できるようになります
    class func rgbColor(_ rgbValue: UInt) -> UIColor{
        return UIColor(
            red:   CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >>  8) / 255.0,
            blue:  CGFloat( rgbValue & 0x0000FF)        / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
