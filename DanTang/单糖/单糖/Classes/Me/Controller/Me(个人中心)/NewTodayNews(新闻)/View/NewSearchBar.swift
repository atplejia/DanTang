//
//  NewSearchBar.swift
//  单糖
//
//  Created by 金亮齐 on 16/9/14.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

import UIKit
import SnapKit
class NewSearchBar: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = YMGlobalColor()
        addSubview(searchBar)
        
        searchBar.snp_makeConstraints { (make) in
            make.size.equalTo(CGSizeMake(SCREENW - 30, 30))
            make.center.equalTo(self)
        }
    }
    
    lazy var searchBar: YMSearchBar = {
        let searchBar = YMSearchBar()
        searchBar.placeholder = "搜索"
        return searchBar
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class YMSearchBar: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.whiteColor()
        layer.cornerRadius = kCornerRadius
        layer.masksToBounds = true
        let searchIcon = UIImageView()
        font = UIFont.systemFontOfSize(15)
        searchIcon.image = UIImage(named: "search_discover_16x16_")
        searchIcon.width = 16
        searchIcon.height = 16
        leftView = searchIcon
        leftViewMode = .Always
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
