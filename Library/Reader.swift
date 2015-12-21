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
    
    var login : String = ""
    var password : String = ""
    
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
        
        self.login = dictionary["login"] as! String
        self.password = dictionary["password"] as! String
        
        self.name = dictionary["name"] as! String
        self.birthDate = dictionary["birthDate"] as! String
        self.passport = dictionary["passport"] as! String
        self.address = dictionary["address"] as! String
        self.phoneNumber = dictionary["phoneNumber"] as! String
        self.dateOfRecord = dictionary["dateOfRecord"] as! String
        self.faculty = dictionary["faculty"] as! String
        self.department = dictionary["department"] as! String
    }
    
    // isDebtor() -> Bool
    
    func isDebtor() -> Bool {
        
        return false
    }
    
    func deleteFromDB() {
        DB.query("DELETE FROM reader WHERE id = \(self.reader_id)")
        //DB.query("DELETE FROM book WHERE")
    }
    
    func insertToDB() {
        DB.query("INSERT INTO reader VALUES('', '\(login)', '\(password)', '\(name)', '\(birthDate)', '\(passport)', '\(address)', '\(phoneNumber)', '\(dateOfRecord)', '\(faculty)', '\(department)')");
        
        let data : NSArray = DB.query("SELECT id FROM reader ORDER BY id DESC LIMIT 1")
        self.reader_id = Int(data[0]["id"] as! String)!
    }
}