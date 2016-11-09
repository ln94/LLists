//
//  LHeaderView.m
//  LLists
//
//  Created by Lana Shatonova on 9/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LHeaderView.h"

@interface LHeaderView ()

@end

@implementation LHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.backgroundColor = C_WHITE;
    
    // Plus Icon
    self.addButton = [[UIButton alloc] initInSuperview:self edge:UIViewEdgeLeft length:KHeaderViewAddButtonWidth insets:inset_bottom(kPaddingTiny)];
    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:28],
                    NSForegroundColorAttributeName:C_ICON };
    NSAttributedString *addButtonTitle = [NSAttributedString attributedStringWithAttributes:attributes format:@"+"];
    [self.addButton setAttributedTitle:addButtonTitle forState:UIControlStateNormal];
    
    // Separator
    UIView *separator = [[UIView alloc] initInSuperview:self edge:UIViewEdgeBottom length:1];
    separator.backgroundColor = C_SEPARATOR;
    
    return self;
}

@end
