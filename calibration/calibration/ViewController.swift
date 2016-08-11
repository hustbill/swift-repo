//
//  ViewController.swift
//  calibration
//
//  Created by bill on 8/10/16.
//  Copyright © 2016 bill. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    // MARK: Properties
    @IBOutlet weak var passwdTextField: UITextField!

    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions


    @IBAction func loginSys(sender: UIButton) {
        print("login system now!")
        print(nameTextField.text)
        print(passwdTextField.text)
    }

}

