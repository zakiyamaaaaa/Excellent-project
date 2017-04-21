//
//  SearchLocationViewController.swift
//  prototype01
//
//  Created by shoichiyamazaki on 2017/04/19.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit
import CoreLocation

class SearchLocationViewController: UIViewController, CLLocationManagerDelegate {

    var myLocationManager:CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let status = CLLocationManager.authorizationStatus()
        if status == CLAuthorizationStatus.restricted || status == CLAuthorizationStatus.denied{
            return
        }
        
        myLocationManager = CLLocationManager()
        myLocationManager.delegate = self
        
        if status == CLAuthorizationStatus.notDetermined{
            myLocationManager.requestWhenInUseAuthorization()
        }
        
        if !CLLocationManager.locationServicesEnabled(){
            return
        }
        
        myLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        myLocationManager.distanceFilter = kCLDistanceFilterNone
        myLocationManager.requestLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let ud = UserDefaults.standard
        guard let my_uid = ud.string(forKey: "uid") else {return}
        
        guard let location = manager.location else { return }
        let my_lat = location.coordinate.latitude
        let my_lng = location.coordinate.longitude
        print("my_id:\(my_uid)")
        print("my_lat:\(my_lat)")
        print("my_lng:\(my_lng)")
        
        updateMylocation(uuid: my_uid, lat: my_lat, lng: my_lng)
        
    }
    
    func updateMylocation(uuid:String,lat:Double, lng:Double){
        let postLocationData:[String:Any] = ["uid":uuid,"lat":lat,"lng":lng]
        
        guard let urlString = URL(string: "http://localhost:8888/test/updateLocation.php") else {return}
        var request = URLRequest(url: urlString)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: postLocationData, options: JSONSerialization.WritingOptions.prettyPrinted)
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                let str = String(data: data! ,encoding: .utf8)
                print("data:\(data)")
                print("str:\(str)")
                print("response:\(response!)")
                //近くのユーザー情報取得後、画面遷移
                
            })
            task.resume()
        }catch{
            print("Error:\(error.localizedDescription)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }

    @IBAction func searchLocationButton(_ sender: Any) {
        
        
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
