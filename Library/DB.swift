//
//  DB.swift
//  Library
//
//  Created by Artem Tverdokhlebov on 12.12.15.
//  Copyright © 2015 Leonid Humeniuk & Artem Tverdokhlebov. All rights reserved.
//

import Foundation
import UIKit

@objc class DB : NSObject {
    
    static private func parseJSON(inputData: NSData) -> NSArray {
        do {
            let dictionaryFullJson: NSArray = try NSJSONSerialization.JSONObjectWithData(inputData, options: NSJSONReadingOptions.MutableContainers) as! NSArray
            return dictionaryFullJson
        } catch _ {
            return NSArray();
        }
    }
    
    static private func getData(urlToRequest: String) -> NSData {
        return NSData(contentsOfURL: NSURL(string: urlToRequest)!)!
    }
    
    static func query(query : String) -> NSArray {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        let data = getData("http://library-kpi.tk/sendQuery.php?query=" + query.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
        
        var result : NSArray = NSArray()
        
        result = self.parseJSON(data)
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        
        return result
    }
    
}