//
//  NewsCell.swift
//  StretchyHeader
//
//  Created by asu on 2015-09-29.
//  Copyright © 2015 asu. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {

    var category: String
    var headline: String
    
    required
    init?(coder aDecoder: NSCoder) {
        self.category = ""
        self.headline = ""
        super.init(coder: aDecoder)
    }
    
}

