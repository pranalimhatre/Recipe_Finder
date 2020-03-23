//
//  YoutTubeVideoTableViewCell.swift
//  Reciepe_Video
//
//  Created by Ramesh Singh on 4/6/17.
//  Copyright © 2017 NPU_18910. All rights reserved.
//

import UIKit

class YoutTubeVideoTableViewCell: UITableViewCell,UIWebViewDelegate {

    @IBOutlet var webView1: UIWebView!
    @IBOutlet var webView: [UIWebView]!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
