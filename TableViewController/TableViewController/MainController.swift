//
//  MainController.swift
//  TableViewController
//  
//  Reference: http://www.hangge.com/blog/cache/detail_716.html
//  Created by bill on 8/30/16.
//  Copyright © 2016 bill. All rights reserved.
//
//
import UIKit

class MainController: UITableViewController {
    
    var tasks:[String] = ["今天任务","明天任务","后天任务"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int {
            return tasks.count
    }
    
    override func tableView(tableView: UITableView,
                            cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("maincell",
                                                               forIndexPath: indexPath) as UITableViewCell
        //获取label
        let label = cell.viewWithTag(1000) as! UILabel
        //设置label内容
        label.text = "\(indexPath.row)：\(tasks[indexPath.row])"
        return cell
    }
    
    override func tableView(tableView: UITableView,
                            didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //获取cell
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        //根据原先状态，改变勾选或取消勾选状态
        if cell?.accessoryType == UITableViewCellAccessoryType.None{
            cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
        }else{
            cell?.accessoryType = UITableViewCellAccessoryType.None
        }
        //取消选中状态
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}