//
//  QJLCollectionViewCell.swift
//  单糖
//
//  Created by 金亮齐 on 16/8/2.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

import UIKit
import Kingfisher

protocol QJLCollectionViewCellDelegate: NSObjectProtocol {
    func collectionViewCellDidClickedLikeButton(button: UIButton)
}

class QJLCollectionViewCell: UICollectionViewCell {

    weak var delegate: QJLCollectionViewCellDelegate?
    
    var result: QJLSearchResult? {
        didSet {
            let url = result!.cover_image_url!
            productImageView.kf_setImageWithURL(NSURL(string: url)!, placeholderImage: nil, optionsInfo: nil, progressBlock: nil) { (image, error, cacheType, imageURL) in
                self.placeholderBtn.hidden = true
            }
            likeButton.setTitle(" " + String(result!.favorites_count!) + " ", forState: .Normal)
            titleLabel.text = result!.name
            priceLabel.text = "￥" + String(result!.price!)
        }
    }
    
    
    var product: QJLProduct? {
        didSet {
            let url = product!.cover_image_url!
            productImageView.kf_setImageWithURL(NSURL(string: url)!, placeholderImage: nil, optionsInfo: nil, progressBlock: nil) { (image, error, cacheType, imageURL) in
                self.placeholderBtn.hidden = true
            }
            likeButton.setTitle(" " + String(product!.favorites_count!) + " ", forState: .Normal)
            titleLabel.text = product!.name
            priceLabel.text = "￥" + String(product!.price!)
        }
    }
    // 占位图片
    @IBOutlet weak var placeholderBtn: UIButton!
    // 背景图片
    @IBOutlet weak var productImageView: UIImageView!
    // 标题
    @IBOutlet weak var titleLabel: UILabel!
    // 价格
    @IBOutlet weak var priceLabel: UILabel!
    // 喜欢按钮
    @IBOutlet weak var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func likeButtonClick(sender: UIButton) {
        delegate?.collectionViewCellDidClickedLikeButton(sender)
    }


}
