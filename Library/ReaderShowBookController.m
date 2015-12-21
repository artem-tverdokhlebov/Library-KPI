//
//  ReaderShowBookController.m
//  Library
//
//  Created by Leonid Humeniuk on 12/18/15.
//  Copyright © 2015 Leonid Humeniuk & Artem Tverdokhlebov. All rights reserved.
//

#import "ReaderShowBookController.h"
#import "ReaderAuthorListController.h"
#import "ReaderThemeListController.h"
#import "ReaderThemeController.h"
#import "Library-Swift.h"
@interface ReaderShowBookController()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *udkLabel;


@end
@implementation ReaderShowBookController
- (IBAction)addToBascket:(id)sender {
}
-(void)viewDidLoad{
    [super viewDidLoad];
    self.titleLabel.text = self.book.title;
    self.udkLabel.text = self.book.udk;
    self.tableView.delegate = self;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.destinationViewController isKindOfClass:[ReaderAuthorListController class]]){
        ReaderAuthorListController *nextVC = segue.destinationViewController;
        nextVC.bookAuthors = [self.book getAuthors];
        
    }
    if([segue.destinationViewController isKindOfClass:[ReaderThemeListController class]]){
        ReaderThemeListController *nextVC = segue.destinationViewController;
        nextVC.bookThemes = [self.book getThemes];
        
    }
}

@end
