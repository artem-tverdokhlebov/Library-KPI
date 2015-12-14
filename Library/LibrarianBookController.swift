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
    var data : NSArray = NSArray()
    var books : [Book] = [Book]()
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let bookCell = tableView.dequeueReusableCellWithIdentifier("bookCell", forIndexPath: indexPath) 
    
        bookCell.textLabel!.text = books[indexPath.row].title

        return bookCell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        books = [Book]()
        
        data = DB.query("SELECT * FROM book")
        
        for item in data {
            let book : Book = Book()
            book.parseFromDictionary(item as! [NSObject : AnyObject])
            books.append(book)
        }
        
        tableView.reloadData()
    }

}