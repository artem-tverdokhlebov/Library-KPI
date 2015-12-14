//
//  TakenBook.m
//  Library
//
//  Created by Leonid Humeniuk on 12/12/15.
//  Copyright © 2015 Leonid Humeniuk & Artem Tverdokhlebov. All rights reserved.
//

#import "TakenBook.h"

@implementation TakenBook
-(void)parseFromDictionary:(NSDictionary *)dictionary{
    self.takenBookID =[dictionary[@"id"] intValue];
    self.bookID = [dictionary[@"book_id"] intValue];
    self.ticketID = [dictionary[@"ticket_id"] intValue];
    self.dateOfIssue = dictionary[@"dateOfIssue"];
    self.dateOfReturn = dictionary[@"dateOfReturn"];
}
@end
