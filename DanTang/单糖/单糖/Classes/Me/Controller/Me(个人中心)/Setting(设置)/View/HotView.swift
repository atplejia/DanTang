//
//  HotView.swift
//  单糖
//
//  Created by 金亮齐 on 16/8/5.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

import UIKit

class HotView: UIView {

    private let iconW = (ScreenWidth - 2 * 10) * 0.25
    private let iconH: CGFloat = 80
    
    var iconClick:((index: Int) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, iconClick: ((index: Int) -> Void)) {
        self.init(frame:frame)
        self.iconClick = iconClick
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: 模型的Set方法
    var headData: HeadData? {
        didSet {
            if headData?.icons?.count > 0 {
                
                if headData!.icons!.count % 4 != 0 {
                    self.rows = headData!.icons!.count / 4 + 1
                } else {
                    self.rows = headData!.icons!.count / 4
                }
                var iconX: CGFloat = 0
                var iconY: CGFloat = 0
                
                for i in 0..<headData!.icons!.count {
                    iconX = CGFloat(i % 4) * iconW + 10
                    iconY = iconH * CGFloat(i / 4)
                    let icon = IconImageTextView(frame: CGRectMake(iconX, iconY, iconW, iconH), placeholderImage: UIImage(named: "icon_icons_holder")!)
                    
                    icon.tag = i
                    icon.activitie = headData!.icons![i]
                    let tap = UITapGestureRecognizer(target: self, action: "iconClick:")
                    icon.addGestureRecognizer(tap)
                    addSubview(icon)
                }
            }
        }
    }
    // MARK: rows数量
    private var rows: Int = 0 {
        willSet {
            bounds = CGRectMake(0, 0, ScreenWidth, iconH * CGFloat(newValue))
        }
    }
    
    // MARK:- Action
    func iconClick(tap: UITapGestureRecognizer) {
        if iconClick != nil {
            iconClick!(index: tap.view!.tag)
        }
    }


}
