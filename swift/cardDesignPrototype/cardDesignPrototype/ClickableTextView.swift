//
//  ClickableTextView.swift
//  webLinkTest
//
//  Created by shoichiyamazaki on 2017/06/09.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class ClickableTextView: UITextView {
    
    
    var tap:UITapGestureRecognizer!
    override public init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        print("init")
        setup()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.textContainer.lineFragmentPadding = 0
        self.textContainerInset = UIEdgeInsets.zero
        setup()
    }
    
    
    func setup(){
        
        // Add tap gesture recognizer to Text View
        tap = UITapGestureRecognizer(target: self, action: #selector(self.myMethodToHandleTap(sender:)))
        //        tap.delegate = self
        self.addGestureRecognizer(tap)
    }
    
    func myMethodToHandleTap(sender: UITapGestureRecognizer){
        
        let myTextView = sender.view as! UITextView
        let layoutManager = myTextView.layoutManager
        
        // location of tap in myTextView coordinates and taking the inset into account
        var location = sender.location(in: myTextView)
        location.x -= myTextView.textContainerInset.left;
        location.y -= myTextView.textContainerInset.top;
        
        
        // character index at tap location
        let characterIndex = layoutManager.characterIndex(for: location, in: myTextView.textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        // if index is valid then do something.
        if characterIndex < myTextView.textStorage.length {
            
            let orgString = myTextView.attributedText.string
            
            
            //Find the WWW
            var didFind = false
            var count:Int = characterIndex
            while(count > 2 && didFind == false){
                
                let myRange = NSRange(location: count-1, length: 2)
                let substring = (orgString as NSString).substring(with: myRange)
                
                //                print(substring,count)
                
                if substring == " w" || (substring  == "w." && count == 3){
                    didFind = true
                    //                    print("Did find",count)
                    
                    var count2 = count
                    while(count2 < orgString.characters.count){
                        
                        let myRange = NSRange(location: count2 - 1, length: 2)
                        let substring = (orgString as NSString).substring(with: myRange)
                        
                        //                        print("Did 2",count2,substring)
                        count2 += 1
                        
                        
                        //If it was at the end of textView
                        if count2  == orgString.characters.count {
                            
                            let length = orgString.characters.count - count
                            let myRange = NSRange(location: count, length: length)
                            
                            let substring = (orgString as NSString).substring(with: myRange)
                            
                            openLink(link: substring)
                            print("It's a Link",substring)
                            return
                        }
                        
                        //If it's in the middle
                        
                        if substring.hasSuffix(" "){
                            
                            let length =  count2 - count
                            let myRange = NSRange(location: count, length: length)
                            
                            let substring = (orgString as NSString).substring(with: myRange)
                            
                            openLink(link: substring)
                            print("It's a Link",substring)
                            
                            return
                        }
                        
                    }
                    
                    return
                }
                
                
                if substring.hasPrefix(" "){
                    
                    print("Not a link")
                    return
                }
                
                count -= 1
                
            }
            
            
        }
        
        
    }
    
    
    func openLink(link:String){
        
        if let checkURL = URL(string: "http://\(link.replacingOccurrences(of: " ", with: ""))") {
            if UIApplication.shared.canOpenURL(checkURL) {
                UIApplication.shared.open(checkURL, options: [:], completionHandler: nil)
                
                print("url successfully opened")
            }
        } else {
            print("invalid url")
        }
    }
    
    
    public override func didMoveToWindow() {
        if self.window == nil{
            self.removeGestureRecognizer(tap)
            print("ClickableTextView View removed from")
        }
    }
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
