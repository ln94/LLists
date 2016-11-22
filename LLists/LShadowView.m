//
//  LShadowView.m
//  LLists
//
//  Created by Lana Shatonova on 11/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LShadowView.h"

@implementation LShadowView

@synthesize transitionType = _transitionType;
@synthesize transitionDuration = _transitionDuration;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.backgroundColor = C_SHADOW;
    self.hidden = YES;
    
    // GR
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeUp)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    [self addGestureRecognizer:swipeUp];
    
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeDown)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self addGestureRecognizer:swipeDown];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap)];
    [self addGestureRecognizer:tap];
    
    // Transition
    self.transitionType = LViewTransitionTypeFade;
    self.transitionDuration = kAnimationDurationSmall;
    
    return self;
}

- (void)didSwipeUp {
    if (self.delegate) {
        [self.delegate shadowViewDidSwipeUp];
    }
}

- (void)didSwipeDown {
    if (self.delegate) {
        [self.delegate shadowViewDidSwipeDown];
    }
}

- (void)didTap {
    if (self.delegate) {
        [self.delegate shadowViewDidTap];
    }
}

@end
