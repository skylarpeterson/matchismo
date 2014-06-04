//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Skylar Peterson on 10/17/13.
//  Copyright (c) 2013 Class Apps. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCard.h"
#import "SetCardDeck.h"

@interface SetGameViewController ()

@end

@implementation SetGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	[super setMode:3];
    [super updateUI];
}

- (Deck *)createDeck
{
    return [[SetCardDeck alloc] init];
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"selected" : @"faceup"];
}

- (NSAttributedString *)titleForCard:(SetCard *)card
{
    NSMutableAttributedString *contents = [[NSMutableAttributedString alloc] initWithString:card.contents];
    if ([card.shading isEqualToString:@"outline"]) {
        [contents setAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],
                              NSStrokeWidthAttributeName : @3,
                              NSStrokeColorAttributeName : card.color}
                      range:NSMakeRange(0, contents.length)];
    } else if ([card.shading isEqualToString:@"outline+"]) {
        [contents setAttributes:@{NSForegroundColorAttributeName : card.color,
                              NSStrokeWidthAttributeName : @3,
                            NSStrokeColorAttributeName : [UIColor blackColor]}
                    range:NSMakeRange(0, contents.length)];
    } else if ([card.shading isEqualToString:@"filled"]) {
        [contents setAttributes:@{NSForegroundColorAttributeName : card.color}
                      range:NSMakeRange(0, contents.length)];
    }
    return contents;
}

@end
