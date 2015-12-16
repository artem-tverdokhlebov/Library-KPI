//
//  Book.m
//  Library
//
//  Created by Leonid Humeniuk on 12/12/15.
//  Copyright © 2015 Leonid Humeniuk & Artem Tverdokhlebov. All rights reserved.
//

#import "Book.h"
#import "Library-Swift.h"
@implementation Book


-(void)parseFromDictionary:(NSDictionary *)dictionary{
    self.bookID =[dictionary[@"id"] intValue];
    self.inventoryNumber = [dictionary[@"inventoryValue"] intValue];
    self.title = dictionary[@"title"];
    self.udk = dictionary[@"udk"];
    self.cardID = [dictionary[@"card_id"] intValue];;
}


-(void)deleteFromDataBase{
    [DB query:[NSString stringWithFormat:@"DELETE FROM book WHERE id = %i",self.bookID]];
}
@end
