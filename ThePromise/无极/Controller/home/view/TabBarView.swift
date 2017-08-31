//
//  TabBarView.swift
//  ThePromise
//
//  Created by zhugy on 2017/8/31.
//  Copyright © 2017年 zhugy. All rights reserved.
//

import UIKit
import Cartography

class TabBarView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 50, height: 30)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
        constrain(collectionView) { (collectionView) in
            collectionView.edges == collectionView.superview!.edges
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(TabBarItem.classForCoder(), forCellWithReuseIdentifier: "TabBarItem")
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TabBarItem", for: indexPath) as! TabBarItem
        return cell
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
