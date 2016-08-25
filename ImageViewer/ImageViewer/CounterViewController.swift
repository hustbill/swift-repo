//
//  CounterViewController.swift
//  ImageViewer
//
//  Created by bill on 8/25/16.
//  Copyright © 2016 bill. All rights reserved.
//

import UIKit

class CounterViewController: UIViewController {
    
    ///UI Controls
    var timeLabel: UILabel? //??????

    @IBOutlet weak var txta: UILabel!
    
    var remainingSeconds: Int = 0 {
        willSet(newSeconds) {
            
            let mins = newSeconds / 60
            let seconds = newSeconds % 60
            
            timeLabel!.text = NSString(format: "%02d:%02d", mins, seconds) as String
            
            
        }
    }
    
    var timer: NSTimer?
    var isCounting: Bool = false {
        willSet(newValue) {
            if newValue {
                timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTimer:", userInfo: nil, repeats: true)
            } else {
                timer?.invalidate()
                timer = nil
            }
            //setSettingButtonsEnabled(!newValue)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        setupTimeLabel()
      
        remainingSeconds = 300
        
        doTimer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        timeLabel!.frame = CGRectMake(10, 40, self.view.bounds.size.width-20, 120)
        
        
    }
    
    
    //UI Helpers
    
    func setupTimeLabel() {
        
        timeLabel = UILabel()
        timeLabel!.textColor = UIColor.whiteColor()
        timeLabel!.font = UIFont(name: "Helvetica", size: 80)
        timeLabel!.backgroundColor = UIColor.blackColor()
        timeLabel!.textAlignment = NSTextAlignment.Center
        
        self.view.addSubview(timeLabel!)
    }
    
    func setuptimeButtons() {
        

        
    }
    


    
    //Actions

    func startStopButtonTapped(sender: UIButton) {
        isCounting = !isCounting
        
        if isCounting {
            createAndFireLocalNotificationAfterSeconds(remainingSeconds)
        } else {
            UIApplication.sharedApplication().cancelAllLocalNotifications()
        }
        
    }
    
    func clearButtonTapped(sender: UIButton) {
        remainingSeconds = 0
    }
    
    func updateTimer(sender: NSTimer) {
        remainingSeconds -= 1
        
        if remainingSeconds <= 0 {
            let alert = UIAlertView()
            alert.title = "?????"
            alert.message = ""
            alert.addButtonWithTitle("OK")
            alert.show()
            
        }
    }
    
    //Helpers
    
    func createAndFireLocalNotificationAfterSeconds(seconds: Int) {
        
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        let notification = UILocalNotification()
        
        let timeIntervalSinceNow = Double(seconds)
        notification.fireDate = NSDate(timeIntervalSinceNow:timeIntervalSinceNow);
        
        notification.timeZone = NSTimeZone.systemTimeZone();
        notification.alertBody = "?????";
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification);
        
    }
    
    
    func doTimer(){
        var timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "timerFireMethod:", userInfo: nil, repeats:true);
        timer.fire()
    }
    func timerFireMethod(timer: NSTimer) {
        var formatter = NSDateFormatter();
        formatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
        var strNow = formatter.stringFromDate(NSDate())
        txta.text  = "\(strNow)"
    }

    
    
}
