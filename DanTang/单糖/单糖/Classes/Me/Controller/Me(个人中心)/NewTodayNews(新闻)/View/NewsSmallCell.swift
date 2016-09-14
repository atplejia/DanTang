//
//  NewsSmallCell.swift
//  单糖
//
//  Created by 金亮齐 on 16/9/14.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

import UIKit

class NewsSmallCell: NewsTopicCell {

    var newsTopic: NewsTopic? {
        didSet{
            titleLabel.text = String(newsTopic!.title!)
            timeLabel.text = NSString.changeDateTime(newsTopic!.publish_time!)
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
            
            if newsTopic!.image_list.count > 0 {
                for index in 0..<newsTopic!.image_list.count {
                    let imageView = UIImageView()
                    let imageList = newsTopic!.image_list[index]
                    let urlLlist = imageList.url_list![index]
                    let urlString = urlLlist["url"] as! String
                    if urlString.hasSuffix(".webp") {
                        let range = urlString.rangeOfString(".webp")
                        let url = urlString.substringToIndex(range!.startIndex)
                        imageView.kf_setImageWithURL(NSURL(string: url)!)
                    } else {
                        imageView.kf_setImageWithURL(NSURL(string: urlString)!)
                    }
                    let x: CGFloat = CGFloat(index) * (newsTopic!.imageW + 6)
                    imageView.frame = CGRectMake(x, 0, newsTopic!.imageW, newsTopic!.imageH)
                    imageView.backgroundColor = UIColor.lightGrayColor()
                    middleView.addSubview(imageView)
                }
            }
            
            if let label = newsTopic?.label {
                stickLabel.setTitle(" \(label) ", forState: .Normal)
                stickLabel.hidden = false
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(middleView)
        
        middleView.snp_makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp_bottom).offset(kMargin)
            make.left.equalTo(titleLabel.snp_left)
            make.right.equalTo(titleLabel.snp_right)
            make.bottom.equalTo(avatarImageView.snp_top).offset(-kMargin)
        }
    }
    
    /// 中间 3 张图的容器
    private lazy var middleView: UIView = {
        let middleView = UIView()
        return middleView
    }()
    
    /// 举报按钮点击
    override func closeBtnClick() {
        closeButtonClosure?(filterWords: filterWords!)
    }
    
    /// 举报按钮点击回调
    func closeButtonClick(closure:(filterWords: [YMFilterWord])->()) {
        closeButtonClosure = closure
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
