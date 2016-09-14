//
//  QJLSeeAllTopicCell.swift
//  单糖
//
//  Created by 金亮齐 on 16/8/2.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

import UIKit
import Kingfisher
class QJLSeeAllTopicCell: UITableViewCell {
    var collection: QJLCollection? {
        didSet {
            let url = collection!.cover_image_url
            bgImageView.kf_setImageWithURL(NSURL(string: url!)!, placeholderImage: nil, optionsInfo: nil, progressBlock: nil) { (image, error, cacheType, imageURL) in
                self.placeholderButton.hidden = true
            }
            titleLabel.text = collection!.title
            subtitleLabel.text = collection!.subtitle
        }
    }
    
    @IBOutlet weak var bgImageView: UIImageView!
    
    @IBOutlet weak var placeholderButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgImageView.layer.cornerRadius = kCornerRadius
        bgImageView.layer.masksToBounds = true
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
