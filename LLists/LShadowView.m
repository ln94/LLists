//
//  LShadowView.m
//  LLists
//
//  Created by Lana Shatonova on 11/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LShadowView.h"

@implementation LShadowView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.backgroundColor = C_SHADOW;
    
    // GR
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeUp)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    [self addGestureRecognizer:swipeUp];
    
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeDown)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self addGestureRecognizer:swipeDown];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap)];
    [self addGestureRecognizer:tap];
    
    return self;
}

- (void)setHidden:(BOOL)hidden {
    [UIView transitionWithView:self duration:kAnimationDurationMed options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        [super setHidden:hidden];
    } completion:nil];
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
