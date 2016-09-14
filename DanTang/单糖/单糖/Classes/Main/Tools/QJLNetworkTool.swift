//
//  QJLNetworkTool.swift
//  单糖
//
//  Created by 金亮齐 on 16/8/2.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

import Foundation
import Alamofire
import SVProgressHUD
import SwiftyJSON

let NEW_URL = "http://lf.snssdk.com/"

class QJLNetworkTool: NSObject {
    
    /// 单例
    static let shareNetworkTool = QJLNetworkTool()
    
    /// 获取首页数据
    func loadHomeInfo(id: Int, finished:(homeItems: [QJLHomeItem]) -> ()) {

        let url = BASE_URL + "v1/channels/\(id)/items"
        let params = ["gender": 1,
                      "generation": 1,
                      "limit": 20,
                      "offset": 0]
        Alamofire
            .request(.GET, url, parameters: params)
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    SVProgressHUD.showErrorWithStatus("加载失败...")
                    return
                }
                if let value = response.result.value {
                    let dict = JSON(value)
                    let code = dict["code"].intValue
                    let message = dict["message"].stringValue
                    guard code == RETURN_OK else {
                        SVProgressHUD.showInfoWithStatus(message)
                        return
                    }
                    let data = dict["data"].dictionary
                    //  字典转成模型
                    if let items = data!["items"]?.arrayObject {
                        var homeItems = [QJLHomeItem]()
                        for item in items {
                            let homeItem = QJLHomeItem(dict: item as! [String: AnyObject])
                            homeItems.append(homeItem)
                        }
                        finished(homeItems: homeItems)
                    }
                }
        }
    }
    
    /// 获取首页顶部选择数据
    func loadHomeTopData(finished:(ym_channels: [QJLChannel]) -> ()) {
        
        let url = BASE_URL + "v2/channels/preset"
        let params = ["gender": 1,
                      "generation": 1]
        Alamofire
            .request(.GET, url, parameters: params)
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    SVProgressHUD.showErrorWithStatus("加载失败...")
                    return
                }
                if let value = response.result.value {
                    let dict = JSON(value)
                    let code = dict["code"].intValue
                    let message = dict["message"].stringValue
                    guard code == RETURN_OK else {
                        SVProgressHUD.showInfoWithStatus(message)
                        return
                    }
                    SVProgressHUD.dismiss()
                    let data = dict["data"].dictionary
                    if let channels = data!["channels"]?.arrayObject {
                        var ym_channels = [QJLChannel]()
                        for channel in channels {
                            let ym_channel = QJLChannel(dict: channel as! [String: AnyObject])
                            ym_channels.append(ym_channel)
                        }
                        finished(ym_channels: ym_channels)
                    }
                }
        }
    }
    
    
    /// 搜索界面数据
    func loadHotWords(finished:(words: [String]) -> ()) {
        SVProgressHUD.showWithStatus("正在加载...")
        let url = BASE_URL + "v1/search/hot_words"
        Alamofire
            .request(.GET, url)
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    SVProgressHUD.showErrorWithStatus("加载失败...")
                    return
                }
                if let value = response.result.value {
                    let dict = JSON(value)
                    let code = dict["code"].intValue
                    let message = dict["message"].stringValue
                    guard code == RETURN_OK else {
                        SVProgressHUD.showInfoWithStatus(message)
                        return
                    }
                    SVProgressHUD.dismiss()
                    if let data = dict["data"].dictionary {
                        if let hot_words = data["hot_words"]?.arrayObject {
                            finished(words: hot_words as! [String])
                        }
                    }
                }
        }
    }
    

    
    /// 分类界面 顶部 专题合集
    func loadCategoryCollection(limit: Int, finished:(collections: [QJLCollection]) -> ()) {
        SVProgressHUD.showWithStatus("正在加载...")
        let url = BASE_URL + "v1/collections"
        let params = ["limit": limit,
                      "offset": 0]
        Alamofire
            .request(.GET, url, parameters: params)
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    SVProgressHUD.showErrorWithStatus("加载失败...")
                    return
                }
                if let value = response.result.value {
                    let dict = JSON(value)
                    let code = dict["code"].intValue
                    let message = dict["message"].stringValue
                    guard code == RETURN_OK else {
                        SVProgressHUD.showInfoWithStatus(message)
                        return
                    }
                    SVProgressHUD.dismiss()
                    if let data = dict["data"].dictionary {
                        if let collectionsData = data["collections"]?.arrayObject {
                            var collections = [QJLCollection]()
                            for item in collectionsData {
                                let collection = QJLCollection(dict: item as! [String: AnyObject])
                                collections.append(collection)
                            }
                            finished(collections: collections)
                        }
                    }
                }
        }
    }

    
    /// 顶部 专题合集 -> 专题列表
    func loadCollectionPosts(id: Int, finished:(posts: [QJLCollectionPost]) -> ()) {
        SVProgressHUD.showWithStatus("正在加载...")
        let url = BASE_URL + "v1/collections/\(id)/posts"
        let params = ["gender": 1,
                      "generation": 1,
                      "limit": 20,
                      "offset": 0]
        Alamofire
            .request(.GET, url, parameters: params)
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    SVProgressHUD.showErrorWithStatus("加载失败...")
                    return
                }
                if let value = response.result.value {
                    let dict = JSON(value)
                    let code = dict["code"].intValue
                    let message = dict["message"].stringValue
                    guard code == RETURN_OK else {
                        SVProgressHUD.showInfoWithStatus(message)
                        return
                    }
                    SVProgressHUD.dismiss()
                    if let data = dict["data"].dictionary {
                        if let postsData = data["posts"]?.arrayObject {
                            var posts = [QJLCollectionPost]()
                            for item in postsData {
                                let post = QJLCollectionPost(dict: item as! [String: AnyObject])
                                posts.append(post)
                            }
                            finished(posts: posts)
                        }
                    }
                }
        }
    }

    
    
    /// 分类界面 风格,品类
    func loadCategoryGroup(finished:(outGroups: [AnyObject]) -> ()) {
        SVProgressHUD.showWithStatus("正在加载...")
        let url = BASE_URL + "v1/channel_groups/all"
        Alamofire
            .request(.GET, url)
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    SVProgressHUD.showErrorWithStatus("加载失败...")
                    return
                }
                if let value = response.result.value {
                    let dict = JSON(value)
                    let code = dict["code"].intValue
                    let message = dict["message"].stringValue
                    guard code == RETURN_OK else {
                        SVProgressHUD.showInfoWithStatus(message)
                        return
                    }
                    SVProgressHUD.dismiss()
                    if let data = dict["data"].dictionary {
                        if let channel_groups = data["channel_groups"]?.arrayObject {
                            // outGroups 存储两个 inGroups 数组，inGroups 存储 YMGroup 对象
                            // outGroups 是一个二维数组
                            var outGroups = [AnyObject]()
                            for channel_group in channel_groups {
                                var inGroups = [QJLGroup]()
                                let channels = channel_group["channels"] as! [AnyObject]
                                for channel in channels {
                                    let group = QJLGroup(dict: channel as! [String: AnyObject])
                                    inGroups.append(group)
                                }
                                outGroups.append(inGroups)
                            }
                            finished(outGroups: outGroups)
                        }
                    }
                }
        }
    }
    
    /// 底部 风格品类 -> 列表
    func loadStylesOrCategoryInfo(id: Int, finished:(items: [QJLCollectionPost]) -> ()) {
        SVProgressHUD.showWithStatus("正在加载...")
        let url = BASE_URL + "v1/channels/\(id)/items"
        let params = ["limit": 20,
                      "offset": 0]
        Alamofire
            .request(.GET, url, parameters: params)
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    SVProgressHUD.showErrorWithStatus("加载失败...")
                    return
                }
                if let value = response.result.value {
                    let dict = JSON(value)
                    let code = dict["code"].intValue
                    let message = dict["message"].stringValue
                    guard code == RETURN_OK else {
                        SVProgressHUD.showInfoWithStatus(message)
                        return
                    }
                    SVProgressHUD.dismiss()
                    if let data = dict["data"].dictionary {
                        if let itemsData = data["items"]?.arrayObject {
                            var items = [QJLCollectionPost]()
                            for item in itemsData {
                                let post = QJLCollectionPost(dict: item as! [String: AnyObject])
                                items.append(post)
                            }
                            finished(items: items)
                        }
                    }
                }
        }
    }
    
    /// 获取单品数据
    func loadProductData(finished:(products: [QJLProduct]) -> ()) {
        SVProgressHUD.showWithStatus("正在加载...")
        let url = BASE_URL + "v2/items"
        let params = ["gender": 1,
                      "generation": 1,
                      "limit": 20,
                      "offset": 0]
        Alamofire
            .request(.GET, url, parameters: params)
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    SVProgressHUD.showErrorWithStatus("加载失败...")
                    return
                }
                if let value = response.result.value {
                    let dict = JSON(value)
                    let code = dict["code"].intValue
                    let message = dict["message"].stringValue
                    guard code == RETURN_OK else {
                        SVProgressHUD.showInfoWithStatus(message)
                        return
                    }
                    SVProgressHUD.dismiss()
                    if let data = dict["data"].dictionary {
                        if let items = data["items"]?.arrayObject {
                            var products = [QJLProduct]()
                            for item in items {
                                if let itemData = item["data"] {
                                    let product = QJLProduct(dict: itemData as! [String: AnyObject])
                                    products.append(product)
                                }
                            }
                            finished(products: products)
                        }
                    }
                }
        }
    }

    /// 获取单品详情数据
    func loadProductDetailData(id: Int, finished:(productDetail: QJLProductDetail) -> ()) {
        SVProgressHUD.showWithStatus("正在加载...")
        let url = BASE_URL + "v2/items/\(id)"
        Alamofire
            .request(.GET, url)
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    SVProgressHUD.showErrorWithStatus("加载失败...")
                    return
                }
                if let value = response.result.value {
                    let dict = JSON(value)
                    let code = dict["code"].intValue
                    let message = dict["message"].stringValue
                    guard code == RETURN_OK else {
                        SVProgressHUD.showInfoWithStatus(message)
                        return
                    }
                    SVProgressHUD.dismiss()
                    if let data = dict["data"].dictionaryObject {
                        let productDetail = QJLProductDetail(dict: data)
                        finished(productDetail: productDetail)
                    }
                }
        }
    }

    /// 商品详情 评论
    func loadProductDetailComments(id: Int, finished:(comments: [QJLComment]) -> ()) {
        SVProgressHUD.showWithStatus("正在加载...")
        let url = BASE_URL + "v2/items/\(id)/comments"
        let params = ["limit": 20,
                      "offset": 0]
        Alamofire
            .request(.GET, url, parameters: params)
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    SVProgressHUD.showErrorWithStatus("加载失败...")
                    return
                }
                if let value = response.result.value {
                    let dict = JSON(value)
                    let code = dict["code"].intValue
                    let message = dict["message"].stringValue
                    guard code == RETURN_OK else {
                        SVProgressHUD.showInfoWithStatus(message)
                        return
                    }
                    SVProgressHUD.dismiss()
                    if let data = dict["data"].dictionary {
                        if let commentsData = data["comments"]?.arrayObject {
                            var comments = [QJLComment]()
                            for item in commentsData {
                                let comment = QJLComment(dict: item as! [String: AnyObject])
                                comments.append(comment)
                            }
                            finished(comments: comments)
                        }
                    }
                }
        }
    }
    
    /// 根据搜索条件进行搜索
    func loadSearchResult(keyword: String, sort: String, finished:(results: [QJLSearchResult]) -> ()) {
        SVProgressHUD.showWithStatus("正在加载...")
        let url = "http://api.dantangapp.com/v1/search/item"
        
        let params = ["keyword": keyword,
                      "limit": 20,
                      "offset": 0,
                      "sort": sort]
        Alamofire
            .request(.GET, url, parameters: params as? [String : AnyObject])
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    SVProgressHUD.showErrorWithStatus("加载失败...")
                    return
                }
                if let value = response.result.value {
                    let dict = JSON(value)
                    let code = dict["code"].intValue
                    let message = dict["message"].stringValue
                    guard code == RETURN_OK else {
                        SVProgressHUD.showInfoWithStatus(message)
                        return
                    }
                    SVProgressHUD.dismiss()
                    let data = dict["data"].dictionary
                    if let items = data!["items"]?.arrayObject {
                        var results = [QJLSearchResult]()
                        for item in items {
                            let result = QJLSearchResult(dict: item as! [String: AnyObject])
                            results.append(result)
                        }
                        finished(results: results)
                    }
                }
        }
    }
    
    /// 有多少条文章更新
    func loadArticleRefreshTip(finished:(count: Int)->()) {
        let url = NEW_URL + "2/article/v39/refresh_tip/"
        Alamofire
            .request(.GET, url)
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    SVProgressHUD.showErrorWithStatus("加载失败...")
                    return
                }
                if let value = response.result.value {
                    let json = JSON(value)
                    let data = json["data"].dictionary
                    let count = data!["count"]!.int
                    finished(count: count!)
                }
        }
        
    }
    
    /// ------------------------ 新   闻 -------------------------
    //
    /// 获取新闻顶部标题内容(和视频内容使用一个接口)
    func loadNewsTitlesData(finished:(topTitles: [NewsTopTitle])->()) {
        let url = NEW_URL + "article/category/get_subscribed/v1/?"
        let params = ["device_id": device_id,
                      "aid": 13,
                      "iid": IID]
        Alamofire
            .request(.GET, url, parameters: params)
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    SVProgressHUD.showErrorWithStatus("加载失败...")
                    return
                }
                if let value = response.result.value {
                    let json = JSON(value)
                    let dataDict = json["data"].dictionary
                    if let data = dataDict!["data"]!.arrayObject {
                        var topics = [NewsTopTitle]()
                        for dict in data {
                            let title = NewsTopTitle(dict: dict as! [String: AnyObject])
                            topics.append(title)
                        }
                        finished(topTitles: topics)
                    }
                }
        }
    }
    
    
    /// 新闻 -> 『+』点击，添加标题，获取推荐标题内容
    func loadRecommendTopic(finished:(recommendTopics: [NewsTopTitle]) -> ()) {
        let url = "https://lf.snssdk.com/article/category/get_extra/v1/?"
        let params = ["device_id": device_id,
                      "aid": 13,
                      "iid": IID]
        Alamofire
            .request(.GET, url, parameters: params)
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    SVProgressHUD.showErrorWithStatus("加载失败...")
                    return
                }
                if let value = response.result.value {
                    let json = JSON(value)
                    if let data = json["data"].arrayObject {
                        var topics = [NewsTopTitle]()
                        for dict in data {
                            let title = NewsTopTitle(dict: dict as! [String: AnyObject])
                            topics.append(title)
                        }
                        finished(recommendTopics: topics)
                    }
                }
        }
    }
    
    /// 获取新闻不同分类的新闻内容(和视频内容使用一个接口)
    func loadCategoryNewsFeed(category: String, tableView: UITableView, finished:(nowTime: NSTimeInterval,newsTopics: [NewsTopic])->()) {
        let url = NEW_URL + "api/news/feed/v39/?"
        let params = ["device_id": device_id,
                      "category": category,
                      "iid": IID]
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            let nowTime = NSDate().timeIntervalSince1970
            Alamofire
                .request(.GET, url, parameters: params as? [String : AnyObject])
                .responseJSON { (response) in
                    tableView.mj_header.endRefreshing()
                    guard response.result.isSuccess else {
                        SVProgressHUD.showErrorWithStatus("加载失败...")
                        return
                    }
                    if let value = response.result.value {
                        let json = JSON(value)
                        let datas = json["data"].array
                        var topics = [NewsTopic]()
                        for data in datas! {
                            let content = data["content"].stringValue
                            let contentData: NSData = content.dataUsingEncoding(NSUTF8StringEncoding)!
                            do {
                                let dict = try NSJSONSerialization.JSONObjectWithData(contentData, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                                print(dict)
                                let topic = NewsTopic(dict: dict as! [String : AnyObject])
                                topics.append(topic)
                            } catch {
                                SVProgressHUD.showErrorWithStatus("获取数据失败!")
                            }
                            
                        }
                        finished(nowTime: nowTime, newsTopics: topics)
                    }
            }
        })
        tableView.mj_header.automaticallyChangeAlpha = true //根据拖拽比例自动切换透
        tableView.mj_header.beginRefreshing()
    }
    
    /// 获取新闻不同分类的新闻内容
    func loadCategoryMoreNewsFeed(category: String, lastRefreshTime: NSTimeInterval, tableView: UITableView, finished:(moreTopics: [NewsTopic])->()) {
        let url = NEW_URL + "api/news/feed/v39/?"
        let params = ["device_id": device_id,
                      "category": category,
                      "iid": IID,
                      "last_refresh_sub_entrance_interval": lastRefreshTime]
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            Alamofire
                .request(.GET, url, parameters: params as? [String : AnyObject])
                .responseJSON { (response) in
                    tableView.mj_footer.endRefreshing()
                    guard response.result.isSuccess else {
                        SVProgressHUD.showErrorWithStatus("加载失败...")
                        return
                    }
                    if let value = response.result.value {
                        let json = JSON(value)
                        let datas = json["data"].array
                        var topics = [NewsTopic]()
                        for data in datas! {
                            let content = data["content"].stringValue
                            let contentData: NSData = content.dataUsingEncoding(NSUTF8StringEncoding)!
                            do {
                                let dict = try NSJSONSerialization.JSONObjectWithData(contentData, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                                let topic = NewsTopic(dict: dict as! [String : AnyObject])
                                topics.append(topic)
                            } catch {
                                SVProgressHUD.showErrorWithStatus("获取数据失败!")
                            }
                        }
                        finished(moreTopics: topics)
                    }
            }
        })
    }

    
}
