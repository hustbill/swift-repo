//
//  FirstViewController.swift
//  ButtonClickActionDemo
//
//  Created by bill on 8/31/16.
//  Copyright © 2016 bill. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var BtnSend1: UIButton!
    @IBOutlet weak var BtnSend2: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        BtnSend1.addTarget(self, action: "buttonClicked:", forControlEvents: .TouchUpInside)
        BtnSend2.addTarget(self, action: "buttonClicked:", forControlEvents: .TouchUpInside)
   
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonClicked(sender: AnyObject?) {
        if sender === BtnSend1 {
            // do something
            BtnSend1.setTitle("已完成",forState: .Normal)
        }
    }


}

