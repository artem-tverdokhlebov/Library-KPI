//
//  ReaderAuthorListController.m
//  Library
//
//  Created by Leonid Humeniuk on 12/20/15.
//  Copyright © 2015 Leonid Humeniuk & Artem Tverdokhlebov. All rights reserved.
//

#import "ReaderAuthorListController.h"
#import "Library-Swift.h"
#import "ReaderBookForRequestController.h"

@interface ReaderAuthorListController()

@property (nonatomic) NSMutableArray <Author *> *authors;

@end
@implementation ReaderAuthorListController
-(NSMutableArray<Author *> *)authors{
    if(!_authors){
        _authors = [@[] mutableCopy];
    }
    return _authors;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.authors = [self.bookAuthors mutableCopy];
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"authorListCell" forIndexPath:indexPath];
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


@end
