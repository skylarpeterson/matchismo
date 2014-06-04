//
//  SetCard.m
//  Matchismo
//
//  Created by Skylar Peterson on 10/15/13.
//  Copyright (c) 2013 Class Apps. All rights reserved.
//

#import "SetCard.h"

@interface SetCard ()
@property (nonatomic, strong, readwrite) NSAttributedString *cardContents;

@property (nonatomic, strong, readwrite) NSString *sign;
@property (nonatomic, strong, readwrite) UIColor *color;
@property (nonatomic, strong, readwrite) NSString *shading;
@property (nonatomic, readwrite) NSUInteger val;
@end

@implementation SetCard

- (int)match:(NSArray *)otherCards
{
    int matchScore = 0;
    if ([otherCards count] == 2) {
        BOOL signs = [self compareSigns:otherCards];
        BOOL colors = [self compareColors:otherCards];
        BOOL shading = [self compareShading:otherCards];
        BOOL count = [self compareVal:otherCards];
        if (!signs && !colors && !shading && !count) {
            matchScore += 10;
        }
    }
    return matchScore;
}

- (BOOL)compareSigns:(NSArray *)otherCards
{
    SetCard *first = [otherCards firstObject];
    SetCard *second = [otherCards objectAtIndex:1];
    if ([self.sign isEqualToString:first.sign] && [self.sign isEqualToString:second.sign]) return NO;
    if ([self.sign isEqualToString:first.sign]) return YES;
    if ([self.sign isEqualToString:second.sign]) return YES;
    if ([first.sign isEqualToString:second.sign]) return YES;
    return NO;
}

- (BOOL)compareColors:(NSArray *)otherCards
{
    SetCard *first = [otherCards firstObject];
    SetCard *second = [otherCards objectAtIndex:1];
    if (self.color == first.color && self.color == second.color) return NO;
    if (self.color == first.color) return YES;
    if (self.color == second.color) return YES;
    if (first.color == second.color) return YES;
    return NO;
}

- (BOOL)compareShading:(NSArray *)otherCards
{
    SetCard *first = [otherCards firstObject];
    SetCard *second = [otherCards objectAtIndex:1];
    if ([self.shading isEqualToString:first.shading] && [self.shading isEqualToString:second.shading]) return NO;
    if ([self.shading isEqualToString:first.shading]) return YES;
    if ([self.shading isEqualToString:second.shading]) return YES;
    if ([first.shading isEqualToString:second.shading]) return YES;
    return NO;
}

- (BOOL)compareVal:(NSArray *)otherCards
{
    SetCard *first = [otherCards firstObject];
    SetCard *second = [otherCards objectAtIndex:1];
    if (self.val == first.val && self.val == second.val) return NO;
    if (self.val == first.val) return YES;
    if (self.val == second.val) return YES;
    if (first.val == second.val) return YES;
    return NO;
}

- (NSString *)contents
{
    NSString *cardString = @"";
    for (int i = 0; i < self.val; i++) {
        cardString = [cardString stringByAppendingString:[NSString stringWithFormat:@"%@", self.sign]];
    }
    return cardString;
}

- (NSAttributedString *)cardContents
{
    if (!_cardContents) {
        _cardContents = [[NSAttributedString alloc] init];
    }
    return _cardContents;
}

- (SetCard *)initWithSign:(NSString *)sign andColor:(UIColor *)color andShading:(NSString *)shading andValue:(NSUInteger)val
{
    self = [super init];
    if (self) {
        self.sign = sign;
        self.color = color;
        self.shading = shading;
        self.val = val;
    }
    return self;
}

+ (NSArray *)validSigns
{
    return @[@"▲", @"●", @"■"];
}

+ (NSArray *)validColors
{
    UIColor *red = [UIColor colorWithRed:1.0f green:69.0f/255.0f blue:0.0f alpha:1.0f];
    UIColor *green = [UIColor colorWithRed:50.0f/255.0f green:205.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
    UIColor *purple = [UIColor colorWithRed:147.0f/255.0f green:112.0f/255.0f blue:219.0f/255.0f alpha:1.0f];
    return @[red, green, purple];
}

+ (NSArray *)validShading
{
    return @[@"outline", @"outline+", @"filled"];
}

+ (NSUInteger)maxNumber
{
    return 3;
}

@end
