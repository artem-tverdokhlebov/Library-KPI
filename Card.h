//
//  Card.h
//  Library
//
//  Created by Leonid Humeniuk on 12/12/15.
//  Copyright © 2015 Leonid Humeniuk & Artem Tverdokhlebov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property (nonatomic) int cardID;
@property (nonatomic) bool readRoom;

-(void)parseFromDictionary:(NSDictionary *)dictionary;

@end
