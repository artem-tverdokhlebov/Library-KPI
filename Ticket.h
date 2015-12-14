//
//  Ticket.h
//  Library
//
//  Created by Leonid Humeniuk on 12/12/15.
//  Copyright © 2015 Leonid Humeniuk & Artem Tverdokhlebov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ticket : NSObject
@property (nonatomic) int ticketID;
@property (nonatomic) int readerID;
@property (nonatomic) NSString *beginDate;
@property (nonatomic) NSString *endDate;
-(void)parseFromDictionary:(NSDictionary *) dictionary;
@end
