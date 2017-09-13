//
//  UITableView+Help.swift
//  PPTVSports
//
//  Created by ospreyren on 17/11/2016.
//  Copyright © 2016 PPTV. All rights reserved.
//

import UIKit

enum CellDefine {
    case cellClass(AnyClass)
    case cellNib(UINib)
}

protocol CellReuseID {
    static var allReuseID: [CellReuseID] { get }

    var cellDefine: CellDefine { get }
    var string: String { get }
}

protocol TableViewCellReuseID: CellReuseID {
    static func register(for tableView: UITableView) // 有默认实现👇
}

extension TableViewCellReuseID {
    static func register(for tableView: UITableView) {
        for reuseID in self.allReuseID {
            switch reuseID.cellDefine {
            case .cellClass(let cellClass):
                tableView.register(cellClass, forCellReuseIdentifier: reuseID.string)

            case .cellNib(let nib):
                tableView.register(nib, forCellReuseIdentifier: reuseID.string)
            }
        }
    }
}

protocol CollectionViewCellReuseID: CellReuseID {
    static func register(for collectionView: UICollectionView)
}

extension CollectionViewCellReuseID {
    static func register(for collectionView: UICollectionView) {
        for reuseID in self.allReuseID {
            switch reuseID.cellDefine {
            case .cellClass(let cellClass):
                collectionView.register(cellClass, forCellWithReuseIdentifier: reuseID.string)

            case .cellNib(let nib):
                collectionView.register(nib, forCellWithReuseIdentifier: reuseID.string)
            }
        }
    }
}
