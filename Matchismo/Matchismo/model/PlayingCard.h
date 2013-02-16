//
//  PlayingCard.h
//  Matchismo
//
//  Created by Raymond Mendoza on 2013-02-15.
//  Copyright (c) 2013 Raymond Mendoza. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString * suit;

@property (nonatomic) NSUInteger rank;

+ (NSArray *) validSuits;
+ (NSUInteger) maxRank;

@end
