//
//  YMShareVerticalButton.swift
//  单糖
//
//  Created by 金亮齐 on 16/9/14.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

import UIKit

class YMShareVerticalButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.textAlignment = .Center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 调整图片
        imageView?.centerX = self.width * 0.5
        imageView?.y = 0
        imageView?.width = 60
        imageView?.height = 60
        // 调整文字
        titleLabel?.x = 0
        titleLabel?.y = imageView!.height + 7
        titleLabel?.width = self.width
        titleLabel?.height = self.height - self.titleLabel!.y
    }

}
