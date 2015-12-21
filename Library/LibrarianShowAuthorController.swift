//
//  LibrarianShowAuthorController.swift
//  Library
//
//  Created by Artem Tverdokhlebov on 12/17/15.
//  Copyright © 2015 Leonid Humeniuk & Artem Tverdokhlebov. All rights reserved.
//

import Foundation
import UIKit

class LibrarianShowAuthorController : UITableViewController {
    var author : Author = Author()
    
    @IBOutlet var authorName: UILabel!
    @IBOutlet var authorBirthdate: UILabel!
    
    func passAuthor(author : Author) {
        self.author = author
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.destinationViewController is LibrarianBookListController) {
            let destination = segue.destinationViewController as! LibrarianBookListController
            
            destination.passBooks(author.getBooks())
        }
        
        if(segue.destinationViewController is LibrarianEditAuthorController) {
            let destination = segue.destinationViewController as! LibrarianEditAuthorController
            
            destination.passAuthor(author)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = author.name
        authorName.text = author.name
        authorBirthdate.text = author.birthDate
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.title = author.name
        authorName.text = author.name
        authorBirthdate.text = author.birthDate
    }
}