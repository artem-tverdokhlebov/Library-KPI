//
//  LibrarianAddAuthorController.swift
//  Library
//
//  Created by Artem Tverdokhlebov on 12/16/15.
//  Copyright © 2015 Leonid Humeniuk & Artem Tverdokhlebov. All rights reserved.
//

import Foundation
import UIKit

class LibrarianAddAuthorController : UITableViewController, UITextFieldDelegate {
    
    @IBOutlet var authorName: UITextField!
    @IBOutlet var authorBirthdate: UILabel!
    @IBOutlet var datePicker: UIDatePicker!
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) { () -> Void in }
    }
    
    @IBAction func dateChanged(sender: AnyObject) {
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        
        let strDate = dateFormatter.stringFromDate(datePicker.date)
        authorBirthdate.text = strDate
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        authorName.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        authorName.delegate = self
        
        datePicker.setDate(NSDate(), animated: true)
        dateChanged(self)
    }
}