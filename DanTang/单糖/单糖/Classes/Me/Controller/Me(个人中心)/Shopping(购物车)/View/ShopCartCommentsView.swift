//
//  ShopCartCommentsView.swift
//  单糖
//
//  Created by 金亮齐 on 16/8/5.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

import UIKit

class ShopCartCommentsView: UIView {

    var textField = UITextField()
    private let signCommentsLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.whiteColor()
        
        addSubview(lineView(CGRectMake(10, 0, ScreenWidth - 10, 0.5)))
        
        signCommentsLabel.text = "收货备注"
        signCommentsLabel.textColor = UIColor.blackColor()
        signCommentsLabel.font = UIFont.systemFontOfSize(15)
        signCommentsLabel.sizeToFit()
        signCommentsLabel.frame = CGRectMake(15, 0, signCommentsLabel.width, 50)
        addSubview(signCommentsLabel)
        
        textField.placeholder = "可输入100字以内特殊要求内容"
        textField.frame = CGRectMake(CGRectGetMaxX(signCommentsLabel.frame) + 10, 10, ScreenWidth - CGRectGetMaxX(signCommentsLabel.frame) - 10 - 20, 50 - 20)
        textField.font = UIFont.systemFontOfSize(15)
        textField.borderStyle = UITextBorderStyle.RoundedRect
        textField.autocorrectionType = UITextAutocorrectionType.No
        textField.autocapitalizationType = UITextAutocapitalizationType.None
        addSubview(textField)
        
        addSubview(lineView(CGRectMake(0, 50 - 0.5, ScreenWidth, 0.5)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func lineView(frame: CGRect) -> UIView {
        let lineView = UIView(frame: frame)
        lineView.backgroundColor = UIColor.blackColor()
        lineView.alpha = 0.1
        return lineView
    }


}
