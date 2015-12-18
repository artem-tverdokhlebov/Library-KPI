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
    self.cardID = [dictionary[@"card_id"] intValue];
}

-(void)deleteFromDB{
    [DB query:[NSString stringWithFormat:@"DELETE FROM book WHERE id = %i",self.bookID]];
    [DB query:[NSString stringWithFormat:@"DELETE FROM bookAuthor WHERE book_id = %i",self.bookID]];
    [DB query:[NSString stringWithFormat:@"DELETE FROM bookTheme WHERE book_id = %i",self.bookID]];
}

-(NSArray<Author *> *)getAuthors{
    NSMutableArray<Author *> *authors = [@[] mutableCopy];
    NSArray *data = [DB query:[NSString stringWithFormat:@"SELECT author.* FROM bookAuthor INNER JOIN author ON bookAuthor.author_id = author.id WHERE book_id = %i",self.bookID]];
    for (NSObject *item in data) {
        Author *a = [Author new];
        [a parseFromDictionary:(NSDictionary *)item];
        [authors addObject:a];
    }
    return [authors copy];
}

-(NSArray<Theme *> *)getThemes{
    NSMutableArray<Theme *> *themes = [@[] mutableCopy];
    NSArray *data = [DB query:[NSString stringWithFormat:@"SELECT theme.* FROM bookTheme INNER JOIN theme ON bookTheme.theme_id = theme.id WHERE book_id = %i",self.bookID]];
    for (NSObject *item in data) {
        Theme *t = [Theme new];
        [t parseFromDictionary:(NSDictionary *)item];
        [themes addObject:t];
    }
    return [themes copy];
}

-(void)connectToAuthor:(Author *)author{
    [DB query:[NSString stringWithFormat:@"INSERT INTO bookAuthor VALUES (%i, %i)", self.bookID, author.author_id]];
}

-(void)connectToTheme:(Theme *)theme{
    [DB query:[NSString stringWithFormat:@"INSERT INTO bookTheme VALUES (%i, %i)", self.bookID, theme.theme_id]];
}
-(void)insertToDB{
    [DB query:[NSString stringWithFormat:@"INSERT INTO bookTheme VALUES ('',%i,'%@','%@', %i)",self.inventoryNumber, self.title, self.udk, self.cardID]];
}

@end
