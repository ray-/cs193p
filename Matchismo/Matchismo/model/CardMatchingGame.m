//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Raymond Mendoza on 2013-02-21.
//  Copyright (c) 2013 Raymond Mendoza. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (strong, nonatomic) NSMutableArray * cards;
@property (nonatomic) int score;
@end

@implementation CardMatchingGame

#define FLIP_COST 1
#define MISMATCH_PENALTY 2
#define MATCH_BONUS 4


-(id)initCardCount:(NSUInteger)cardCount
         usingDeck:(Deck *)deck {

    self = [super init];
    
    if (self) {
        for (int i = 0; i < cardCount; i++) {
            Card * card = [deck drawRandomCard];
            if (!card) {
                return nil;
            } else {
                self.cards[i] = card;
            }
        }
    }
    
    return self;
    
}

- (NSMutableArray *) cards {
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < self.cards.count) ? self.cards[index] : nil;
}

-(void)flipCardAtIndex:(NSUInteger)index {
    Card * card = [self cardAtIndex:index];
    
    if (!card.isUnplayable) {
        if (!card.faceUp) {
            for (Card * otherCard in self.cards) {
                if (otherCard.faceUp && !otherCard.isUnplayable) {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        card.unplayable = YES;
                        otherCard.unplayable = YES;
                        self.score += matchScore * MATCH_BONUS;
                    } else {
                        self.score -= MISMATCH_PENALTY;
                    }
                    break;

                }
            }
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.faceUp;
    }
}

@end
