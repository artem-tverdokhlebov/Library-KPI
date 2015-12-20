//
//  Book.h
//  Library
//
//  Created by Leonid Humeniuk on 12/12/15.
//  Copyright © 2015 Leonid Humeniuk & Artem Tverdokhlebov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject
@property (nonatomic) NSString *title;
@property (nonatomic) int bookID;
//@property (nonatomic) int inventoryNumber;
@property (nonatomic) NSString *udk;
@property (nonatomic) int cardID;


-(void)parseFromDictionary:(NSDictionary *) dictionary;
-(void)deleteFromDB;
-(NSArray *)getAuthors;
-(NSArray *)getThemes;
-(void)connectToAuthor:(NSObject *)author;
-(void)connectToTheme:(NSObject *)theme;
-(void)insertToDB;
@end

//TODO: getCard()
//TODO: setCard(Card)