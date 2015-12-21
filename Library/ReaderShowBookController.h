//
//  ReaderShowBookController.h
//  Library
//
//  Created by Leonid Humeniuk on 12/18/15.
//  Copyright © 2015 Leonid Humeniuk & Artem Tverdokhlebov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"

@interface ReaderShowBookController : UITableViewController
@property (nonatomic) Book *book;
@property (nonatomic) int readerID;
@end
