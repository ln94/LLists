//
//  LListCellView.m
//  LLists
//
//  Created by Lana Shatonova on 9/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LListCellView.h"
#import "LSeparator.h"

@implementation LListCellView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.backgroundColor = C_CLEAR;
    
    // Text Field
    self.textField = [[UITextField alloc] initFullInSuperview:self insets:inset_bottom(kSeparatorHeight)];
    self.textField.font = F_TITLE;
    self.textField.textColor = C_MAIN_TEXT;
    self.textField.returnKeyType = UIReturnKeyDone;
    
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    self.textField.leftView = [[UIView alloc] initWithSize:s(kTextFieldLeftViewWidth, self.textField.height)];
    
    // Color Tag
    self.colorTag = [[LColorTag alloc] initInSuperview:self.textField.leftView edge:UIViewEdgeLeft length:kColorTagWidth insets:inset_left(kPaddingSmall)];
    
    // Separator
    LSeparator *separator = [[LSeparator alloc] initInSuperview:self edge:UIViewEdgeBottom length:kSeparatorHeight];

    // Long Press
//    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressed:)];
//    [self addGestureRecognizer:longPress];
    
    return self;
}


@end
