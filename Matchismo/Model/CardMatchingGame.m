//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Skylar Peterson on 10/5/13.
//  Copyright (c) 2013 Class Apps. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic, readwrite) NSInteger recentScore;
@property (nonatomic, readwrite) BOOL mismatchOccurred;
@property (nonatomic, strong, readwrite) NSMutableArray *attemptedMatchedCards;
@end

@implementation CardMatchingGame

- (void)setMode:(NSInteger)mode
{
    if (mode < 2 || mode > 3) _mode = 2;
    else _mode = mode;
}

//- (NSMutableArray *)attemptedMatchedCards
//{
//    if (!_attemptedMatchedCards) _attemptedMatchedCards = [[NSMutableArray alloc] init];
//    return _attemptedMatchedCards;
//}

- (NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

static const int MATCH_BONUS = 4;
static const int MISMATCH_PENALTY = 2;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            self.attemptedMatchedCards = [[NSMutableArray alloc] init];
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    [self.attemptedMatchedCards addObject:otherCard];
                    if ([self.attemptedMatchedCards count] == self.mode - 1) {
                        break;
                    }
                }
            }
            if ([self.attemptedMatchedCards count] == self.mode - 1) {
                int matchScore = [card match:self.attemptedMatchedCards];
                if (matchScore > 0) {
                    self.score += matchScore * MATCH_BONUS;
                    self.recentScore = self.score + matchScore * MATCH_BONUS;
                    self.mismatchOccurred = NO;
                    card.matched = YES;
                } else {
                    self.score -= MISMATCH_PENALTY;
                    self.recentScore = MISMATCH_PENALTY;
                    self.mismatchOccurred = YES;
                }
                for (Card *otherCard in self.attemptedMatchedCards) {
                    otherCard.matched = (matchScore > 0) ? YES : NO;
                    otherCard.chosen = (matchScore > 0) ? YES : NO;
                }
            }
            [self.attemptedMatchedCards addObject:card];
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

@end
