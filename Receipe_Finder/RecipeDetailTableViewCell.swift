//
//  RecipeDetailTableViewCell.swift
//  Receipe_Finder
//
//  Created by Bansari_19473 on 4/10/17.
//  Copyright © 2017 Pranali_19462. All rights reserved.
//

import UIKit

class RecipeDetailTableViewCell: UITableViewCell {

    
    @IBOutlet var lbl_IngredientMeasurement: UILabel!
    @IBOutlet var lbl_IngredientName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
