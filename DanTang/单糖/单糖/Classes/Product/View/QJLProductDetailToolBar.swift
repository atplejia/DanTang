//
//  QJLProductDetailToolBar.swift
//  单糖
//
//  Created by 金亮齐 on 16/8/2.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

import UIKit

protocol QJLProductDetailToolBarDelegate: NSObjectProtocol {
    func toolBarDidClickedTMALLButton()
}

class QJLProductDetailToolBar: UIView {

    weak var delegate: QJLProductDetailToolBarDelegate?
    
    @IBOutlet weak var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        likeButton.layer.borderColor = QJLlobalRedColor().CGColor
        likeButton.layer.borderWidth = klineWidth
        likeButton.setImage(UIImage(named: "content-details_like_16x16_"), forState: .Normal)
        likeButton.setImage(UIImage(named: "content-details_like_selected_16x16_"), forState: .Selected)
    }
    
    @IBAction func likeButtonClick(sender: UIButton) {
        // 判断是否登录
        if NSUserDefaults.standardUserDefaults().boolForKey(isLogin) {
            sender.selected = !sender.selected
        } else {
            let loginVC = QJLLoginViewController()
            loginVC.title = "登录"
            let nav = QJLNavigationController(rootViewController: loginVC)
            UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(nav, animated: true, completion: nil)
        }
    }
    
    @IBAction func goTMALLButtonClick() {
        delegate?.toolBarDidClickedTMALLButton()
    }


}
