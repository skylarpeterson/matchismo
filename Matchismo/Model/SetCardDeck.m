//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Skylar Peterson on 10/15/13.
//  Copyright (c) 2013 Class Apps. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        for (NSString *sign in [SetCard validSigns]) {
            for (UIColor *color in [SetCard validColors]) {
                for (NSString *shading in [SetCard validShading]) {
                    for (NSUInteger rank = 1; rank <= [SetCard maxNumber]; rank++) {
                        SetCard *card = [[SetCard alloc] initWithSign:sign
                                                             andColor:color
                                                           andShading:shading
                                                             andValue:rank];
                        [self addCard:card];
                    }
                }
            }
        }
    }
    
    return self;
}

@end
