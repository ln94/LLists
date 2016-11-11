//
//  LListCellRightSwipeView.m
//  LLists
//
//  Created by Lana Shatonova on 11/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LListCellRightSwipeView.h"
#import "LSeparator.h"

@implementation LListCellRightSwipeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    // Delete Button
    self.deleteButton = [[LIconButton alloc] initInSuperview:self edge:UIViewEdgeRight length:20 insets:i(0, kPaddingSmall, kSeparatorHeight, 0)];
    self.deleteButton.icon = LIconCross;
    
    // Edit Button
    self.editButton = [[LIconButton alloc] initInSuperview:self edge:UIViewEdgeRight length:45 insets:inset_bottom(kSeparatorHeight)];
    self.editButton.right = self.deleteButton.left;
    self.editButton.icon = LIconCircle;
    
    // Separator
    LSeparator *separator = [[LSeparator alloc] initInSuperview:self edge:UIViewEdgeBottom length:kSeparatorHeight];
    
    return self;
}

+ (CGFloat)width {
    return 90;
}

@end
