//
//  QJLTabBarController.swift
//  单糖
//
//  Created by 金亮齐 on 16/8/2.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

import UIKit

class QJLTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = UIColor(red: 245 / 255, green: 80 / 255, blue: 83 / 255, alpha: 1.0)
        // 添加子控制器
        addChildViewControllers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /**
     # 添加子控制器
     */
    private func addChildViewControllers() {
        addChildViewController("QJLDanTangViewController", title: "单糖", imageName: "TabBar_home_23x23_")
        addChildViewController("QJLProductViewController", title: "单品", imageName: "TabBar_gift_23x23_")
        addChildViewController("QJLCategoryViewController", title: "分类", imageName: "TabBar_category_23x23_")
        addChildViewController("QJLMeViewController", title: "我", imageName: "TabBar_me_boy_23x23_")
    }
    
    /**
     # 初始化子控制器
     
     - parameter childControllerName: 需要初始化的控制器
     - parameter title:               标题
     - parameter imageName:           图片名称
     */
    private func addChildViewController(childControllerName: String, title: String, imageName: String) {
        // 动态获取命名空间
        let ns = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String
        // 将字符串转化为类，默认情况下命名空间就是项目名称，但是命名空间可以修改
        let cls: AnyClass? = NSClassFromString(ns + "." + childControllerName)
        let vcClass = cls as! UIViewController.Type
        let vc = vcClass.init()
        // 设置对应的数据
        vc.tabBarItem.image = UIImage(named: imageName)
        vc.tabBarItem.selectedImage = UIImage(named: imageName + "selected")
        vc.title = title
        // 给每个控制器包装一个导航控制器
        let nav = QJLNavigationController()
        nav.addChildViewController(vc)
        addChildViewController(nav)
    }

}
