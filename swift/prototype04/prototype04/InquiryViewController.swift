//
//  InquiryViewController.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/08/18.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class InquiryViewController: UIViewController,UITextViewDelegate{

    @IBOutlet weak var contentTextView: UITextView!
    
    var placeholderFlag:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        contentTextView.layer.borderWidth = 1
        contentTextView.delegate = self
        
        let toolBar:UIToolbar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.sizeToFit()
        
        let spacer:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: self, action: nil)
//        let doneButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: Selector("closeKeyboard:"))
        let doneButton = UIBarButtonItem(title: "完了", style: .done, target: self, action:#selector(self.closeKeyboard(sender:)))
        
        let toolBarItems = [spacer,doneButton]
        toolBar.setItems(toolBarItems, animated: true)
        
        contentTextView.becomeFirstResponder()
        contentTextView.layer.masksToBounds = true
        contentTextView.layer.cornerRadius = 5
        
        //ここが重要です。textView.inputAccessoryViewプロパティにtoolBarを指定します。
        contentTextView.inputAccessoryView = toolBar
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        placeholderFlag = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func closeKeyboard(sender: UITextView){
        //キーボードを隠す
        contentTextView.resignFirstResponder()
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if placeholderFlag == true{
            textView.text = ""
            placeholderFlag = false
        }
        
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        
//        if textView.text.isEmpty == true{
//            textView.text = "問い合わせ内容をこちらにお書きください"
//        }
        
        return true
    }
    
    
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        
        if let uuid = User().uuid,contentTextView.text.isEmpty == false{
            inquiry(uid: uuid, content: contentTextView.text!)
        }else{
            
        }
    }

    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func inquiry(uid:String,content:String){
        let postData:[String:Any] = ["uuid":uid,"content":content]
        let requestURL = URL(string: "http://localhost:8888/test/inquiryForApp.php")
        var request = URLRequest(url: requestURL!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do{
            
            request.httpBody = try JSONSerialization.data(withJSONObject: postData, options: .prettyPrinted)
            let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
                print("request Inquiry")
                let str = String(data:data!,encoding:.utf8)
                if str == "send"{
                    let alert = UIAlertController(title: "問い合わせ内容が送信されました", message: nil, preferredStyle: .alert)
                    
                    self.present(alert, animated: true, completion: {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:
                            {
                                alert.dismiss(animated: true, completion: {
                                    self.dismiss(animated: true, completion: nil)
                                })
                        }
                            
                        )
                    })
                }else{
                    let alert = UIAlertController(title: "送信失敗", message: "時間をおいて、再度送信してください", preferredStyle: .alert)
                    
                    self.present(alert, animated: true, completion: {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:
                            {
                                alert.dismiss(animated: true, completion: {
                                    self.dismiss(animated: true, completion: nil)
                                })
                        }
                            
                        )
                    })
                }
                
            })
            task.resume()
            
            
        }catch{
            print("error:\(error.localizedDescription)")
            
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
