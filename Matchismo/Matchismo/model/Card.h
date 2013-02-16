//
//  Card.h
//  Matchismo
//
//  Created by Raymond Mendoza on 2013-02-14.
//  Copyright (c) 2013 Raymond Mendoza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (nonatomic)NSString * contents;

@property (nonatomic, getter = isFaceUp)BOOL faceUp;

@property (nonatomic, getter = isUnplayable)BOOL unplayable;

-(int)match:(NSArray *) otherCards;

@end
