//
//  NewDetailController.swift
//  单糖
//
//  Created by 金亮齐 on 16/9/14.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

import UIKit
import SnapKit

class NewDetailController: UIViewController {
    
    var newsTopic: NewsTopic?
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.barStyle = .Black
        navigationController?.navigationBar.barTintColor = YMColor(210, g: 63, b: 66, a: 1.0)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }

    private func setupUI() {
        view.backgroundColor = YMGlobalColor()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "new_more_titlebar_28x28_"), style: .Plain, target: self, action: #selector(homeDetailBBItemClick))
        navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        navigationController?.navigationBar.barStyle = .Default
        navigationItem.titleView = searchBar
        searchBar.placeholder = newsTopic?.source!
        
        view.addSubview(webView)
        
        view.addSubview(bottomView)
        
        webView.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(view)
            make.bottom.equalTo(bottomView.snp_top)
        }
        
        bottomView.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(view)
            make.height.equalTo(45)
        }
        
        let url = NSURL(string: newsTopic!.url!)
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
        bottomView.commentCount = newsTopic?.comment_count
    }
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.height = 30
        searchBar.width = SCREENW - 60
        return searchBar
    }()
    
    private lazy var bottomView: NewDetailBottomView = {
        let bottomView = NSBundle.mainBundle().loadNibNamed(String(NewDetailBottomView), owner: nil, options: nil).last as! NewDetailBottomView
        return bottomView
    }()
    
    private lazy var webView: UIWebView = {
        let webView = UIWebView()
        /// 自动对页面进行缩放以适应屏幕
        webView.scalesPageToFit = true
        webView.dataDetectorTypes = .All
        return webView
    }()
    
    /// 更多按钮点击
    func homeDetailBBItemClick() {
        NewShareView.show()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension NewDetailController {
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .Default
    }
}

