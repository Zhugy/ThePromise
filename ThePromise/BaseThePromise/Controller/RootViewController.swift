//
//  RootViewController.swift
//  ThePromise
//
//  Created by zhugy on 2017/8/31.
//  Copyright © 2017年 zhugy. All rights reserved.
//

import UIKit

class RootViewController: UITabBarController {
    init() {
        super.init(nibName: nil, bundle: nil)
        crearViewController()
    }
    
    func crearViewController() {
        var viewControllers: [UINavigationController] = []
        var imageNames : [UIImage] = []
        var selectedImageNames : [UIImage] = []
        var titles : [String] = []
        
        let homeVC: HomeViewController = HomeViewController()
        let homeNv: UINavigationController = UINavigationController(rootViewController: homeVC)
        
        viewControllers.append(homeNv)
        imageNames.append(#imageLiteral(resourceName: "home"))
        selectedImageNames.append(#imageLiteral(resourceName: "home_s"))
        titles.append("首页")
        
        let searchVC: SearchViewController = SearchViewController()
        let searchNv: UINavigationController = UINavigationController(rootViewController: searchVC)
        
        viewControllers.append(searchNv)
        imageNames.append(#imageLiteral(resourceName: "search"))
        selectedImageNames.append(#imageLiteral(resourceName: "search_s"))
        titles.append("发现")
        
        let ownVC: OwnViewController = OwnViewController()
        let ownNv: UINavigationController = UINavigationController(rootViewController: ownVC)
        
        viewControllers.append(ownNv)
        imageNames.append(#imageLiteral(resourceName: "own"))
        selectedImageNames.append(#imageLiteral(resourceName: "own_s"))
        titles.append("我的")
        
        for i in 0 ..< viewControllers.count {
            let item: UITabBarItem = UITabBarItem(title: titles[i], image: imageNames[i].withRenderingMode(.alwaysOriginal), selectedImage: selectedImageNames[i].withRenderingMode(.alwaysOriginal))
            item.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.ps_warmGrey], for: .normal)
            item.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.ps_bloodOrange], for: .selected)
            item.titlePositionAdjustment = UIOffsetMake(0, -3)
            viewControllers[i].tabBarItem = item
        }
        self.viewControllers = viewControllers
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
