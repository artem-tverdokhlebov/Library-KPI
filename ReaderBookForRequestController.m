//
//  ReaderBookForRequestController.m
//  Library
//
//  Created by Leonid Humeniuk on 12/13/15.
//  Copyright © 2015 Leonid Humeniuk & Artem Tverdokhlebov. All rights reserved.
//

#import "ReaderBookForRequestController.h"
#import "Book.h"
#import "Library-Swift.h"
@interface ReaderBookForRequestController ()
@property (nonatomic) NSArray *data;
@property (nonatomic) NSMutableArray <Book *> *books;

@end
@implementation ReaderBookForRequestController

- (NSMutableArray<Book *> *)books{
    if(!_books){
        _books = [@[] mutableCopy];
    }
    return _books;
}

-(NSString *)query{
    if(!_query){
        _query = @"SELECT * FROM book";
    }
    return _query;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}




-(void)viewDidLoad{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.data = [DB query: self.query];
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
@end
