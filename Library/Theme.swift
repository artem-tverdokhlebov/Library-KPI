//
//  Theme.swift
//  Library
//
//  Created by Artem Tverdokhlebov on 12.12.15.
//  Copyright © 2015 Leonid Humeniuk & Artem Tverdokhlebov. All rights reserved.
//

import Foundation

@objc class Theme : NSObject {
    var theme_id : Int = 0
    var title : String = ""
    
    func parseFromDictionary(dictionary : NSDictionary) {
        self.theme_id = Int(dictionary["id"] as! String)!
        self.title = dictionary["title"] as! String
    }
    
    func getBooks() -> [Book] {
        var books : [Book] = [Book]()
        let data : NSArray = DB.query("SELECT book.* FROM bookTheme INNER JOIN book ON bookTheme.book_id = book.id WHERE theme_id = \(theme_id)")
        
        for item in data {
            let book : Book = Book()
            book.parseFromDictionary(item as! [NSObject : AnyObject])
            books.append(book)
        }
        
        return books
    }
    
    func insertToDB() {
        DB.query("INSERT INTO theme VALUES('', '\(title)')");
    }
    
    func deleteFromDB() {
        DB.query("DELETE FROM theme WHERE id = \(self.theme_id)")
        DB.query("DELETE FROM book WHERE")
    }
}