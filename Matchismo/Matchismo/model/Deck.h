//
//  Deck.h
//  Matchismo
//
//  Created by Raymond Mendoza on 2013-02-14.
//  Copyright (c) 2013 Raymond Mendoza. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

-(void)addCard:(Card *)card atTop:(BOOL)addToTop;

-(Card *)drawRandomCard;

@end
