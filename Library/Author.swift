//
//  Author.swift
//  Library
//
//  Created by Artem Tverdokhlebov on 12.12.15.
//  Copyright © 2015 Leonid Humeniuk & Artem Tverdokhlebov. All rights reserved.
//

import Foundation

@objc class Author : NSObject {
    var author_id : Int = 0
    var name : String = ""
    var birthDate : String = ""
    
    func parseFromDictionary(dictionary : NSDictionary) {
        self.author_id = Int(dictionary["id"] as! String)!
        self.name = dictionary["name"] as! String
        self.birthDate = dictionary["birthDate"] as! String
    }
    
    func getBooks() -> [Book] {
        var books : [Book] = [Book]()
        let data : NSArray = DB.query("SELECT book.* FROM bookAuthor INNER JOIN book ON bookAuthor.book_id = book.id WHERE author_id = \(author_id)")
        
        for item in data {
            let book : Book = Book()
            book.parseFromDictionary(item as! [NSObject : AnyObject])
            books.append(book)
        }
        
        return books
    }

    func insertToDB() {
        DB.query("INSERT INTO author VALUES('', '\(name)', '\(birthDate)')");
        
        let data : NSArray = DB.query("SELECT id FROM author ORDER BY id DESC LIMIT 1")
        self.author_id = Int(data[0]["id"] as! String)!
    }
    
    func updateInDB() {
        DB.query("UPDATE author SET name = '\(self.name)', birthDate = '\(self.birthDate)' WHERE id = \(self.author_id)")
    }
    
    func deleteFromDB() {
        DB.query("DELETE FROM author WHERE id = \(self.author_id)")
    }
    
    func reloadFromDB() {
        let data : NSArray = DB.query("SELECT author.* FROM author WHERE id = \(self.author_id)")
        self.parseFromDictionary(data[0] as! NSDictionary)
    }
}