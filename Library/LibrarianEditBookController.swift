//
//  LibrarianEditBookController.swift
//  Library
//
//  Created by Artem Tverdokhlebov on 12/20/15.
//  Copyright © 2015 Leonid Humeniuk & Artem Tverdokhlebov. All rights reserved.
//

import Foundation
import UIKit

class LibrarianEditBookController : UITableViewController, UITextFieldDelegate {
    var authors : [Author] = [Author]()
    var themes : [Theme] = [Theme]()
    
    var book : Book = Book()
    
    @IBOutlet var bookTitle: UITextField!
    @IBOutlet var bookUDK: UITextField!
    
    @IBOutlet var saveButton: UIBarButtonItem!
    
    func passBook(book : Book) {
        self.book = book
    }
    
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
        checkParams()
    }
    
    func passThemes(themes : [Theme]) {
        self.themes = themes
        checkParams()
    }
    
    @IBAction func saveBook(sender: AnyObject) {
        //TODO: implement
    }
    
    @IBAction func bookTitleChanged(sender: AnyObject) {
        checkParams()
    }
    
    @IBAction func bookUDKChanged(sender: AnyObject) {
        checkParams()
    }
    
    func checkParams() {
        var errors : [String] = [String]()
        
        if(bookTitle.text!.isEmpty) {
            errors.append("Назва книги не повинна бути порожньою")
        }
        
        if(authors.isEmpty) {
            errors.append("Книга повинна мати як мінімум 1 автора")
        }
        
        if(themes.isEmpty) {
            errors.append("Книга повинна мати як мінімум 1 тематику")
        }
        
        if(bookUDK.text!.isEmpty) {
            errors.append("УДК книги не повинен бути порожнім")
        }
        
        if(errors.isEmpty) {
            saveButton.enabled = true
        } else {
            saveButton.enabled = false
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        bookTitle.resignFirstResponder()
        bookUDK.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        bookTitle.delegate = self
        bookUDK.delegate = self
        
        bookTitle.text = book.title
        bookUDK.text = book.udk
        
        passAuthors(book.getAuthors() as! [Author])
        passThemes(book.getThemes() as! [Theme])
        
        checkParams()
    }
}