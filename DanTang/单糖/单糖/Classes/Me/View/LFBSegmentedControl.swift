//
//  LFBSegmentedControl.swift
//  单糖
//
//  Created by 金亮齐 on 16/8/5.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

import UIKit

class LFBSegmentedControl: UISegmentedControl {

    var segmentedClick:((index: Int) -> Void)?
    
    override init(items: [AnyObject]?) {
        super.init(items: items)
        tintColor = UIColor.whiteColor()
        setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.blackColor()], forState: UIControlState.Selected)
        setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.blackColor()], forState: UIControlState.Normal)
        addTarget(self, action: "segmentedControlDidValuechange:", forControlEvents: UIControlEvents.ValueChanged)
        selectedSegmentIndex = 0
    }
    
    convenience init(items: [AnyObject]?, didSelectedIndex: (index: Int) -> ()) {
        self.init(items: items)
        
        segmentedClick = didSelectedIndex
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func segmentedControlDidValuechange(sender: UISegmentedControl) {
        if segmentedClick != nil {
            segmentedClick!(index: sender.selectedSegmentIndex)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
