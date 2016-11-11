//
//  LIconButton.m
//  LLists
//
//  Created by Lana Shatonova on 10/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

static const CGFloat kLength = 13.5;
#import "LIconButton.h"

@implementation LIconButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.backgroundColor = C_CLEAR;
//    self.backgroundColor = C_RANDOM;
    
    return self;
}

- (void)setIcon:(LIcon)icon {
    _icon = icon;
    
    switch (icon) {
        case LIconPlus:
            [self drawPlus];
            break;
            
        case LIconBack:
            [self drawBack];
            break;
            
        case LIconCircle:
            [self drawCircle];
            break;
            
        case LIconCross:
            [self drawCross];
            break;
            
        default:
            break;
    }
}


- (void)drawPlus {
    CGFloat lineWidth = 1.8;
    CGFloat lineLength = kLength + 3;
    
    UIView *line1 = [[UIView alloc] initCenterInSuperview:self size:s(lineWidth, lineLength)];
    line1.backgroundColor = C_ICON;
    
    UIView *line2 = [[UIView alloc] initCenterInSuperview:self size:s(lineLength, lineWidth)];
    line2.backgroundColor = C_ICON;
}

- (void)drawBack {
    CGFloat lineWidth = 2;
    CGFloat lineLength = kLength;
    
    UIView *line1 = [[UIView alloc] initCenterInSuperview:self size:s(lineWidth, lineLength)];
    line1.backgroundColor = C_ICON;
    line1.bottom = self.height/2 + 3;
    line1.rotation = M_PI_4;
    
    UIView *line2 = [[UIView alloc] initCenterInSuperview:self size:s(lineWidth, lineLength)];
    line2.backgroundColor = C_ICON;
    line2.top = self.height/2 - 3;
    line2.rotation = -M_PI_4;
}

- (void)drawCircle {
    CGFloat lineWidth = 1.8;
    CGFloat width = kLength + 4;
    
    UIView *circle = [[UIView alloc] initCenterInSuperview:self size:size_square(width)];
    circle.backgroundColor = C_CLEAR;
    circle.layer.borderColor = C_ICON.CGColor;
    circle.layer.borderWidth = lineWidth;
    circle.layer.cornerRadius = width / 2;
}

- (void)drawCross {
    UIButton *fakeButton = [[UIButton alloc] initFullInSuperview:self];
    
    CGFloat lineWidth = 2;
    CGFloat lineLength = kLength + 6;
    
    UIView *line1 = [[UIView alloc] initCenterInSuperview:fakeButton size:s(lineWidth, lineLength)];
    line1.backgroundColor = C_ICON;
    
    UIView *line2 = [[UIView alloc] initCenterInSuperview:fakeButton size:s(lineLength, lineWidth)];
    line2.backgroundColor = C_ICON;

    fakeButton.rotation = M_PI_4;
}

@end
