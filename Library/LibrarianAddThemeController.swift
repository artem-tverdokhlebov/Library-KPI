//
//  LibrarianAddThemeController.swift
//  Library
//
//  Created by Artem Tverdokhlebov on 12/19/15.
//  Copyright © 2015 Leonid Humeniuk & Artem Tverdokhlebov. All rights reserved.
//

import Foundation
import UIKit

class LibrarianAddThemeController : UITableViewController, UITextFieldDelegate {
    @IBOutlet var themeTitle: UITextField!
    @IBOutlet var addButton: UIBarButtonItem!
    
    @IBAction func cancelButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func checkParams() {
        var errors : [String] = [String]()
        
        if(themeTitle.text!.isEmpty) {
            errors.append("Назва тематики не повинна бути порожньою")
        }
        
        if(errors.isEmpty) {
            addButton.enabled = true
        } else {
            addButton.enabled = false
        }
    }
    
    @IBAction func addTheme(sender: AnyObject) {
        let theme : Theme = Theme()
        theme.title = themeTitle.text!
        
        theme.insertToDB()
        
        let alert = UIAlertController(title: "Тематика", message: "Тематика була успішно додана", preferredStyle: UIAlertControllerStyle.Alert)
        let alertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in self.cancelButton(self)}
        alert.addAction(alertAction)
        presentViewController(alert, animated: true) { () -> Void in }
    }
    
    @IBAction func themeTitleChanged(sender: AnyObject) {
        self.checkParams()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        themeTitle.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        themeTitle.delegate = self
        
        addButton.enabled = false
    }
}