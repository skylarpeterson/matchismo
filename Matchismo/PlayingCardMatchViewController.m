//
//  PlayingCardMatchViewController.m
//  Matchismo
//
//  Created by Skylar Peterson on 10/17/13.
//  Copyright (c) 2013 Class Apps. All rights reserved.
//

#import "PlayingCardMatchViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardMatchViewController ()

@end

@implementation PlayingCardMatchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [super setMode:2];
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"faceup" : @"facedown"];
}

- (NSAttributedString *)titleForCard:(Card *)card
{
    return card.isChosen ? [[NSAttributedString alloc] initWithString:card.contents] : [[NSAttributedString alloc] initWithString:@""];
}

@end
