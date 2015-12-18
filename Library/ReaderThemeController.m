//
//  ReaderThemeController.m
//  Library
//
//  Created by Leonid Humeniuk on 12/13/15.
//  Copyright © 2015 Leonid Humeniuk & Artem Tverdokhlebov. All rights reserved.
//

#import "ReaderThemeController.h"
#import "Library-Swift.h"
#import "ReaderBookForRequestController.h"

@interface ReaderThemeController ()<UISearchBarDelegate>
@property (nonatomic) NSArray *data;
@property (nonatomic) NSMutableArray <Theme *> *themes;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end
@implementation ReaderThemeController
-(NSMutableArray<Theme *> *)themes{
    if(!_themes){
        _themes = [@[] mutableCopy];
    }
    return _themes;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchBar.delegate = self;
    
    self.data = [DB query:@"SELECT * FROM theme"];
    for (NSObject *item in self.data) {
        Theme *theme = [Theme new];
        [theme parseFromDictionary:(NSDictionary *)item];
        [self.themes addObject:theme];
    }
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"clientThemeCell" forIndexPath:indexPath];
    cell.textLabel.text = self.themes[indexPath.row].title;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.themes.count;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.destinationViewController isKindOfClass:[ReaderBookForRequestController class]]){
        ReaderBookForRequestController *nextVC = segue.destinationViewController;
        nextVC.query = [NSString stringWithFormat:@"SELECT book.* FROM book INNER JOIN bookTheme ON bookTheme.book_id = book.id WHERE theme_id = %i", self.themes[[self.tableView indexPathForSelectedRow].row].theme_id];
    }
}
-(void)getResultsByTitle:(NSString *)title{
    if(title){
        self.data = [DB query:[NSString stringWithFormat:@"SELECT * FROM theme WHERE title LIKE '%%%@%%'",title]];
    } else {
        self.data = [DB query:@"SELECT * FROM theme"];
        
    }
    self.themes = [@[] mutableCopy];
    for (NSObject *item in self.data) {
        Theme *theme = [Theme new];
        [theme parseFromDictionary:(NSDictionary *)item];
        [self.themes addObject:theme];
    }
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.searchBar resignFirstResponder];
    [self getResultsByTitle:self.searchBar.text];
    
    [self.tableView reloadData];
}

@end
