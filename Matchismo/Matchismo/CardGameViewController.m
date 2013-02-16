//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Raymond Mendoza on 2013-02-14.
//  Copyright (c) 2013 Raymond Mendoza. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (nonatomic) Deck * deck;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@end

@implementation CardGameViewController

- (void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (void) setCardButtons:(NSArray *)cardButtons {
    _cardButtons = cardButtons;
    
    for (UIButton * cardButton in self.cardButtons) {
        Card * card = [self.deck drawRandomCard];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
    }
}

- (Deck *) deck {
    if (!_deck) {
        _deck = [[PlayingCardDeck alloc] init];
    }
    
    return _deck;
}

- (IBAction)flipCard:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    self.flipCount++;
}


@end
