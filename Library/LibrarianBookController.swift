//
//  LibrarianBookController.swift
//  Library
//
//  Created by Artem Tverdokhlebov on 12.12.15.
//  Copyright © 2015 Leonid Humeniuk & Artem Tverdokhlebov. All rights reserved.
//

import Foundation
import UIKit

class LibrarianBookController : UITableViewController, UISearchBarDelegate {
    var data : NSArray = NSArray()
    var books : [Book] = [Book]()
    
    @IBOutlet var searchBar: UISearchBar!
    
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
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]?  {
        let deleteAction = UITableViewRowAction(style: .Default, title: "Видалити", handler: { (action , indexPath) -> Void in
            self.books[indexPath.row].deleteFromDB()
            self.books.removeAtIndex(indexPath.row)
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
        
        if self.refreshControl!.refreshing
        {
            self.refreshControl!.endRefreshing()
        }
    }
    
    func loadBooks() {
        books = [Book]()
        
        data = DB.query("SELECT * FROM book")
        
        for item in data {
            let book : Book = Book()
            book.parseFromDictionary(item as! [NSObject : AnyObject])
            books.append(book)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.destinationViewController is LibrarianShowBookController) {
            let destination = segue.destinationViewController as! LibrarianShowBookController
            
            destination.passBook(books[tableView.indexPathForSelectedRow!.row])
        }
    }
    
    func getResultsByTitle(query : String) {
        data = DB.query("SELECT * FROM book WHERE title LIKE '%" + query + "%'")
        books = [Book]()
        
        for item in data {
            let book : Book = Book()
            book.parseFromDictionary(item as! [NSObject : AnyObject])
            books.append(book)
        }
    }
    
    func getResultsByUDK(query : String) {
        data = DB.query("SELECT * FROM book WHERE udk LIKE '%" + query + "%'")
        books = [Book]()
        
        for item in data {
            let book : Book = Book()
            book.parseFromDictionary(item as! [NSObject : AnyObject])
            books.append(book)
        }
    }
    
    func getResultsByTheme(query : String) {
        data = DB.query("SELECT book.* FROM bookTheme JOIN theme ON bookTheme.theme_id = theme.id JOIN book ON bookTheme.book_id = book.id WHERE theme.title LIKE '%" + query + "%'")
        books = [Book]()
        
        for item in data {
            let book : Book = Book()
            book.parseFromDictionary(item as! [NSObject : AnyObject])
            books.append(book)
        }
    }
    
    func getResultsByAuthor(query : String) {
        data = DB.query("SELECT book.* FROM bookAuthor JOIN author ON bookAuthor.author_id = author.id JOIN book ON bookAuthor.book_id = book.id WHERE author.name LIKE '%" + query + "%'")
        
        books = [Book]()
        
        for item in data {
            let book : Book = Book()
            book.parseFromDictionary(item as! [NSObject : AnyObject])
            books.append(book)
        }
    }
    
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        searchBarSearchButtonClicked(searchBar)
    }
        
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        if(searchBar.text!.isEmpty) {
            loadBooks()
        } else {
            if(searchBar.selectedScopeButtonIndex == 0) {
                getResultsByTitle(searchBar.text! as String)
            }
            if(searchBar.selectedScopeButtonIndex == 1) {
            getResultsByUDK(searchBar.text! as String)
            }
            if(searchBar.selectedScopeButtonIndex == 2) {
                getResultsByAuthor(searchBar.text! as String)
            }
            if(searchBar.selectedScopeButtonIndex == 3) {
                getResultsByTheme(searchBar.text! as String)
            }
        }
        
        tableView.reloadData()
    }

    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        loadBooks()
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        searchBar.scopeBarBackgroundImage = UIImage()
        
        loadBooks()
    }

}