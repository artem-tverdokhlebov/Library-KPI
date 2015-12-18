//
//  ReaderShowBookController.m
//  Library
//
//  Created by Leonid Humeniuk on 12/18/15.
//  Copyright © 2015 Leonid Humeniuk & Artem Tverdokhlebov. All rights reserved.
//

#import "ReaderShowBookController.h"
#import "ReaderBookThemeOrAuthorController.h"
#import "Library-Swift.h"
@interface ReaderShowBookController()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end
@implementation ReaderShowBookController
- (IBAction)addToBascket:(id)sender {
}
-(void)viewDidLoad{
    [super viewDidLoad];
    self.titleLabel.text = self.book.title;
    self.tableView.delegate = self;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UITableViewCell *cell = sender;
    if([segue.destinationViewController isKindOfClass: [ReaderBookThemeOrAuthorController class]]){
        ReaderBookThemeOrAuthorController *nextVC = segue.destinationViewController;
        if([cell.restorationIdentifier isEqualToString:@"author"]){
            nextVC.authors = [self getBookAuthors];
        }
        if([cell.restorationIdentifier isEqualToString:@"theme"]){
            nextVC.themes = [self getBookThemes];
        }
    }
}

-(NSArray *)getBookAuthors{
    NSMutableArray<Author *> *authors = [@[] mutableCopy];
    
    NSArray *data = [DB query:[NSString stringWithFormat:@"SELECT author.* FROM author INNER JOIN bookAuthor ON bookAuthor.author_id = author.id WHERE book_id = %i",self.book.bookID]];
    for (NSObject *item in data) {
        Author *author = [Author new];
        [author parseFromDictionary:(NSDictionary *)item];
        [authors addObject:author];
    }

    
    return [authors copy];
}
-(NSArray *)getBookThemes{
    NSMutableArray<Theme *> *themes = [@[] mutableCopy];
    
    NSArray *data = [DB query:[NSString stringWithFormat:@"SELECT theme.* FROM theme INNER JOIN bookTheme ON bookTheme.theme_id = theme.id WHERE bookTheme.book_id = %i",self.book.bookID]];
    for (NSObject *item in data) {
        Theme *theme = [Theme new];
        [theme parseFromDictionary:(NSDictionary *)item];
        [themes addObject:theme];
    }
    
    
    return [themes copy];
}
@end
