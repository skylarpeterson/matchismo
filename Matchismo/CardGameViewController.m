//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Skylar Peterson on 9/26/13.
//  Copyright (c) 2013 Class Apps. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "HistoryViewController.h"

@interface CardGameViewController ()
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
//@property (weak, nonatomic) IBOutlet UISegmentedControl *modeControl;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (nonatomic) NSInteger mode;
@property (strong, nonatomic) NSMutableArray *historyStrings;
@end

@implementation CardGameViewController

- (NSMutableArray *)historyStrings
{
    if (!_historyStrings) {
        _historyStrings = [[NSMutableArray alloc] init];
    }
    return _historyStrings;
}

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];
        _game.mode = self.mode;
    }
    return _game;
}

- (void)setMode:(NSInteger)mode
{
    _mode = mode;
}

- (Deck *)createDeck { return nil; }

- (IBAction)touchCardButton:(UIButton *)sender
{
//    if(self.modeControl.enabled == YES) {
//        self.modeControl.enabled = NO;
//        self.game.mode = self.modeControl.selectedSegmentIndex == 0 ? 2 : 3;
//    }
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    }
    self.descriptionLabel.attributedText = [self updatedStringForChosenCards];
}

- (NSAttributedString *)titleForCard:(Card *)card { return nil; }

- (UIImage *)backgroundImageForCard:(Card *)card { return nil; }

- (NSAttributedString *)updatedStringForChosenCards
{
//    int mode = self.modeControl.selectedSegmentIndex == 0 ? 2 : 3;
    NSMutableArray *matchedCards = [[NSMutableArray alloc] init];
    NSMutableAttributedString *updateString = [[NSMutableAttributedString alloc] initWithString:@""];
    for (Card *card in self.game.attemptedMatchedCards) {
        [updateString appendAttributedString:[self titleForCard:card]];
        if (card.isMatched) [matchedCards addObject:card];
    }

    if (self.game.attemptedMatchedCards.count == self.mode) {
        if (matchedCards.count > 0) {
            NSMutableAttributedString *beginning = [[NSMutableAttributedString alloc] initWithString:@"Matched "];
            [beginning appendAttributedString:updateString];
            [beginning appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" for %d points", self.game.recentScore]]];
            updateString = beginning;
            [self.historyStrings addObject:updateString];
        }
    } else if(self.game.mismatchOccurred) {
        [updateString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" don't match! %d point penalty!", self.game.recentScore]]];
        [self.historyStrings addObject:updateString];
    }
    return updateString;
}

- (IBAction)resetGame:(id)sender
{
    self.game = nil;
//    self.modeControl.enabled = YES;
    [self updateUI];
    self.descriptionLabel.text = @"Let the game begin!";
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showHistory"]) {
        if ([segue.destinationViewController isKindOfClass:[HistoryViewController class]]) {
            HistoryViewController *historyController = (HistoryViewController *)segue.destinationViewController;
            historyController.history = self.historyStrings;
        }
    }
}

@end
