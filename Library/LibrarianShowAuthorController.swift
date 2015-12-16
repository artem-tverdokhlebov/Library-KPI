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
    
    func passAuthor(author : Author) {
        self.author = author
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = author.name
        //bookTitle.text = book.title
    }
    
}