//
//  ViewController.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/05/09.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit
import CoreLocation

class LocationSearchViewController: UIViewController, UIViewControllerTransitioningDelegate,UINavigationControllerDelegate,CLLocationManagerDelegate{

    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var userImageView01: UIImageView!
    @IBOutlet weak var imageYConstraint: NSLayoutConstraint!
    
    var myLocationManager:CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myImageView.layer.masksToBounds = true
        myImageView.layer.cornerRadius = myImageView.frame.width/2
        
        userImageView01.layer.masksToBounds = true
        userImageView01.layer.cornerRadius = 75/2
        userImageView01.layer.borderWidth = 3
        userImageView01.layer.borderColor = UIColor.white.cgColor
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        
        //自分のimageを設定
        let documentDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let imgFileName = "sample.png"
        let tmp = UIImage(contentsOfFile: "\(documentDir)/\(imgFileName)")
        myImageView.image =  tmp
        let circleView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        circleView.center = myImageView.center
        circleView.layer.cornerRadius = 200/2
        circleView.backgroundColor = UIColor.rgbColor(0xfffadad)
        self.view.addSubview(circleView)
        self.view.bringSubview(toFront: myImageView)
        
        //後ろの動き
        UIView.animate(withDuration: 4, delay: 0, options: [.repeat, .curveLinear], animations: {
            circleView.transform = CGAffineTransform.init(scaleX: 4, y: 4)
            circleView.alpha = 0
        }, completion: nil)
        requstLocation()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "mainVC") as! UINavigationController
        vc.transitioningDelegate = self
        
        
        //serverに近くのユーザー問い合わせが返ってこないとnilエラーになるのでわざと遅らせている
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    //位置情報取得のパーミッション→リクエスト
    func requstLocation(){
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
        
        requestToServer(lat: lat, lng: lng)
    }
    
    //位置取得に失敗したときに呼ばれる
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:\(error.localizedDescription)")
    }
    
    //サーバーに自分の近い人をリクエスト
    func requestToServer(lat:Double,lng:Double){
        let udsetting = UserDefaultSetting()
        udsetting.write(key: .uuid, value: "hoge")
        let uuid = udsetting.read(key: .uuid) as String
        let serverConnect = ServerConnection()

        print("\n")
        serverConnect.requestCard(uuid: uuid, lat: lat, lng: lng)
        //サーバーから受け取ったjsonデータをjson decode

    }
    
    //Animation
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return Animation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

