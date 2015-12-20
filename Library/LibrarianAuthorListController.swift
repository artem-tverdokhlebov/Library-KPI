//
//  LibrarianAuthorListController.swift
//  Library
//
//  Created by Artem Tverdokhlebov on 12/20/15.
//  Copyright © 2015 Leonid Humeniuk & Artem Tverdokhlebov. All rights reserved.
//

import Foundation
import UIKit

class LibrarianAuthorListController : UITableViewController {
    var authors : [Author] = [Author]()
    
    func passAuthors(authors : [Author]) {
        self.authors = authors
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return authors.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let authorCell = self.tableView.dequeueReusableCellWithIdentifier("authorCell", forIndexPath: indexPath)
        
        authorCell.textLabel!.text = authors[indexPath.row].name
        
        return authorCell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.destinationViewController is LibrarianShowAuthorController) {
            let destination = segue.destinationViewController as! LibrarianShowAuthorController
            
            destination.passAuthor(authors[tableView.indexPathForSelectedRow!.row])
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}