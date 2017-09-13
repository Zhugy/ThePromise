//
//  HomeViewController.swift
//  ThePromise
//
//  Created by zhugy on 2017/8/31.
//  Copyright © 2017年 zhugy. All rights reserved.
//

import UIKit
import Cartography

class HomeViewController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    let pageViewController: UIPageViewController = {
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        return pageViewController
    }()
    
    var viewControllers: [UIViewController] = []
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = UIColor.white
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildViewController(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.view.frame = view.frame
        
        viewControllers.append(HomeSubViewController())
        viewControllers.append(TwoViewController())
        
        pageViewController.setViewControllers([viewControllers[0]], direction: .forward, animated: false, completion: nil)
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        
        // Do any additional setup after loading the view.
    }
    
    func viewControllerAtIndex(index: Int) -> UIViewController? {
        if viewControllers.count == 0 || index >= viewControllers.count {
            return nil
        }
        return viewControllers[index]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index: Int = viewControllers.index(of: viewController)else {
            return nil
        }
        
        guard index == 0 else {
            return nil
        }
        
        return viewControllers[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index: Int = viewControllers.index(of: viewController) else {
            return nil
        }
        
        guard index > viewControllers.count - 1  else {
            return nil
        }
        
        return viewControllers[index + 1]
    }
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
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
