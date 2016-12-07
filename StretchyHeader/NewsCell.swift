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
    
    internal func setNews(news: Dictionary<String, String>){
    	self.category = news["category"] as String!
        self.headline = news["headline"] as String!

        self.refresh()
        
    }
    
    func refresh(){
        self.categoryLabel.text = self.category;
        self.headlineLabel.text = self.headline;
        
        switch self.category {
        case "World":
            self.categoryLabel.textColor = UIColor.red
        case "Americas":
            self.categoryLabel.textColor = UIColor.blue
        case "Europe":
            self.categoryLabel.textColor = UIColor.orange
        case "Middle East":
            self.categoryLabel.textColor = UIColor.green
        case "Africa":
            self.categoryLabel.textColor = UIColor.gray
        case "Asia Pacific":
            self.categoryLabel.textColor = UIColor.purple

        default:
            self.categoryLabel.textColor = UIColor.black
        }
        
    }
    
}

