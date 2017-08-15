//
//  LocationSearchViewControllerDemo.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/06/27.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit
import CoreLocation

class LocationSearchViewControllerDemo: UIViewController,UIViewControllerTransitioningDelegate,UINavigationControllerDelegate,CLLocationManagerDelegate{

    var myLocationManager:CLLocationManager!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    var myStatus = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        userImageView.layer.masksToBounds = true
        userImageView.layer.cornerRadius = userImageView.frame.width/2
        userImageView.layer.borderWidth = 3
        userImageView.layer.borderColor = UIColor.white.cgColor
        
        //status読み込み
        if let status = User().status{
            myStatus = status
        }
        
//        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        let vc = storyboard.instantiateViewController(withIdentifier: "trialVC") as! UIViewController
//        vc.modalTransitionStyle = .crossDissolve
//        vc.modalPresentationStyle = .overFullScreen
//        self.present(vc, animated: true, completion: nil)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //自分のimageを設定
        
        let circleView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        circleView.center = self.view.center
        circleView.layer.cornerRadius = 200/2
        circleView.backgroundColor = UIColor.rgbColor(0xfffadad)
        self.view.addSubview(circleView)
        self.view.bringSubview(toFront: userImageView)
        
        //後ろの動き
        UIView.animate(withDuration: 4, delay: 0, options: [.repeat, .curveLinear], animations: {
            circleView.transform = CGAffineTransform.init(scaleX: 4, y: 4)
            circleView.alpha = 0
            
        }, completion: { _ in
            
        })
        
        let documentDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let imgFileName = "userimg.png"
        var tmp = UIImage(contentsOfFile: "\(documentDir)/\(imgFileName)")
        if tmp == nil{
            tmp = #imageLiteral(resourceName: "anonymous")
        }
        userImageView.image = tmp
        
        
        requstLocalePermission()
//        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        let vc = storyboard.instantiateViewController(withIdentifier: "demoMain") as! ContainerViewControllerTest
//        vc.transitioningDelegate = self
//        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
//            self.present(vc, animated: true, completion: nil)
//        }
    }
    
    //位置情報取得のパーミッション→リクエスト
    func requstLocalePermission(){
        myLocationManager = CLLocationManager()
        myLocationManager.delegate = self
        
        switch CLLocationManager.authorizationStatus() {
        //制限されたとき
        case .restricted:
            print("no user")
        //否定されたとき
        case .denied:
            print("no user")
        case .notDetermined:
            myLocationManager.requestWhenInUseAuthorization()
        default:
            print("peremited")
        }
        
        if !CLLocationManager.locationServicesEnabled(){
            return
        }
        myLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        myLocationManager.distanceFilter = kCLDistanceFilterNone
        myLocationManager.requestLocation()
    }
    
    //位置が更新されたときに呼ばれる
    //サーバーに位置を更新
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = manager.location else { return }
        let lat = location.coordinate.latitude
        let lng = location.coordinate.longitude
        
        print("lat:\(lat),lng:\(lng)")
        
        requestCloseUser(lat: lat, lng: lng)
    }
    
    
    //位置取得に失敗したときに呼ばれる
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:\(error.localizedDescription)")
    }
    
    //サーバーに自分の近い人をリクエスト
    func requestCloseUser(lat:Double,lng:Double){
//        let udsetting = UserDefaultSetting()
//        udsetting.write(key: .uuid, value: "hoge")
        
        let serverConnect = ServerConnection()
        
        if let uuid = my().uuid {
            serverConnect.requestMyData(inuuid: uuid)
            requestMatchingUserList(inuuid: uuid)
            requestCard(uuid: uuid, lat: lat, lng: lng)
        }else{
            print("error:LocationVC")
        }
        
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return Animation()
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

extension LocationSearchViewControllerDemo{
    
    func requestMatchingUserList(inuuid:String){
        
        let postData:[String:Any] = ["uuid":inuuid,"status":myStatus]
        var returnData:[Any]?
        
        guard let requestURL = URL(string: "http://localhost:8888/test/requestMessageUserList.php") else {return}
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: postData, options: .prettyPrinted)
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                
                
                do{
                    returnData = try JSONSerialization.jsonObject(with: data!, options: []) as? [Any]
                    let app:AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    app.messageList = returnData
                    
                    
                }catch{
                    print(error.localizedDescription)
                }
            })
            task.resume()
        }catch{
            print(error.localizedDescription)
        }
    }
    
    //locationVCで使用
    func requestCard(uuid:String,lat:Double,lng:Double){
        let postData:[String:Any] = ["uuid":uuid,"lat":lat,"lng":lng,"status":myStatus]
        print(postData)
        var returnData:[Any]?
        
        guard let requestURL = URL(string: "http://localhost:8888/test/updateLocation.php") else {return}
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: postData, options: .prettyPrinted)
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                print(String(data:data!, encoding: .utf8))
                do{
                    returnData = try JSONSerialization.jsonObject(with: data!, options: []) as? [Any]
                    //app deleagetに取得したデータを格納
                    let app:AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    app.cardListDelegate = returnData
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                    let vc = storyboard.instantiateViewController(withIdentifier: "demoMain") as! ContainerViewControllerTest
                    vc.transitioningDelegate = self
                    
                    //serverに近くのユーザー問い合わせが返ってこないとnilエラーになるのでわざと遅らせている
                    //location取得してるときにrequestCardが終わってから遷移するように
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.present(vc, animated: true, completion: nil)
                    }
                    
                    
                }catch{
                    print("json decode error:\(error.localizedDescription)")
                }
                
            })
            
            task.resume()
        }catch{
            print("error:\(error.localizedDescription)")
        }
    }
    
}
