//
//  LAddItemView.m
//  LLists
//
//  Created by Lana Shatonova on 10/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LAddItemView.h"
#import "LIconButton.h"


@interface LAddItemView () <LTextViewDelegate>

@property (nonatomic) LIconButton *plusButton;

@end


@implementation LAddItemView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.backgroundColor = C_WHITE;
    
    // Plus Button
    self.plusButton = [[LIconButton alloc] initInSuperview:self edge:UIViewEdgeLeft length:kCellLeftViewWidth];
    self.plusButton.icon = LIconPlus;
    self.plusButton.userInteractionEnabled = NO;
    
    // Text View
    self.textView.height = [self.textView heightForText:@""];
    self.textView.centerY = self.height / 2;
    self.textView.placeholder = @"New Item";
    self.textView.lDelegate = self;
    
    return self;
}

- (void)setShowingPlusButton:(BOOL)showing completion:(void (^)())completion {
    
    [UIView transitionWithView:self.plusButton duration:plusButtonAnimationDuration options:(showing ? showingAnimation : hidingAnimation) animations:nil completion:^(BOOL finished) {
        if (completion) completion();
    }];
}

#pragma mark - LTextViewDelegate

- (void)textViewShouldChangeHeight:(LTextView *)textView by:(CGFloat)by {
    CGFloat newHeigth = self.textView.height + by + kSeparatorBottomLineHeight;
    self.height = newHeigth <= kSingleListViewCellMinHeight ? kSingleListViewCellMinHeight : newHeigth;
    
    [self.plusButton centerInSuperview];
    self.plusButton.x = 0;
}

@end
