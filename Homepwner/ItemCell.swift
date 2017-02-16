//
//  ItemCell.swift
//  Homepwner
//
//  Created by Piervincenzo Parisi on 15/02/17.
//  Copyright © 2017 Piervincenzo Parisi. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var serialNumberLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        nameLabel.adjustsFontForContentSizeCategory = true
        serialNumberLabel.adjustsFontForContentSizeCategory = true
        valueLabel.adjustsFontForContentSizeCategory = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let a = Int(valueLabel.text!.replacingOccurrences(of: "$", with: "")) {
            if a < 50 {
                valueLabel.textColor = UIColor.green
            }
            else {
                valueLabel.textColor = UIColor.red
            }
        }
    }

}
