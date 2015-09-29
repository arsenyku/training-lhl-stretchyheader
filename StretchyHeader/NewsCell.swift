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
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var headlineLabel: UILabel!
    
    required
    init?(coder aDecoder: NSCoder) {
        self.category = ""
        self.headline = ""
        super.init(coder: aDecoder)
    }
    
    internal func setNews(news news: Dictionary<String, String>){
    	self.category = news["category"] as String!
        self.headline = news["headline"] as String!

        self.refresh()
        
    }
    
    func refresh(){
        self.categoryLabel.text = self.category;
        self.headlineLabel.text = self.headline;
        
        switch self.category {
        case "World":
            self.categoryLabel.textColor = UIColor.redColor()
        case "Americas":
            self.categoryLabel.textColor = UIColor.blueColor()
        case "Europe":
            self.categoryLabel.textColor = UIColor.orangeColor()
        case "Middle East":
            self.categoryLabel.textColor = UIColor.greenColor()
        case "Africa":
            self.categoryLabel.textColor = UIColor.grayColor()
        case "Asia Pacific":
            self.categoryLabel.textColor = UIColor.purpleColor()

        default:
            self.categoryLabel.textColor = UIColor.blackColor()
        }
        
    }
    
}

