//
//  ChoiceStatusViewController.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/08/13.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import UIKit

class ChoiceStatusViewController: UIViewController {
    let ud = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func recruiterButtonTapped(_ sender: Any) {
        //recruiterとして登録
        print("aaa")
        var a = my()
        a.register(key: .status, value: 1)
        //このあと、それぞれの設定画面へ遷移する(storyboardで設定済み)
    }

    @IBAction func studentButtonTapped(_ sender: Any) {
        //studentとして登録
        print("bbb")
        var a = my()
        a.register(key: .status, value: 2)
        //このあと、それぞれの設定画面へ遷移する(storyboardで設定済み)
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
