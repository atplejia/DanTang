//
//  SelectedAdressViewController.swift
//  单糖
//
//  Created by 金亮齐 on 16/8/4.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

import UIKit

class SelectedAdressViewController: AnimationViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildNavigationItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if UserInfo.sharedUserInfo.hasDefaultAdress() {
            let titleView = AdressTitleView(frame: CGRectMake(0, 0, 0, 30))
            titleView.setTitle(UserInfo.sharedUserInfo.defaultAdress()!.address!)
            titleView.frame = CGRectMake(0, 0, titleView.adressWidth, 30)
            navigationItem.titleView = titleView
            
            let tap = UITapGestureRecognizer(target: self, action: "titleViewClick")
            navigationItem.titleView?.addGestureRecognizer(tap)
        }
    }
    
    // MARK: - Build UI
    private func buildNavigationItem() {


        let titleView = AdressTitleView(frame: CGRectMake(0, 0, 0, 30))
        titleView.frame = CGRectMake(0, 0, titleView.adressWidth, 30)
        navigationItem.titleView = titleView
        
        
        
        let tap = UITapGestureRecognizer(target: self, action: "titleViewClick")
        navigationItem.titleView?.addGestureRecognizer(tap)
    }
    
    
    
    func titleViewClick() {
        weak var tmpSelf = self
        
//        let adressVC = MyAdressViewController { (adress) -> () in
//            let titleView = AdressTitleView(frame: CGRectMake(0, 0, 0, 30))
//            titleView.setTitle(adress.address!)
//            titleView.frame = CGRectMake(0, 0, titleView.adressWidth, 30)
//            tmpSelf?.navigationItem.titleView = titleView
//            UserInfo.sharedUserInfo.setDefaultAdress(adress)
//            
//            let tap = UITapGestureRecognizer(target: self, action: "titleViewClick")
//            tmpSelf?.navigationItem.titleView?.addGestureRecognizer(tap)
//        }
//        adressVC.isSelectVC = true
//        navigationController?.pushViewController(adressVC, animated: true)
//    }

}
}
