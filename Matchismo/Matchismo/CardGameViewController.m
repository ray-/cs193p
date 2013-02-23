//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Raymond Mendoza on 2013-02-14.
//  Copyright (c) 2013 Raymond Mendoza. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame * game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@end

@implementation CardGameViewController

- (CardMatchingGame *) game {
    if (!_game) {
        _game = [[CardMatchingGame alloc] initCardCount:self.cardButtons.count
                                              usingDeck:[[PlayingCardDeck alloc] init]];
    }
    return _game;
}

- (void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}
                 
- (void) updateUI {
    for (UIButton * cardButton in self.cardButtons) {
        Card * card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = cardButton.enabled ? 1.0 : 0.3;
    }
[self.scoreLabel setText:[NSString stringWithFormat:@"Score: %d", self.game.score]];
}

- (void) setCardButtons:(NSArray *)cardButtons {
    _cardButtons = cardButtons;
    [self updateUI];
}

- (IBAction)flipCard:(UIButton *)sender {
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}


@end
