//
//  LDoneButton.m
//  LLists
//
//  Created by Lana Shatonova on 2/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LDoneButton.h"

@interface LDoneButton ()

@property (nonatomic) UIView *blankCircle;
@property (nonatomic) UIView *filledCircle;
@end

@implementation LDoneButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;

    self.backgroundColor = C_CLEAR;
    
    self.blankCircle = [[UIView alloc] initCenterInSuperview:self size:size_square(kDoneButtonLength)];
    self.blankCircle.backgroundColor = C_WHITE;
    self.blankCircle.layer.cornerRadius = kDoneButtonLength / 2;
    self.blankCircle.layer.borderWidth = 1;
    self.blankCircle.layer.borderColor = C_SEPARATOR.CGColor;
    self.blankCircle.layer.shadowRadius = 5;
    
    CGFloat kFilledCircleLength = kDoneButtonLength - 6;
    self.filledCircle = [[UIView alloc] initCenterInSuperview:self.blankCircle size:size_square(kFilledCircleLength)];
    self.filledCircle.backgroundColor = C_ICON;
    self.filledCircle.layer.cornerRadius = kFilledCircleLength / 2;
    self.filledCircle.layer.borderWidth = 0;
    self.filledCircle.hidden = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didPressDoneButton)];
    [self addGestureRecognizer:tap];
    
    return self;
}

- (void)didPressDoneButton {
    
    [self doneAnimation:^{
        if (self.delegate) {
            [self.delegate didPressDoneButton:self];
        }
    }];
}

- (void)doneAnimation:(void(^)())completion {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.filledCircle.hidden = NO;
    } completion:^(BOOL finished) {
        if (completion) completion();
    }];
}

@end
