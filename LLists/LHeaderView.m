//
//  LHeaderView.m
//  LLists
//
//  Created by Lana Shatonova on 9/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LHeaderView.h"

@interface LHeaderView ()

@property (nonatomic) UIButton *plusIconButton;

@end

@implementation LHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    // Plus Icon
    self.plusIconButton = [[UIButton alloc] initInSuperview:self edge:UIViewEdgeLeft length:2*kPaddingSmall+kColorTagWidth insets:inset_bottom(kPaddingTiny)];
    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:28],
                    NSForegroundColorAttributeName:C_ICON };
    NSAttributedString *plusIconTitle = [NSAttributedString attributedStringWithAttributes:attributes format:@"+"];
    [self.plusIconButton setAttributedTitle:plusIconTitle forState:UIControlStateNormal];
    [self.plusIconButton addTarget:self action:@selector(didPressPlusIconButton)];
    
    // Separator
    UIView *separator = [[UIView alloc] initInSuperview:self edge:UIViewEdgeBottom length:1];
    separator.backgroundColor = C_SEPARATOR;
    
    return self;
}

- (void)didPressPlusIconButton {
    if (self.delegate) {
        [self.delegate didPressAddButton];
    }
}

@end
