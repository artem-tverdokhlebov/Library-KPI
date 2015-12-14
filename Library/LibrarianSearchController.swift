//
//  LibrarianSearchController.swift
//  Library
//
//  Created by Artem Tverdokhlebov on 13.12.15.
//  Copyright © 2015 Leonid Humeniuk & Artem Tverdokhlebov. All rights reserved.
//

import Foundation

import UIKit

class LibrarianSearchController : UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    var data : NSArray = NSArray()
    var books : [Book] = [Book]()
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var searchType: UISegmentedControl!
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let bookCell = tableView.dequeueReusableCellWithIdentifier("bookCell", forIndexPath: indexPath)
        
        bookCell.textLabel!.text = books[indexPath.row].title
        
        return bookCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
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
        data = DB.query("SELECT book.* FROM book INNER JOIN theme ON book.theme_id = theme.id WHERE theme.title LIKE '%" + query + "%'")
        books = [Book]()
        
        for item in data {
            let book : Book = Book()
            book.parseFromDictionary(item as! [NSObject : AnyObject])
            books.append(book)
        }
    }
    
    func getResultsByAuthor(query : String) {
        data = DB.query("SELECT * FROM book INNER JOIN author ON book.author_id = author.id WHERE author.name LIKE '%" + query + "%'")
        books = [Book]()
        
        for item in data {
            let book : Book = Book()
            book.parseFromDictionary(item as! [NSObject : AnyObject])
            books.append(book)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
    
        searchType.addTarget(self, action: "typeSelected:", forControlEvents: UIControlEvents.ValueChanged)
        
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        if(searchType.selectedSegmentIndex == 0) {
            getResultsByTitle(searchBar.text! as String)
        }
        if(searchType.selectedSegmentIndex == 1) {
            getResultsByUDK(searchBar.text! as String)
        }
        if(searchType.selectedSegmentIndex == 2) {
            getResultsByTheme(searchBar.text! as String)
        }
        if(searchType.selectedSegmentIndex == 3) {
            getResultsByAuthor(searchBar.text! as String)
        }
        
        tableView.reloadData()
    }
    
    func typeSelected(sender: UISegmentedControl)
    {
        searchBarSearchButtonClicked(searchBar)
    }
}