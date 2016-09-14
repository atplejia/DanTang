//
//  YMAddTopicViewController.swift
//  单糖
//
//  Created by 金亮齐 on 16/9/14.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

import UIKit

class YMAddTopicViewController: UIViewController {
    
    /// 我的频道
    var myTopics = [NewsTopTitle]()
    /// 推荐频道
    var recommendTopics = [NewsTopTitle]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        /// 获取推荐标题内容
        QJLNetworkTool.shareNetworkTool.loadRecommendTopic { [weak self] (topics) in
            self!.recommendTopics = topics
            
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    private func setupUI() {
        view.backgroundColor = UIColor.whiteColor()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "add_channels_close_20x20_"), style: .Plain, target: self, action: #selector(closeBBItemClick))
        // 去除 navigationBar 底部的黑线
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
    }
    
    
    func closeBBItemClick() {
        dismissViewControllerAnimated(false, completion: nil)
    }

}
