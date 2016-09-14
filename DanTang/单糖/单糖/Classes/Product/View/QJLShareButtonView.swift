//
//  QJLShareButtonView.swift
//  单糖
//
//  Created by 金亮齐 on 16/8/2.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

import UIKit

class QJLShareButtonView: UIView {
    
     private let blogURLStr = "http://git.oschina.net/www.skyheng.com/DanTang"
     private let authorImage = UIImage(named: "more_icon_about_author")
     private let shareText = "Swift全新开源作品"
    // 图片数组
    let images = ["Share_WeChatTimelineIcon_70x70_", "Share_WeChatSessionIcon_70x70_", "Share_WeiboIcon_70x70_", "Share_QzoneIcon_70x70_", "Share_QQIcon_70x70_", "Share_CopyLinkIcon_70x70_"]
    // 标题数组
    let titles = ["微信朋友圈", "微信好友", "微博", "QQ 空间", "QQ 好友", "复制链接"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    private func setupUI() {
        
        let maxCols = 3
        
        let buttonW: CGFloat = 70
        let buttonH: CGFloat = buttonW + 30
        let buttonStartX: CGFloat = 20
        let xMargin: CGFloat = (SCREENW - 20 - 2 * buttonStartX - CGFloat(maxCols) * buttonW) / CGFloat(maxCols - 1)
        
        // 创建按钮
        for index in 0..<images.count {
            let button = QJLVerticalButton()
            button.tag = index
            button.setImage(UIImage(named: images[index]), forState: .Normal)
            button.setTitle(titles[index], forState: .Normal)
            button.setTitleColor(UIColor.blackColor(), forState: .Normal)
            button.titleLabel?.font = UIFont.systemFontOfSize(14)
            button.width = buttonW
            button.height = buttonH
            button.addTarget(self, action: #selector(shareButtonClick(_:)), forControlEvents: .TouchUpInside)
            
            // 计算 X、Y
            let row = Int(index / maxCols)
            let col = index % maxCols
            let buttonX: CGFloat = CGFloat(col) * (xMargin + buttonW) + buttonStartX
            let buttonMaxY: CGFloat = CGFloat(row) * buttonH
            let buttonY = buttonMaxY
            button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH)
            addSubview(button)
        }
    }
    
    func shareButtonClick(button: UIButton) {
        if let shareButtonType = QJLShareButtonType(rawValue: button.tag) {
            switch shareButtonType {
                
            case .WeChatTimeline:
                
            
                break
            case .WeChatSession:
                UMSocialData.defaultData().extConfig.wechatSessionData.url = blogURLStr
                UMSocialData.defaultData().extConfig.wechatSessionData.title = "Swift开源新作"
                
                
                let shareURL = UMSocialUrlResource(snsResourceType: UMSocialUrlResourceTypeImage, url: blogURLStr)
                
                UMSocialDataService.defaultDataService().postSNSWithTypes([UMShareToWechatSession], content: "醉看红尘这场梦", image: authorImage, location: nil, urlResource: shareURL,  presentedController: nil) { (response) -> Void in
                    if response.responseCode.rawValue == UMSResponseCodeSuccess.rawValue {
                        let alert = UIAlertView(title: "成功", message: "分享成功", delegate: nil, cancelButtonTitle: "知道了")
                        alert.show()
                    } else {
                        let alert = UIAlertView(title: "失败", message: "分享失败", delegate: nil, cancelButtonTitle: "知道了")
                        alert.show()
                    }
                }
              
                break
            case .Weibo:
                
                break
            case .QZone:
                
                break
            case .QQFriends:
                
                UMSocialData.defaultData().extConfig.qqData.url = blogURLStr
                UMSocialData.defaultData().extConfig.qqData.title = "Swift开源新作"
                
                
                let shareURL = UMSocialUrlResource(snsResourceType: UMSocialUrlResourceTypeImage, url: blogURLStr)
                
                UMSocialDataService.defaultDataService().postSNSWithTypes([UMShareToQQ], content: "醉看红尘这场梦", image: authorImage, location: nil, urlResource: shareURL,  presentedController: nil) { (response) -> Void in
                    if response.responseCode.rawValue == UMSResponseCodeSuccess.rawValue {
                        let alert = UIAlertView(title: "成功", message: "分享成功", delegate: nil, cancelButtonTitle: "知道了")
                        alert.show()
                    } else {
                        let alert = UIAlertView(title: "失败", message: "分享失败", delegate: nil, cancelButtonTitle: "知道了")
                        alert.show()
                    }
                }

                
                break
            case .CopyLink:
                
                break
            }
        }
  
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    

}
