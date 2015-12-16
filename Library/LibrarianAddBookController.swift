//
//  LibrarianAddBookController.swift
//  Library
//
//  Created by Artem Tverdokhlebov on 12/16/15.
//  Copyright © 2015 Leonid Humeniuk & Artem Tverdokhlebov. All rights reserved.
//

import Foundation
import UIKit

class LibrarianAddBookController : UITableViewController,UITextFieldDelegate {
    var authors : [Author] = [Author]()
    var themes : [Theme] = [Theme]()
    
    @IBOutlet var bookTitle: UITextField!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell : UITableViewCell = sender as! UITableViewCell
        let destination : LibrarianSelectController = segue.destinationViewController as! LibrarianSelectController
        
        destination.title = cell.textLabel?.text

        if(cell.restorationIdentifier == "Author") {
            destination.loadAuthors()
            destination.passSelected(authors)
        }
        
        if(cell.restorationIdentifier == "Theme") {
            destination.loadThemes()
            destination.passSelected(themes)
        }
    }
    
    func passAuthors(authors : [Author]) {
        self.authors = authors
    }
    
    func passThemes(themes : [Theme]) {
        self.themes = themes
    }
    
    func addBook() {
        // TODO: implement
    }
    
    @IBAction func cancelButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addBook(sender: AnyObject) {
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        bookTitle.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        bookTitle.delegate = self
    }
}