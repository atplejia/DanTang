//
//  QJLSeeAllController.swift
//  单糖
//
//  Created by 金亮齐 on 16/8/2.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

import UIKit

let seeAllcellID = "QJLSeeAllTopicCell"

class QJLSeeAllController: QJLBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var collections = [QJLCollection]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: String(QJLSeeAllTopicCell), bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: seeAllcellID)
        tableView.separatorStyle = .None
        tableView.rowHeight = 160
        /// 分类界面 顶部 专题合集
        QJLNetworkTool.shareNetworkTool.loadCategoryCollection(20) { (collections) in
            self.collections = collections
            self.tableView!.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension QJLSeeAllController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collections.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(seeAllcellID) as! QJLSeeAllTopicCell
        cell.collection = collections[indexPath.row]
        cell.selectionStyle = .None
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let collectionDetailVC = QJLCollectionDetailController()
        let collection = collections[indexPath.row]
        collectionDetailVC.title = collection.title
        collectionDetailVC.id = collection.id
        collectionDetailVC.type = "专题合集"
        navigationController?.pushViewController(collectionDetailVC, animated: true)
    }


}
