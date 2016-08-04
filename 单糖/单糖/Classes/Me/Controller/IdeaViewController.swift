//
//  IdeaViewController.swift
//  单糖
//
//  Created by 金亮齐 on 16/8/4.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

import UIKit
import SVProgressHUD
class IdeaViewController: QJLBaseViewController {
    
    private let margin: CGFloat = 15
    private var promptLabel: UILabel!
    
    private var iderTextView: PlaceholderTextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildPlaceholderLabel()
        
        buildIderTextView()
        
        self.setupNav()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        /// 设置导航栏
        func setupNav() {
            view.backgroundColor = QJLColor(239, g: 239, b: 239,a: 1)
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送", style: .Plain, target: self, action: #selector(rightItemClick))
            
        }
    
    private func buildPlaceholderLabel() {
        promptLabel = UILabel(frame: CGRectMake(margin, 66, ScreenWidth - 2 * margin, 50))
        promptLabel.text = "你的批评和建议能帮助我们更好的完善产品,请留下你的宝贵意见!"
        promptLabel.numberOfLines = 2;
        promptLabel.textColor = UIColor.blackColor()
        promptLabel.font = UIFont.systemFontOfSize(15)
        view.addSubview(promptLabel)
    }
    
    private func buildIderTextView() {
        iderTextView = PlaceholderTextView(frame: CGRectMake(margin, CGRectGetMaxY(promptLabel.frame) + 10, ScreenWidth - 2 * margin, 150))
        iderTextView.placeholder = "请输入宝贵意见(300字以内)"
        view.addSubview(iderTextView)
    }
    
        func rightItemClick() {
            
            if iderTextView.text == nil || 0 == iderTextView.text?.characters.count {
                SVProgressHUD.showImage(UIImage(named: "v2_orderSuccess")!, status: "请输入意见,心里空空的")
            } else if iderTextView.text?.characters.count < 5 {
                SVProgressHUD.showImage(UIImage(named: "v2_orderSuccess")!, status: "请输入超过5个字啊亲~")
            } else if iderTextView.text?.characters.count >= 300 {
                SVProgressHUD.showImage(UIImage(named: "v2_orderSuccess")!, status: "说的太多了,臣妾做不到啊~")
            } else {
                SVProgressHUD.showWithStatus("发送中")
                let time = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
                dispatch_after(time, dispatch_get_main_queue(), { () -> Void in
                    let QJLSettingVC = QJLSettingViewController()
                    self.navigationController?.pushViewController(QJLSettingVC, animated: true)
                    
                    SVProgressHUD.showSuccessWithStatus("已经收到你的意见了,我们会刚正面的,放心吧~~")
                })
            }
    }

}
    

