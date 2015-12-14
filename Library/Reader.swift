//
//  Reader.swift
//  Library
//
//  Created by Artem Tverdokhlebov on 12.12.15.
//  Copyright © 2015 Leonid Humeniuk & Artem Tverdokhlebov. All rights reserved.
//

import Foundation

@objc class Reader : NSObject {
    var reader_id : Int = 0
    var name : String = ""
    var birthDate : String = ""
    var passport : String = ""
    var address : String = ""
    var phoneNumber : String = ""
    var dateOfRecord : String = ""
    var faculty : String = ""
    var department : String = ""
    
    func parseFromDictionary(dictionary : NSDictionary) {
        self.reader_id = Int(dictionary["id"] as! String)!
        self.name = dictionary["name"] as! String
        self.birthDate = dictionary["birthDate"] as! String
        self.passport = dictionary["passport"] as! String
        self.address = dictionary["address"] as! String
        self.phoneNumber = dictionary["phoneNumber"] as! String
        self.dateOfRecord = dictionary["dateOfRecord"] as! String
        self.faculty = dictionary["faculty"] as! String
        self.department = dictionary["department"] as! String
    }
}