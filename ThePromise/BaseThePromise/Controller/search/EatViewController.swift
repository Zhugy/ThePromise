//
//  EatViewController.swift
//  ThePromise
//
//  Created by zhugy on 2017/9/12.
//  Copyright © 2017年 zhugy. All rights reserved.
//

import UIKit
import Cartography

class EatViewController: UIViewController {

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
        btn.setTitleColor(UIColor.red, for: .normal)
        btn.backgroundColor = UIColor.ps_paleGrey
        return btn
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = UIColor.white
        view.addSubview(headView)
        view.addSubview(playBtn)
        setupConstraints()
        playBtn.addTarget(self, action: #selector(EatViewController.searchFoot), for: .touchUpInside)
    }
    
    func setupConstraints() {
        constrain(headView, playBtn) { (headView, playBtn) in
            headView.top == headView.superview!.top + 64
            headView.leading == headView.superview!.leading + 30
            headView.trailing == headView.superview!.trailing - 30
            headView.height == 300
            
            playBtn.top == headView.bottom + 35
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

}
