//
//  LibrarianEditThemeController.swift
//  Library
//
//  Created by Artem Tverdokhlebov on 12/20/15.
//  Copyright © 2015 Leonid Humeniuk & Artem Tverdokhlebov. All rights reserved.
//

import Foundation
import UIKit

class LibrarianEditThemeController : UITableViewController, UITextFieldDelegate {
    var theme : Theme = Theme()
    
    @IBOutlet var themeTitle: UITextField!
    @IBOutlet var saveButton: UIBarButtonItem!
    
    @IBAction func saveTheme(sender: AnyObject) {
        theme.title = themeTitle.text!
        
        theme.updateInDB()
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func passTheme(theme : Theme) {
        self.theme = theme
    }
    
    @IBAction func themeTitleChanged(sender: AnyObject) {
        self.checkParams()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        themeTitle.resignFirstResponder()
        return true
    }
    
    func checkParams() {
        var errors : [String] = [String]()
        
        if(themeTitle.text!.isEmpty) {
            errors.append("Название тематики не должно быть пустым")
        }
        
        if(errors.isEmpty) {
            saveButton.enabled = true
        } else {
            saveButton.enabled = false
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

        var destination : LibrarianShowThemeController = LibrarianShowThemeController()
        
        for item in self.navigationController!.viewControllers {
            if(item is LibrarianShowThemeController) {
                destination = item as! LibrarianShowThemeController
            }
        }

        destination.theme.reloadFromDB()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        themeTitle.delegate = self
        
        themeTitle.text = theme.title
    }

}