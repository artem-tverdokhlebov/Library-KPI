//
//  LibrarianReaderController.swift
//  Library
//
//  Created by Artem Tverdokhlebov on 12/20/15.
//  Copyright © 2015 Leonid Humeniuk & Artem Tverdokhlebov. All rights reserved.
//

import Foundation
import UIKit

class LibrarianReaderController : UITableViewController {
    var data : NSArray = NSArray()
    var readers : [Reader] = [Reader]()
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return readers.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let readerCell = self.tableView.dequeueReusableCellWithIdentifier("readerCell", forIndexPath: indexPath)
        
        readerCell.textLabel!.text = readers[indexPath.row].name
        
        return readerCell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]?  {
        let deleteAction = UITableViewRowAction(style: .Default, title: "Видалити", handler: { (action , indexPath) -> Void in
            self.readers[indexPath.row].deleteFromDB()
            self.readers.removeAtIndex(indexPath.row)
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
        self.loadReaders()
        
        tableView.reloadData()
        
        if self.refreshControl!.refreshing
        {
            self.refreshControl!.endRefreshing()
        }
    }
    
    func loadReaders() {
        readers = [Reader]()
        
        data = DB.query("SELECT * FROM reader")
        
        for item in data {
            let reader : Reader = Reader()
            reader.parseFromDictionary(item as! [NSObject : AnyObject])
            readers.append(reader)
        }
    }
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        
        loadReaders()
    }
    
}