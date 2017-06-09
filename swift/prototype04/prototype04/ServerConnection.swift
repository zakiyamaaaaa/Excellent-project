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
    func requestCard(uuid:String,lat:Double,lng:Double){
        let postData:[String:Any] = ["uuid":uuid,"lat":lat,"lng":lng]
//        let errorData:Data = Data()
//        var returnData:Data = Data()
        var returnData:[Any]?
        
        guard let updateLocationURL = URL(string: "http://52.163.126.71/test/updateLocation.php") else {return}
        var request = URLRequest(url: updateLocationURL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: postData, options: .prettyPrinted)
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
//                let str = String(data: data!, encoding:.utf8)
//                print("lat:\(lat),lng:\(lng),data:\(str),res:\(response)\n,uuid:\(uuid)")
//            returnData = data!
                do{
                    returnData = try JSONSerialization.jsonObject(with: data!, options: []) as? [Any]
                    
                    let app:AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    app.cardListDelegate = returnData
                    print("setted")
                }catch{
                    print("json decode error:\(error.localizedDescription)")
                }
                
            })
            
            task.resume()
        }catch{
            print("error:\(error.localizedDescription)")
        }
    }
    
    func getMyData(uuid:String)->[String:Any]{
        let postData:[String:Any] = ["uuid":uuid]
        
        var dic:[String:Any]?
        let updateLocationURL = URL(string: "http://52.163.126.71/test/requestMyData.php")
        var request = URLRequest(url: updateLocationURL!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: postData, options: .prettyPrinted)
            let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
//                let str = String(data: data!, encoding:.utf8)
                do{
                        dic = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                }catch{
                    print(error.localizedDescription)
                }
            })
            task.resume()
        }catch{
            print("error:\(error.localizedDescription)")
            //            return errorData
        }
        sleep(5)
        return dic!
    }
    
    func updateMyData(mydata:[String:Any]){
        
        //myData Field
        //
        let postData = mydata
        let updateLocationURL = URL(string: "http://52.163.126.71/test/updateUserSwipe03.php")
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
