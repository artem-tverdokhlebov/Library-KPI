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
    
    @IBOutlet var addButton: UIBarButtonItem!
    
    @IBAction func cancelButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) { () -> Void in }
    }
    
    @IBAction func dateChanged(sender: AnyObject) {
        self.checkParams()
        
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
    
    @IBAction func authorNameChanged(sender: AnyObject) {
        self.checkParams()
    }
    
    func checkParams() {
        var errors : [String] = [String]()
        
        if(authorName.text!.isEmpty) {
            errors.append("Ім'я автора не повинно бути порожнім")
        }
        
        if(errors.isEmpty) {
            addButton.enabled = true
        } else {
            addButton.enabled = false
        }
    }
    
    @IBAction func addAuthor(sender: AnyObject) {
        let author : Author = Author()
        author.name = authorName.text!
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        author.birthDate = dateFormatter.stringFromDate(datePicker.date)

        author.insertToDB()
        
        let alert = UIAlertController(title: "Автор", message: "Автор був успішно доданий", preferredStyle: UIAlertControllerStyle.Alert)
        let alertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in self.cancelButton(self)}
        alert.addAction(alertAction)
        presentViewController(alert, animated: true) { () -> Void in }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        authorName.delegate = self
        
        datePicker.setDate(NSDate(), animated: true)
        dateChanged(self)
        
        addButton.enabled = false
    }
}