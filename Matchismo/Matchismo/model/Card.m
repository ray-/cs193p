//
//  Card.m
//  Matchismo
//
//  Created by Raymond Mendoza on 2013-02-14.
//  Copyright (c) 2013 Raymond Mendoza. All rights reserved.
//

#import "Card.h"

@implementation Card

-(int)match:(NSArray *)otherCards {
    int score = 0;
    
    for (Card * card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    
    return score;
}


@end
