//
//  ReaderController.m
//  Library
//
//  Created by Leonid Humeniuk on 12/20/15.
//  Copyright © 2015 Leonid Humeniuk & Artem Tverdokhlebov. All rights reserved.
//

#import "ReaderController.h"
#import "ReaderBookController.h"
@implementation ReaderController
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.destinationViewController isKindOfClass:[ReaderBookController class] ]){
        ReaderBookController *nextVC = segue.destinationViewController;
        nextVC.readerID = self.readerID;
       
    }
}

-(void)viewDidLoad{
    [super viewDidLoad];
    NSLog(@"reader controller %i", self.readerID);
}
@end
