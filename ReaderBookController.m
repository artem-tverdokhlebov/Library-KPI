//
//  ReaderBookController.m
//  Library
//
//  Created by Leonid Humeniuk on 12/13/15.
//  Copyright © 2015 Leonid Humeniuk & Artem Tverdokhlebov. All rights reserved.
//

#import "ReaderBookController.h"
#import "Book.h"
#import "Library-Swift.h"
#import "ReaderShowBookController.h"

@interface ReaderBookController () <UISearchBarDelegate>
@property (nonatomic) NSArray *data;
@property (nonatomic) NSMutableArray <Book *> *books;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end
@implementation ReaderBookController 
- (NSMutableArray<Book *> *)books{
    if(!_books){
        _books = [@[] mutableCopy];
    }
    return _books;
}



-(void)viewDidLoad{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchBar.delegate = self;
    
    self.data = [DB query:@"SELECT * FROM book"];
    for (NSObject *item in self.data) {
        Book *book = [Book new];
        [book parseFromDictionary:(NSDictionary *)item];
        [self.books addObject:book];
    }
     [self.tableView reloadData];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"clientBookCell" forIndexPath:indexPath];
    cell.textLabel.text = self.books[indexPath.row].title;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.books.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)getResultsByTitle:(NSString *)title{
    if(title){
        self.data = [DB query:[NSString stringWithFormat:@"SELECT * FROM book WHERE title LIKE '%%%@%%'",title]];
    } else {
        self.data = [DB query:@"SELECT * FROM book"];

    }
    self.books = [@[] mutableCopy];
    for (NSObject *item in self.data) {
        Book *book = [Book new];
        [book parseFromDictionary:(NSDictionary *)item];
        [self.books addObject:book];
    }
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.searchBar resignFirstResponder];
    [self getResultsByTitle:self.searchBar.text];
    
    [self.tableView reloadData];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.destinationViewController isKindOfClass:[ReaderShowBookController class]]){
        ReaderShowBookController *nextVC = segue.destinationViewController;
        nextVC.book = self.books[[self.tableView indexPathForSelectedRow].row];
    }
    
}

@end
