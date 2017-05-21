//
//  AppDelegate.swift
//  VerticalContainerViewControllerDemo
//
//  Created by Muronaka Hiroaki on 2017/05/21.
//  Copyright © 2017年 Muronaka Hiroaki. All rights reserved.
//

import UIKit
import VerticalContainerViewController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let rootViewController = VerticalContainerViewController()
        rootViewController.dataSource = self
        self.window?.rootViewController = rootViewController
        self.window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate: VerticalContainerViewControllerDataSource {
    
    func numberOfData(viewController: VerticalContainerViewController) -> Int {
        return 10
    }
    
    func verticalViewController(_ viewController: VerticalContainerViewController, setupFor viewControlelr: UIViewController, at row: Int) {
        let vc = viewControlelr as! SampleViewController
        vc.titleLabel.text = "\(row + 1)"
    }
    
    func createPageViewController(viewController: VerticalContainerViewController) -> UIViewController {
        let vc = SampleViewController(nibName: "SampleViewController", bundle: nil)
        vc.verticalContainerViewController = self.window!.rootViewController as! VerticalContainerViewController
        return vc
    }
}
