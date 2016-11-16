//
//  LAddItemView.m
//  LLists
//
//  Created by Lana Shatonova on 10/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LAddItemView.h"

@interface LAddItemView () <LTextViewDelegate>

@end


@implementation LAddItemView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.backgroundColor = C_WHITE;
    
    // Plus Button
    self.plusButton = [[LIconButton alloc] initInSuperview:self edge:UIViewEdgeLeft length:kSingleListCellLeftViewWidth];
    self.plusButton.icon = LIconPlus;
    
    // Text View
    self.textView.height = [self.textView heightForText:@""];
    self.textView.centerY = self.height / 2;
    
    self.textView.placeholder = @"New Item";
    
    return self;
}

- (void)setShowingPlusButton:(BOOL)showing completion:(void (^)())completion {
    
    [UIView transitionWithView:self.plusButton duration:plusButtonAnimationDuration options:(showing ? showingAnimation : hidingAnimation) animations:nil completion:^(BOOL finished) {
        if (completion) completion();
    }];
}

#pragma mark - LTextViewDelegate

- (void)textViewShouldChangeHeight:(LTextView *)textView to:(CGFloat)height {
    
    self.height = height + kSeparatorBottomLineHeight > kSingleListCellMinHeight ? height + kSeparatorBottomLineHeight : kSingleListCellMinHeight;
}

- (void)textViewDidChangeHeight:(LTextView *)textView {
    
    if (textView.height + kSeparatorBottomLineHeight < self.height) {
        self.textView.centerY = (kSingleListCellMinHeight - kSeparatorBottomLineHeight) / 2;
    }
    else {
        self.textView.top = 0;
    }
}

@end
