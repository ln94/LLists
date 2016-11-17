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
    self.textView = [[LTextView alloc] initFullInSuperview:self insets:inset_left(kSingleListCellLeftViewWidth)];
    self.textView.font = F_MAIN_TEXT;
    self.textView.lDelegate = self;
    
    return self;
}

- (void)centerTextView {
    if (self.textView.height > self.height) {
        self.textView.height = [self.textView heightForText:self.textView.text];
    }
    
    if (self.textView.height < self.height) {
        self.textView.centerY = self.height / 2;
    }
    else {
        self.textView.top = 0;
    }
}

#pragma mark - LTextViewDelegate

- (void)textViewShouldChangeHeight:(LTextView *)textView to:(CGFloat)height {
    self.height = height > kSingleListCellMinHeight ? height : kSingleListCellMinHeight;
}

- (void)textViewDidChangeHeight:(LTextView *)textView {
    [self centerTextView];
}

@end
