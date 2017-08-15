//
//  ChatViewController.swift
//  
//
//  Created by shoichiyamazaki on 2017/06/28.
//
//

import UIKit
import JSQMessagesViewController
import Firebase

class ChatViewController: JSQMessagesViewController {

    
    var roomKey = "hogeKey"
    
    var messages:[JSQMessage] = []
    var senderImage:UIImage?
    var recieverId:String!
    var recieverImage:UIImage?
    var recieverInfo:[String:Any] = [:]
    var senderInfo:UserInfo = UserInfo()
    var navigationView:UIView!
    var backButton:UIButton!
    var navigationTitle:String = "hoge"
    
    enum targetType{
        case sender
        case reciever
    }
    
    let udSetting:UserDefaultSetting = UserDefaultSetting()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.getKeyboardHeight(notification:)),
            name: NSNotification.Name.UIKeyboardDidShow,
            object: nil
        )
        self.collectionView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height*1.2)

        self.collectionView.backgroundColor = UIColor.init(white: 0.9, alpha: 1)
        let documentDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let imgFileName = "sample.png"
        var tmp = UIImage(contentsOfFile: "\(documentDir)/\(imgFileName)")
        if tmp == nil{
            tmp = #imageLiteral(resourceName: "anonymous")
        }
        senderImage =  tmp
        recieverImage = getImage(uuid: recieverId)
        
        
        // Do any additional setup after loading the view.
    }
    
    var keyboardheight:CGFloat!
    func getKeyboardHeight(notification: Notification) {
        
        if let userInfo = notification.userInfo {
            if let keyboardFrameInfo = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue {
                // キーボードの高さを取得
                keyboardheight = keyboardFrameInfo.cgRectValue.height
                print(keyboardFrameInfo.cgRectValue.height)
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        showMessage(roomKey)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = navigationTitle
//        let parentVC = self.navigationController?.parent as! ContainerViewControllerTest
//        parentVC.navigationView.isHidden = true
        
    }
    
    func backView(_ sender:UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    //uuidを指定して、画像を取得
    func getImage(uuid:String)->UIImage?{
        guard let imgFilePath = URL(string: "http://localhost:8888/test/img/\(uuid)/userimg.jpg") else { return nil}
        var img:UIImage?
        
        do{
            let data = try Data(contentsOf: imgFilePath)
            img = UIImage(data: data)
        }catch{
            print("error:\(error.localizedDescription)")
        }
        return img
    }
//    override func scrollToBottom(animated: Bool) {
//        
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //read message
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.row]
    }
    
    //imageの表示設定
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        self.collectionView.collectionViewLayout.incomingAvatarViewSize = CGSize(width: 40, height: 40)
        self.collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSize(width: 40, height: 40)
        
        if messages[indexPath.row].senderId == senderId{
            return JSQMessagesAvatarImageFactory.avatarImage(with: senderImage, diameter: 100)
        } else{
            return JSQMessagesAvatarImageFactory.avatarImage(with: recieverImage, diameter: 100)
        }
        //        return JSQMessagesAvatarImageFactory.avatarImage(withUserInitials: messages[indexPath.row].senderDisplayName, backgroundColor: UIColor.darkGray, textColor: UIColor.black, font: UIFont.systemFont(ofSize: 10), diameter: 30)
    }
    
    //set textColor
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as? JSQMessagesCollectionViewCell
        if messages[indexPath.row].senderId == senderId {
            cell?.textView.textColor = UIColor.black
        } else {
            cell?.textView.textColor = UIColor.black
        }
        return cell!
    }
    
    //メッセージの背景色
    //ここでメッセージがinかoutかを判定して、自分のメッセージか、相手のメッセージかを判別している。
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        if messages[indexPath.row].senderId == senderId{
            return JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImage(with: UIColor.white)
        }else{
            return JSQMessagesBubbleImageFactory().incomingMessagesBubbleImage(with: UIColor.white)
        }
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForCellTopLabelAt indexPath: IndexPath!) -> CGFloat {
        
//        if indexPath.row == 0{
//            return 80
//        }
//        
        return 20
    }
    
    //Send Button
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
//        let message = JSQMessage(senderId: senderId, displayName: senderDisplayName, text: text)!
//        messages.append(message)
//        finishSendingMessage(animated: true)
//        self.inputToolbar.contentView.textView.resignFirstResponder()
        inputToolbar.contentView.textView.text = ""
        let ref = Database.database().reference()
    ref.child("rooms").child(roomKey).child("message").childByAutoId().setValue(["senderId":senderId,"text":text,"displayName":senderDisplayName,"date":[".sv":"timestamp"]])
       self.inputToolbar.contentView.textView.resignFirstResponder()
//        self.scrollToBottom(animated: true)
        
        
        if self.collectionView.contentSize.height + keyboardheight + inputToolbar.bounds.height > self.collectionView.frame.height {
            
            self.collectionView.setContentOffset(CGPoint(x:0,y:self.collectionView.contentSize.height + self.inputToolbar.bounds.height - keyboardheight), animated: true)
        }
//        if self.collectionView.contentSize.height > self.collectionView.frame.height {
//            self.collectionView.setContentOffset(
//                CGPoint(x: 0, y: self.collectionView.contentSize.height
//                    - self.collectionView.frame.height + self.inputToolbar.bounds.height),
//                animated: true)
//        }    }
    }
    
    
    func showMessage(_ roomKey:String){
        let ref = Database.database().reference()
        ref.child("rooms").child(roomKey).observe(.value, with: {snapshot in
            guard let dic = snapshot.value as? Dictionary<String,AnyObject> else {
                return
            }
            print("snapshot:\(snapshot)")
            guard let posts = dic["message"] as? Dictionary<String,Dictionary<String,AnyObject>>else{
                return
            }
            
            var keyValueArray:[(String,Int)] = []
            for(key,value) in posts{
                keyValueArray.append((key:key,data:value["date"] as! Int))
            }
            
            keyValueArray.sort{$0.1 < $1.1}
            var preMessage = [JSQMessage]()
            
            
            for sortedTuple in keyValueArray{
                for(key, value) in posts {
                    if key == sortedTuple.0{
                        let senderId = value["senderId"] as! String
                        let text = value["text"] as! String
                        let displayName = value["displayName"] as! String
                        preMessage.append(JSQMessage(senderId: senderId, displayName: displayName, text: text))
                    }
                }
            }
            print("preMessage:\(preMessage)")
            
            self.messages = preMessage
            self.collectionView.reloadData()
        
        })
    }
    
    
    //画面中のアイテム数
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
}
