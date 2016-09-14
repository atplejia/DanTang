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
    
    private var segment: LFBSegmentedControl!
    private var systemTableView: LFBTableView!
    private var systemMessage: [UserMessage]?
    private var userMessage: [UserMessage]?
    private var secondView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bulidSystemTableView()
        bulidSecontView()
        bulidSegmentedControl()
        showSystemTableView()
        loadSystemMessage()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func bulidSecontView() {
        secondView = UIView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64))
        secondView?.backgroundColor = QJLColor(239, g: 239, b: 239,a: 1)

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
    
    private func bulidSegmentedControl() {
        weak var tmpSelf = self
        segment = LFBSegmentedControl(items: ["系统消息", "用户消息"], didSelectedIndex: { (index) -> () in
            if 0 == index {
                tmpSelf!.showSystemTableView()
            } else if 1 == index {
                tmpSelf!.showUserTableView()
            }
        })
        navigationItem.titleView = segment
        navigationItem.titleView?.frame = CGRectMake(0, 5, 180, 27)
    }
    
    private func bulidSystemTableView() {
        systemTableView = LFBTableView(frame: view.bounds, style: .Plain)
        systemTableView.backgroundColor = QJLColor(239, g: 239, b: 239,a: 1)

        systemTableView.showsHorizontalScrollIndicator = false
        systemTableView.showsVerticalScrollIndicator = false
        systemTableView.delegate = self
        systemTableView.dataSource = self
        systemTableView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0)
        view.addSubview(systemTableView)
        
        loadSystemTableViewData()
    }
    
    private func loadSystemTableViewData() {
        weak var tmpSelf = self
        UserMessage.loadSystemMessage { (data, error) -> () in
            tmpSelf!.systemMessage = data
            tmpSelf!.systemTableView.reloadData()
        }
    }
    
    private func loadSystemMessage() {
        weak var tmpSelf = self
        UserMessage.loadSystemMessage { (data, error) -> () in
            tmpSelf!.systemMessage = data
            tmpSelf!.systemTableView.reloadData()
        }
    }
    
    private func showSystemTableView() {
        secondView?.hidden = true
    }
    
    private func showUserTableView() {
        secondView?.hidden = false
    }
    
}

extension QJLMessageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = SystemMessageCell.systemMessageCell(tableView)
        cell.message = systemMessage![indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return systemMessage?.count ?? 0
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let message = systemMessage![indexPath.row]
        
        return message.cellHeight
    }

    

}




