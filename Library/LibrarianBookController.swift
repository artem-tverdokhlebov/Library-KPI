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
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]?  {
        let deleteAction = UITableViewRowAction(style: .Default, title: "Видалити", handler: { (action , indexPath) -> Void in
            self.books[indexPath.row].deleteFromDB()
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        })
        
        deleteAction.backgroundColor = UIColor.redColor()
        
        return [deleteAction]
    }
    
    @IBAction func editButtonClicked(sender: AnyObject) {
        if(self.tableView.editing) {
            navigationItem.setLeftBarButtonItem(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Edit, target: self, action: "editButtonClicked:"), animated: true)
            self.tableView.setEditing(false, animated: true)
        } else {
            navigationItem.setLeftBarButtonItem(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "editButtonClicked:"), animated: true)
            self.tableView.setEditing(true, animated: true)
        }
    }
    
    @IBAction func refresh(sender: AnyObject) {
        self.loadBooks()
        tableView.reloadData()
    }
    
    func loadBooks() {
        books = [Book]()
        
        data = DB.query("SELECT * FROM book")
        
        for item in data {
            let book : Book = Book()
            book.parseFromDictionary(item as! [NSObject : AnyObject])
            books.append(book)
        }
        
        if self.refreshControl!.refreshing
        {
            self.refreshControl!.endRefreshing()
        }
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
        
        loadBooks()
    }

}