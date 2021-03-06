//
//  LIconButton.m
//  LLists
//
//  Created by Lana Shatonova on 10/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LIconButton.h"

@interface LIconButton ()

@property (nonatomic) UIImageView *iconView;

@end


@implementation LIconButton

@synthesize transitionType = _transitionType;
@synthesize transitionDuration = _transitionDuration;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.backgroundColor = C_CLEAR;
    
    // Icon View
    self.iconView = [[UIImageView alloc] initFullInSuperview:self];
    
    // Transition
    self.transitionType = LViewTransitionTypeFlip;
    self.transitionDuration = kAnimationDurationLong;

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
            
        case LIconForward:
            [self drawForward];
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

#pragma mark - Draw

- (void)drawPlus {
    CGFloat lineWidth = 1.8;
    CGFloat lineLength = kIconHeight;
    
    UIView *line1 = [[UIView alloc] initCenterInSuperview:self.iconView size:s(lineWidth, lineLength)];
    line1.backgroundColor = C_ICON;
    
    UIView *line2 = [[UIView alloc] initCenterInSuperview:self.iconView size:s(lineLength, lineWidth)];
    line2.backgroundColor = C_ICON;
}

- (void)drawBack {
    CGFloat lineWidth = 2;
    CGFloat lineLength = kIconHeight - 2.5;
    
    UIView *line1 = [[UIView alloc] initCenterInSuperview:self.iconView size:s(lineWidth, lineLength)];
    line1.backgroundColor = C_ICON;
    line1.bottom = self.height/2 + 3;
    line1.rotation = M_PI_4;
    
    UIView *line2 = [[UIView alloc] initCenterInSuperview:self.iconView size:s(lineWidth, lineLength)];
    line2.backgroundColor = C_ICON;
    line2.top = self.height/2 - 3;
    line2.rotation = -M_PI_4;
}

- (void)drawForward {
    CGFloat lineWidth = 2;
    CGFloat lineLength = kIconHeight - 3;
    
    UIView *line1 = [[UIView alloc] initCenterInSuperview:self.iconView size:s(lineWidth, lineLength) insets:i(3, 0, 0, 3 *lineLength)];
    line1.backgroundColor = C_ICON;
    
    UIView *line2 = [[UIView alloc] initCenterInSuperview:self.iconView size:s(lineLength, lineWidth) insets:i((lineLength + lineWidth) / 2, 0, 0, 1.5 * lineLength)];
    line2.backgroundColor = C_ICON;
    
    self.iconView.rotation = -M_PI_4;
}

- (void)drawCircle {
    CGFloat lineWidth = 1.8;
    CGFloat width = kIconHeight;
    
    UIView *circle = [[UIView alloc] initCenterInSuperview:self.iconView size:size_square(width)];
    circle.backgroundColor = C_CLEAR;
    circle.layer.borderColor = C_ICON.CGColor;
    circle.layer.borderWidth = lineWidth;
    circle.layer.cornerRadius = width / 2;
}

- (void)drawCross {
    CGFloat lineWidth = 2;
    CGFloat lineLength = kIconHeight + 2.5;
    
    UIView *line1 = [[UIView alloc] initCenterInSuperview:self.iconView size:s(lineWidth, lineLength)];
    line1.backgroundColor = C_ICON;
    
    UIView *line2 = [[UIView alloc] initCenterInSuperview:self.iconView size:s(lineLength, lineWidth)];
    line2.backgroundColor = C_ICON;

    self.iconView.rotation = M_PI_4;
}

@end
