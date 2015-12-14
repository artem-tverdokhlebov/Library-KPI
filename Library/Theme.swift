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
}