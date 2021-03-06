//
//  ShopCartCell.swift
//  单糖
//
//  Created by 金亮齐 on 16/8/5.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

import UIKit

class ShopCartCell: UITableViewCell {

    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let buyView    = BuyView()
    
    var goods: Goods? {
        didSet {
            if goods?.is_xf == 1 {
                titleLabel.text = "[精选]" + goods!.name!
            } else {
                titleLabel.text = goods?.name
            }
            
            priceLabel.text = "$" + goods!.price!.cleanDecimalPointZear()
            
            buyView.goods = goods
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = UITableViewCellSelectionStyle.None
        
        titleLabel.frame = CGRectMake(15, 0, ScreenWidth * 0.5, 50)
        titleLabel.font = UIFont.systemFontOfSize(15)
        titleLabel.textColor = UIColor.blackColor()
        contentView.addSubview(titleLabel)
        
        buyView.frame = CGRectMake(ScreenWidth - 85, (50 - 25) * 0.55, 80, 25)
        contentView.addSubview(buyView)
        
        priceLabel.frame = CGRectMake(CGRectGetMinX(buyView.frame) - 100 - 5, 0, 100, 50)
        priceLabel.textAlignment = NSTextAlignment.Right
        contentView.addSubview(priceLabel)
        
        let lineView = UIView(frame: CGRectMake(10, 50 - 0.5, ScreenWidth - 10, 0.5))
        lineView.backgroundColor = UIColor.blackColor()
        lineView.alpha = 0.1
        contentView.addSubview(lineView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static private let identifier = "ShopCarCell"
    
    class func shopCarCell(tableView: UITableView) -> ShopCartCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? ShopCartCell
        
        if cell == nil {
            cell = ShopCartCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)
        }
        
        return cell!
    }


}
