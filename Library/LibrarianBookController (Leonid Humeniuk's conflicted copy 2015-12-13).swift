//
//  LibrarianBookController.swift
//  Library
//
//  Created by Artem Tverdokhlebov on 12.12.15.
//  Copyright © 2015 Leonid Humeniuk & Artem Tverdokhlebov. All rights reserved.
//

import Foundation
import UIKit

class LibrarianBookController : UITableViewController {
    //var books : NSMutableArray = NSMutableArray()
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return books.count
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let bookCell = tableView.dequeueReusableCellWithIdentifier("bookCell", forIndexPath: indexPath) 
    
        //bookCell.textLabel!.text = books[indexPath.row]

        return bookCell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let db : DB = DB()
        
        //books = db.query("SELECT * FROM book")
        
        tableView.reloadData()
    }

}