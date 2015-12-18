//
//  Card.m
//  Library
//
//  Created by Leonid Humeniuk on 12/12/15.
//  Copyright © 2015 Leonid Humeniuk & Artem Tverdokhlebov. All rights reserved.
//

#import "Card.h"

@implementation Card
-(void)parseFromDictionary:(NSDictionary *)dictionary{
    self.cardID = [dictionary[@"id"] intValue];
    self.readRoom = [dictionary[@"readRoom"] intValue];
}
@end
