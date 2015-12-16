//
//  LibrarianSelectController.swift
//  Library
//
//  Created by Artem Tverdokhlebov on 12/16/15.
//  Copyright © 2015 Leonid Humeniuk & Artem Tverdokhlebov. All rights reserved.
//

import Foundation
import UIKit

class LibrarianSelectController : UITableViewController {
    var data : NSArray = NSArray()
    var objects : [AnyObject] = [AnyObject]()

    var selectedObjects : [AnyObject] = [AnyObject]()

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("selectCell", forIndexPath: indexPath)
        
        if(objects[indexPath.row] is Author)  {
            cell.textLabel!.text = objects[indexPath.row].name
            
            if let _ = selectedObjects.indexOf({$0.name == objects[indexPath.row].name}) {
                cell.accessoryType = .Checkmark
            }
        }
        
        if(objects[indexPath.row] is Theme)  {
            cell.textLabel!.text = objects[indexPath.row].title
            
            if let _ = selectedObjects.indexOf({$0.title == objects[indexPath.row].title}) {
                cell.accessoryType = .Checkmark
            }
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(tableView.cellForRowAtIndexPath(indexPath)?.accessoryType == .Checkmark) {
            tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = .None
        } else {
            tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = .Checkmark
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        selectedObjects = [AnyObject]()
        
        for(var i = 0; i < tableView.numberOfRowsInSection(0); i++) {
            if(tableView.cellForRowAtIndexPath(NSIndexPath(forRow: i, inSection: 0))?.accessoryType == .Checkmark) {
                selectedObjects.append(objects[i])
            }
        }
        
        let destination : LibrarianAddBookController = self.navigationController!.viewControllers.last as! LibrarianAddBookController
    
        if(objects[0] is Author)  {
            destination.passAuthors(selectedObjects as! [Author])
        }
        
        if(objects[0] is Theme)  {
            destination.passThemes(selectedObjects as! [Theme])
        }
    }
    
    func loadThemes() {
        objects = [Theme]()
            
        data = DB.query("SELECT * FROM theme")
            
        for item in data {
            let theme : Theme = Theme()
            theme.parseFromDictionary(item as! [NSObject : AnyObject])
            objects.append(theme)
        }
        
        tableView.reloadData()
    }
    
    func loadAuthors() {
        objects = [Author]()
            
        data = DB.query("SELECT * FROM author")
            
        for item in data {
            let author : Author = Author()
            author.parseFromDictionary(item as! [NSObject : AnyObject])
            objects.append(author)
        }
        
        tableView.reloadData()
    }
    
    func passSelected(selectedObjects : [AnyObject]) {
        self.selectedObjects = selectedObjects
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}