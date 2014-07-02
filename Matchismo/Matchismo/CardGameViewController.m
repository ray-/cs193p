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
@property (weak, nonatomic) IBOutlet UIButton *redealButton;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISwitch *gameModeSwitch;
@end

@implementation CardGameViewController

- (CardMatchingGame *) game {
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
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
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.selected = card.chosen;
        cardButton.enabled = !card.matched;
        cardButton.alpha = cardButton.enabled ? 1.0 : 0.3;
    }
    [self.scoreLabel setText:[NSString stringWithFormat:@"Score: %d", self.game.score]];
}

- (NSString *)titleForCard: (Card *)card {
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard: (Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (void) setCardButtons:(NSArray *)cardButtons {
    _cardButtons = cardButtons;
    [self updateUI];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    [self.game chooseCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    self.gameModeSwitch.enabled = NO;
    [self updateUI];
}

- (IBAction)redeal:(id)sender {
    [_game restart];
    self.flipCount = 0;
    self.gameModeSwitch.enabled = YES;
    [self updateUI];

}

- (IBAction)switchGameMode:(UISwitch *)sender {
    if (sender.isOn) {
        self.game.numCardsToMatch = 3;
    } else {
        self.game.numCardsToMatch = 2;
    }
}

@end
