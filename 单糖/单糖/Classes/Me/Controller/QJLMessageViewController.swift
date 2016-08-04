//
//  QJLMessageViewController.swift
//  单糖
//
//  Created by 金亮齐 on 16/8/2.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

import UIKit

let messageCellID = "messageCellID"

class QJLMessageViewController: QJLBaseViewController {
    
    private var secondView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        bulidSecontView()

        // Do any additional setup after loading the view.
    }
    /// 创建 tableView
    private func setupTableView() {
      
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func bulidSecontView() {
        secondView = UIView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight))
        secondView?.backgroundColor = UIColor.clearColor()
        view.addSubview(secondView!)
        
        let normalImageView = UIImageView(image: UIImage(named: "v2_my_message_empty"))
        normalImageView.center = view.center
        normalImageView.center.y -= 150
        secondView?.addSubview(normalImageView)
        
        let normalLabel = UILabel()
        normalLabel.text = "~~~并没有消息~~~"
        normalLabel.textAlignment = NSTextAlignment.Center
        normalLabel.frame = CGRectMake(0, CGRectGetMaxY(normalImageView.frame) + 10, ScreenWidth, 50)
        secondView?.addSubview(normalLabel)
    }
    
}




