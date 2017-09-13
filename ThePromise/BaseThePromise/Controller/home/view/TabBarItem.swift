//
//  TabBarItem.swift
//  ThePromise
//
//  Created by zhugy on 2017/8/31.
//  Copyright © 2017年 zhugy. All rights reserved.
//

import UIKit
import Cartography

class TabBarItem: UICollectionViewCell {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "热门"
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.ps_baseYellow
        contentView.addSubview(titleLabel)
        setUpContraints()
    }
    
    func setUpContraints() {
        constrain(titleLabel) { (titleLabel) in
            titleLabel.edges == titleLabel.superview!.edges
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
