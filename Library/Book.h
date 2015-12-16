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
@property (nonatomic) int inventoryNumber;
@property (nonatomic) NSString *udk;
@property (nonatomic) int cardID;

-(void)parseFromDictionary:(NSDictionary *) dictionary;
-(void)deleteFromDataBase;
@end

//TODO: getAuthors() -> [Author]