//
//  LItemCellView.m
//  LLists
//
//  Created by Lana Shatonova on 10/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LItemCellView.h"

@implementation LItemCellView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.backgroundColor = C_WHITE;
    
    // Text View
    self.textView = [[LTextView alloc] initFullInSuperview:self insets:i(0, 0, kSeparatorOneLineHeight, kCellLeftViewWidth)];
    self.textView.font = F_MAIN_TEXT;
    
    // Separator
    self.separator = [[UIView alloc] initInSuperview:self edge:UIViewEdgeBottom length:kSeparatorOneLineHeight];
    self.separator.backgroundColor = C_SEPARATOR;
    
    return self;
}

@end
