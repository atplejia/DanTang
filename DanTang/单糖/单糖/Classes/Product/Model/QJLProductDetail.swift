//
//  QJLProductDetail.swift
//  单糖
//
//  Created by 金亮齐 on 16/8/2.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

import UIKit

class QJLProductDetail: NSObject {
    var describe: String?
    
    var liked: Bool?
    
    var url: String?
    
    var purchase_url: String?
    
    var image_urls: [String]?
    
    var comments_count: Int?
    
    var detail_html: String?
    
    var name: String?
    
    var id: Int?
    
    var price: String?
    
    
    init(dict: [String: AnyObject]) {
        describe = dict["description"] as? String
        id = dict["id"] as? Int
        comments_count = dict["comments_count"] as? Int
        image_urls = dict["image_urls"] as? [String]
        name = dict["name"] as? String
        price = dict["price"] as? String
        purchase_url = dict["purchase_url"] as? String
        url = dict["url"] as? String
        liked = dict["liked"] as? Bool
        detail_html = dict["detail_html"] as? String
    }


}
