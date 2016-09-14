//
//  UserInfo.swift
//  单糖
//
//  Created by 金亮齐 on 16/8/4.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

import UIKit

class UserInfo: NSObject {
    
    private static let instance = UserInfo()
    
    private var allAdress: [Adress]?
    
    class var sharedUserInfo: UserInfo {
        return instance
    }
    
    func hasDefaultAdress() -> Bool {
        
        if allAdress != nil {
            return true
        } else {
            return false
        }
    }
    
    func setAllAdress(adresses: [Adress]) {
        allAdress = adresses
    }
    
    func cleanAllAdress() {
        allAdress = nil
    }
    
    func defaultAdress() -> Adress? {
        if allAdress == nil {
            weak var tmpSelf = self
            
            AdressData.loadMyAdressData { (data, error) -> Void in
                if data?.data?.count > 0 {
                    tmpSelf!.allAdress = data!.data!
                } else {
                    tmpSelf?.allAdress?.removeAll()
                }
            }
            
            return allAdress?.count > 1 ? allAdress![0] : nil
        } else {
            return allAdress![0]
        }
    }
    
    func setDefaultAdress(adress: Adress) {
        if allAdress != nil {
            allAdress?.insert(adress, atIndex: 0)
        } else {
            allAdress = [Adress]()
            allAdress?.append(adress)
        }
    }


}
