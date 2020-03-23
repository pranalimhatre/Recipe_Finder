//
//  RecipeListTableViewCell.swift
//  Receipe_Finder
//
//  Created by Bansari_19473 on 4/8/17.
//  Copyright © 2017 Pranali_19462. All rights reserved.
//

import UIKit

class RecipeListTableViewCell: UITableViewCell {
   
    @IBOutlet var imgRcp: UIImageView!
    
    @IBOutlet var lblrcpname: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
