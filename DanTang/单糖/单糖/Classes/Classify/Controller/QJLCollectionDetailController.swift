//
//  QJLCollectionDetailController.swift
//  单糖
//
//  Created by 金亮齐 on 16/8/2.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

import UIKit

let collectionTableCellID = "QJLCollectionTableViewCell"

class QJLCollectionDetailController: UIViewController {
    
    var type = String()
    
    var posts = [QJLCollectionPost]()
    
    var id: Int?
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: String(QJLCollectionTableViewCell), bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: collectionTableCellID)
        tableView.rowHeight = 150
        tableView.separatorStyle = .None
        weak var weakSelf = self
        if type == "专题合集" {
            QJLNetworkTool.shareNetworkTool.loadCollectionPosts(id!) { (posts) in
                weakSelf!.posts = posts
                weakSelf!.tableView.reloadData()
            }
        } else if type == "风格品类" {
            QJLNetworkTool.shareNetworkTool.loadStylesOrCategoryInfo(id!, finished: { (items) in
                weakSelf!.posts = items
                weakSelf!.tableView.reloadData()
            })
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension QJLCollectionDetailController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(collectionTableCellID) as! QJLCollectionTableViewCell
        cell.selectionStyle = .None
        cell.collectionPost = posts[indexPath.row
        ]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let postDetailVC = QJLPostDetailViewController()
        postDetailVC.post = posts[indexPath.row]
        postDetailVC.title = "攻略详情"
        navigationController?.pushViewController(postDetailVC, animated: true)
    }



}
