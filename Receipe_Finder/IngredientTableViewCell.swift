//
//  IngredientTableViewCell.swift
//  Receipe_Finder
//
//  Created by Pranali on 4/7/17.
//  Copyright © 2017 Pranali_19462. All rights reserved.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {

    @IBOutlet var IMgingri: UIImageView!

    
    @IBOutlet var lblIngri: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       // lblIngri.font = UIFont(name: "Avenir-Light", size: 17.0)
        
        // Initialization code
        //Avenir-Light
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
