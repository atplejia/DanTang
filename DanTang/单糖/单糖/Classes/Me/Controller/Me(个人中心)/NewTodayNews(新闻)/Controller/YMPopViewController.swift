//
//  YMPopViewController.swift
//  单糖
//
//  Created by 金亮齐 on 16/9/14.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

import UIKit

class YMPopViewController: UIViewController {

    var filterWords = [YMFilterWord]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clearColor()
        view.addSubview(popView)
        popView.filterWords = filterWords
        switch filterWords.count {
        case 0:
            popView.frame = CGRectZero
        case 1, 2:
            popView.frame = CGRectMake(0, 8, SCREENW - 2 * kHomeMargin, 93)
        case 3, 4:
            popView.frame = CGRectMake(0, 8, SCREENW - 2 * kHomeMargin, 130)
        case 5, 6:
            popView.frame = CGRectMake(0, 8, SCREENW - 2 * kHomeMargin, 167)
        default:
            popView.frame = CGRectZero
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private lazy var popView: YMPopView = {
        let popView = YMPopView()
        
        return popView
    }()

}
