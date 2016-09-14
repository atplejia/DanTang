//
//  CouponViewController.swift
//  单糖
//
//  Created by 金亮齐 on 16/8/4.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

import UIKit
import SVProgressHUD
class CouponViewController: QJLBaseViewController {
    
    private var bindingCouponView: BindingCouponView?
    private var couponTableView: LFBTableView?
    
    private var useCoupons: [Coupon] = [Coupon]()
    private var unUseCoupons: [Coupon] = [Coupon]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNav()
        buildBindingCouponView()
        
        bulidCouponTableView()
        
        loadCouponData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setupNav()  {
    
     navigationItem.rightBarButtonItem = UIBarButtonItem(title: "使用规则", style: .Plain, target: self, action: #selector(rightItemClick))
        
        
    }
    
    // MARK: bulidUI
    
    func buildBindingCouponView() {
        bindingCouponView = BindingCouponView(frame: CGRectMake(0, 66, ScreenWidth, 50), bindingButtonClickBack: { (couponTextFiled) -> () in
            if couponTextFiled.text != nil && !(couponTextFiled.text!.isEmpty) {
                SVProgressHUD.showImage(UIImage(named: "v2_orderSuccess")!, status: "请输入正确的优惠劵")
            } else {
                let alert = UIAlertView(title: nil, message: "请输入优惠码!", delegate: nil, cancelButtonTitle: "确定")
                alert.show()
            }
        })
        view.addSubview(bindingCouponView!)
    }
    
    private func bulidCouponTableView() {
        couponTableView = LFBTableView(frame: CGRectMake(0, 116, ScreenWidth, ScreenHeight ), style: UITableViewStyle.Plain)
        couponTableView!.delegate = self
        couponTableView?.dataSource = self
        view.addSubview(couponTableView!)
    }
    // MARK: Method
    private func loadCouponData() {
        weak var tmpSelf = self
        CouponData.loadCouponData { (data, error) -> Void in
            if error != nil {
                return
            }
            
            if data?.data?.count > 0 {
                for obj in data!.data! {
                    switch obj.status {
                    case 0: tmpSelf!.useCoupons.append(obj)
                        break
                    default: tmpSelf!.unUseCoupons.append(obj)
                        break
                    }
                }
            }
            
            tmpSelf!.couponTableView?.reloadData()
        }
    }
    
    // MARK: Action
    func rightItemClick() {
        let couponRuleVC = CoupinRuleViewController()
        couponRuleVC.loadURLStr = "http://m.beequick.cn/show/webview/p/coupon?zchtauth=e33f2ac7BD%252BaUBDzk6f5D9NDsFsoCcna6k%252BQCEmbmFkTbwnA&__v=ios4.7&__d=d14ryS0MFUAhfrQ6rPJ9Gziisg%2F9Cf8CxgkzZw5AkPMbPcbv%2BpM4HpLLlnwAZPd5UyoFAl1XqBjngiP6VNOEbRj226vMzr3D3x9iqPGujDGB5YW%2BZ1jOqs3ZqRF8x1keKl4%3D"
        couponRuleVC.navTitle = "使用规则"
        navigationController?.pushViewController(couponRuleVC, animated: true)
    }
}

// - MARK: UITableViewDelegate, UITableViewDataSource
extension CouponViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if useCoupons.count > 0 && unUseCoupons.count > 0 {
            if 0 == section {
                return useCoupons.count
            } else {
                return unUseCoupons.count
            }
        }
        
        if useCoupons.count > 0 {
            return useCoupons.count
        }
        
        if unUseCoupons.count > 0 {
            return unUseCoupons.count
        }
        
        return 0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if useCoupons.count > 0 && unUseCoupons.count > 0 {
            return 2
        } else if useCoupons.count > 0 || unUseCoupons.count > 0 {
            return 1
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = CouponCell.cellWithTableView(tableView)
        var coupon: Coupon?
        if useCoupons.count > 0 && unUseCoupons.count > 0 {
            if 0 == indexPath.section {
                coupon = useCoupons[indexPath.row]
            } else {
                coupon = unUseCoupons[indexPath.row]
            }
        } else if useCoupons.count > 0 {
            coupon = useCoupons[indexPath.row]
        } else if unUseCoupons.count > 0 {
            coupon = unUseCoupons[indexPath.row]
        }
        
        cell.coupon = coupon!
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if unUseCoupons.count > 0 && useCoupons.count > 0 && 0 == section {
            return 10
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if unUseCoupons.count > 0 && useCoupons.count > 0 {
            if 0 == section {
                let footView = UIView(frame: CGRectMake(0, 0, ScreenWidth, 10))
                footView.backgroundColor = UIColor.clearColor()
                let lineView = UIView(frame: CGRectMake(CouponViewControllerMargin, 4.5, ScreenWidth - 2 * CouponViewControllerMargin, 1))
                lineView.backgroundColor = QJLColor(230, g: 230, b: 230,a: 1)
                footView.addSubview(lineView)
                return footView
            } else {
                return nil
            }
        } else {
            return nil
        }
    }



}
