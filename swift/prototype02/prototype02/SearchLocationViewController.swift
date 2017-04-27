//
//  SearchLocationViewController.swift
//  prototype02
//
//  Created by shoichiyamazaki on 2017/04/24.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit
import CoreLocation

class SearchLocationViewController: UIViewController, CLLocationManagerDelegate {

    var myLocationManager:CLLocationManager!
    var nearUserArray:[Any]?
    var jsonData:Data!
    
    @IBOutlet weak var searchingLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        requestLocation()
        
        // Do any additional setup after loading the view.
    }
    
    func requestLocation(){
        
        myLocationManager = CLLocationManager()
        myLocationManager.delegate = self
        
        switch CLLocationManager.authorizationStatus() {
        case .restricted:
            print("no use")
        case .denied:
            print("no use")
        case .notDetermined:
            myLocationManager.requestWhenInUseAuthorization()
        default:
            print("")
        }
        
        

        
        if !CLLocationManager.locationServicesEnabled(){
            return
        }
        
        myLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        myLocationManager.distanceFilter = kCLDistanceFilterNone
        myLocationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = manager.location else {return}
        let myLat = location.coordinate.latitude
        let myLng = location.coordinate.longitude
        print("lat:\(myLat)")
        print("lng:\(myLng)")
        updateLocation(lat: myLat, lng: myLng)
        
//        guard let user = jsonData else { return }
//        setNearUser(data: user)
        //senderで渡します。
        
//        performSegue(withIdentifier: "mainSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mainSegue"{
            let vc = segue.destination as! MainViewController
            vc.userData = nearUserArray as! [[String : Any]]
        }
    }
    
    func updateLocation(lat:Double,lng:Double){
        let ud = UserDefaults.standard
        guard let uuid = ud.string(forKey: "uuid") else {return}
        
        let postLocationData:[String:Any] = ["uuid":uuid,"lat":lat,"lng":lng]
        print("postLocationData:\(postLocationData)")
        guard let updateLocationUrl = URL(string: "http://localhost:8888/test/updateLocation.php") else {return}
        var request = URLRequest(url: updateLocationUrl)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: postLocationData, options: JSONSerialization.WritingOptions.prettyPrinted)
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                let str = String(data:data!, encoding:.utf8)
                self.jsonData = data
                print("str:\(str)")
                print("response:\(response)")
                //strをjsondecodeする必要
                self.setNearUser(data: data!)
                self.performSegue(withIdentifier: "mainSegue", sender: self.nearUserArray)
            })
            task.resume()
        }catch{
            print("error:\(error.localizedDescription)")
        }
    }
    
    func setNearUser(data:Data){
        do{
            nearUserArray = try JSONSerialization.jsonObject(with: data, options: []) as? [Any]
        }catch{
            print("error:\(error.localizedDescription)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("erro:\(error.localizedDescription)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
