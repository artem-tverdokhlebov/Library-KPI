//
//  LibrarianEditAuthorController.swift
//  Library
//
//  Created by Artem Tverdokhlebov on 12/20/15.
//  Copyright © 2015 Leonid Humeniuk & Artem Tverdokhlebov. All rights reserved.
//

import Foundation
import UIKit

class LibrarianEditAuthorController : UITableViewController, UITextFieldDelegate {
    var author : Author = Author()
    
    @IBOutlet var authorName: UITextField!
    @IBOutlet var authorBirthdate: UILabel!
    
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var saveButton: UIBarButtonItem!
    
    @IBAction func saveAuthor(sender: AnyObject) {
        author.name = authorName.text!
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        author.birthDate = dateFormatter.stringFromDate(datePicker.date)
        
        author.updateInDB()
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func passAuthor(author : Author) {
        self.author = author
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        authorName.resignFirstResponder()
        return true
    }
    
    @IBAction func authorNameChanged(sender: AnyObject) {
        self.checkParams()
    }
    
    @IBAction func dateChanged(sender: AnyObject) {
        self.checkParams()
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        
        let strDate = dateFormatter.stringFromDate(datePicker.date)
        authorBirthdate.text = strDate
    }
    
    func checkParams() {
        var errors : [String] = [String]()
        
        if(authorName.text!.isEmpty) {
            errors.append("Ім'я автора не повинно бути порожнім")
        }
        
        if(errors.isEmpty) {
            saveButton.enabled = true
        } else {
            saveButton.enabled = false
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        var destination : LibrarianShowAuthorController = LibrarianShowAuthorController()
        
        for item in self.navigationController!.viewControllers {
            if(item is LibrarianShowAuthorController) {
                destination = item as! LibrarianShowAuthorController
            }
        }
        
        destination.author.reloadFromDB()
    }
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        authorName.delegate = self
        
        dateChanged(self)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        datePicker.setDate(dateFormatter.dateFromString(author.birthDate)!, animated: true)
        dateChanged(self)
        
        authorName.text = author.name
        
        checkParams()
    }
}