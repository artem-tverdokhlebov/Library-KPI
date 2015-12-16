//
//  LibrarianThemeController.swift
//  Library
//
//  Created by Artem Tverdokhlebov on 13.12.15.
//  Copyright © 2015 Leonid Humeniuk & Artem Tverdokhlebov. All rights reserved.
//

import Foundation
import UIKit

class LibrarianThemeController : UITableViewController, UISearchBarDelegate {
    var data : NSArray = NSArray()
    var themes : [Theme] = [Theme]()
    
    @IBOutlet var searchBar: UISearchBar!
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return themes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let themeCell = tableView.dequeueReusableCellWithIdentifier("themeCell", forIndexPath: indexPath)
        
        themeCell.textLabel!.text = themes[indexPath.row].title
        
        return themeCell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]?  {
        let deleteAction = UITableViewRowAction(style: .Default, title: "Видалити", handler: { (action , indexPath) -> Void in
            //themes[indexPath.row].dbDelete()
        })
        
        deleteAction.backgroundColor = UIColor.redColor()
        
        return [deleteAction]
    }
    
    func getResultsByTitle(query : String) {
        if(query != "") {
            data = DB.query("SELECT * FROM theme WHERE title LIKE '%" + query + "%'")
        } else {
            data = DB.query("SELECT * FROM theme")
        }
        themes = [Theme]()
        
        for item in data {
            let theme : Theme = Theme()
            theme.parseFromDictionary(item as! [NSObject : AnyObject])
            themes.append(theme)
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
   
        getResultsByTitle(searchBar.text! as String)
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        themes = [Theme]()
        
        data = DB.query("SELECT * FROM theme")
        
        for item in data {
            let theme : Theme = Theme()
            theme.parseFromDictionary(item as! [NSObject : AnyObject])
            themes.append(theme)
        }
        
        tableView.reloadData()
    }
    
}