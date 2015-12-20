//
//  LibrarianBookListController.swift
//  Library
//
//  Created by Artem Tverdokhlebov on 12/20/15.
//  Copyright © 2015 Leonid Humeniuk & Artem Tverdokhlebov. All rights reserved.
//

import Foundation
import UIKit

class LibrarianBookListController : UITableViewController {
    var books : [Book] = [Book]()
    
    func passBooks(books : [Book]) {
        self.books = books
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let bookCell = self.tableView.dequeueReusableCellWithIdentifier("bookCell", forIndexPath: indexPath)
        
        bookCell.textLabel!.text = books[indexPath.row].title
        
        return bookCell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.destinationViewController is LibrarianShowBookController) {
            let destination = segue.destinationViewController as! LibrarianShowBookController
            
            destination.passBook(books[tableView.indexPathForSelectedRow!.row])
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}