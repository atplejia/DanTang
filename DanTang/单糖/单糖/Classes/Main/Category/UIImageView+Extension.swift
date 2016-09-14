//
//  UIImageView+Extension.swift
//  单糖
//
//  Created by 金亮齐 on 16/9/14.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setCircleHeader(url: String) {
        let placeholder = UIImage(named: "home_head_default_29x29_")
        self.kf_setImageWithURL(NSURL(string: url)!)
        self.kf_setImageWithURL(NSURL(string: url)!)
    }
}

