//
//  OrderStatuslViewController.swift
//  单糖
//
//  Created by 金亮齐 on 16/8/5.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

import UIKit

class OrderStatuslViewController: QJLBaseViewController {
    
    private var orderDetailTableView: LFBTableView?
    private var segment: LFBSegmentedControl!
    private var orderDetailVC: OrderDetailViewController?
    private var orderStatuses: [OrderStatus]? {
        didSet {
            orderDetailTableView?.reloadData()
        }
    }

    var order: Order? {
        didSet {
            orderStatuses = order?.status_timeline
            
            if order?.detail_buttons?.count > 0 {
                let btnWidth: CGFloat = 80
                let btnHeight: CGFloat = 40
                for i in 0..<order!.detail_buttons!.count {
                    let btn = UIButton(frame: CGRectMake(view.width - (10 + CGFloat(i + 1) * (btnWidth + 10)), view.height - 50 - 64 + (50 - btnHeight) * 0.5, btnWidth, btnHeight))
                    btn.setTitle(order!.detail_buttons![i].text, forState: UIControlState.Normal)
                    btn.backgroundColor = QJLColor(253, g: 212, b: 49,a: 1)
                    btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
                    btn.titleLabel?.font = UIFont.systemFontOfSize(13)
                    btn.layer.cornerRadius = 5;
                    btn.tag = order!.detail_buttons![i].type
                    btn.addTarget(self, action: "detailButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
                    view.addSubview(btn)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildNavigationItem()
        
        buildOrderDetailTableView()
        

    }
    
    private func buildNavigationItem() {
     
        weak var tmpSelf = self
        segment = LFBSegmentedControl(items: ["订单状态", "订单详情"], didSelectedIndex: { (index) -> () in
            if index == 0 {
                tmpSelf!.showOrderStatusView()
            } else if index == 1 {
                tmpSelf!.showOrderDetailView()
            }
        })
        navigationItem.titleView = segment
        navigationItem.titleView?.frame = CGRectMake(0, 5, 180, 27)
    }
    
    private func buildOrderDetailTableView() {
        orderDetailTableView = LFBTableView(frame: CGRectMake(0,0, ScreenWidth, ScreenHeight), style: .Plain)
        orderDetailTableView?.backgroundColor = UIColor.whiteColor()
        orderDetailTableView?.delegate = self
        orderDetailTableView?.dataSource = self
        orderDetailTableView?.rowHeight = 80
        view.addSubview(orderDetailTableView!)
    }

    func detailButtonClick(sender: UIButton) {
        print("点击了底部按钮 类型是" + "\(sender.tag)")
    }
    
    func showOrderStatusView() {
        weak var tmpSelf = self
        tmpSelf!.orderDetailVC?.view.hidden = true
        tmpSelf!.orderDetailTableView?.hidden = false
    }
    
    func showOrderDetailView() {
        weak var tmpSelf = self
        if tmpSelf!.orderDetailVC == nil {
            tmpSelf!.orderDetailVC = OrderDetailViewController()
            tmpSelf!.orderDetailVC?.view.hidden = false
            tmpSelf!.orderDetailVC?.order = order
            tmpSelf!.addChildViewController(orderDetailVC!)
            tmpSelf!.view.insertSubview(orderDetailVC!.view, atIndex: 0)
        } else {
            tmpSelf!.orderDetailVC?.view.hidden = false
        }
        tmpSelf!.orderDetailTableView?.hidden = true
    }
}

extension OrderStatuslViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = OrderStatusCell.orderStatusCell(tableView)
        cell.orderStatus = orderStatuses![indexPath.row]
        
        if indexPath.row == 0 {
            cell.orderStateType = .Top
        } else if indexPath.row == orderStatuses!.count - 1 {
            cell.orderStateType = .Bottom
        } else {
            cell.orderStateType = .Middle
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderStatuses?.count ?? 0
    }


}
