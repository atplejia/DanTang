//
//  QJLProductDetailBottomView.swift
//  单糖
//
//  Created by 金亮齐 on 16/8/2.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

import UIKit
import SnapKit

let commentCellID = "commentCellID"

class QJLProductDetailBottomView: UIView {

    
    var comments = [QJLComment]()
    
    var product: QJLProduct? {
        didSet {
            weak var weakSelf = self
            /// 获取单品详细数据
            QJLNetworkTool.shareNetworkTool.loadProductDetailData(product!.id!) { (productDetail) in
                weakSelf!.choiceButtonView.commentButton.setTitle("评论(\(productDetail.comments_count!))", forState: .Normal)
                weakSelf!.webView.loadHTMLString(productDetail.detail_html!, baseURL: nil)
            }
            /// 获取评论数据
            QJLNetworkTool.shareNetworkTool.loadProductDetailComments(product!.id!) { (comments) in
                weakSelf!.comments = comments
                weakSelf!.tableView.reloadData()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    func setupUI() {
        // 添加顶部选择按钮 view（图文介绍，评论）
        addSubview(choiceButtonView)
        
        addSubview(tableView)
        
        addSubview(webView)
        
        choiceButtonView.snp_makeConstraints { (make) in
            make.size.equalTo(CGSizeMake(SCREENW, 44))
            make.top.equalTo(self)
        }
        
        tableView.snp_makeConstraints { (make) in
            make.top.equalTo(choiceButtonView.snp_bottom)
            make.left.right.bottom.equalTo(self)
        }
        
        webView.snp_makeConstraints { (make) in
            make.top.equalTo(choiceButtonView.snp_bottom)
            make.left.right.bottom.equalTo(self)
        }
    }
    
    private lazy var webView: UIWebView = {
        let webView = UIWebView()
        /// 自动对页面进行缩放以适应屏幕
        webView.scalesPageToFit = true
        webView.dataDetectorTypes = .All
        webView.delegate = self
        return webView
    }()
    
    private lazy var choiceButtonView: QJLDetailChoiceButtonView = {
        let choiceButtonView = QJLDetailChoiceButtonView.choiceButtonView()
        choiceButtonView.delegate = self
        return choiceButtonView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.hidden = true
        let nib = UINib(nibName: String(QJLCommentCell), bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: commentCellID)
        tableView.dataSource = self
        tableView.separatorStyle = .None
        tableView.rowHeight = 64
        return tableView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension QJLProductDetailBottomView: QJLDetailChoiceButtonViewDegegate, UIWebViewDelegate, UITableViewDataSource {
    
    // MARK: - YMDetailChoiceButtonViewDegegate
    func choiceIntroduceButtonClick() {
        tableView.hidden = true
        webView.hidden = false
    }
    
    func choicecommentButtonClick() {
        tableView.hidden = false
        webView.hidden = true
        
    }
    
    // MARK: - UIWebViewDelegate
    func webViewDidStartLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    // MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(commentCellID) as! QJLCommentCell
        cell.comment = comments[indexPath.row]
        return cell
    }
    

}
