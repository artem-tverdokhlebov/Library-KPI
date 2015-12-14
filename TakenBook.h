//
//  TakenBook.h
//  Library
//
//  Created by Leonid Humeniuk on 12/12/15.
//  Copyright © 2015 Leonid Humeniuk & Artem Tverdokhlebov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TakenBook : NSObject
@property (nonatomic) int takenBookID;
@property (nonatomic) int bookID;
@property (nonatomic) int ticketID;
@property (nonatomic) NSString *dateOfIssue;
@property (nonatomic) NSString *dateOfReturn;
-(void)parseFromDictionary:(NSDictionary *)dictionary;
@end
