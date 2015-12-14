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
}