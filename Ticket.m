//
//  Ticket.m
//  Library
//
//  Created by Leonid Humeniuk on 12/12/15.
//  Copyright © 2015 Leonid Humeniuk & Artem Tverdokhlebov. All rights reserved.
//

#import "Ticket.h"

@implementation Ticket
-(void)parseFromDictionary:(NSDictionary *)dictionary{
    self.ticketID =[dictionary[@"id"] intValue];
    self.readerID = [dictionary[@"reader_id"] intValue];
    self.beginDate = dictionary[@"beginDate"];
    self.endDate = dictionary[@"endDate"];
}
@end
