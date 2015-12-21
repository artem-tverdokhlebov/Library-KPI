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
#import "ReaderController.h"
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

-(int)readerID{
    if(!_readerID){
        _readerID = 0;
    
    }
    return _readerID;
}



-(void)viewDidLoad{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchBar.delegate = self;
    
    self.readerID = ((ReaderController *)self.tabBarController).readerID;
    
    NSLog(@"reader book controller %i",self.readerID);
    self.searchBar.scopeBarBackgroundImage = [UIImage new];
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
    self.data = [DB query:[NSString stringWithFormat:@"SELECT * FROM book WHERE title LIKE '%%%@%%'",title]];
    self.books = [@[] mutableCopy];
    for (NSObject *item in self.data) {
        Book *book = [Book new];
        [book parseFromDictionary:(NSDictionary *)item];
        [self.books addObject:book];
    }
}
-(void)getResultsByUDK:(NSString *)udk{
    self.data = [DB query:[NSString stringWithFormat:@"SELECT * FROM book WHERE udk LIKE '%%%@%%'",udk]];
    self.books = [@[] mutableCopy];
    for (NSObject *item in self.data) {
        Book *book = [Book new];
        [book parseFromDictionary:(NSDictionary *)item];
        [self.books addObject:book];
    }
    
}

-(void)getResultsByAuthor:(NSString *)author{
    self.data = [DB query:[NSString stringWithFormat:@"SELECT book.* FROM bookAuthor JOIN author ON bookAuthor.author_id = author.id JOIN book ON bookAuthor.book_id = book.id WHERE author.name LIKE '%%%@%%'",author]];
    self.books = [@[] mutableCopy];
    for (NSObject *item in self.data) {
        Book *book = [Book new];
        [book parseFromDictionary:(NSDictionary *)item];
        [self.books addObject:book];
    }
    
}

-(void)getResultByTheme:(NSString *)theme{
    self.data = [DB query:[NSString stringWithFormat:@"SELECT book.* FROM bookTheme JOIN theme ON bookTheme.theme_id = theme.id JOIN book ON bookTheme.book_id = book.id WHERE theme.title LIKE '%%%@%%'",theme]];
    self.books = [@[] mutableCopy];
    for (NSObject *item in self.data) {
        Book *book = [Book new];
        [book parseFromDictionary:(NSDictionary *)item];
        [self.books addObject:book];
    }
    
}

-(void)loadBooks{
    self.books = [@[] mutableCopy];
    self.data = [DB query:@"SELECT * FROM book"];
    for (NSObject *item in self.data) {
        Book *book = [Book new];
        [book parseFromDictionary:(NSDictionary *)item];
        [self.books addObject:book];
    }
}
- (IBAction)refresh:(id)sender {
    
    [self loadBooks];
    
    [self.tableView reloadData];
    
    if (self.refreshControl.refreshing){
        [self.refreshControl endRefreshing];
    }
    
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.searchBar resignFirstResponder];
    if([self.searchBar.text isEqualToString:@""]){
        [self loadBooks];
    } else {
        if(searchBar.selectedScopeButtonIndex == 0){
            [self getResultsByTitle:self.searchBar.text];
        }
        if(searchBar.selectedScopeButtonIndex == 1){
            [self getResultsByUDK:self.searchBar.text];
        }
        if(searchBar.selectedScopeButtonIndex == 2){
            [self getResultsByAuthor:self.searchBar.text];
        }
        if(searchBar.selectedScopeButtonIndex == 3){
            [self getResultByTheme:self.searchBar.text];
        }
    }
    
    [self.tableView reloadData];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self loadBooks];
    [self.tableView reloadData];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.destinationViewController isKindOfClass:[ReaderShowBookController class]]){
        ReaderShowBookController *nextVC = segue.destinationViewController;
        nextVC.book = self.books[[self.tableView indexPathForSelectedRow].row];
    }
    
}

@end
