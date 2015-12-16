//
//  Book.m
//  Library
//
//  Created by Leonid Humeniuk on 12/12/15.
//  Copyright © 2015 Leonid Humeniuk & Artem Tverdokhlebov. All rights reserved.
//

#import "Book.h"

@implementation Book
-(void)parseFromDictionary:(NSDictionary *)dictionary{
    self.bookID =[dictionary[@"id"] intValue];
    self.inventoryNumber = [dictionary[@"inventoryValue"] intValue];
    self.title = dictionary[@"title"];
    self.authorID = [dictionary[@"author_id"] intValue];
    self.themeID = [dictionary[@"theme_id"] intValue];
    self.udk = dictionary[@"udk"];
    self.cardID = [dictionary[@"card_id"] intValue];;
}
// TODO: метод для удаления из базы
@end
