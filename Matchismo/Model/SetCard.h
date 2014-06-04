//
//  SetCard.h
//  Matchismo
//
//  Created by Skylar Peterson on 10/15/13.
//  Copyright (c) 2013 Class Apps. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic, strong, readonly) NSAttributedString *cardContents;

- (SetCard *)initWithSign:(NSString *)sign
                 andColor:(UIColor *)color
               andShading:(NSString *)shading
                 andValue:(NSUInteger)val;

@property (nonatomic, strong, readonly) NSString *sign;
@property (nonatomic, strong, readonly) UIColor *color;
@property (nonatomic, strong, readonly) NSString *shading;
@property (nonatomic, readonly) NSUInteger val;

+ (NSArray *)validSigns;
+ (NSArray *)validColors;
+ (NSArray *)validShading;
+ (NSUInteger)maxNumber;

@end
