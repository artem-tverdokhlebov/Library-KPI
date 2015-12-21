//
//  ReaderThemeListController.m
//  Library
//
//  Created by Leonid Humeniuk on 12/20/15.
//  Copyright © 2015 Leonid Humeniuk & Artem Tverdokhlebov. All rights reserved.
//

#import "ReaderThemeListController.h"
#import "ReaderThemeController.h"
#import "Library-Swift.h"
#import "ReaderBookForRequestController.h"
@interface ReaderThemeListController()
@property (nonatomic) NSMutableArray <Theme *> *themes;
@end
@implementation ReaderThemeListController
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
    self.themes = [self.bookThemes mutableCopy];
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"themeListCell" forIndexPath:indexPath];
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

@end
