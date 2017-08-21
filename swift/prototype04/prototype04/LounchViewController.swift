//
//  LounchViewController.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/08/21.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class LounchViewController: UIViewController,UIScrollViewDelegate{

    @IBOutlet weak var myPageController: UIPageControl!
    @IBOutlet weak var myScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myScrollView.delegate = self
        myPageController.currentPage = 0
        myPageController.numberOfPages = 3
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        myPageController.currentPage = Int(myScrollView.contentOffset.x / myScrollView.frame.maxX)
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
