//
//  LibrarianThemeListController.swift
//  Library
//
//  Created by Artem Tverdokhlebov on 12/20/15.
//  Copyright © 2015 Leonid Humeniuk & Artem Tverdokhlebov. All rights reserved.
//

import Foundation
import UIKit

class LibrarianThemeListController : UITableViewController {
    var themes : [Theme] = [Theme]()
    
    func passThemes(themes : [Theme]) {
        self.themes = themes
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return themes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let themeCell = self.tableView.dequeueReusableCellWithIdentifier("themeCell", forIndexPath: indexPath)
        
        themeCell.textLabel!.text = themes[indexPath.row].title
        
        return themeCell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.destinationViewController is LibrarianShowThemeController) {
            let destination = segue.destinationViewController as! LibrarianShowThemeController
            
            destination.passTheme(themes[tableView.indexPathForSelectedRow!.row])
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }

}