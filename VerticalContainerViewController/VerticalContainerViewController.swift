//
//  VerticalContainerViewController.swift
//  VerticalContainerViewController
//
//  Created by Muronaka Hiroaki on 2017/05/21.
//  Copyright © 2017年 Muronaka Hiroaki. All rights reserved.
//

import UIKit

public protocol VerticalContainerViewControllerDataSource {
    
    func numberOfData(viewController: VerticalContainerViewController) -> Int
    
    func verticalViewController(_ viewController: VerticalContainerViewController, setupFor viewControlelr: UIViewController, at row: Int)
    
    func createPageViewController(viewController: VerticalContainerViewController) -> UIViewController
    
}

public protocol VerticalContainerViewControlelrDelegate {
    
    func verticalContainerViewController(viewController: VerticalContainerViewController,
                                         pageViewController: UIPageViewController,
                                         changeRow: Int)
}

/**
 * 上中下と３つのPageViewControllerを生成して、ページ切り替えをできるようにする
 */
open class VerticalContainerViewController: UIViewController {
    
    var dataSource: VerticalContainerViewControllerDataSource!
    var delegate: VerticalContainerViewController?
    
    var transition = VerticalPagingTransition()
    var currentPageViewController: UIViewController?
    
    public fileprivate(set) var currentIndex:Int = 0

    override open func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateViewController()
    }

    override open func didReceiveMemoryWarning() {
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
    public func pageUp() {
        updateViewController(isUp: true)
    }
    
    public func pageDown() {
        updateViewController(isUp : false)
    }
    
    fileprivate func updateViewController(isUp: Bool = true) {
        guard currentIndex < dataSource.numberOfData(viewController: self) else {
            return
        }
        
        if let currentVC = currentPageViewController {
            self.currentPageViewController = dataSource.createPageViewController(viewController: self)
            dataSource.verticalViewController(self, setupFor: self.currentPageViewController!, at: currentIndex)
            changePage(oldVC: currentVC,  newVC:self.currentPageViewController!, isUp: isUp)
        } else {
            self.currentPageViewController = dataSource.createPageViewController(viewController: self)
            dataSource.verticalViewController(self, setupFor: self.currentPageViewController!, at: currentIndex)
            add(childViewController: self.currentPageViewController!)
        }
    }
    
    fileprivate func changePage(oldVC: UIViewController, newVC: UIViewController, isUp: Bool) {
//        oldVC.beginAppearanceTransition(false, animated: true)
        oldVC.willMove(toParentViewController: nil)
        
//        newVC.beginAppearanceTransition(true, animated: true)
        self.addChildViewController(newVC)
        
        
        let newVCTo: CGRect = oldVC.view.frame
        var newVCFrom: CGRect = oldVC.view.frame
        var oldVCTo: CGRect = oldVC.view.frame
        
        if isUp {
            newVCFrom.origin.y = oldVC.view.frame.height
            oldVCTo.origin.y = -oldVC.view.frame.height
        } else {
            newVCFrom.origin.y = -oldVC.view.frame.height
            oldVCTo.origin.y = oldVC.view.frame.height 
        }
        
        newVC.view.frame = newVCFrom
        
        self.transition(from: oldVC, to: newVC, duration: 1.0, options: [] , animations: { 
            newVC.view.frame = newVCTo
            oldVC.view.frame = oldVCTo
        }) { isFinish in
            if isFinish {
                oldVC.removeFromParentViewController()
                newVC.didMove(toParentViewController: self)
            }
        }
        
        
        
    }
    
    fileprivate func remove(childViewController: UIViewController) {
        childViewController.beginAppearanceTransition(false, animated: true)
        childViewController.willMove(toParentViewController: nil)
        childViewController.view.removeFromSuperview()
        childViewController.removeFromParentViewController()
        childViewController.endAppearanceTransition()
    }
    
    fileprivate func add(childViewController: UIViewController) {
//        childViewController.beginAppearanceTransition(true, animated: true)
        self.addChildViewController(childViewController)
        childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        childViewController.view.frame = self.view.frame
        self.view.addSubview(childViewController.view)
        childViewController.didMove(toParentViewController: self)
//        childViewController.endAppearanceTransition()
    }

}
