import UIKit

extension UIView {
    
    func GetImage() -> UIImage{
        
        // キャプチャする範囲を取得.
        let rect = self.bounds
        
        // ビットマップ画像のcontextを作成.
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        
        // 対象のview内の描画をcontextに複写する.
        self.layer.render(in: context)
        
        // 現在のcontextのビットマップをUIImageとして取得.
        let capturedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        // contextを閉じる.
        UIGraphicsEndImageContext()
        
        return capturedImage
    }
}

class SnapshotViewController: UIViewController {
    
    var myLabel: UILabel!
    @IBOutlet weak var myImageView: UIImageView!
    
    override func viewDidLoad() {
        
        // Labelを生成.
        myLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        myLabel.text = "test"
        myLabel.textAlignment = NSTextAlignment.center
        myLabel.layer.borderWidth = 1
        myLabel.layer.borderColor = UIColor.white.cgColor
        myLabel.layer.position = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2 - 100)
        
        // ImageViewを生成.
        let blurEffect = UIBlurEffect(style: .dark)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.alpha = 1
//        myImageView.addSubview(visualEffectView)
        visualEffectView.frame = self.view.frame
        self.view.addSubview(visualEffectView)
        
        // Buttonを生成.
        let myButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 20))
        myButton.setTitle("push", for: UIControlState.normal)
        myButton.setTitleColor(UIColor.blue, for: UIControlState.normal)
        myButton.addTarget(self, action: #selector(SnapshotViewController.onClickMyButton(sender:)), for: UIControlEvents.touchUpInside)
        myButton.layer.position = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height - 50)
        
        // viewにそれぞれを追加.
        self.view.addSubview(myLabel)
        self.view.addSubview(myButton)
    }
    
    
    /*
     Buttonが押された時に呼ばれるメソッド.
     */
    func onClickMyButton(sender: UIButton) {
        // キャプチャ画像を取得.
//        let myImage = myLabel.GetImage() as UIImage
//        let myImage = myLabel.snapshotView(afterScreenUpdates: true)?
        // ImageViewのimageにセット.
//        myImageView.image = myImage
        
        // 縦横比率を保ちつつ画像をUIImageViewの大きさに合わせる.
        myImageView.contentMode = UIViewContentMode.scaleAspectFit
    }
}
