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
    @IBOutlet var bookUDK: UITextField!
    
    @IBOutlet var addButton: UIBarButtonItem!
    
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
    
    @IBAction func cancelButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
            errors.append("Название книги не должно быть пустым")
        }
        
        if(authors.isEmpty) {
            errors.append("Книга должна иметь как минимум 1 автора")
        }
        
        if(themes.isEmpty) {
            errors.append("Книга должна иметь как минимум 1 тему")
        }
        
        if(bookUDK.text!.isEmpty) {
            errors.append("УДК книги не должен быть пустым")
        }
        
        if(errors.isEmpty) {
            addButton.enabled = true
        } else {
            addButton.enabled = false
        }
    }
    
    @IBAction func addBook(sender: AnyObject) {
        let book : Book = Book()
        book.title = bookTitle.text
        book.udk = bookUDK.text
            
        for theme in themes {
            book.connectToTheme(theme)
        }
            
        for author in authors {
            book.connectToAuthor(author)
        }
            
        book.insertToDB()
            
        let alert = UIAlertController(title: "Добавлено", message: "Книга была успешно добавлена", preferredStyle: UIAlertControllerStyle.Alert)
        let alertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in }
        alert.addAction(alertAction)
        presentViewController(alert, animated: true) { () -> Void in self.cancelButton(self)}
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
        
        addButton.enabled = false
    }
}