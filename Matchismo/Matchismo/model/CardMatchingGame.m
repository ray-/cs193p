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
@property (nonatomic) int cardCount;
@property (strong, nonatomic) Deck * deck;
@end

@implementation CardMatchingGame

#define FLIP_COST 1
#define MISMATCH_PENALTY 2
#define MATCH_BONUS 4

// designated initializer
-(instancetype)initWithCardCount:(NSUInteger)cardCount
             usingDeck:(Deck *)deck {

    self = [super init];
    
    if (self) {
        self.cardCount = cardCount;
        self.deck = deck;
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

-(void)chooseCardAtIndex:(NSUInteger)index {
    Card * card = [self cardAtIndex:index];
    
    if (!card.matched) {
        if (!card.chosen) {
            for (Card * otherCard in self.cards) {
                if (otherCard.chosen && !otherCard.matched) {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        card.matched = YES;
                        otherCard.matched = YES;
                        self.score += matchScore * MATCH_BONUS;
                    } else {
                        self.score -= MISMATCH_PENALTY;
                    }
                    break;

                }
            }
            self.score -= FLIP_COST;
        }
        card.chosen = !card.chosen;
    }
}

- (void) restart {
    self.score = 0;
    
    for (Card * card in self.cards) {
        card.matched = NO;
        card.chosen = NO;
        [self.deck addCard:card];
    }
    
    for (int i = 0; i < self.cardCount; i++) {
        Card * card = [self.deck drawRandomCard];
        if (!card) {
            return;
        } else {
            self.cards[i] = card;
        }
    }
    
    
}

@end
