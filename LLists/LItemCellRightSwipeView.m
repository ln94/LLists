//
//  LItemCellRightSwipeView.m
//  LLists
//
//  Created by Lana Shatonova on 18/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LItemCellRightSwipeView.h"

@implementation LItemCellRightSwipeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    // Delete Button
    self.deleteButton = [[LIconButton alloc] initInSuperview:self edge:UIViewEdgeRight length:kSwipeViewIconButtonWidth insets:i(0, kPaddingTiny, 1, 0)];
    self.deleteButton.icon = LIconCross;
    
    // Separator
    UIView *separator = [[UIView alloc] initInSuperview:self edge:UIViewEdgeBottom length:kSingleListSeparatorHeight];
    separator.backgroundColor = C_SEPARATOR;
    
    return self;
}

+ (CGFloat)width {
    return kSwipeViewIconButtonWidth + kPaddingTiny;
}

@end
