//
//  ViewController.m
//  Library
//
//  Created by Leonid Humeniuk on 12/12/15.
//  Copyright © 2015 Leonid Humeniuk & Artem Tverdokhlebov. All rights reserved.
//

#import "ViewController.h"
#import <Library-Swift.h>
#import "Book.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    NSArray *ar = [DB query: @"SELECT * FROM book"];
    Book *b = [Book new];
    [b parseFromDictionary:ar[0]];
    NSLog(@"%@",ar[0]);
    NSLog(@"%@ %@ %i", b.title, b.udk , b.inventoryNumber);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
