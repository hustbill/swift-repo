//
//  TaskViewController.swift
//  TableViewController
//
//  Created by bill on 8/30/16.
//  Copyright © 2016 bill. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var stepTextField: UITextField!
    
    @IBOutlet weak var stateTextField: UITextField!
    
    var task : Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field’s user input through delegate callbacks.
        stepTextField.delegate = self
        stateTextField.delegate = self
        
       
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // Set up views if editing an existing Meal.
        if let meal = task {
            stepTextField.text = meal.step
            stateTextField.text   = meal.state
        }
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("send data back to listview")
        
        if saveButton === sender {
            let stepNum = stepTextField.text!
            
            let stepState = stateTextField.text!
            task = Task(step: stepNum, state: stepState)
            print(task)
        }
            
        
            
//            
//            // Set the meal to be passed to MealListTableViewController after the unwind segue.
        
            
//            
//            
//            print(tasks.count)
//            
//            print(stepNum)
//            //svc.tasks.append(Task(step: stepNum!, state: stepState)!)
//            tasks[stepNum!].state = stepState
//            svc.tasks = tasks
//            
//            //svc.tasks[stepNum!].state = stepState
//            
            
        
    }
    
    
    @IBAction func saveTasks(sender: AnyObject) {
        print("saveTask")
    }
}


