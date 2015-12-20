//
//  LibrarianShowBookController.swift
//  Library
//
//  Created by Artem Tverdokhlebov on 12/17/15.
//  Copyright © 2015 Leonid Humeniuk & Artem Tverdokhlebov. All rights reserved.
//

import Foundation
import UIKit

class LibrarianShowBookController : UITableViewController {
    var book : Book = Book()
    var authors : [Author] = [Author]()
    var themes : [Theme] = [Theme]()
    
    @IBOutlet var bookTitle: UILabel!
    @IBOutlet var bookAuthors: UILabel!
    
    func passBook(book : Book) {
        self.book = book
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.destinationViewController is LibrarianAuthorListController) {
            let destination = segue.destinationViewController as! LibrarianAuthorListController
            
            destination.passAuthors(book.getAuthors() as! [Author])
        }
        
        if(segue.destinationViewController is LibrarianThemeListController) {
            let destination = segue.destinationViewController as! LibrarianThemeListController
            
            destination.passThemes(book.getThemes() as! [Theme])
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = book.title
        bookTitle.text = book.title
    }
}