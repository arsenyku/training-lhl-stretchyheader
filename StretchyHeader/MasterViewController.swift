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
    var objects = [[String:String]]()

    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var headerDateLabel: UILabel!
    @IBOutlet weak var headerView: UIView!

    var tableViewHeaderHeight:CGFloat = 300
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        objects = [
            ["category":"World", "headline":"Climate change protests, divestments meet fossil fuels realities"],
        	["category":"Europe", "headline":"Scotland's 'Yes' leader says independence vote is 'once in a lifetime'"],
        	["category":"Middle East", "headline":"Airstrikes boost Islamic State, FBI director warns more hostages possible"],
	        ["category":"Africa", "headline":"Nigeria says 70 dead in building collapse; questions S. Africa victim claim"],
        	["category":"Asia Pacific", "headline":"Despite UN ruling, Japan seeks backing for whale hunting"],
        	["category":"Americas", "headline":"Officials: FBI is tracking 100 Americans who fought alongside IS in Syria"],
        	["category":"World", "headline":"South Africa in $40 billion deal for Russian nuclear reactors"],
        	["category":"Europe", "headline":"'One million babies' created by EU student exchanges"]
        ]
        
        tableViewHeaderHeight = max(tableViewHeaderHeight, max(headerView.frame.height, headerImageView.frame.height))
        
        print ("UIImage \(headerImageView.image)")
        
        // Makes cells auto-sizing as long as constraints are in place.
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        tableView.tableHeaderView = nil;
        tableView.addSubview(headerView)

        headerDateLabel.text = (Date() as NSDate).dateString(withFormat: "MMMM dd")
        headerDateLabel.textColor = UIColor.white
        
        navigationItem.leftBarButtonItem = editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem:.add, target:self, action: #selector(MasterViewController.insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        tableView.contentOffset = CGPoint(x: 0, y: -tableViewHeaderHeight)
        tableView.contentInset = UIEdgeInsets(top: tableViewHeaderHeight, left: 0, bottom: 0, right: 0)

        updateHeaderView()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)

        navigationController?.isNavigationBarHidden = true;

    }
    
    override func viewWillDisappear(_ animated: Bool) { // Called when the view is dismissed, covered or otherwise hidden. Default does nothing
        navigationController?.isNavigationBarHidden = false;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(_ sender: AnyObject) {
      objects.insert([:], at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
   
    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object as AnyObject?
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Scroll View Delebgate
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
		updateHeaderView()
    }
    
    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath)

        let newsCell = cell as! NewsCell
        
        let object = objects[indexPath.row]
        newsCell.setNews(news:object);
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }

    // MARK: - Private

    func updateHeaderView() {
        
        print ("Header height \(tableViewHeaderHeight) vs actual \(headerView.frame.height) vs image \(headerImageView.frame.height)")
        
        // Update the frame of the header view such that its at the top of the table view
        headerView.frame = CGRect(x:0, y:-tableViewHeaderHeight,
            width:view.frame.size.width, height:tableViewHeaderHeight)
        
        // contentOffset is a smaller value than -kTableHeaderHeight
        if (tableView.contentOffset.y < -tableViewHeaderHeight) {
        	// we position the header view right at that offset and extend the height of the header view.
            headerView.frame = CGRect(x:0, y:tableView.contentOffset.y,
                width:view.frame.size.width, height:-tableView.contentOffset.y)
        }
        
    }
    
}

