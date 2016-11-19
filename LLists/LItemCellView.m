//
//  LItemCellView.m
//  LLists
//
//  Created by Lana Shatonova on 10/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LItemCellView.h"

@interface LItemCellView () <LTextViewDelegate>

@end

@implementation LItemCellView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.backgroundColor = C_CLEAR;
    
    // Text View
    self.textView = [[LTextView alloc] initFullInSuperview:self insets:i(0, 0, 1, kSingleListCellLeftViewWidth)];
    self.textView.font = F_MAIN_TEXT;
    self.textView.lDelegate = self;
    
    // Separator
    UIView *separator = [[UIView alloc] initInSuperview:self edge:UIViewEdgeBottom length:kSingleListSeparatorHeight];
    separator.backgroundColor = C_SEPARATOR;
    
    return self;
}

- (void)centerTextView {
    // Fix height if it's too big
    if (self.textView.height + 1 > self.height) {
        LOG(@"- Fix height");
        self.textView.height = [self.textView heightForText:self.textView.text];
    }
    
    if (self.textView.height + 1 < self.height) {
        self.textView.centerY = (self.height - 1) / 2;
    }
    else {
        self.textView.top = 0;
    }
}

#pragma mark - LTextViewDelegate

- (void)textViewShouldChangeHeight:(LTextView *)textView to:(CGFloat)height {
    self.height = height + 1 > kSingleListCellMinHeight ? height + 1: kSingleListCellMinHeight;
}

- (void)textViewDidChangeHeight:(LTextView *)textView {
    [self centerTextView];
}

@end
