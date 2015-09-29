//
//  MasterViewController.swift
//  StretchyHeader
//
//  Created by asu on 2015-09-29.
//  Copyright © 2015 asu. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [AnyObject]()

    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var headerDateLabel: UILabel!
    @IBOutlet weak var headerView: UIView!

    let kTableViewHeaderHeight:CGFloat = 300.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.objects = [
            ["category":"World", "headline":"Climate change protests, divestments meet fossil fuels realities"],
        	["category":"Europe", "headline":"Scotland's 'Yes' leader says independence vote is 'once in a lifetime'"],
        	["category":"Middle East", "headline":"Airstrikes boost Islamic State, FBI director warns more hostages possible"],
	        ["category":"Africa", "headline":"Nigeria says 70 dead in building collapse; questions S. Africa victim claim"],
        	["category":"Asia Pacific", "headline":"Despite UN ruling, Japan seeks backing for whale hunting"],
        	["category":"Americas", "headline":"Officials: FBI is tracking 100 Americans who fought alongside IS in Syria"],
        	["category":"World", "headline":"South Africa in $40 billion deal for Russian nuclear reactors"],
        	["category":"Europe", "headline":"'One million babies' created by EU student exchanges"]
        ]
        
        // Makes cells auto-sizing as long as constraints are in place.
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100
        
        self.tableView.tableHeaderView = nil;
        self.tableView.addSubview(self.headerView)

        self.headerDateLabel.text = NSDate().dateStringWithFormat("MMMM dd")
        self.headerDateLabel.textColor = UIColor.whiteColor()
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        
//        self.tableView.contentInset = UIEdgeInsets(top: kTableViewHeaderHeight, left: 0, bottom: 0, right: 0)
//        self.tableView.contentOffset = CGPointMake(0, -kTableViewHeaderHeight)
        
        
//        self.tableView.contentOffset = CGPointMake(0, 1000)
//        self.tableView.contentInset = UIEdgeInsetsMake(self.headerImageView.frame.size.height, 0, 0, 0)
//        self.headerView.frame = CGRect(x: 0, y:-self.headerImageView.frame.size.height,
//            width: self.headerView.frame.size.width, height:self.headerView.frame.size.height)
        
        
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)

        self.navigationController?.navigationBarHidden = true;

    }
    
    override func viewWillDisappear(animated: Bool) { // Called when the view is dismissed, covered or otherwise hidden. Default does nothing
        self.navigationController?.navigationBarHidden = false;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(sender: AnyObject) {
        objects.insert(NSDate(), atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
   
    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row] as! NSDate
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("newsCell", forIndexPath: indexPath)

        let newsCell = cell as! NewsCell
        
        let object = objects[indexPath.row] as! Dictionary<String, String>
        newsCell.setNews(news:object);
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }

}

