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
   

    
    var tasks = [Task]()
    
    var currentStep = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem()
        
        // Load any saved meals, otherwise load sample data.
        if let savedTasks = loadTasks() {
            tasks += savedTasks
            
        } else {
            // Load the sample data.
            loadCalibrationTasks()
        }
        
    }
    
    func loadCalibrationTasks() {
        var taskNums:[String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
        
        var taskStates:[String] = ["开始 > ","待完成", "待完成", "待完成","待完成",
                                   "待完成","待完成","待完成","待完成","待完成","待完成"]
        for i in 0 ..< taskNums.count  {
      
            tasks.append(Task(step: taskNums[i], state: taskStates[i])!)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print(currentStep)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int {
            return tasks.count
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("send data to TaskViewController")
        
        if segue.identifier == "showTaskView" {
            let taskDetailViewController = segue.destinationViewController as! TaskViewController
            
            // Get the cell that generated this segue.
            if let selectedMealCell = sender as? TaskTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedMealCell)!
                let selectedMeal = tasks[indexPath.row]
                taskDetailViewController.task = selectedMeal
            }
        }
        
        
    }
    
    func loadTasks() -> [Task]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Task.ArchiveURL.path!) as? [Task]
    }
    
    
    func saveTasks() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(tasks, toFile: Task.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save tasks...")
        }
    }
    
    
    override func tableView(tableView: UITableView,
                            cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TaskTableViewCell",
                                                               forIndexPath: indexPath) as UITableViewCell
        //获取label
        let label = cell.viewWithTag(1000) as! UILabel
        let button = cell.viewWithTag(2000) as! UIButton
        //设置label内容
        label.text = "\(tasks[indexPath.row].step) "
        button.setTitle("\(tasks[indexPath.row].state)", forState: .Normal)
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
    @IBAction func startCalibration(sender: AnyObject) {
    }
    
    
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? TaskViewController, task = sourceViewController.task {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                print("Update an existing meal")
                // Update an existing meal.
                tasks[selectedIndexPath.row] = task
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            } 
        }
        // Save the meals.
        saveTasks()
    }

}