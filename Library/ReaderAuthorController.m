//
//  ReaderauthorController.m
//  Library
//
//  Created by Leonid Humeniuk on 12/13/15.
//  Copyright © 2015 Leonid Humeniuk & Artem Tverdokhlebov. All rights reserved.
//

#import "ReaderAuthorController.h"
#import "Library-Swift.h"
#import "ReaderBookForRequestController.h"


@interface ReaderAuthorController () <UISearchBarDelegate>

@property (nonatomic) NSMutableArray <Author *> *authors;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;


@end
@implementation ReaderAuthorController
-(NSMutableArray<Author *> *)authors{
    if(!_authors){
        _authors = [@[] mutableCopy];
    }
    return _authors;
}
-(NSArray *)data{
    if(!_data){
        _data = [DB query:@"SELECT * FROM author"];
    }
    return _data;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchBar.delegate = self;
    
        for (NSObject *item in self.data) {
        Author *author = [Author new];
        [author parseFromDictionary:(NSDictionary *)item];
        [self.authors addObject:author];
    }
    [self.tableView reloadData];
}

-(void)loadAuthors{
    self.authors = [@[] mutableCopy];
    self.data = [DB query:@"SELECT * FROM author"];
    for (NSObject *item in self.data) {
        Author *author = [Author new];
        [author parseFromDictionary:(NSDictionary *)item];
        [self.authors addObject:author];
    }
}
- (IBAction)refresh:(id)sender {
  
    [self loadAuthors];
    
    [self.tableView reloadData];
    
    if (self.refreshControl.refreshing){
        [self.refreshControl endRefreshing];
    }

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"clientAuthorCell" forIndexPath:indexPath];
    cell.textLabel.text = self.authors[indexPath.row].name;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.authors.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.destinationViewController isKindOfClass:[ReaderBookForRequestController class]]){
        ReaderBookForRequestController *nextVC = segue.destinationViewController;
        nextVC.query = [NSString stringWithFormat:@"SELECT book.* FROM book INNER JOIN bookAuthor ON bookAuthor.book_id = book.id WHERE author_id = %i", self.authors[[self.tableView indexPathForSelectedRow].row].author_id];
    }
}
-(void)getResultsByTitle:(NSString *)name{
    if(name){
        self.data = [DB query:[NSString stringWithFormat:@"SELECT * FROM author WHERE name LIKE '%%%@%%'",name]];
    } else {
        self.data = [DB query:@"SELECT * FROM author"];
        
    }
    self.authors = [@[] mutableCopy];
    for (NSObject *item in self.data) {
        Author *author = [Author new];
        [author parseFromDictionary:(NSDictionary *)item];
        [self.authors addObject:author];
    }
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.searchBar resignFirstResponder];
    [self getResultsByTitle:self.searchBar.text];
    [self.tableView reloadData];
}
    

@end
