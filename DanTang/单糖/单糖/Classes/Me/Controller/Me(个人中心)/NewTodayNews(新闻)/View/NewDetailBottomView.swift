//
//  NewDetailBottomView.swift
//  单糖
//
//  Created by 金亮齐 on 16/9/14.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

import UIKit

class NewDetailBottomView: UIView {

    var commentCount: Int? {
        didSet {
            // 评论数量
            commentCountLabel.text = "\(commentCount!) "
            commentCountLabel.hidden = (commentCount == 0) ? true : false
        }
    }
    
    
    @IBOutlet weak var commentCountLabel: UILabel!
    
    @IBOutlet weak var textFiled: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commentCountLabel.sizeToFit()
        textFiled.placeholder = "  写评轮..."
        textFiled.layer.cornerRadius = 15
        textFiled.layer.masksToBounds = true
        textFiled.layer.borderColor = YMColor(220, g: 220, b: 220, a: 1.0).CGColor
        textFiled.layer.borderWidth = klineWidth
    }
    
    @IBAction func commentButtonClick(sender: UIButton) {
        
    }
    
    @IBAction func likeButtonClick(sender: UIButton) {
        
    }
    
    @IBAction func shareButtonClick(sender: UIButton) {
        NewShareView.show()
    }


}
