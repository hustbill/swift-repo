//
//  TaskViewCell.swift
//  TableViewController
//
//  Created by hua zhang on 8/30/16.
//  Copyright © 2016 bill. All rights reserved.
//


import UIKit

class TaskTableViewCell: UITableViewCell {
    // MARK: Properties
    
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var stateBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
