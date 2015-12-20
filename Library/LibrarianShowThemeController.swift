//
//  LibrarianShowThemeController.swift
//  Library
//
//  Created by Artem Tverdokhlebov on 12/20/15.
//  Copyright © 2015 Leonid Humeniuk & Artem Tverdokhlebov. All rights reserved.
//

import Foundation
import UIKit

class LibrarianShowThemeController : UITableViewController {
    var theme : Theme = Theme()

    @IBOutlet var themeTitle: UILabel!
    
    func passTheme(theme : Theme) {
        self.theme = theme
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.destinationViewController is LibrarianEditThemeController) {
            let destination = segue.destinationViewController as! LibrarianEditThemeController
        
            destination.passTheme(theme)
        }
        
        //
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = theme.title
        themeTitle.text = theme.title
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.title = theme.title
        themeTitle.text = theme.title
    }
}