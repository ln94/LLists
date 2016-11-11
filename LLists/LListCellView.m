//
//  LListCellView.m
//  LLists
//
//  Created by Lana Shatonova on 9/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LListCellView.h"

@implementation LListCellView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.backgroundColor = C_CLEAR;
    
    // Color Tag
    self.colorTag = [[LColorTag alloc] initInSuperview:self edge:UIViewEdgeLeft length:kColorTagWidth insets:i(0, 0, kSeparatorHeight, kPaddingSmall)];
    
    // Text Field
    self.textField = [[LTextField alloc] initFullInSuperview:self insets:i(0, 0, kSeparatorHeight, kAllListsCellLeftViewWidth)];
    self.textField.font = F_TITLE;
    
    // Separator
    self.separator = [[LSeparator alloc] initInSuperview:self edge:UIViewEdgeBottom length:kSeparatorHeight];
    
    return self;
}


@end
