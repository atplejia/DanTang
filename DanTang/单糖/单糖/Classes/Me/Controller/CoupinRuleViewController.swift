//
//  CoupinRuleViewController.swift
//  单糖
//
//  Created by 金亮齐 on 16/8/4.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

import UIKit

class CoupinRuleViewController: QJLBaseViewController {

    private let webView = UIWebView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight))
    private let loadProgressAnimationView: LoadProgressAnimationView = LoadProgressAnimationView(frame: CGRectMake(0, 0, ScreenWidth, 3))
    var loadURLStr: String? {
        didSet {
            webView.loadRequest(NSURLRequest(URL: NSURL(string: loadURLStr!)!))
        }
    }
    
    var navTitle: String? {
        didSet {
            navigationItem.title = navTitle
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
        
        buildWebView()
        webView.addSubview(loadProgressAnimationView)
    }
    
    private func buildWebView() {
        webView.delegate = self
        webView.backgroundColor = UIColor.whiteColor()
        view.addSubview(webView)
    }
}

extension CoupinRuleViewController: UIWebViewDelegate {
    
    func webViewDidStartLoad(webView: UIWebView) {
        loadProgressAnimationView.startLoadProgressAnimation()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        loadProgressAnimationView.endLoadProgressAnimation()
    }


}
