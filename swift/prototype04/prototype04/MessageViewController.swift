//
//  MessageViewController.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/05/25.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit
import JSQMessagesViewController

class MessageViewController: JSQMessagesViewController {

    var messages:[JSQMessage] = []
    var senderImage:UIImage?
    var recieverImage:UIImage?
    var recieverInfo:[String:Any] = [:]
    var senderInfo:UserInfo = UserInfo()
    
    enum targetType{
        case sender
        case reciever
    }
    
    let udSetting:UserDefaultSetting = UserDefaultSetting()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        senderInfo.uuid = udSetting.read(key: .uuid)
        
        senderId = senderInfo.uuid
        let documentDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let imgFileName = "sample.png"
        let tmp = UIImage(contentsOfFile: "\(documentDir)/\(imgFileName)")
        senderImage =  tmp
        senderDisplayName = udSetting.read(key: .username)
        
        recieverImage = getImage(uuid: recieverInfo["uuid"] as! String)
        // Do any additional setup after loading the view.
    }
    
    //uuidを指定して、画像を取得
    func getImage(uuid:String)->UIImage?{
        guard let imgFilePath = URL(string: "http://52.163.126.71/test/img/\(uuid)/userimg.jpg") else { return nil}
        var img:UIImage?
        
        do{
            let data = try Data(contentsOf: imgFilePath)
            img = UIImage(data: data)
        }catch{
            print("error:\(error.localizedDescription)")
        }
        return img
    }

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
            cell?.textView.textColor = UIColor.darkGray
        }
        return cell!
    }
    
    //メッセージの背景色
    //ここでメッセージがinかoutかを判定して、自分のメッセージか、相手のメッセージかを判別している。
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        if messages[indexPath.row].senderId == senderId{
            return JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
        }else{
            return JSQMessagesBubbleImageFactory().incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleGreen())
        }
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForCellTopLabelAt indexPath: IndexPath!) -> CGFloat {
        return 20
    }
    
    //Send Button
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        let message = JSQMessage(senderId: senderId, displayName: senderDisplayName, text: text)!
        messages.append(message)
        finishSendingMessage(animated: true)
        self.inputToolbar.contentView.textView.resignFirstResponder()
    }
    
    
    //画面中のアイテム数
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
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
