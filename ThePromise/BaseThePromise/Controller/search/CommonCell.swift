//
//  CommonCell.swift
//  ThePromise
//
//  Created by zhugy on 2017/9/12.
//  Copyright © 2017年 zhugy. All rights reserved.
//

import UIKit
import Cartography

class CommonCell: UITableViewCell {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.red
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubview(titleLabel)
        constrain(titleLabel) { (titleLabel) in
            titleLabel.top == titleLabel.superview!.top + 12
            titleLabel.leading == titleLabel.superview!.leading + 28
            titleLabel.trailing == titleLabel.superview!.trailing - 12
            titleLabel.bottom == titleLabel.superview!.bottom - 12
            titleLabel.height == 30
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
