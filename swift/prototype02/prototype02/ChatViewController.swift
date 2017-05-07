//
//  ChatViewController.swift
//  MainViewWithFunction05
//
//  Created by shoichiyamazaki on 2017/04/24.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import Firebase

class ChatViewController: JSQMessagesViewController {

    var messages:[JSQMessage] = []
    var senderImage:UIImage = UIImage()
    var recieverImage:UIImage = UIImage()
    
    var roomKey:String?
    
    var myUUID:String!
    
    var recieverUUID:String!
    
    enum targetFlag {
        case sender
        case reciever
    }
    
    @IBOutlet weak var backButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let ud = UserDefaults.standard
        myUUID = ud.string(forKey: "uuid")
        
        senderId = myUUID
        senderDisplayName = "hoge"
        
//        setImage(uuid: "bbb", target: .sender)
        senderImage = UIImage(named: "sender")!
        setImage(uuid: recieverUUID, target: .reciever)
        
        //test
//        messages.append(JSQMessage(senderId: senderId, displayName: senderDisplayName, text: "hoge"))
        
        self.view.addSubview(backButton)
        // Do any additional setup after loading the view.
    }
    
    func setImage(uuid:String,target:targetFlag){
        let imageFilePath = URL(string: "http://localhost:8888/test/img/\(uuid)/userimg.jpg")
        var image:UIImage
        switch target {
        case .sender:
            image = senderImage
            do{
                let data = try Data(contentsOf: imageFilePath!)
                senderImage = UIImage(data: data)!
                print("success to set iamge")
            }catch{
                print(error.localizedDescription)
            }
        case .reciever:
            image = recieverImage
            
            do{
                let data = try Data(contentsOf: imageFilePath!)
                recieverImage = UIImage(data: data)!
                print("success to set iamge")
            }catch{
                print(error.localizedDescription)
            }
        default:
            print("default")
        }
        
        
    }
    
    
    //read message
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.row]
    }
    
    //imageの設定
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
        var height:CGFloat = 10
        if indexPath.row == 0{
            height = 100
        }
        return height
    }
    
    //Send Button
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        let message = JSQMessage(senderId: senderId, displayName: senderDisplayName, text: text)!
        messages.append(message)
        finishSendingMessage(animated: true)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
//    private func sendAutoMessage() {
//        let message = JSQMessage(senderId: targetUser["senderId"].string, displayName: targetUser["displayName"].string, text: "返信するぞ")
//        messages.append(message)
//        finishReceivingMessageAnimated(true)
//    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
