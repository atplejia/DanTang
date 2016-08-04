//
//  QJLDetailChoiceButtonView.swift
//  单糖
//
//  Created by 金亮齐 on 16/8/2.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

import UIKit

protocol QJLDetailChoiceButtonViewDegegate: NSObjectProtocol {
    /// 图文介绍按钮点击
    func choiceIntroduceButtonClick()
    /// 评论按钮点击
    func choicecommentButtonClick()
}

class QJLDetailChoiceButtonView: UIView {

    weak var delegate: QJLDetailChoiceButtonViewDegegate?
    
    @IBOutlet weak var lineView: UIView!
    
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var commentButton: UIButton!
    
    @IBAction func introduceButtonClick(sender: UIButton) {
        UIView.animateWithDuration(kAnimationDuration) {
            self.lineView.x = 0
        }
        delegate?.choiceIntroduceButtonClick()
    }
    
    @IBAction func commentButtonClick(sender: UIButton) {
        UIView.animateWithDuration(kAnimationDuration) {
            self.lineView.x = SCREENW * 0.5
        }
        delegate?.choicecommentButtonClick()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    class func choiceButtonView() -> QJLDetailChoiceButtonView{
        return NSBundle.mainBundle().loadNibNamed(String(self), owner: nil, options: nil).last as! QJLDetailChoiceButtonView
    }


}
