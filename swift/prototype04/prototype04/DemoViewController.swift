//
//  DemoViewController.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/08/20.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit
import AVFoundation
import CoreMedia

class DemoViewController: UIViewController {
    @IBOutlet weak var blurView: UIView!

    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var movieView: AvPlayerView!
    var videoPlayer:AVPlayer!
    
    let textList = ["最初に、あなたの周りにいる\nマッチング候補を検索します","近くの相手が表示されます","カードをタップすると相手の詳細情報が表示されます","興味がない相手の場合は、左にスワイプ\nもしくは、☓ボタンを押してください","お互いが「興味があり」の場合は、\nマッチングし、メッセージのやりとりができます。"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    let path = Bundle.main.path(forResource: "demo", ofType: "mp4") ?? ""
    let fileURL = URL(fileURLWithPath: path)
    let avAsset = AVURLAsset(url: fileURL, options: nil)
    let playerItem = AVPlayerItem(asset: avAsset)
    videoPlayer = AVPlayer(playerItem: playerItem)
    textLabel.text = textList[0]
    // Do any additional setup after loading the view, typically from a nib.
}

override func viewWillAppear(_ animated: Bool) {
    movieView.setPlayer(videoPlayer)
    self.videoPlayer.play()
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
        self.videoPlayer.pause()
        
        self.textLabel.text = self.textList[1]
        
        UIView.animate(withDuration: 1, animations: { 
            self.blurView.alpha = 0
        }, completion: { (Bool) in
            self.blurView.isHidden = true
        })
    }
    
}

var startFlag:Bool = true
var count = 0
@IBAction func buttonTapped(_ sender: Any) {
    
    videoPlayer.play()
    if count == 0{
        self.blurView.isHidden = false
        self.textLabel.text = self.textList[2]
        UIView.animate(withDuration: 1, animations: { 
            self.blurView.alpha = 0.8
        }, completion: { (Bool) in

        })
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            self.videoPlayer.pause()
            UIView.animate(withDuration: 1, animations: {
                self.blurView.alpha = 0
            }, completion: { (Bool) in
                self.blurView.isHidden = true
            })
        }
    }
    
    if count == 1{
        self.blurView.isHidden = false
        self.textLabel.text = self.textList[3]
        UIView.animate(withDuration: 1, animations: {
            self.blurView.alpha = 0.8
        }, completion: { (Bool) in
            
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.textLabel.text = self.textList[4]
        }
        
        
    }
    
    count += 1
    
}

override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}

}

final class AvPlayerView:UIView{
    
    enum VideoGravity{
        case resizeAspect
        case resizeAspectFill
        case resize
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override class var layerClass:AnyClass{
        return AVPlayerLayer.self
    }
    
    func setVideoGravity(_ gravity: VideoGravity) {
        let layer = self.layer as! AVPlayerLayer
        switch(gravity) {
        case .resizeAspect:
            layer.videoGravity = AVLayerVideoGravityResizeAspect
        case .resizeAspectFill:
            layer.videoGravity = AVLayerVideoGravityResizeAspectFill
        case .resize:
            layer.videoGravity = AVLayerVideoGravityResize
        }
    }
    
    func setPlayer(_ player: AVPlayer) {
        let layer = self.layer as! AVPlayerLayer
        layer.player = player
    }
}
