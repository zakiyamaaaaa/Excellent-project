//
//  ServerConnection.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/05/22.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import Foundation
import UIKit

struct ServerConnection {
    
    
    //未利用
    //自分の座標を投げて、近くのユーザーを取得する
    //locationVCで使用していたが、リクエストデータ返ってきた所で遷移するように、locatioinVCの中で関数を実行するように変更した
    func requestCard(uuid:String,lat:Double,lng:Double){
        let postData:[String:Any] = ["uuid":uuid,"lat":lat,"lng":lng]

        var returnData:[Any]?
        
        guard let requestURL = URL(string: "http://localhost:8888/test/updateLocation.php") else {return}
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: postData, options: .prettyPrinted)
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                do{
                    returnData = try JSONSerialization.jsonObject(with: data!, options: []) as? [Any]
                    //app deleagetに取得したデータを格納
                    let app:AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    app.cardListDelegate = returnData
                    
                }catch{
                    print("json decode error:\(error.localizedDescription)")
                }
                
            })
            
            task.resume()
        }catch{
            print("error:\(error.localizedDescription)")
        }
    }
    
    
    //ユーザー情報登録するときに実行
    func registerUser(postImage:UIImage?){
        let user = User()
        guard let status = user.status else { return }
        
        switch status {
        case 1:
            
            var postData = Recruiter().all
            if let image = postImage{
                let pngImageData = UIImagePNGRepresentation(image)! as NSData
                let encodedImageData = pngImageData.base64EncodedString(options: [])
                postData["profileImage"] = encodedImageData
                
            }
            
            let requestURL = URL(string: "http://localhost:8888/test/registerUser.php")
            var request = URLRequest(url: requestURL!)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            do{
                request.httpBody = try JSONSerialization.data(withJSONObject: postData, options: .prettyPrinted)
                let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
                    print("register my data")
                    let str = String(data:data!,encoding:.utf8)
                    print(str!)
                })
                task.resume()
                
                
            }catch{
                print("error:\(error.localizedDescription)")
                
            }
        case 2:
            
            var postData = my().all
            if let image = postImage{
                let pngImageData = UIImagePNGRepresentation(image)! as NSData
                let encodedImageData = pngImageData.base64EncodedString(options: [])
                postData["profileImage"] = encodedImageData
                
            }
            
            let requestURL = URL(string: "http://localhost:8888/test/registerUser.php")
            var request = URLRequest(url: requestURL!)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            do{
                request.httpBody = try JSONSerialization.data(withJSONObject: postData, options: .prettyPrinted)
                let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
                    print("register my data")
                    let str = String(data:data!,encoding:.utf8)
                    print(str!)
                })
                task.resume()
                
                
            }catch{
                print("error:\(error.localizedDescription)")
                
            }
        default:
            break
        }
    }
    
    func updateBeforeValid(postImage:UIImage?){
        let user = User()
        guard let status = user.status else { return }
        
        switch status {
        case 1:
            
            var postData = Recruiter().all
            if let image = postImage{
                let pngImageData = UIImagePNGRepresentation(image)! as NSData
                let encodedImageData = pngImageData.base64EncodedString(options: [])
                postData["profileImage"] = encodedImageData
                
            }
            
            let requestURL = URL(string: "http://localhost:8888/test/updateBeforeValid.php")
            var request = URLRequest(url: requestURL!)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            do{
                request.httpBody = try JSONSerialization.data(withJSONObject: postData, options: .prettyPrinted)
                let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
                    print("update my data")
                    let str = String(data:data!,encoding:.utf8)
                    print(str!)
                })
                task.resume()
                
                
            }catch{
                print("error:\(error.localizedDescription)")
                
            }
        case 2:
            
            var postData = my().all
            if let image = postImage{
                let pngImageData = UIImagePNGRepresentation(image)! as NSData
                let encodedImageData = pngImageData.base64EncodedString(options: [])
                postData["profileImage"] = encodedImageData
                
            }
            
            let requestURL = URL(string: "http://localhost:8888/test/updateBeforeValid.php")
            var request = URLRequest(url: requestURL!)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            do{
                request.httpBody = try JSONSerialization.data(withJSONObject: postData, options: .prettyPrinted)
                let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
                    print("register my data")
                    let str = String(data:data!,encoding:.utf8)
                    print(str!)
                })
                task.resume()
                
                
            }catch{
                print("error:\(error.localizedDescription)")
                
            }
        default:
            break
        }
    }
    
    func updateMyData(postImage:UIImage?)->Bool?{
        let user = User()
        guard let status = user.status else { return false}
        
        switch status {
        case 1:
            
            var postData = Recruiter().all
            if let image = postImage{
                let pngImageData = UIImagePNGRepresentation(image)! as NSData
                let encodedImageData = pngImageData.base64EncodedString(options: [])
                postData["profileImage"] = encodedImageData
                
            }
            
            let requestURL = URL(string: "http://localhost:8888/test/updateMyData.php")
            var request = URLRequest(url: requestURL!)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            do{
                var flag = false
                request.httpBody = try JSONSerialization.data(withJSONObject: postData, options: .prettyPrinted)
                let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
                    print("update my data")
                    let str = String(data:data!,encoding:.utf8)
                    if str! == "sucess" {
                        flag = true
                        
                    }
                })
                task.resume()
                
                return flag
            }catch{
                print("error:\(error.localizedDescription)")
                
            }
        case 2:
            
            var postData = my().all
            if let image = postImage{
                let pngImageData = UIImagePNGRepresentation(image)! as NSData
                let encodedImageData = pngImageData.base64EncodedString(options: [])
                postData["profileImage"] = encodedImageData
                
            }
            
            let requestURL = URL(string: "http://localhost:8888/test/updateBeforeValid.php")
            var request = URLRequest(url: requestURL!)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            do{
                request.httpBody = try JSONSerialization.data(withJSONObject: postData, options: .prettyPrinted)
                let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
                    print("register my data")
                    let str = String(data:data!,encoding:.utf8)
                    print(str!)
                })
                task.resume()
                
                
            }catch{
                print("error:\(error.localizedDescription)")
                
            }
        default:
            break
        }
        return false
    }
    
    //editvcで保存したら、自分の情報が更新される
//    func updateMyData(){
    
        //非推奨
//        let app:AppDelegate = UIApplication.shared.delegate as! AppDelegate
//        let postData:[String:Any] = app.myInfoDelegate!
//        let requestURL = URL(string: "http://localhost:8888/test/updateMyData.php")
//        var request = URLRequest(url: requestURL!)
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        do{
//            request.httpBody = try JSONSerialization.data(withJSONObject: postData, options: .prettyPrinted)
//            let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
//                print("update my data")
//                print(response)
//            })
//            task.resume()
//        }catch{
//            print("error:\(error.localizedDescription)")
//            
//        }
//    }
    
    //自分の情報を取得
    //MainVCで使用
//    func requestMyData(uuid:String)->[String:Any]{
//        let postData:[String:Any] = ["uuid":uuid]
//        
//        var dic:[String:Any]?
//        let requestURL = URL(string: "http://localhost:8888/test/requestMyData.php")
//        var request = URLRequest(url: requestURL!)
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        do{
//            request.httpBody = try JSONSerialization.data(withJSONObject: postData, options: .prettyPrinted)
//            let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
////                let str = String(data: data!, encoding:.utf8)
//                do{
////                        dic = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
//                }catch{
//                    print(error.localizedDescription)
//                }
//            })
//            task.resume()
//        }catch{
//            print("error:\(error.localizedDescription)")
//            //            return errorData
//        }
//        sleep(5)
//        return dic!
//    }
    
    func updateWhenAppInActive(){
//        let a = my()
//        var postData = a.all
        let app:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let postData:[String:Any] = app.myInfoDelegate!
        let requestURL = URL(string: "http://localhost:8888/test/updateWhenAppInactive.php")
        var request = URLRequest(url: requestURL!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: postData, options: .prettyPrinted)
            let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
                print("update my data")
                let str = String(data:data!,encoding:.utf8)
                print(str!)
            })
            task.resume()
            
            
        }catch{
            print("error:\(error.localizedDescription)")
            
        }
    }
    
    func requestMyData(inuuid:String){
        let user = User()
        guard let status = user.status else { return }
        let postData:[String:Any] = ["uuid":inuuid,"status":status]
        
        var dic:[String:Any]?
        let requestURL = URL(string: "http://localhost:8888/test/requestMyData.php")
        var request = URLRequest(url: requestURL!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: postData, options: .prettyPrinted)
            let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
                //                let str = String(data: data!, encoding:.utf8)
                do{
                    dic = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any]
                    let app:AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    app.myInfoDelegate = dic
                    
                }catch{
                    print(error.localizedDescription)
                }
            })
            task.resume()
        }catch{
            print("error:\(error.localizedDescription)")
            //            return errorData
        }
    }
    
    //自分の情報の更新
    //スワイプ結果をサーバーに投げる
    func updateMyData(mydata:[String:Any]){
        
        //myData Field
        //
        let postData = mydata
        let updateLocationURL = URL(string: "http://localhost:8888/test/updateUserSwipe03.php")
        var request = URLRequest(url: updateLocationURL!)
        
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: postData, options: .prettyPrinted)
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                print("res:\(response)")
            })
            task.resume()
        }catch{
            print("error:\(error.localizedDescription)")
            //            return errorData
        }
    }
}
