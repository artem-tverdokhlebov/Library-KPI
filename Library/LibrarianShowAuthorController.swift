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
        /*if(segue.destinationViewController is LibrarianShowAuthorController) {
            let destination = segue.destinationViewController as! LibrarianShowAuthorController
            
            destination.passAuthor(authors[tableView.indexPathForSelectedRow!.row])
        }*/
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = author.name
        authorName.text = author.name
        authorBirthdate.text = author.birthDate
    }
    
}