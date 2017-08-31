//
//  HomeViewController.swift
//  ThePromise
//
//  Created by zhugy on 2017/8/31.
//  Copyright © 2017年 zhugy. All rights reserved.
//

import UIKit
import Cartography

class HomeViewController: UIViewController {

    let tabBarView: TabBarView = TabBarView(frame: CGRect.zero)
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = UIColor.white
        view.addSubview(tabBarView)
        constrain(tabBarView) { (tabBarView) in
            tabBarView.top == tabBarView.superview!.top + 100
            tabBarView.leading == tabBarView.superview!.leading
            tabBarView.trailing == tabBarView.superview!.trailing
            tabBarView.height == 50
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
