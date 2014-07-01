//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Raymond Mendoza on 2013-02-21.
//  Copyright (c) 2013 Raymond Mendoza. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

- (id)initWithCardCount:(NSUInteger) cardCount
              usingDeck:(Deck *) deck;

- (void)chooseCardAtIndex:(NSUInteger) index;

- (Card *)cardAtIndex:(NSUInteger) index;

- (void) restart;

@property (nonatomic, readonly) int score;

@end
