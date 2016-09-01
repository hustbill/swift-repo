//
//  cellOfdeviceTableViewCell.swift
//  TableViewController
//
//  Created by bill on 9/1/16.
//  Copyright © 2016 bill. All rights reserved.
//


import UIKit

class cellOfdeviceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var textTitle: UILabel!
    
    @IBOutlet weak var connectDeviceBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

