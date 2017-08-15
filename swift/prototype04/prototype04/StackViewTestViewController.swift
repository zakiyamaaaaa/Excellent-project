//
//  StackViewTestViewController.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/07/30.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class StackViewTestViewController: UIViewController {

    @IBOutlet weak var myStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var pressedCount = 0
    @IBAction func buttonpushed(_ sender: Any) {
        myStackView.backgroundColor = UIColor.green
        pressedCount += 1
        myStackView.frame.size = CGSize(width: CGFloat(Int(myStackView.frame.height)*pressedCount), height: myStackView.frame.height)
        let num = arc4random_uniform(4)
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: myStackView.frame.height, height: myStackView.frame.height))
        
        switch num{
        case 0:
            imageView.image = #imageLiteral(resourceName: "morningIconColored")
        case 1:
            imageView.image = #imageLiteral(resourceName: "lunchIconColored")
        case 2:
            imageView.image = #imageLiteral(resourceName: "dinnerIconColored")
        case 3:
            imageView.image = #imageLiteral(resourceName: "caffeIconColored")
        default:
            break
        }
        
        
        myStackView.addArrangedSubview(imageView)
        
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
