//
//  YMHomeShare.swift
//  单糖
//
//  Created by 金亮齐 on 16/9/13.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

import UIKit

class YMHomeShare: NSObject {
    
    var icon: NSString?
    
    var icon_night: NSString?
    
    var title: String?
    
    init(dict: [String: AnyObject]) {
        super.init()
        icon = dict["icon"] as? String
        icon_night = dict["icon_night"] as? String
        title = dict["title"] as? String
    }
}