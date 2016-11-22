//
//  LColorTag.m
//  LLists
//
//  Created by Lana Shatonova on 3/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LColorTag.h"

@implementation LColorTag

@synthesize transitionType = _transitionType;
@synthesize transitionDuration = _transitionDuration;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.alpha = 0.5;

    // Transition
    self.transitionType = LViewTransitionTypeFlip;
    self.transitionDuration = kAnimationDurationMed;
    
    return self;
}

- (void)setColor:(UIColor *)color {
    _color = color;
    self.backgroundColor = color;
}

@end
