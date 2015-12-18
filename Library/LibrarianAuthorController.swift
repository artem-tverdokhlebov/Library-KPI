//
//  LibrarianAuthorController.swift
//  Library
//
//  Created by Artem Tverdokhlebov on 13.12.15.
//  Copyright © 2015 Leonid Humeniuk & Artem Tverdokhlebov. All rights reserved.
//

import Foundation
import UIKit

class LibrarianAuthorController : UITableViewController, UISearchBarDelegate {
    var data : NSArray = NSArray()
    var authors : [Author] = [Author]()
    
    @IBOutlet var searchBar: UISearchBar!
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return authors.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let authorCell = tableView.dequeueReusableCellWithIdentifier("authorCell", forIndexPath: indexPath)
        
        authorCell.textLabel!.text = authors[indexPath.row].name
        
        return authorCell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]?  {
        let deleteAction = UITableViewRowAction(style: .Default, title: "Удалить", handler: { (action , indexPath) -> Void in
            self.authors[indexPath.row].deleteFromDB()
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
    
    func getResultsByName(query : String) {
        if(query != "") {
            data = DB.query("SELECT * FROM author WHERE name LIKE '%\(query)%'")
        } else {
            data = DB.query("SELECT * FROM author")
        }
        authors = [Author]()
        
        for item in data {
            let author : Author = Author()
            author.parseFromDictionary(item as! [NSObject : AnyObject])
            authors.append(author)
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        getResultsByName(searchBar.text! as String)
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        authors = [Author]()

        data = DB.query("SELECT * FROM author")
        
        for item in data {
            let author : Author = Author()
            author.parseFromDictionary(item as! [NSObject : AnyObject])
            authors.append(author)
        }
        
        tableView.reloadData()
    }
    
}