////
////  RadialGradientLayer.swift
////  prototype04
////
////  Created by shoichiyamazaki on 2017/05/18.
////  Copyright © 2017年 shoichiyamazaki. All rights reserved.
////
//
//import UIKit
//
//class RadialGradientLayer: CALayer {
//    override init(){
//        
//        super.init()
//        
//        needsDisplayOnBoundsChange = true
//    }
//    
//    init(center:CGPoint,radius:CGFloat,colors:[CGColor]){
//        
//        self.center = center
//        self.radius = radius
//        self.colors = colors
//        
//        super.init()
//        
//    }
//    
//    required init(coder aDecoder: NSCoder) {
//        
//        super.init()
//        
//    }
//    
//    var center:CGPoint = CGPoint(x: 50, y: 50)
//    var radius:CGFloat = 20
//    var colors:[CGColor] = [UIColor(red: 251/255, green: 237/255, blue: 33/255, alpha: 1.0).cgColor , UIColor(red: 251/255, green: 179/255, blue: 108/255, alpha: 1.0).cgColor]
//    
//    override func draw(in ctx: CGContext!) {
//        
//        ctx.saveGState()
//        
//        var colorSpace = CGColorSpaceCreateDeviceRGB()
//        
//        var locations:[CGFloat] = [0.0, 1.0]
//        
////        var gradient = CGGradientCreateWithColors(colorSpace, colors as CFArray, [0.0,1.0])
//        var gradient = CGGradient.init(colorsSpace: colorSpace, colors: colors, locations: locations)
//        
//        var startPoint = CGPoint(x: 0, y: self.bounds.height)
//        var endPoint = CGPoint(x: self.bounds.width, y: self.bounds.height)
//        CGContext.drawRadialGradient(ctx)
////        CGContextDrawRadialGradient(ctx, gradient!, center, 0.0, center, radius, 0)
//        
//    }
//    
//}
//
//}
