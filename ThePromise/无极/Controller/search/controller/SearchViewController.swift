//
//  SearchViewController.swift
//  ThePromise
//
//  Created by zhugy on 2017/8/31.
//  Copyright © 2017年 zhugy. All rights reserved.
//

import UIKit
import Cartography

class SearchViewController: UIViewController {

    let headView: UIView = {
        let heaadView = UIView()
        heaadView.backgroundColor = UIColor.ps_greyish
        heaadView.layer.cornerRadius = 5
        heaadView.layer.shadowOffset = CGSize(width: 3, height: 3)
        heaadView.layer.shadowColor = UIColor.red.cgColor
        return heaadView
    }()
    
    let playBtn: UIButton = {
        let btn = UIButton(type: UIButtonType.custom)
        btn.setTitle("吃啥", for: .normal)
        return btn
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = UIColor.white
        view.addSubview(headView)
        view.addSubview(playBtn)
        setupConstraints()
        playBtn.addTarget(self, action: #selector(SearchViewController.searchFoot), for: .touchUpInside)
    }
    
    func setupConstraints() {
        constrain(headView, playBtn) { (headView, playBtn) in
            headView.top == headView.superview!.top + 30
            headView.leading == headView.superview!.leading + 30
            headView.trailing == headView.superview!.trailing - 30
            headView.height == 300
            
            playBtn.top == headView.bottom + 100
            playBtn.centerX == playBtn.superview!.centerX
            playBtn.width == 85
            playBtn.height == 45
        }
    }
    
    func searchFoot() {
        
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
