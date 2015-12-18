//
//  ReaderBookThemeOrAuthorController.m
//  Library
//
//  Created by Leonid Humeniuk on 12/18/15.
//  Copyright © 2015 Leonid Humeniuk & Artem Tverdokhlebov. All rights reserved.
//

#import "ReaderBookThemeOrAuthorController.h"
#import "Library-Swift.h"
@implementation ReaderBookThemeOrAuthorController


-(void)viewDidLoad{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(self.themes){
        return self.themes.count;
    } else {
        return self.authors.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"authorOrTheme" forIndexPath:indexPath];
    if(self.themes){
        Theme *theme = self.themes[indexPath.row];
        cell.textLabel.text = theme.title;
    }
    if(self.authors){
        Author *author = self.authors[indexPath.row];
        cell.textLabel.text = author.name;
    }
    return cell;
}

@end
