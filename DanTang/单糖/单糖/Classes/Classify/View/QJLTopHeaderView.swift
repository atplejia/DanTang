//
//  QJLTopHeaderView.swift
//  单糖
//
//  Created by 金亮齐 on 16/8/2.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

import UIKit

protocol QJLTopHeaderViewDelegate: NSObjectProtocol {
    func topViewDidClickedMoreButton(button: UIButton)
}

class QJLTopHeaderView: UIView {

    weak var delegate: QJLTopHeaderViewDelegate?
    
    /// 查看全部按钮
    @IBAction func viewAllButton(sender: UIButton) {
        delegate?.topViewDidClickedMoreButton(sender)
    }

}
