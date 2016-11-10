//
//  LIconButton.m
//  LLists
//
//  Created by Lana Shatonova on 10/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LIconButton.h"

@interface LIconButton ()

@property (nonatomic) NSDictionary *attributes;

@end

@implementation LIconButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.backgroundColor = C_CLEAR;
    
    self.attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:28],
                                  NSForegroundColorAttributeName:C_ICON };
    
    return self;
}

- (void)setIcon:(LIcon)icon {
    _icon = icon;
    
    NSString *title;
    switch (icon) {
        case LIconPlus:
            title = @"+";
            break;
            
        case LIconBack:
            title = @"<";
            break;
            
        case LIconCircle:
            title = @"o";
            break;
            
        default:
            title = @"";
            break;
    }
    NSAttributedString *attributedTitle = [NSAttributedString attributedStringWithAttributes:self.attributes format:title];
    [self setAttributedTitle:attributedTitle forState:UIControlStateNormal];
}

@end
