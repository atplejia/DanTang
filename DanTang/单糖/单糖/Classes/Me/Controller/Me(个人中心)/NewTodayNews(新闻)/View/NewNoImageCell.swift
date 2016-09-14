//
//  NewNoImageCell.swift
//  单糖
//
//  Created by 金亮齐 on 16/9/14.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

import UIKit

class NewNoImageCell: NewTopicCell {

    var newsTopic: NewsTopic? {
        didSet{
            titleLabel.text = String(newsTopic!.title!)
            if let publishTime = newsTopic?.publish_time {
                timeLabel.text = NSString.changeDateTime(publishTime)
            }
            
            if let sourceAvatar = newsTopic?.source_avatar {
                nameLabel.text = newsTopic!.source
                avatarImageView.setCircleHeader(sourceAvatar)
            }
            
            if let mediaInfo = newsTopic!.media_info {
                nameLabel.text = mediaInfo.name
                avatarImageView.setCircleHeader(mediaInfo.avatar_url!)
            }
            
            if let commentCount = newsTopic!.comment_count {
                if commentCount >= 10000 {
                    commentLabel.text = "\(commentCount / 10000)万评论"
                } else {
                    commentLabel.text = "\(commentCount)评论"
                }
            } else {
                commentLabel.hidden = true
            }
            
            filterWords = newsTopic?.filter_words
            if let label = newsTopic?.label {
                stickLabel.setTitle(" \(label) ", forState: .Normal)
                stickLabel.hidden = false
                closeButton.hidden = (label == "置顶") ?  true : false
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    /// 举报按钮点击
    override func closeBtnClick() {
        closeButtonClosure?(filterWords: filterWords!)
    }
    
    /// 举报按钮点击回调
    func closeButtonClick(closure:(filterWord: [YMFilterWord])->()) {
        closeButtonClosure = closure
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
