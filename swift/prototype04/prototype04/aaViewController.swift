//
//  aaViewController.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/05/17.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class AaViewController: UIViewController {

    var a:[String] = []
    var b:[String] = []
    
    @IBOutlet weak var backgroundView: UIImageView!
    
    @IBOutlet weak var matchingView: UIView!
    @IBOutlet weak var constraint: NSLayoutConstraint!
    @IBOutlet weak var layoutconstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.layoutconstraint.constant = 0
//        let abc = UserDefaultSetting()
////        abc.save(key: .username, value: "aaa")
////        let str:String = abc.read(key: .username)
//        abc.save(key: .job, value: ["営業","IT"])
//        print(abc.returnSetValue())
//        print(str)
        
//        //グラデーションの開始色
//        let topColor = UIColor(red:0.07, green:0.13, blue:0.26, alpha:1)
//        //グラデーションの開始色
//        let bottomColor = UIColor(red:0.54, green:0.74, blue:0.74, alpha:1)
//        
//        //グラデーションの色を配列で管理
////        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor, topColor.cgColor, topColor.cgColor]
//        let gradientColors:[CGColor] = [topColor.cgColor,bottomColor.cgColor,topColor.cgColor,bottomColor.cgColor]
////        let gradienColors:[CGColor] = []
//        
//        //グラデーションレイヤーを作成
//        let gradientLayer: CAGradientLayer = CAGradientLayer()
//        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
//        
//        gradientLayer.endPoint = CGPoint(x: 0, y: 0)
//        
//        //グラデーションの色をレイヤーに割り当てる
//        gradientLayer.colors = gradientColors
//        //グラデーションレイヤーをスクリーンサイズにする
//        gradientLayer.frame = self.view.bounds
//        
//        //グラデーションレイヤーをビューの一番下に配置
//        self.view.layer.insertSublayer(gradientLayer, at: 0)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var Write: UIButton!
    @IBAction func WriteTapped(_ sender: Any) {
        
        
//        self.view.bringSubview(toFront: self.matchingView.subviews)
        
        
        let blurEffect = UIBlurEffect(style: .dark)
        
        // ブラーエフェクトからエフェクトビューを生成
        var visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.alpha = 0
        
        // エフェクトビューのサイズを指定（オリジナル画像と同じサイズにする）
        visualEffectView.frame = matchingView.bounds
        
        // 画像にエフェクトビューを貼り付ける
//        matchingView.addSubview(visualEffectView)
        self.backgroundView.addSubview(visualEffectView)
        
        for view in matchingView.subviews{
            view.alpha = 0
        }
        
        self.view.bringSubview(toFront: self.matchingView)
        UIView.animate(withDuration: 3) {
            visualEffectView.alpha = 1
            self.matchingView.alpha = 1
            
            self.matchingView.transform = CGAffineTransform.init(translationX: 0, y: -self.view.frame.height)
            for view in self.matchingView.subviews{
                view.alpha = 1
            }
        }
        
//        let ud = UserDefaults.standard
//        let array = ["aaa","bbb","ccc"]
//        let dic = [1:"aaa",2:"bbb",3:"ccc"]
//        let hoge:[[Int:String]] = [dic]
//        
//        ud.set(hoge, forKey: "hoge")
//        ud.set(array, forKey: "array")
        
    }
    @IBAction func ReadTapped(_ sender: Any) {
//        let ud = UserDefaults.standard
////        print(ud.array(forKey: "array"))
//        print(ud.array(forKey: "hoge"))
        
        var postData = ["uuid":"hoge","encounterd":["fhjg","nvkfs"]] as [String : Any]
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

    @IBAction func buttonTapped(_ sender: Any) {
//        let vc = ViewController() as! UIViewController
//        self.navigationController?.pushViewController(vc, animated: true)
//        performSegue(withIdentifier: "segueSample", sender: true)
        let data = requestCard(uuid: "hoge")
        print(data["uuid"])
//        let postData:[String:String] = ["uuid":"hoge","moke":"aaa"]
//        guard let requestURL = URL(string: "http://localhost:8888/test/requestMyData.php") else { return }
//        var request = URLRequest(url: requestURL)
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        do{
//            request.httpBody = try JSONSerialization.data(withJSONObject: postData, options: .prettyPrinted)
//            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
//                let str = String(data:data!, encoding: .utf8)
//                print(str)
//                print("res:\(response)")
//            })
//            task.resume()
//        }catch{
//            print(error.localizedDescription)
//        }
        
    }
    
    func requestCard(uuid:String)->[String:Any]{
        let postData:[String:Any] = ["uuid":uuid]
        
        
        let updateLocationURL = URL(string: "http://localhost:8888/test/requestMyData.php")
        var request = URLRequest(url: updateLocationURL!)
        var returnData:Data = Data()
        var returnData02:[Any]?
        var dic:[String:Any]?
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: postData, options: .prettyPrinted)
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
//                let str = String(data: data!, encoding:.utf8)
//                                print(str)
                do{
//                    returnData02 = try JSONSerialization.jsonObject(with: data!, options: []) as? [Any]
                    let ccc = try JSONSerialization.jsonObject(with: data!, options: [])
                    print(ccc)
                    dic = ccc as? [String:Any]
                    print(type(of: ccc))
                    
                }catch{
                    print("json decode error:\(error.localizedDescription)")
                }
//                print(response)
            })
            task.resume()
        }catch{
            print("error:\(error.localizedDescription)")
            //            return errorData
        }
        sleep(3)
        
        return dic!
        //        print("34:\(returnData)")
        //        return returnData
    }
    @IBAction func backToMainView(_ sender: Any) {
        UIView.animate(withDuration: 3) { 
            self.matchingView.transform = CGAffineTransform.init(translationX: 0, y: self.view.frame.height)
            self.matchingView.alpha = 0
            self.backgroundView.subviews.last?.alpha = 0
            for view in  self.matchingView.subviews {
                view.alpha = 0
            }
            
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.backgroundView.subviews.last?.removeFromSuperview()
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
