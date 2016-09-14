//
//  AppDelegate.swift
//  单糖
//
//  Created by 金亮齐 on 16/8/2.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        //创建window
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.makeKeyAndVisible()
        //检查进入沙盒是否引导页的判断
        if !NSUserDefaults.standardUserDefaults().boolForKey(QJLFirstLaunch) {
            window?.rootViewController = QJLNewfeatureViewController()
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: QJLFirstLaunch)
        }else{
            window?.rootViewController = QJLTabBarController()
        }
        
   
        setUM()
        return true
        
    }
    
    //重写openURL
    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject])
        -> Bool {
            return TencentOAuth.HandleOpenURL(url)
    }
    
    //重写handleOpenURL
    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        return TencentOAuth.HandleOpenURL(url)
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func setUM() {
        UMSocialData.setAppKey("569f662be0f55a0efa0001cc")
        UMSocialWechatHandler.setWXAppId("wx2db791be2eb77467", appSecret: "f7ce3d560e9c5ef85dcac21a46b07b73", url: "http://git.oschina.net/www.skyheng.com")
        UMSocialQQHandler.setQQWithAppId("100371282", appKey: "aed9b0303e3ed1e27bae87c33761161d", url: "http://git.oschina.net/www.skyheng.com")
        UMSocialSinaSSOHandler.openNewSinaSSOWithAppKey("1939108327", redirectURL: "http://weibo.com/u/5500516766")
        
        UMSocialConfig.hiddenNotInstallPlatforms([UMShareToWechatSession, UMShareToQzone, UMShareToQQ, UMShareToSina, UMShareToWechatTimeline])
    }

}

