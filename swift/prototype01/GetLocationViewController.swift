//
//  GetLocationViewController.swift
//  prototype01
//
//  Created by shoichiyamazaki on 2017/04/16.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit
import CoreLocation

class GetLocationViewController: UIViewController, CLLocationManagerDelegate{

    var myLocationManager:CLLocationManager!
    
    var userName:String = "default"
    var userId:String = "default"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ud = UserDefaults.standard
        
        
        //UserDefaultからユーザー情報引き出し
        if ud.object(forKey: "username") != nil{
            userName = ud.string(forKey: "username")!
        }else{
            print("no set username in ud")
        }
        
        if ud.object(forKey: "uid") != nil{
                userId = ud.string(forKey: "uid")!
        }else{
            print("no set uid in ud")
        }
        
        
        
        let locationState = CLLocationManager.authorizationStatus()
        if locationState == CLAuthorizationStatus.restricted || locationState == CLAuthorizationStatus.denied{
            return
        }
        
        myLocationManager = CLLocationManager()
        myLocationManager.delegate = self
        
        if locationState == CLAuthorizationStatus.notDetermined{
            myLocationManager.requestWhenInUseAuthorization()
        }
        
        if !CLLocationManager.locationServicesEnabled(){
            return
        }
        
        myLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        myLocationManager.distanceFilter = kCLDistanceFilterNone
        myLocationManager.requestLocation()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //ロケーション取得→データPOST→ロケーション近い人のデータが返ってくる
        //メイン画面へ
        
        if let location = manager.location{
            let myLatitude = location.coordinate.latitude
            let myLongitude = location.coordinate.longitude
            
            let myData:[String:Any] = ["uid":self.userId,"username":self.userName, "lat":myLatitude, "lng":myLongitude]
            requestCandidate(myData)
        }
        
    }
    
    func requestCandidate(_ data:Any){
        let urlString = "http://localhost:8888/test/MainViewWithFunction.php"
        let request = NSMutableURLRequest(url: URL(string: urlString)!)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: data, options: JSONSerialization.WritingOptions.prettyPrinted)
            let task:URLSessionDataTask = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (resData, res, error) in
                
            })
            task.resume()
        }catch{
            
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
